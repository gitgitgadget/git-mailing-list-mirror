From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 00/15] complete reroll of my "port rebase -i to C" series
Date: Fri, 28 Aug 2009 06:47:30 +0200
Message-ID: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtZg-0006Ec-9P
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbZH1E7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbZH1E7L
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:11 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49689 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbZH1E7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:08 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9611D8180C9;
	Fri, 28 Aug 2009 06:59:01 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 37016818075;
	Fri, 28 Aug 2009 06:58:58 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127256>

So unlike previous series, this is a complete reroll of all my previous
patches to port rebase -i to C using code from the sequencer project.

The main changes are in the commit messages that I tried to improve
according to Junio's feedback. But some patches were also squashed
together and there are a few minor changes too:

- comments have been added before the pick_commit() function (patch
11/15: revert: libify cherry-pick and revert functionnality),

- and a line in the usage message as been removed from patch 13/15
(sequencer: add "do_commit()" and related functions) because it should
be added by the next patch instead.

Christian Couder (9):
  sequencer: add "builtin-sequencer--helper.c"
  rebase -i: use "git sequencer--helper --make-patch"
  sequencer: add "--reset-hard" option to "git sequencer--helper"
  rebase -i: use "git sequencer--helper --reset-hard"
  sequencer: add "--fast-forward" option to "git sequencer--helper"
  sequencer: let "git sequencer--helper" callers set "allow_dirty"
  rebase -i: use "git sequencer--helper --fast-forward"
  pick: libify "pick_help_msg()"
  rebase -i: use "git sequencer--helper --cherry-pick"

Stephan Beyer (6):
  sequencer: add "make_patch" function to save a patch
  sequencer: add "reset_almost_hard()" and related functions
  sequencer: add "do_fast_forward()" to perform a fast forward
  revert: libify cherry-pick and revert functionnality
  sequencer: add "do_commit()" and related functions working on
    "next_commit"
  sequencer: add "--cherry-pick" option to "git sequencer--helper"

 .gitignore                  |    1 +
 Makefile                    |    3 +
 builtin-revert.c            |  293 ++++--------------------
 builtin-sequencer--helper.c |  543 +++++++++++++++++++++++++++++++++++++++++++
 builtin.h                   |    1 +
 git-rebase--interactive.sh  |   42 ++--
 git.c                       |    1 +
 pick.c                      |  240 +++++++++++++++++++
 pick.h                      |   14 ++
 9 files changed, 865 insertions(+), 273 deletions(-)
 create mode 100644 builtin-sequencer--helper.c
 create mode 100644 pick.c
 create mode 100644 pick.h
