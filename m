From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 0/6] Improve tag checking in fsck and with
 transfer.fsckobjects
Date: Fri, 12 Sep 2014 10:07:43 +0200 (CEST)
Message-ID: <cover.1410509168.git.johannes.schindelin@gmx.de>
References: <cover.1410445430.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 12 10:07:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSLtb-00051J-St
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 10:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbaILIHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 04:07:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:60320 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbaILIHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 04:07:48 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MOSNd-1XPLcg3sHt-005ruh;
 Fri, 12 Sep 2014 10:07:43 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410445430.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:+x3sxCh9rRs4R3ug9+Kzi+IHNhUrr+NbApr1/46Pd3VAgAn4Vdq
 W5L+ZHrtwFVWjW5JxoFbJm4ElvmoGYmaCBQMOY8Nxjh07CgNrDh55UmzlPN3NIC5GSnvS0E
 WBJFqCULLYk3XNB5ef0RtOKsBvSh0yDTGQs8DggCsdknfTWAj2LNBxkExRBesxtkxgfDEmU
 ueNK2dM1HUwgm5HtdV4RQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256906>

This patch series introduces detailed checking of tag objects when
calling git fsck, and also when transfer.fsckobjects is set to true.

To this end, the fsck machinery is reworked to accept the buffer and
size of the object to check, and for commit and tag objects, we verify
that the buffers contain an end of header (i.e. an empty line) to
guarantee that our checks do not run beyond the buffer.

This work was sponsored by GitHub.

Changes since v3:

- removed undesired negativity from commit message

- removed space in '2> err'

Johannes Schindelin (6):
  Refactor type_from_string() to avoid die()ing in case of errors
  Accept object data in the fsck_object() function
  Make sure fsck_commit_buffer() does not run out of the buffer
  fsck: check tag objects' headers
  Add regression tests for stricter tag fsck'ing
  Make sure that index-pack --strict checks tag objects

 builtin/fsck.c           |   2 +-
 builtin/index-pack.c     |   3 +-
 builtin/unpack-objects.c |  14 +++--
 fsck.c                   | 133 +++++++++++++++++++++++++++++++++++++++++++----
 fsck.h                   |   4 +-
 object.c                 |  11 +++-
 object.h                 |   3 +-
 t/t1450-fsck.sh          |  20 +++++++
 t/t5302-pack-index.sh    |  19 +++++++
 9 files changed, 189 insertions(+), 20 deletions(-)

-- 
2.0.0.rc3.9669.g840d1f9
