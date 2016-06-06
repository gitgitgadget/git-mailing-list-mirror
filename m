From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [RFC][PATCH 0/8] struct object_id, Part 4
Date: Mon,  6 Jun 2016 23:38:53 +0000
Message-ID: <20160606233901.63845-1-sandals@crustytoothpaste.net>
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 01:39:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA471-0006U1-73
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 01:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbcFFXjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 19:39:10 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40640 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140AbcFFXjJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 19:39:09 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9368B282A8;
	Mon,  6 Jun 2016 23:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465256347;
	bh=abZlrDRMqxssr3IVZPNeodmNstCyV89O8wAvsLzB5QQ=;
	h=From:To:Cc:Subject:Date:From;
	b=At81M1+JUqqYXm/QNovZvOzv/jx5jPa75joGYUSJBB0+iftvvrhuk6qQxo42ru7sI
	 cV2YXNgfz9vVL4h/aEmHB2zJ2woqgyQl4VoGYW70/XR7CSkunDRquaV4u52eueThus
	 uHOvgToGMNs7QXLJndSyq/4crSv6q6+O2boyvaZqNVDxQMquFyiNo9E5BPmBLVYPhD
	 C6DbIFq/f/hrK7NLOjpDgCI1jiPkyESb0MXYBpBh3le3OfvRHWd1P8Ai8AAVWTXCoM
	 wjDF6rTkxixKuGoMf7GqiNkf8Of8cy8puyXUNFHoWCSFty3uayrwwAng9E9ve8o8BB
	 hMl4BhVAmEWnhkBS5VVexLIKc+5H/xx6lyL/gPAOgPCLk+vRCHlg5rLiowSJkXgOPy
	 t1U1TgT0mJ83LkNE8RieCzIteuiC7GUuwKJ1UX4uuOWaXQbaztYdC3CPWWGTwLDJ2a
	 7ktDg/fRt5SVGLvmVLwGlsMb5/4jVNg/MBKX4iQJdUwpZB3+ggb
X-Mailer: git-send-email 2.8.1.369.geae769a
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296578>

This series is part 4 in a series of conversions to replace instances of
unsigned char [20] with struct object_id.  Most of this series touches
the merge-recursive code.

New in this series is the use of Coccinelle (http://coccinelle.lip6.fr/)
semantic patches.  These semantic patches can make automatic
transformations to C source code for cleanup or refactoring reasons.

This series introduces a set of transforms for the struct object_id
transition, cleans up some existing code with them, and applies a small
number of semantic patches to transform parts of the merge-recursive
code.  Some manual refactoring work follows.

Note that in the patches created with the semantic patches, the only
manual change was the definition of the struct member.  This series is
marked as RFC to see if this is a viable technique for further work to
ease both the creation and review of patches.  Opinions are of course
welcomed.

The testsuite continues to pass at each step.

brian m. carlson (8):
  Add basic Coccinelle transforms.
  Apply standard object_id Coccinelle transformations.
  Convert struct diff_filespec to struct object_id
  Rename struct diff_filespec's sha1_valid member.
  merge-recursive: convert struct stage_data to use object_id
  merge-recursive: convert struct merge_file_info to object_id
  merge-recursive: convert leaf functions to use struct object_id
  merge-recursive: convert merge_recursive_generic to object_id

 bisect.c                  |   2 +-
 builtin/blame.c           |   6 +-
 builtin/fast-export.c     |  10 +-
 builtin/merge-recursive.c |  20 +--
 builtin/merge.c           |  13 +-
 builtin/reset.c           |   4 +-
 combine-diff.c            |  14 +--
 diff.c                    |  95 +++++++-------
 diffcore-break.c          |   4 +-
 diffcore-rename.c         |  16 +--
 diffcore.h                |   4 +-
 line-log.c                |  12 +-
 merge-recursive.c         | 310 ++++++++++++++++++++++++----------------------
 merge-recursive.h         |   6 +-
 notes-merge.c             |  42 +++----
 refs/files-backend.c      |   4 +-
 standard.cocci            |  83 +++++++++++++
 submodule.c               |   4 +-
 wt-status.c               |   3 +-
 19 files changed, 376 insertions(+), 276 deletions(-)
 create mode 100644 standard.cocci
