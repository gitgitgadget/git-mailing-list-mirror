From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Fri,  6 May 2016 18:13:41 +0200
Message-ID: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:14:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiOm-0007yb-P6
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604AbcEFQOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:35 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63737 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758542AbcEFQOe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:34 -0400
X-AuditID: 1207440d-bb3ff7000000090b-8a-572cc2dd4756
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 7D.38.02315.DD2CC275; Fri,  6 May 2016 12:14:21 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUg031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:19 -0400
X-Mailer: git-send-email 2.8.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqHv3kE64wYrH5hbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyHjy6wFpyQr/jzLrGB8b5EFyMHh4SAicT+ffFd
	jFwcQgJbGSUuT7zOBOEcZ5KYvGYOcxcjJwebgK7Eop5mJhBbRCBCouFVCyNIM7PAZ0aJldwg
	YWEBV4l/t/+wg9gsAqoSv598ZASxeQXMJb6ems0KYksIyElcnv6AbQIj1wJGhlWMcok5pbm6
	uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIcHCu4Px/zqZQ4wCHIxKPLwZJ7XDhVgTy4or
	cw8xSnIwKYnyfi/QCRfiS8pPqcxILM6ILyrNSS0+xCjBwawkwntlH1CONyWxsiq1KB8mJc3B
	oiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBG3QQqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1
	LyW1KLG0JCMeFMzxxcBwBknxAO2VB2nnLS5IzAWKQrSeYtTlOLL/3lomIZa8/LxUKXFeA5Ai
	AZCijNI8uBWw1PCKURzoY2HeSSBVPMC0AjfpFdASJqAl7+dqgiwpSURISTUw+u3xFfaU2Xpt
	JofJb+WtvPNeRlRs6P0lOuv+rCUb5P8a8O79ZXDwQ8ayGUtqXomFzLr3bb9IVLt2cESlWb/Q
	r6p3eyQmnJz3jlU0/eGpif8PqIb/W6sYy+924ITVQu9/Rl+5OZfrHOFyZJmt/XJN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293800>

Thanks to David, Junio, and Peff for their comments on v1 of this
patch series [1]. I think I have addressed all of the points that were
brought up. Plus I fixed a pre-existing bug that I noticed myself
while adding some more tests; see the first bullet point below for
more information.

Changes between v1 and v2:

* Prefixed the patch series with three new patches that demonstrate
  and fix some bugs in reference resolution that I noticed while
  inspecting this series:

  * "t1404: demonstrate a bug resolving references" -- this
    demonstrates a bug that has existed since at least 2.5.0.
  * "read_raw_ref(): don't get confused by an empty directory"
  * "commit_ref(): if there is an empty dir in the way, delete it"

* Added a patch "read_raw_ref(): move docstring to header file".

* "ref_transaction_create(): disallow recursive pruning": Add a
  comment that `REF_ISPRUNING` must only be used with `REF_NODEREF`.

* "refs: don't dereference on rename": explain why we can't pass an
  `old_sha1` argument to `delete_ref()`. Inline `resolve_flags`
  constant to make the code more transparent.

* "add_update(): initialize the whole ref_update": move some more
  checks from `ref_transaction_update()` to `add_update()`.

* "refs: resolve symbolic refs first":
  * Remove unused `deleting` parameter from `lock_raw_ref()`
  * Fix a comment, add another.

* "lock_ref_sha1_basic(): only handle REF_NODEREF mode": initialize
  `ref_name` only once, as its value can be reused.

This patch series is also available from my GitHub repo [2] as branch
"split-under-lock".

[1] http://thread.gmane.org/gmane.comp.version-control.git/292772
[2] https://github.com/mhagger/git

David Turner (2):
  refs: allow log-only updates
  refs: don't dereference on rename

Michael Haggerty (31):
  t1404: demonstrate a bug resolving references
  commit_ref(): if there is an empty dir in the way, delete it
  read_raw_ref(): don't get confused by an empty directory
  safe_create_leading_directories(): improve docstring
  remove_dir_recursively(): add docstring
  refname_is_safe(): use skip_prefix()
  refname_is_safe(): don't allow the empty string
  refname_is_safe(): insist that the refname already be normalized
  commit_ref_update(): write error message to *err, not stderr
  rename_ref(): remove unneeded local variable
  ref_transaction_commit(): remove local variable n
  read_raw_ref(): rename flags argument to type
  read_raw_ref(): clear *type at start of function
  read_raw_ref(): rename symref argument to referent
  read_raw_ref(): improve docstring
  read_raw_ref(): move docstring to header file
  lock_ref_sha1_basic(): remove unneeded local variable
  refs: make error messages more consistent
  ref_transaction_create(): disallow recursive pruning
  ref_transaction_commit(): correctly report close_ref() failure
  delete_branches(): use resolve_refdup()
  verify_refname_available(): adjust constness in declaration
  add_update(): initialize the whole ref_update
  lock_ref_for_update(): new function
  unlock_ref(): move definition higher in the file
  ref_transaction_update(): check refname_is_safe() at a minimum
  refs: resolve symbolic refs first
  lock_ref_for_update(): don't re-read non-symbolic references
  lock_ref_for_update(): don't resolve symrefs
  commit_ref_update(): remove the flags parameter
  lock_ref_sha1_basic(): only handle REF_NODEREF mode

 builtin/branch.c                   |  19 +-
 cache.h                            |   5 +
 dir.h                              |  23 +
 refs.c                             |  96 ++--
 refs/files-backend.c               | 909 ++++++++++++++++++++++++++++---------
 refs/refs-internal.h               |  95 +++-
 t/t1400-update-ref.sh              |  41 +-
 t/t1404-update-ref-df-conflicts.sh |  76 +++-
 t/t1430-bad-ref-name.sh            |   2 +-
 t/t3200-branch.sh                  |   9 +
 10 files changed, 1013 insertions(+), 262 deletions(-)

-- 
2.8.1
