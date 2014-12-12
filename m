From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/24] Add reflog_expire() to the references API
Date: Fri, 12 Dec 2014 09:56:39 +0100
Message-ID: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM3K-0005Ff-M8
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934679AbaLLI5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:21 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59919 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934049AbaLLI5U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:20 -0500
X-AuditID: 12074414-f797f6d000004084-56-548aade89ebf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.03.16516.8EDAA845; Fri, 12 Dec 2014 03:57:12 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nA023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:10 -0500
X-Mailer: git-send-email 2.1.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqPtibVeIwZaJEhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujIkHlzAWXBarONO0ib2BcYdQFyMnh4SAicSJd3NYIGwxiQv31rN1MXJxCAlc
	ZpTYOrGVGcI5xiTxdcI+dpAqNgFdiUU9zUwgtoiAmsTEtkNg3cwCJxglZjeEgNjCAs4SL7bO
	YwOxWQRUJR7P3gpWzwsU/3/gAVCcA2ibnMTWdd4TGLkXMDKsYpRLzCnN1c1NzMwpTk3WLU5O
	zMtLLdK10MvNLNFLTSndxAgJFZEdjEdOyh1iFOBgVOLhfZHaFSLEmlhWXJl7iFGSg0lJlPf7
	ZKAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6/UUA53pTEyqrUonyYlDQHi5I477fF6n5CAumJ
	JanZqakFqUUwWRkODiUJ3qNrgBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQYEe
	XwwMdZAUD9BetrUge4sLEnOBohCtpxgVpcR5T4PMFQBJZJTmwY2FJYBXjOJAXwrzOoJU8QCT
	B1z3K6DBTECDl2/pABlckoiQkmpgnLfAsIelT8VtilzQLNbLy7uFb1z3leL5UnSliV2CY5XE
	xVbHXcf+yEwqLLzP8G+z/+pwt6QInb4O016J+p1FjcHz5jzRWLtylXHMn233ZsS6Kiht2DL/
	e47PkvqvK/kaEorOpFS+WCiwf/OS4KUOWQkm9bl6R7m4Guzyeuct/tT2WU17ebeC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261339>

This is v2 of the series. Thanks to Jonathan, Stefan, Junio, and
Ronnie for their feedback on v1 [1]. I think I have addressed all of
the issues that were raised.

Changes since v1:

* Several improvements to commit messages and comments; added some
  Reviewed-by comments from the mailing list.

* Change the signature of expire_reflog() early in the series to cast
  off its heritage as an each_ref_fn.

* Move the static lock_file object into expire_reflog(), and explain
  the locking policy better.

* Report errors if hold_lock_file_for_update() or fdopen_lock_file()
  fails.

* Fix the capitalization in some error messages.

* When "enum expire_reflog_flags" is first introduced, put its
  definition earlier in the file so that a later patch in the series
  doesn't have to move it.

* Rename reflog_expiry_select_fn to reflog_expiry_should_prune_fn.

* Append Stefan's patch 24/24 "refs.c: let fprintf handle the
  formatting"

This branch is also available on GitHub:

    https://github.com/mhagger/git.git, branch reflog-expire-api-v2

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/260812

Michael Haggerty (18):
  expire_reflog(): it's not an each_ref_fn anymore
  expire_reflog(): rename "ref" parameter to "refname"
  expire_reflog(): return early if the reference has no reflog
  expire_reflog(): use a lock_file for rewriting the reflog file
  Extract function should_expire_reflog_ent()
  expire_reflog(): extract two policy-related functions
  expire_reflog(): add a "flags" argument
  expire_reflog(): move dry_run to flags argument
  expire_reflog(): move updateref to flags argument
  Rename expire_reflog_cb to expire_reflog_policy_cb
  struct expire_reflog_cb: a new callback data type
  expire_reflog(): pass flags through to expire_reflog_ent()
  expire_reflog(): move verbose to flags argument
  expire_reflog(): move rewrite to flags argument
  Move newlog and last_kept_sha1 to "struct expire_reflog_cb"
  expire_reflog(): treat the policy callback data as opaque
  reflog_expire(): new function in the reference API
  lock_any_ref_for_update(): inline function

Ronnie Sahlberg (4):
  refs.c: make ref_transaction_create a wrapper for
    ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update
  refs.c: add a function to append a reflog entry to a fd
  refs.c: remove unlock_ref/close_ref/commit_ref from the refs api

Stefan Beller (2):
  refs.c: don't expose the internal struct ref_lock in the header file
  refs.c: let fprintf handle the formatting

 builtin/reflog.c | 259 ++++++++++++++++++++++--------------------------------
 refs.c           | 263 ++++++++++++++++++++++++++++++++++++++-----------------
 refs.h           |  75 ++++++++++------
 3 files changed, 332 insertions(+), 265 deletions(-)

-- 
2.1.3
