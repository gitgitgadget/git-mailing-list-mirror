From: Mojca Miklavec <mojca.miklavec.lists@gmail.com>
Subject: Serious flaws in "git cvsimport"
Date: Mon, 17 Feb 2014 01:10:38 +0100
Message-ID: <CALBOmsZR2qjCAvUeUqJL4U3BHwanugTGdMrdNQs-wnPXzgDjug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 17 01:10:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFBnH-0003h8-TF
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 01:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbaBQAKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Feb 2014 19:10:40 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:33329 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbaBQAKj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Feb 2014 19:10:39 -0500
Received: by mail-vc0-f180.google.com with SMTP id ks9so10748351vcb.25
        for <git@vger.kernel.org>; Sun, 16 Feb 2014 16:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=FWWPhjMDb3YZOz8yQud1bhSzL4mEllsGL3KSTu886X4=;
        b=oWnLLKYrvJ78UwvFheUzw+zbfpBrYHgvS4B6/jG6giEqIS1oUqknxcxIEPVKnBWhOE
         6KGtKDiSHLdWFuge4OOBzHgS2/NKyxrobwso9Xz/1+XFa/dDDaJoHQG/UGrtijy9WmfE
         p/Ypzhr3n2vFt9viqL7dEXO3mSgbz88eLqnKoTw8gRE256R3yooDDzhh5RM2o9mwsPgG
         y+GIbzSpLPXJpSPKvuDJPz3CYoBURGPoza24Tg6GBmMuu3kYbL0f0owXUMs4aiAoUsMq
         cqR3I2kYsgt0bbmo7bKLHcxqw+6BfsIp9w0JdCAhG+8g+9iSxYsiwCwOGI72Al4Qzctu
         p2sA==
X-Received: by 10.221.66.73 with SMTP id xp9mr10562956vcb.27.1392595838519;
 Sun, 16 Feb 2014 16:10:38 -0800 (PST)
Received: by 10.58.218.34 with HTTP; Sun, 16 Feb 2014 16:10:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242245>

Hello,

I really hate working with CVS, so I have set up a cronjob running
"git cvsimport" on regular basis to create a mirror of gnuplot
sources. I would use another tool, but until a few days ago I wasn't
aware of anything else that supported incremental updates, so that I
could run the conversion every few hours without the need to trash the
old conversions and make all my local/testing branches incompatible
with future development.

I had a lot of problems with the tool, but I was tolerating it (in the
spirit of numerous warnings that the tool isn't working properly):
- Files that have been deleted from CVS long ago don't get removed
from git (that's very very very annoying)
- I have numerous problems with file permissions (executable vs. non-ex=
ecutable)
- The first time when I do the import, all seems fine. But soon after
that I start getting numerous warnings during conversion in the spirit
of
    revision 1.X of file Y is tagged but not present
But maybe that's a bug in CVS.

But recently I discovered that a commit in the main branch of CVS
(trunk/master/whatever-they-call-it-in-cvs) which was important to me
was simply ignored by "git cvsimport". The commit modified three
files. Immediately after the commit, cvsimport claimed the repository
was already up-to-date. After other changes have been done in CVS,
bits and pieces from that important commit started appearing randomly,
together with other commits to CVS =E2=80=93 for example when the same =
file
was modified in another commit, changes from that "important" commit
to the same file were included as well in that later commit (but they
didn't belong to each other).

My understanding was that warnings about bad behaviour of "git
cvsimport" were related mostly to inability to reproduce complicated
branching and merging with zillions of branches. That would be
acceptable to me because I wasn't interested in those zillions of
branches and tags anyway.

But it turned out that whatever is currently in the master branch of
the repository created by "git cvsimport" isn't even corresponding to
what's currently in CVS and some commits are simply missing from
history along with their commit messages. The git repository contains
too many files (those that have been deleted in CVS) and random other
differences in random files, so that I'm not even able to compile the
project any longer as a consequence.

I'm willing to provide the exact details about the failures, but from
what I understand the previous maintainer of the underlying tool
(cvsps) deprecated it due to too numerous problems and flawed design,
so I'm not sure if anyone would be willing to fix the bugs I'm running
into.

I'm currently testing cvs-fast-export of which I only heard a few days
ago in the desperate search for a replacement for "git cvsimport".

It would be nice to see if manuals of cvsimport would at least mention
the existence of that tool in the same way as it mentions cvs2git (it
took me a while to learn about cvs-fast-export) or even better, to
consider it as an alternative for cvsps via a special argument to
cvsimport if that's possible.

Thank you very much,
    Mojca

(Please CC me in replies.)
