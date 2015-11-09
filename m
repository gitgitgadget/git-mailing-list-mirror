From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 00/11] refs backend pre-vtable
Date: Mon,  9 Nov 2015 18:03:37 +0100
Message-ID: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:04:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvpre-0007ey-T0
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbbKIREL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:04:11 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50061 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978AbbKIREH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:04:07 -0500
X-AuditID: 12074411-f797e6d000007df3-79-5640d204de2a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id FB.74.32243.402D0465; Mon,  9 Nov 2015 12:04:04 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Yn026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:02 -0500
X-Mailer: git-send-email 2.6.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqMtyySHM4PAWK4v5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG26O37xOrA7vH3/Qcmj52z7rJ7nD2Y6fGsdw+jx8VLyh4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO2PO13aWghVKFX9uuDYwvpTqYuTkkBAwkWh/u4Qd
	whaTuHBvPVsXIxeHkMBlRomOg19ZIZwTTBIzm/uZQarYBHQlFvU0M4HYIgJqEhPbDrGAFDEL
	fGSUmPtjIVhCWMBQ4tbsG0DdHBwsAqoSh7YmgIR5BcwlrjfcZ4XYJicx5X470wRG7gWMDKsY
	5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxQgJJcAfjjJNyhxgFOBiVeHgZptuH
	CbEmlhVX5h5ilORgUhLljT7hECbEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLdgF1CONyWxsiq1
	KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTBu+kCUKNgUWp6akVaZk4JQpqJgxNk
	OJeUSHFqXkpqUWJpSUY8KNDji4GhDpLiAdq7A6Sdt7ggMRcoCtF6ilGX48n8S3uYhFjy8vNS
	pcR5xS8CFQmAFGWU5sGtgKWNV4ziQB8L8xqAVPEAUw7cpFdAS5iAliz1B1tSkoiQkmpg7Fs6
	j3G9hDbDZQ/G60fY84LsGn4+f3xtgaXqlge2jAWdRxuEbnh9PNGpsDj1ZGsaiwT/vPPnNG5x
	nqls3uq1cuNtj9VV77O5njTGujRf9pfdbrZG5t5TpZ3xn5dp/fq/0TVa3+SH5JIu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281057>

This is another reroll of the pre-vtable part of the refs-backend
patch series dt/refs-backend-pre-vtable. v6 [1] proved cumbersome
because it conflicted messily with lf/ref-is-hidden-namespace [2]. The
conflicts were partly due to the motion of code across files but, even
worse, due to the change of order of function definitions between old
and new files.

So I have heavily "optimized" this reroll for reviewability and to
minimize conflicts with other work in the area. The only such work
that I know of is lf/ref-is-hidden-namespace, which can now be merged
with this series *without conflicts*.

Changes since v6:

* It doesn't move refs.c to the refs/ subdirectory, as v6 did.
  Instead, leave the shared code in the existing file, refs.c.

* Don't rename refs.c to refs/files-backend.c and then selectively
  move content back to refs.c. Instead, move content only once and
  only in one direction, namely from refs.c -> refs/files-backend.c
  (in patch 08/11). This is a giant commit but *it makes no other
  changes* so it should be easy to review. (The "--patience" option of
  "git diff" is quite helpful here. It was turned on when this patch
  series was generated.)

* Preserve the order of code during the move. Aside from a few lines
  of boilerplate, each of the following commands, when applied to
  commit 08, shows only lines being deleted:

    git diff --patience $commit^:refs.c $commit:refs.c
    git diff --patience $commit^:refs.c $commit:refs/files-backend.c

* To make all of the above possible, patches 01 through 06 do a little
  bit of preparatory code untangling. These commits have themselves
  been split up a bit to make them as "obviously correct" as possible.
  Patch 07 creates the new header file, refs/refs-internal.h, thereby
  increasing the visibility of some declarations.

* The final patches 09, 10, and 11 are not quite as "obviously
  correct" as the first eight, but I left them in to keep the logical
  contents of this patch series the same as v6. But these last three
  commits could just as well be postponed until the next tranche of
  patches if that helps speed the way of the first eight patches into
  master.

* I also fixed a commit message and fixed the implementation of the
  new verify_refname_available() function to return a negative number
  on error as documented (previously it returned 1 on error).

I've tried to attribute authorship of these changes as fairly as
possible based on who initiated the corresponding changes. If anybody
feels that I have appropriated his work or, conversely, put words into
his mouth, just let me know and I would be happy to adjust the
authorship.

It would be great to get this patch series (at least the first eight
patches) reviewed and merged as soon as possible. Even though it no
longer conflicts with lf/ref-is-hidden-namespace, it is still very
prone to conflicting with any other work in the references code.

This patch series is also available on my GitHub fork [3] as branch
"refs-backend-pre-vtable".

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/280325/focus=280754
[2] http://article.gmane.org/gmane.comp.version-control.git/281004
[3] https://github.com/mhagger/git

David Turner (5):
  refs: make is_branch public
  copy_msg(): rename to copy_reflog_msg()
  initdb: make safe_create_dir public
  files_log_ref_write: new function
  refs: break out ref conflict checks

Michael Haggerty (4):
  pack_if_possible_fn(): use ref_type() instead of is_per_worktree_ref()
  refname_is_safe(): improve docstring
  refs/refs-internal.h: new header file
  refs: split filesystem-based refs code into a new file

Ronnie Sahlberg (2):
  verify_refname_available(): rename function
  verify_refname_available(): new function

 Makefile                       |    3 +-
 builtin/init-db.c              |   12 -
 cache.h                        |    8 +
 path.c                         |   12 +
 refs.c                         | 3709 +---------------------------------------
 refs.h                         |    2 +
 refs.c => refs/files-backend.c | 1287 +-------------
 refs/refs-internal.h           |  202 +++
 8 files changed, 315 insertions(+), 4920 deletions(-)
 copy refs.c => refs/files-backend.c (75%)
 create mode 100644 refs/refs-internal.h

-- 
2.6.2
