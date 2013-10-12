From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 00/14] Officially start moving to the term 'staging area'
Date: Sat, 12 Oct 2013 02:04:37 -0500
Message-ID: <1381561488-20294-4-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLu-0003vc-JF
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab3JLHLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:00 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48057 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab3JLHK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:59 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so3115712oag.33
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MohbpGEUUogKk3WSlBA7Dpz3LPFb/D2CgKyVlAfuflA=;
        b=gMQ5uQWWdu+HJz71PzMqXa60xffUJkKiAhAmZHL9+q98fGyRLB2SYbijtGahqi0iHa
         y4epeRXzxHvAWaClB825z5u87CjigIKr+vNUL7lS4hsHAv4PZH+hFhYCUsvnqAgkutWX
         8tsmtZKSeCOy+TZOFUXq1RPxGEIRBfgKwfg0FTwYbyvxdKFtMuFp955SX0JUUZV30wYn
         WS+y0qqZYkb7ka2enqxh3R/kE7QcSBdnS0QCPsvOFcepUyzYtg6TgbPbEeDA6jYoMnGG
         1Md88yGI6+WZFmIa3DADZ0qifxHORkHufrZnpwQFG5BxOYBSmeagccpB1ArvZ1RAYf2T
         gUyA==
X-Received: by 10.182.246.39 with SMTP id xt7mr17837831obc.16.1381561858489;
        Sat, 12 Oct 2013 00:10:58 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm101374106oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235965>

tl;dr: everyone except Junio C Hamano and Drew Northup agrees; we should move
away from the name "the index".

It has been discussed many times in the past that 'index' is not an
appropriate description for what the high-level user does with it, and
it has been agreed that 'staging area' is the best term.

The term 'staging area' is more intuitive for newcomers which are more
familiar with English than with Git, and it seems to be a
straightforward mental notion for people with different mother tongues.

In fact it is so intuitive that it's used already in a lot online
documentation, and the people that do teach Git professionally use this
term, because it's easier for many kinds of audiences to grasp.

The meaning of the words 'cache' and 'index' doesn't represent correctly
the mental model of the high-level user:

cache: a 'cache' is a place for easier access; a squirrel caches nuts
so it doesn't have to go looking for them in the future when it might
be much more difficult. Git porcelain is not using the staging area
for easier future access; it's not a cache.

index: an 'index' is a guide of pointers to something else; a book
index has a list of entries so the reader can locate information
easily without having to go through the whole book. Git porcelain is
not using the staging area to find out entries quicker; it's not an
index.

stage: a 'stage' is a special area designated for convenience in order
for some activity to take place; an orator would prepare a stage in
order for her speak to be successful, otherwise many people might not
be able to hear, or see her. Git porcelain is using the staging area
precisely as a special area to be separated from the working directory
for convenience.

The term 'stage' is a good noun itself, but also 'staging area', it
has a good verb; 'to stage', and a nice past-participle; 'staged'.

The first step in moving Git towards this term, is first to add --stage
options for every command that uses --index or --cache. However, there's
a problem with the 'git apply' command, because it treats --index and
--cache differently. Different solutions were proposed, including a
special --stage-only option, however, I think the best solution is a
--[no-]work option to specify if the working directory should be touched
or not, so --index becomes --staged, and --cached becomes --staged
--no-work.

In addition, the 'git stage' command can be extended so the staging area
can be brought closer to the user, like other important Git concepts,
like 'git branch, 'git tag', and 'git remote'. For example, the command
'git stage edit' (which allows the user to edit directly the diff from
HEAD to the staging area) can have a home, where previously there was no
place. It would become natural then to do 'git stage diff', and then
'git stage edit' (to edit the previous diff).

After adding the new --stage options and making sure no functionality is
lost, they can become the recommended ones in the documentation,
eventually, the old ones get deprecated, and eventually obsoleted.

Also, the documentation would need to be updated to replace many
instances of 'the index', with 'the staging area' in porcelain commands.

Moreover, the --stage and --work options also make sense for 'git
reset', and after these options are added, the complicated table to
explain the different behaviors between --soft, --mixed, and --hard
becomes so simple it's not needed any more:

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       A       B     C    D     --no-stage  A       B     D
				--stage     A       D     D
				--work      D       D     D

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       A       B     C    C     --no-stage  A       B     C
				--stage     A       C     C
				--work      C       C     C

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       B       B     C    D     --no-stage  B       B     D
				--stage     B       D     D
				--work      D       D     D

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       B       B     C    C     --no-stage  B       B     C
				--stage     B       C     C
				--work      C       C     C

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       B       C     C    D     --no-stage  B       C     D
				--stage     B       D     D
				--work      D       D     D

      working stage HEAD target             working stage HEAD
      ----------------------------------------------------
       B       C     C    C     --no-stage  B       C     C
				--stage     B       C     C
				--work      C       C     C

It might be possible to do 'git reset --no-stage --work', to reset the
working directory, but leave the staging area alone.

For more reference about the previous discussions:

http://thread.gmane.org/gmane.comp.version-control.git/197111
http://thread.gmane.org/gmane.comp.version-control.git/166675
http://thread.gmane.org/gmane.comp.version-control.git/115666

Felipe Contreras (14):
  Add proper 'stage' command
  stage: add edit command
  diff: document --staged
  grep: add --staged option
  rm: add --staged option
  stash: add --stage option to save
  stash: add --stage to pop and apply
  submodule: add --staged options
  apply: add --stage option
  apply: add --work, --no-work options
  completion: update --staged options
  reset: add --stage and --work options
  reset: allow --keep with --stage
  completion: update 'git reset' new stage options

 Documentation/git-apply.txt            |  11 ++-
 Documentation/git-diff.txt             |   4 +-
 Documentation/git-grep.txt             |   5 +-
 Documentation/git-reset.txt            |   8 +++
 Documentation/git-rm.txt               |   5 +-
 Documentation/git-stage.txt            |  50 +++++++++++--
 Documentation/git-stash.txt            |  14 ++--
 Documentation/git-submodule.txt        |   8 ++-
 Makefile                               |   2 +-
 builtin.h                              |   1 +
 builtin/apply.c                        |   7 ++
 builtin/grep.c                         |   2 +
 builtin/reset.c                        |  27 +++++++
 builtin/rm.c                           |   1 +
 builtin/stage.c                        | 126 +++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  39 ++++++++--
 git-stash.sh                           |  12 +++-
 git-submodule.sh                       |  10 +--
 git.c                                  |   2 +-
 19 files changed, 297 insertions(+), 37 deletions(-)
 create mode 100644 builtin/stage.c

-- 
1.8.4-fc
