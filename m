From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Sequencer: The insn sheet format
Date: Wed,  6 Jul 2011 07:54:14 +0000
Message-ID: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMwO-0005pA-JH
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab1GFHyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:31 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43982 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab1GFHyb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:31 -0400
Received: by qwk3 with SMTP id 3so3221737qwk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=BNAx/2fJc9z25GRfdd3YCHpSw4BiOOTjNpcY+D0Zqjg=;
        b=quOoHYRuoG0/q004CPtVthlQuM0c+2k8OC+Oshh7Pu3H8ww1B2Rlu7LnJMmbSJE9OL
         un/jwtmm6xdmp+SeaP42azR9wHHTvbo6lx2ionB7yg7xP1icbKcdTm62FGp3SKa3u90Y
         3rtiJoVvIuuV+r5d1BsYM4R/lisu1Q4XAjaGE=
Received: by 10.229.107.21 with SMTP id z21mr6181152qco.187.1309938870525;
        Wed, 06 Jul 2011 00:54:30 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176647>

Hi,

Sorry about the delay -- I was travelling again.  I've chistled
everything until the 12th patch to near-perfection.  One of the major
user-visible changes is renaming '--skip-all' to '--reset'.  Initially
suggested by Christian, I really like this name; I think there will be
enough justification for it, especially after we get 'git reset
--hard' to clear away the sequencer state.  Now, we're back to the
point where we need to finalize the instruction sheet format.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (14):
  advice: Introduce error_resolve_conflict
  revert: Inline add_message_to_msg function
  revert: Don't check lone argument in get_encoding
  revert: Rename no_replay to record_origin
  revert: Propogate errors upwards from do_pick_commit
  revert: Eliminate global "commit" variable
  revert: Introduce struct to keep command-line options
  revert: Separate cmdline parsing from functional code
  revert: Don't create invalid replay_opts in parse_args
  revert: Persist data for continuation
  revert: Introduce a layer of indirection over pick_commits
  revert: Introduce --reset to cleanup sequencer data
  revert: Introduce --continue to continue the operation
  revert: Change insn sheet format

 advice.c                           |   31 ++-
 advice.h                           |    1 +
 builtin/revert.c                   |  657 ++++++++++++++++++++++++++++--------
 git-rebase--interactive.sh         |   25 ++-
 t/t3032-merge-recursive-options.sh |    2 +
 t/t3501-revert-cherry-pick.sh      |    1 +
 t/t3502-cherry-pick-merge.sh       |    9 +-
 t/t3504-cherry-pick-rerere.sh      |    2 +
 t/t3505-cherry-pick-empty.sh       |   14 +-
 t/t3506-cherry-pick-ff.sh          |    3 +
 t/t3507-cherry-pick-conflict.sh    |   24 +-
 t/t3510-cherry-pick-sequence.sh    |  119 +++++++
 t/t7502-commit.sh                  |    1 +
 13 files changed, 720 insertions(+), 169 deletions(-)
 create mode 100644 t/t3510-cherry-pick-sequence.sh

-- 
1.7.5.GIT
