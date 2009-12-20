From: Andrew Myrick <amyrick@gmail.com>
Subject: Re: git-svn mergeinfo support performance problem
Date: Sat, 19 Dec 2009 16:39:24 -0800
Message-ID: <6b2f9b1d0912191639m3c4feeaaw72a52adb674ad744@mail.gmail.com>
References: <6b2f9b1d0912181708g32645b48j3886b74101e77d80@mail.gmail.com> 
	<4B2D6FB0.6080103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Johan 't Hart" <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 01:39:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM9q1-0000io-KT
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 01:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbZLTAjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Dec 2009 19:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbZLTAjq
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 19:39:46 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:51880 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481AbZLTAjp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Dec 2009 19:39:45 -0500
Received: by iwn1 with SMTP id 1so2965333iwn.33
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 16:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sZaQv4CHhHikSATw3SzUZZpfEHcDPvH45TdT9gr0JZo=;
        b=X/N645LamrE8MHwDQ7uFYtU7a3Z7gMUPeD66pAIs59yYUZIOBhqftoOmOzGfJT/abw
         bagbhVJZsIvNqZotpS1tCHvZDt2+OC4wvZjGw+n5ZItwqgru71oZKxSbtzhZKOXvRZV5
         5mF+zBwNWv5vjV9lD8l9+rTVPzG5VNvrhTdB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YnZh0iW5R+W/MXW7P+vBKY+PpOfHMYe6hDtVxJjiAHQnn2dPYN+ytiB3y2CoKMKNrs
         pi6F+14vdXSaJ1kDQh1WK5qGNX+DUN4x0bgeymgElD+jLcCmW209rt4DVWGArsEpTnkq
         fLa84nuXg+o+szS1crN1Oq0X2pjKzdTe6VdsU=
Received: by 10.231.6.79 with SMTP id 15mr4265550iby.36.1261269584078; Sat, 19 
	Dec 2009 16:39:44 -0800 (PST)
In-Reply-To: <4B2D6FB0.6080103@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135513>

On Sat, Dec 19, 2009 at 4:28 PM, Johan 't Hart <johanthart@gmail.com> w=
rote:
> Andrew Myrick schreef:
>>
>> I've been testing git-svn v1.6.6-rc3's mergeinfo support on a large
>> svn repository (60,000+ revisions, 20+ GiB) that uses a very
>> branch-heavy integration model in which every change gets its own
>> branch before being committed to trunk. =C2=A0As a result of the mod=
el,
>> there are currently over 1000 lines in the svn:mergeinfo property on
>> trunk.
>
> Just wondering: Isnt this workflow stalling svn itself alot too?

Nope, svn seems to handle it fine.

> And also:
> Do you delete the branches after you reintegrated them? If so, I thin=
k its
> safe for you to cleanup the svn mergeinfo once in a while. That shoul=
d not
> affect 'svn log -g' because the mergeinfo is still there in older rev=
isions.
> I think svn benefits from this too...

We do not delete branches after they've been reintegrated.  Bug fix
and feature branches can get reintegrated into multiple release
branches, so it's not obvious when a branch can be deleted.  There's
already enough process overhead that it's simpler just to leave all of
the branches around.  Since this doesn't seem to affect svn's
performance, we haven't really worried about it.

-Andrew
