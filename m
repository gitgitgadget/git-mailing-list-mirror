From: "David Tweed" <david.tweed@gmail.com>
Subject: Advice on strategy for "temporary" commits
Date: Sun, 11 Mar 2007 05:22:48 +0000
Message-ID: <e1dab3980703102122i398d1fa5ib4e629d32134f4e4@mail.gmail.com>
References: <e1dab3980703080639i4c553e89nb931c2aea45b023b@mail.gmail.com>
	 <20070308163239.GH22713@fieldses.org>
	 <e1dab3980703080907v58739287p18bc2797db7d209e@mail.gmail.com>
	 <esrbub$bg$1@sea.gmane.org>
	 <e1dab3980703102101s21401403ja28c6273ecaa7b83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 06:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQGWF-0001im-2g
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 06:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbXCKFWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 00:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933159AbXCKFWw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 00:22:52 -0500
Received: from ik-out-1112.google.com ([66.249.90.176]:45839 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933156AbXCKFWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 00:22:50 -0500
Received: by ik-out-1112.google.com with SMTP id c21so1306031ika
        for <git@vger.kernel.org>; Sat, 10 Mar 2007 21:22:49 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JpAgqJe6I5GwEWylrUb+iQYC+gPgTw3xsW5+/ecJGjLIIVjkIdKf8Be1HgbOt4WJy3KciCr9Sbwp6Ql8o/buAJyhGoi+DHbOc5nkHwfbO2HBHImJIyyTSy83Fc42JHk382HU0z8iW/HkHyZow2AQc1Fi79Fwfa27Jwa2pOqfgGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FNWdansd1ffR86bU/Ul74+qUuRz2UIYBk9DpcbOxXw9vlbaBMJPXIzTQhnYVdxgode94Fzpt1klP1llhPgxQaQr2K2YzIVBv9FDZTRsHTIKFDvUsaMjNyKk3Sd4OrIz1bouHGen9kO55Lua9c8u4VsBhrwtdWfbRMVOj6BeNrLc=
Received: by 10.70.132.2 with SMTP id f2mr7131508wxd.1173590568815;
        Sat, 10 Mar 2007 21:22:48 -0800 (PST)
Received: by 10.65.160.2 with HTTP; Sat, 10 Mar 2007 21:22:48 -0800 (PST)
In-Reply-To: <e1dab3980703102101s21401403ja28c6273ecaa7b83@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41911>

> Try if "git checkout -m" does what you wanted. Or simply
> do a merge of "more often" branch into "less often" branch,
> perhaps simply not recording it as a merge with
> "git merge --squash" followed by "git commit".
>
> By the way, you know that you can --amend a commit?

Jakub suggested primarily being on the temporary branch,
when updating the archival branch is desired to first commit
to the temporary branch, then switch to the archival branch
and do a "git merge --squash temp-branch-name" and commit.
This seems to half-work, in that when it doesn't flag a merge
conflict it does what I want. Unfortunately it often seems to detect
"conflicts" that aren't conflicts for my usage and which make
automatic cron usage impossible, eg,
-------------------------------- 8< -------------------------------
$ git merge --squash temp
 100% (4/4) done
Auto-merged s
CONFLICT (content): Merge conflict in s
Squash commit -- not updating HEAD
Automatic merge failed; fix conflicts and then commit the result.

$ more s
H1
t1
t2
<<<<<<< HEAD:s
=======
t4
t5
>>>>>>> temp:s

--------------------------------- 8< ----------------------------
I _think_ if I could specify an opposite of the "ours" merge
strategy that always takes file contents from the other branches
head commit. An alternative might be to see if I can figure out directly
commiting the relevant file tree to both branches using low-level
git commands avoiding the higher level git processing (since
this isn't really a merge of different development but recording
the same "content state" on two different branches maybe
trying to make a "merge" work is the wrong idea.)

[In case anyone thinks I'm wrong to want to work primarily from cron
jobs, my rationale is that this stuff is personal to me -- ie,
won't be independently changed by anyone else -- and isn't
a focussed product. Years ago I tried using RCS on my home
directory and found I spent lots of time writing contentless
commit messages like "save
at 11.15 on 05/06/02" and that during crunch periods I'd
avoid making check-ins because it was too much extraneous
work; but these were _precisely_ the times I'd be most likely
to rush and do some stupid changes I'd want to back out, so it
didn't really work and so I stopped using RCS. With my "safety net
and historical archive" usage pattern -- which is different from
productised development -- I really want something safe to
run from cron.]

Anyway, thanks for all the help.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
Details are all that matters; God dwells there, and you never get to
see Him if you don't struggle to get them right. -- Stephen Jay Gould
