From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/7] Fix some problems with reflog expiration
Date: Tue,  3 Mar 2015 12:43:10 +0100
Message-ID: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:43:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSlEZ-0003iP-3I
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbbCCLn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:43:27 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61121 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755934AbbCCLn0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 06:43:26 -0500
X-AuditID: 1207440f-f792a6d000001284-e5-54f59e5d0d99
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 67.4F.04740.D5E95F45; Tue,  3 Mar 2015 06:43:25 -0500 (EST)
Received: from michael.fritz.box (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23BhJqD016748
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 06:43:22 -0500
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqBs772uIwbFOcYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLX609DBb9PZ9YrXYvLmdxeLMm0ZGB06Pv+8/MHnsnHWX3WPBplKP
	Z717GD0uXlL2WPzAy+PzJrkA9ihum6TEkrLgzPQ8fbsE7oy9a38xFmznqtix+BVjA+MSji5G
	Dg4JAROJqSe9uhg5gUwxiQv31rN1MXJxCAlcZpRY/GU+K4RzjEni57mFTCBVbAK6Eot6msFs
	EQE1iYlth1hAbGaBH0wSh1bUgtjCAg4S51ZsBYuzCKhKrLuyFMzmFXCRuHvmLTPENjmJ88d/
	Mk9g5F7AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQTIyS0+Hcwdq2XOcQo
	wMGoxMM7gf1riBBrYllxZe4hRkkOJiVRXvnZQCG+pPyUyozE4oz4otKc1OJDjBIczEoivMxz
	gXK8KYmVValF+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQneSSCNgkWp6akVaZk5
	JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBAjy8GhjpIigdo7885IHuLCxJzgaIQracYFaXEeWVB
	5gqAJDJK8+DGwhLGK0ZxoC+FeeNBqniAyQau+xXQYCagwbcUv4AMLklESEk1MNb+7AkW+Gwu
	YjVfV6vlTUoIx5SfSf1b9YqaPyvKKX3Uyu/T6NH5PXXTr1SvD4HP7x+t/3qLb+cP1pnZVqVF
	i1cEyt9f6a9sX8elmncjopn7yv14v+MvF/VN9HwweZqxQj4br2XHOn/271qN13+f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264650>

This is v3 of the patch series. Thanks to Junio for his comments
about v2 [1]; I think this version addresses all of his points.

Changes since v2:

* Introduce a temporary in "struct ref_lock: delete the force_write
  member" to make a complicated boolean expression easier to
  understand.

* Split the documentation of options for "reflog expire" and "reflog
  delete", and make another couple tweaks to the "reflog"
  documentation.

* Add a NEEDSWORK comment suggesting that the "reflog" command should
  use parse_options() to process its command line.

[1] http://thread.gmane.org/gmane.comp.version-control.git/264586

Michael Haggerty (6):
  write_ref_sha1(): remove check for lock == NULL
  write_ref_sha1(): Move write elision test to callers
  lock_ref_sha1_basic(): do not set force_write for missing references
  reflog: improve and update documentation
  reflog_expire(): ignore --updateref for symbolic references
  reflog_expire(): never update a reference to null_sha1

Stefan Beller (1):
  struct ref_lock: delete the force_write member

 Documentation/git-reflog.txt | 144 ++++++++++++++++++++++++++-----------------
 builtin/reflog.c             |   9 +--
 refs.c                       |  65 ++++++++++---------
 3 files changed, 126 insertions(+), 92 deletions(-)

-- 
2.1.4
