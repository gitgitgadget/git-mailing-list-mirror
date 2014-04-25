From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 00/14] Officially start moving to the term 'staging area'
Date: Fri, 25 Apr 2014 13:12:33 -0500
Message-ID: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:23:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdkmQ-0005sT-9j
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbaDYSXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:17 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:55363 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbaDYSXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:16 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so4709315obc.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3YiqZ1aT6dfm4sMOUa0Ycf3jvBLH6J6yhIrQHmgOacs=;
        b=zAiNj2o2+D4JE7iizHllz0RWaXB9JO7HvnN5KD9XlaG7MJ3aLTDJQfAMqns1EvOscn
         EEQy6WRsaoUwcO8AA1DCp36n9p/HFBdPjTs3tXMRxUDQVOc0mI1/jtxGCIcH0rqZ18ai
         RJNhnGToThgXeL7cGnFd+7a5CHJ/rIN3sK7YYWw4m+jCTanPEdwWFZaSPUD8C6tMse1J
         bo/1RhApceGkaUP5kkKHwPJoy+YD+m3VGtspnfkST7BGArND4AEO2fFIvewW3u+oakLZ
         oWMEQG+7rwNGnR1aAly2n7QUUSd4SYzcOeqnZjzudRoFD06jD0F5kGZPDXqUITqhblQ5
         dK+A==
X-Received: by 10.182.109.201 with SMTP id hu9mr1864921obb.77.1398450195976;
        Fri, 25 Apr 2014 11:23:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm13252506obb.5.2014.04.25.11.23.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247074>

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
http://thread.gmane.org/gmane.comp.version-control.git/233295

I made a summary of all the positions shared towards moving away from the name
"index".

http://article.gmane.org/gmane.comp.version-control.git/233469


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
 Documentation/git-stage.txt            |  51 +++++++++++--
 Documentation/git-stash.txt            |  14 ++--
 Documentation/git-submodule.txt        |   8 ++-
 Makefile                               |   2 +-
 builtin.h                              |   1 +
 builtin/apply.c                        |   7 ++
 builtin/grep.c                         |   2 +
 builtin/reset.c                        |  27 +++++++
 builtin/rm.c                           |   1 +
 builtin/stage.c                        | 127 +++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  39 ++++++++--
 git-stash.sh                           |  12 +++-
 git-submodule.sh                       |  10 +--
 git.c                                  |   2 +-
 19 files changed, 299 insertions(+), 37 deletions(-)
 create mode 100644 builtin/stage.c

-- 
1.9.2+fc1.2.gfbaae8c
