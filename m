From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Created git-basis and modified git-bundle to accept --stdin.
Date: Tue, 24 Jun 2008 20:55:52 +0200
Message-ID: <200806242055.53776.jnareb@gmail.com>
References: <1214273297-8257-1-git-send-email-adambrewster@gmail.com> <m3iqvzl091.fsf@localhost.localdomain> <c376da900806240830p2a48aff0uaf6f22372fead5ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam Brewster" <adam@adambrewster.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:57:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDhS-0007XF-F2
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 20:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbYFXS4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 14:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbYFXS4I
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 14:56:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:51065 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbYFXS4F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 14:56:05 -0400
Received: by nf-out-0910.google.com with SMTP id d3so50167nfc.21
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=G2rNAQwB6H8DL3psegHrbbuYY8F/L3BeVryW1PgnzpA=;
        b=q6jvG06wo2zsUNj33rM2I1IV7QS5U0GYpCo5KSxjyWnIZriUhoZ7CsGAOuQ6VY7PxU
         Y7gEzAeJ3OJlLLrE0pbQEVC8yRSWthuuIIxjuYJVFLItGRtYcPeDYx3PV+aNMyDIT2Bs
         7JbJBtJhgKyBK+KgjB9/47jr2SkF8jO49U13k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=l4hiFB+h90F61mJ3KE2rkMuYwHdil6XgljmCMdnGZmmQ0iYSxePG7BeWzrUONb167d
         jMEcwQVnCmFu1tzpH9fY1Ra87Jp7adlS6wpYNcae6nN/XjK1aVz8tneOspQbZE0Z4urT
         ulnnmtYgiuUFrwIMQEnDkc4A1MZH3bPGpplY0=
Received: by 10.210.105.20 with SMTP id d20mr799578ebc.146.1214333764379;
        Tue, 24 Jun 2008 11:56:04 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.44])
        by mx.google.com with ESMTPS id 2sm47117351nfv.5.2008.06.24.11.56.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 11:56:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <c376da900806240830p2a48aff0uaf6f22372fead5ef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86105>

Adam Brewster wrote:

>> [...]
>>> Then you can add the objects in the bundle to the basis, so they won't
>>> get included in the next pack like this:
>>>
>>>  $ git-basis --update my-basis < my-bundle
>>
>> Why not use "$(git ls-remote my-bundle)" somewhere in the invocation
>> creating new bundle instead?
>>
> 
> You could use "git ls-remote my-bundle | git-basis --update my-basis"
> to do the same thing as the command I gave above.

I was thinking about

  $ git bundle create my-bundle --all --not $(git ls-remote my-bundle | cut -f1)

(or `--branches' instead of `--all').  Or, if you don't want to keep
bundle, but only save basis, just use

  $ git bundle create my-bundle --all --not $(git basis --show my-basis)

No need for `--stdin' / `--revs' / `--basis' option to git-bundle,
at the cost of little shell trickery.

Or even

  $ git ls-remote my-bundle | cut -f1 > my-bases
  [...]
  $ git bundle create my-bundle --all --not $(cat my-bases)

>>> I'm sure that my implementation is crap, but I think this is a useful
>>> idea.  Anybody agree?  Disagree?
>>
>> Documentation, please?  Especially that it looks like '--stdin' option
>> is a bit tricky...
> 
> I wanted to test the waters and make sure that someone was at least
> vaguely interested in this (no need to document code that is never
> going to leave my machine).

See above example, to check if this would be enough...

> I'll prepare another patch with documentation and changing --stdin to
> --revs when I get a chance.

I'm not sure if another name, like --bases=<filename / basename> wouldn't
be better.  Perhaps --stdin is a good name...

-- 
Jakub Narebski
Poland
