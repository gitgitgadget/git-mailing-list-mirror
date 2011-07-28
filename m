From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 00/18] Sequencer for inclusion v4
Date: Thu, 28 Jul 2011 22:22:13 +0530
Message-ID: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:55:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTs5-0003Kh-N5
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab1G1Qzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:55:38 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:47132 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab1G1Qzg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:55:36 -0400
Received: by yia27 with SMTP id 27so1952324yia.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=1hCWzTuyYuxAOAV2qJ+q/htgLnZZHw7PJtXvKllDQS8=;
        b=G34te+Tr51T98O3/SkwOyVtr5PzfT8SlJd7GEa0XBP0j/v3kMeIRK7Yp3b1S1z+H0q
         T7j3wnr+w5Y5sT+tvoKWLUo2LXrx59BVDQDlNjjJvDVlWWLBFd1VpdCU2gPGoPsu2Ptb
         MwVvrlnTLsIqaTcXMByamXyyHoqbH4tjWKygk=
Received: by 10.42.144.193 with SMTP id c1mr138607icv.516.1311872136088;
        Thu, 28 Jul 2011 09:55:36 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.55.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:55:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178081>

Hi,

There were more style nits pointed out in v3: I learnt my lesson and
ran checkpatch.pl this time.  Apart these minor stylistic changes, the
other changes are:
1. Minor improvements to commit messages.
2. Tests now cleanup first, so one failing test doesn't take
everything else down.
3. A rebase that moves "revert: Propogate errors upwards from
do_pick_commit" to the end of the series.  A big thanks to Jonathan
for performing the rebase for me.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (18):
  advice: Introduce error_resolve_conflict
  config: Introduce functions to write non-standard file
  revert: Simplify and inline add_message_to_msg
  revert: Don't check lone argument in get_encoding
  revert: Rename no_replay to record_origin
  revert: Eliminate global "commit" variable
  revert: Introduce struct to keep command-line options
  revert: Separate cmdline parsing from functional code
  revert: Don't create invalid replay_opts in parse_args
  revert: Save data for continuing after conflict resolution
  revert: Save command-line options for continuing operation
  revert: Make pick_commits functionally act on a commit list
  revert: Introduce --reset to remove sequencer state
  reset: Make reset remove the sequencer state
  revert: Remove sequencer state when no commits are pending
  revert: Don't implictly stomp pending sequencer operation
  revert: Introduce --continue to continue the operation
  revert: Propogate errors upwards from do_pick_commit

 Documentation/git-cherry-pick.txt |    6 +
 Documentation/git-revert.txt      |    6 +
 Documentation/sequencer.txt       |    9 +
 Makefile                          |    2 +
 advice.c                          |   31 ++-
 advice.h                          |    3 +-
 branch.c                          |    2 +
 builtin/revert.c                  |  736 +++++++++++++++++++++++++++++--------
 cache.h                           |    2 +
 config.c                          |   36 ++-
 sequencer.c                       |   19 +
 sequencer.h                       |   20 +
 t/7106-reset-sequence.sh          |   43 +++
 t/t3510-cherry-pick-sequence.sh   |  225 +++++++++++
 14 files changed, 969 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/sequencer.txt
 create mode 100644 sequencer.c
 create mode 100644 sequencer.h
 create mode 100755 t/7106-reset-sequence.sh
 create mode 100755 t/t3510-cherry-pick-sequence.sh

-- 
1.7.4.rc1.7.g2cf08.dirty
