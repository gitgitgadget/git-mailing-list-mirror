From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/18] Improve handling of D/F conflicts
Date: Mon, 11 May 2015 17:25:02 +0200
Message-ID: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:25:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrpaT-0002S7-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbbEKPZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:37 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61958 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbbEKPZg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:36 -0400
X-AuditID: 1207440e-f79bc6d000000c43-57-5550c9e74218
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.55.03139.7E9C0555; Mon, 11 May 2015 11:25:27 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnC002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:25 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqPv8ZECowZUTlhZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7owfFw6yFmwXqdh0fB9zA+NzgS5GTg4JAROJS3sOM0LYYhIX7q1n62Lk
	4hASuMwocaN1GzOEc5xJovnXJ7AqNgFdiUU9zUwgtoiAmsTEtkMsIEXMArsYJe4tncoCkhAW
	sJa40nGXFcRmEVCV+PVyD1icV8BF4sLXdVDr5CTOH//JPIGRewEjwypGucSc0lzd3MTMnOLU
	ZN3i5MS8vNQiXWO93MwSvdSU0k2MkLDh28HYvl7mEKMAB6MSD6/BBf9QIdbEsuLK3EOMkhxM
	SqK8v/YGhArxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4VVeA5TjTUmsrEotyodJSXOwKInzqi1R
	9xMSSE8sSc1OTS1ILYLJynBwKEnwNp4AahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwt
	yYgHBXt8MTDcQVI8QHu/grTzFhck5gJFIVpPMSpKifPKAuNZSAAkkVGaBzcWlgxeMYoDfSnM
	ux6knQeYSOC6XwENZgIa7BgHNrgkESEl1cAof3PBCR/ZSe/i/bdOKc/e7vfZIIWh5FvPqRbe
	bzeUevkn9c2awBC8VrVqdk9d2dEFS9e5cWwsr2Itl8hLYd50ebZ5DN9lyzcTAuccNXjkcnfu
	3mPrTG4cCTicwsJTo2f4fmt65SJ5C1357L0b/3NzV/9peLCtUyN91UxD6c2fc+Nn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268778>

This is a re-roll of [1]. This patch series improves the handling of
conflicts between references like "refs/foo" and "refs/foo/bar" that
are not allowed to co-exist. It also changes some functions in this
area to record their error messages in a "struct strbuf *err" argument
rather than sometimes emitting errors directly to stderr.

Changes relative to v1:

* Rebase to master rather than depending on
  mh/ref-lock-avoid-running-out-of-fds, as did v1. There were no
  significant dependencies between the two patch series, and now that
  mh/ref-lock-avoid-running-out-of-fds (now renamed to
  mh/write-refs-sooner.*) has been backported to 2.2, the dependency
  makes even less sense.

* Fix leak of "reason" string in ref_transaction_commit().

* Fix a broken &&-chain in t1404 and fix the function definition as
  per Junio's "SQUASH???" commit.

Thanks to Stefan, Junio, and Eric for their comments regarding v1.

As usual, this patch series is also available from my GitHub
repository [2], as branch "check-df-conflicts-earlier".

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/268117
[2] https://github.com/mhagger/git

Michael Haggerty (18):
  t1404: new tests of ref D/F conflicts within transactions
  is_refname_available(): revamp the comments
  is_refname_available(): avoid shadowing "dir" variable
  is_refname_available(): convert local variable "dirname" to strbuf
  entry_matches(): inline function
  report_refname_conflict(): inline function
  struct nonmatching_ref_data: store a refname instead of a ref_entry
  is_refname_available(): use dirname in first loop
  ref_transaction_commit(): use a string_list for detecting duplicates
  refs: check for D/F conflicts among refs created in a transaction
  verify_refname_available(): rename function
  verify_refname_available(): report errors via a "struct strbuf *err"
  lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
  lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts
  rename_ref(): integrate lock_ref_sha1_basic() errors into ours
  ref_transaction_commit(): provide better error messages
  ref_transaction_commit(): delete extra "the" from error message
  reflog_expire(): integrate lock_ref_sha1_basic() errors into ours

 refs.c                             | 309 ++++++++++++++++++++++++-------------
 t/t1400-update-ref.sh              |  14 +-
 t/t1404-update-ref-df-conflicts.sh | 107 +++++++++++++
 3 files changed, 312 insertions(+), 118 deletions(-)
 create mode 100755 t/t1404-update-ref-df-conflicts.sh

-- 
2.1.4
