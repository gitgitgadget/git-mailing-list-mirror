From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Sequencer for inclusion
Date: Mon, 11 Jul 2011 14:53:51 +0000
Message-ID: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHsJ-000517-0X
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719Ab1GKOyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:13 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46637 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab1GKOyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:12 -0400
Received: by vxb39 with SMTP id 39so2716724vxb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=omiGqyzWiYW6SeNJGhaFvL7njNf/P5fQY82nfJ2VNms=;
        b=xWGoxWQH6vlxhDT6+xwt8R3LS7Dxk/nOvBIZtBBhffaKFuATlKc2GD+Gkp9BBQf6VZ
         cNgujH5mbX8Aji+Xs0BIMNCwniaQIwK26aka6YbxN70SU3Enk/uvYfU8kTfn5mi8W/m7
         sh7HpDQ28NVoYqjV+gbH6NDvXFId2zTYq1+Ds=
Received: by 10.52.155.135 with SMTP id vw7mr626741vdb.238.1310396051843;
        Mon, 11 Jul 2011 07:54:11 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176842>

Hi,

I'm excited to announce the first iteration of a fresh series -- this
one is intended for inclusion.  There are five new patches since last
time, the most significant of which is "revert: Save command-line
options for continuing operation", which introduces a parser for
command-line options.  Some patches might be slightly controversial,
but I think most of the new ideas have already been discussed
previously.  Another significant introduction is "sequencer: Announce
sequencer state location" -- this is where most of the post mid-term
work will go.

I would have liked to reuse the gitconfig parser as-is for the opts
parsing, but it's too tangled up in config.c.  I think it's safe to
say that the opts file format deviates only slightly from the
gitconfig format, and I'm quite happy with the end result.

What this requires now:
1. Review all existing code.  Many things might have moved around due
to heavy rebasing.
2. Repetition of unimplemented suggestions.  I'm sorry if I've missed
out some -- I was focusing on new features this time, not fixing
existing problems.
3. Rigorous testing of the new options parser.  We don't want
segfaults because of a silly parser.
4. New tests and documentation.  There's really no end to this, so
please suggest only things that are absolutely necessary before
inclusion.

In general, please point out things that need to be done immediately
before the inclusion.  The series is becoming large and unmanagable --
we can fix minor issues after the merge.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (17):
  advice: Introduce error_resolve_conflict
  revert: Inline add_message_to_msg function
  revert: Don't check lone argument in get_encoding
  revert: Rename no_replay to record_origin
  revert: Propogate errors upwards from do_pick_commit
  revert: Eliminate global "commit" variable
  revert: Introduce struct to keep command-line options
  revert: Separate cmdline parsing from functional code
  revert: Don't create invalid replay_opts in parse_args
  sequencer: Announce sequencer state location
  revert: Save data for continuing after conflict resolution
  revert: Save command-line options for continuing operation
  revert: Introduce a layer of indirection over pick_commits
  reset: Make hard reset remove the sequencer state
  revert: Remove sequencer state when no commits are pending
  revert: Introduce --reset to remove sequencer state
  revert: Introduce --continue to continue the operation

 Documentation/git-cherry-pick.txt |    6 +
 Documentation/git-revert.txt      |    6 +
 Documentation/sequencer.txt       |    9 +
 Makefile                          |    2 +
 advice.c                          |   31 +-
 advice.h                          |    3 +-
 builtin/reset.c                   |    2 +
 builtin/revert.c                  |  863 ++++++++++++++++++++++++++++++-------
 git-rebase--interactive.sh        |   25 +-
 sequencer.c                       |   19 +
 sequencer.h                       |   19 +
 t/7106-reset-sequence.sh          |   40 ++
 t/t3510-cherry-pick-sequence.sh   |  197 +++++++++
 13 files changed, 1058 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/sequencer.txt
 create mode 100644 sequencer.c
 create mode 100644 sequencer.h
 create mode 100755 t/7106-reset-sequence.sh
 create mode 100755 t/t3510-cherry-pick-sequence.sh

-- 
1.7.5.GIT
