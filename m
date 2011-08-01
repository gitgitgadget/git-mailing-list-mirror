From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5 00/18] Sequencer for inclusion
Date: Mon,  1 Aug 2011 23:36:47 +0530
Message-ID: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:10:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwws-0003Qc-QQ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab1HASKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:10:38 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55115 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1HASKe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:10:34 -0400
Received: by gwaa12 with SMTP id a12so1564869gwa.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GAQqXR5tGwUYhe+j04mH8BxE+deGAmF184M2VS3XbKk=;
        b=KrtQpxJ6VOUhcLnB8AHP5JjAa3w/LEjmBHiaJZf9vMvFEgDi0dsLu5WlxB/HhgaoGR
         BnxnSL4oO5O3rEofKgeRnPnZHhDHLELIrbBl0Fhr26uzfC8JFt9n4L8Q31gDvvRezV5W
         Nj1zU6aLBJMl4ODr1o6++e+NYTvnXYX4SNrUY=
Received: by 10.68.12.225 with SMTP id b1mr2111496pbc.116.1312222233718;
        Mon, 01 Aug 2011 11:10:33 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.10.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:10:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178372>

Hi,

This is yet another iteration, with few improvements since last time.
Some minor nits pointed out by Jonathan and Christian are now fixed.

One additional detail: while playing with my generalized sequencer, I
noticed a couple of embarrassing bugs in the tests -- "malformed
instruction sheet 1" and "malformed instruction sheet 2" were picking
"base..picked" instead of "base..anotherpick".  Fixed now.

Thanks.

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
  revert: Don't implicitly stomp pending sequencer operation
  revert: Introduce --continue to continue the operation
  revert: Propagate errors upwards from do_pick_commit

 Documentation/git-cherry-pick.txt |    6 +
 Documentation/git-revert.txt      |    6 +
 Documentation/sequencer.txt       |    9 +
 Makefile                          |    2 +
 advice.c                          |   31 ++-
 advice.h                          |    3 +-
 branch.c                          |    2 +
 builtin/revert.c                  |  735 +++++++++++++++++++++++++++++--------
 cache.h                           |    2 +
 config.c                          |   36 ++-
 sequencer.c                       |   19 +
 sequencer.h                       |   20 +
 t/7106-reset-sequence.sh          |   44 +++
 t/t3510-cherry-pick-sequence.sh   |  214 +++++++++++
 14 files changed, 958 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/sequencer.txt
 create mode 100644 sequencer.c
 create mode 100644 sequencer.h
 create mode 100755 t/7106-reset-sequence.sh
 create mode 100755 t/t3510-cherry-pick-sequence.sh

-- 
1.7.4.rc1.7.g2cf08.dirty
