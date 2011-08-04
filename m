From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 00/18] Sequencer for inclusion v6
Date: Thu,  4 Aug 2011 16:08:58 +0530
Message-ID: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QovNf-0006hv-6j
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab1HDKmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:42:18 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63604 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab1HDKmR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:42:17 -0400
Received: by pzk37 with SMTP id 37so1836868pzk.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=StLitSbORehACRmlKB3lba8JfAMgsUalA4ymJ4v3KcI=;
        b=LRrJOz6ynSg2ydbQm13iPdP6bJb/lmFOMKNxcCUt1KczoISCH1fftREfYt+vyqA2eL
         QMP7bWIg8lIIQ0s2G2gpMd8gspkmoM2CuXexWfXiNOqkb5JvEsAGzifDVObSUuACoufH
         5zhH5U4PHq+1nrEvxtkevUpf7bQJsTefOyr7Q=
Received: by 10.142.240.20 with SMTP id n20mr654345wfh.401.1312454533779;
        Thu, 04 Aug 2011 03:42:13 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id m7sm2090440pbk.6.2011.08.04.03.42.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 03:42:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178716>

Hi,

Apart from the minor style changes, there are two big hilights in this
iteration of the series:
1. The "--continue complains when there are unresolved conflicts" test
is fixed.  I'd written "base..picked" instead of "base..anotherpick"
earlier.
2. Special handling for the last line in the instruction sheet (when
it is not terminated by a newline).  See [1] for an especially
convincing explanation from Junio.

All the changes made in this iteration are a direct result of
Christian's reviews -- a big thanks.

Thanks for reading.

-- Ram

[1]: http://mid.gmane.org/7v4o1ycsi4.fsf@alter.siamese.dyndns.org

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
 builtin/revert.c                  |  737 +++++++++++++++++++++++++++++--------
 cache.h                           |    2 +
 config.c                          |   36 ++-
 sequencer.c                       |   19 +
 sequencer.h                       |   20 +
 t/7106-reset-sequence.sh          |   44 +++
 t/t3510-cherry-pick-sequence.sh   |  214 +++++++++++
 14 files changed, 960 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/sequencer.txt
 create mode 100644 sequencer.c
 create mode 100644 sequencer.h
 create mode 100755 t/7106-reset-sequence.sh
 create mode 100755 t/t3510-cherry-pick-sequence.sh

-- 
1.7.6.351.gb35ac.dirty
