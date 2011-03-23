From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to remove a git subtree and its history?
Date: Wed, 23 Mar 2011 10:09:21 -0700
Message-ID: <AANLkTi=WX+jD-Vz0wtorHgMBQLQ4=ycHVzZeUt8goxyL@mail.gmail.com>
References: <4D88A1CB.2000500@jku.at> <AANLkTiktAUeOkX0MZh+JbQb1z-JiN=Qet6_AuWavsNk=@mail.gmail.com>
 <4D89B6F4.2050209@jku.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Pollak <robert.pollak@jku.at>
X-From: git-owner@vger.kernel.org Wed Mar 23 18:09:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2RZ5-00072E-SE
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 18:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab1CWRJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 13:09:43 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34818 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab1CWRJm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 13:09:42 -0400
Received: by vxi39 with SMTP id 39so6288887vxi.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KxDbBCbD5Q1fqfDrSf98pNxq7IWnCjnsOt4owTaotPQ=;
        b=XmJlFKfL77WTayziTNqIoRvIzkj58ubYeDWPB+PjXjRPX2GiKY1lIqxAstBCgANU48
         9f65e0uT1x2ZJfDJVHA4C+0KIn0htv52njOVsb1j+1rWaf5q4Pm3UKl1Fwe06fzLRalX
         V+yXNwDaJsKEXSoyWlJQF0yhEXIIt8K+j9T68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bS7XgGK41w8mhS1d9OQ3jXzIsbMnHj4MwXPVOvL8BPIh34oMpNhZOKezWusI7JKDCa
         Zy+AICgis4j8kSSL/t+XL7RQym4ai8fJqXg+4gjsZVsayc/jTPUs47jhZK/fJTiE866+
         fCvGmBsgKbxbh5S6J/NsSeto0D34eIsZujJYA=
Received: by 10.52.89.18 with SMTP id bk18mr7163240vdb.270.1300900181142; Wed,
 23 Mar 2011 10:09:41 -0700 (PDT)
Received: by 10.52.161.132 with HTTP; Wed, 23 Mar 2011 10:09:21 -0700 (PDT)
In-Reply-To: <4D89B6F4.2050209@jku.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169856>

On Wed, Mar 23, 2011 at 2:01 AM, Robert Pollak <robert.pollak@jku.at> w=
rote:
> Am 22.03.2011 21:44, schrieb Avery Pennarun:
>> I've never tried to do this since
>> the history rewrite you'd be doing in this case would completely
>> invalidate all your old history: by removing the subtree in all past
>> revisions, you make all those past revisions unbuildable, which seem=
s
>> like missing the point of version control. =A0Nevertheless, I'm sure=
 you
>> could make it happen if you wanted; you can do pretty much anything
>> you want by filtering git history.
>
> I see. As quite a git newbie I hoped you had done this already and co=
uld
> help me with the necessary git filter-branch command line.

I don't really have time to decode it all for you, but there are
basically two things you need to do here:

1) filter out the subtree merge commits
2) filter out the actual files.

You didn't really say which part of git-filter-branch *didn't* work
for you.  I'm assuming you were successful at #2, since that part
comes straight out of the filter-branch documentation, and you ended
up with some leftover git history (ie. log entries from the parent
project) that you don't want to see.

The easiest way I know to remove commits from the middle of history
(other than rebase, but that's too painful when there are merges) is
to use grafts: https://git.wiki.kernel.org/index.php/GraftPoint

Or maybe 'git replace' is easier than grafts nowadays.

After replacing the offending merge commits, run filter-branch one
more time to make the changes permanent.

>>> (Be free to CC git@vger.kernel.org if you reply, if you think that'=
s
>>> appropriate for archiving the info.)
>>
>> I don't understand why you didn't cc: the git list yourself then. =A0=
But okay :)
>
> I was not sure whether discussion of git-subtree belongs there, since=
 it
> is not part of git (yet?).

The git list seems to be used for discussion of git side projects
sometimes.  As it happens, I'm not subscribed to the list anymore
(nothing personal; I just can't handle the volume right now), so it's
important to leave me on the cc: list though if you want me to see it.

Have fun,

Avery
