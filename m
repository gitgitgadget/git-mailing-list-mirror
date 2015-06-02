From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/3] Fix how for-each-ref handles broken loose references
Date: Tue,  2 Jun 2015 17:57:24 +0200
Message-ID: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:57:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzoZc-0004QF-UZ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 17:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbbFBP5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 11:57:42 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43281 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759109AbbFBP5l (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 11:57:41 -0400
X-AuditID: 1207440c-f79df6d000000d2d-86-556dd2738b74
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.19.03373.372DD655; Tue,  2 Jun 2015 11:57:39 -0400 (EDT)
Received: from michael.fritz.box (p4FC966E3.dip0.t-ipconnect.de [79.201.102.227])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t52FvbBU010977
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 2 Jun 2015 11:57:38 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqFt8KTfU4McqTYszfeEWXVe6mSwa
	eq8wW9xeMZ/Z4kdLD7PF5s3tLA5sHn/ff2DyWLCp1KPpzFFmj2e9exg9Ll5S9vi8SS6ALYrb
	JimxpCw4Mz1P3y6BO+Pa9m+MBVvZK66/6WJrYPzK2sXIySEhYCLxa9NbKFtM4sK99WxdjFwc
	QgKXGSVe3VnKBOGcYJI4dqiRCaSKTUBXYlFPM5gtIqAmMbHtEAuIzSywmVGi82EQiC0s4COx
	Z+0bNhCbRUBVYsKMBjCbV8BF4v6jc2wQ2+Qkzh//yTyBkXsBI8MqRrnEnNJc3dzEzJzi1GTd
	4uTEvLzUIl1DvdzMEr3UlNJNjJCg4dnB+G2dzCFGAQ5GJR5ehk85oUKsiWXFlbmHGCU5mJRE
	eW8czw0V4kvKT6nMSCzOiC8qzUktPsQowcGsJMIruAEox5uSWFmVWpQPk5LmYFES51Vdou4n
	JJCeWJKanZpakFoEk5Xh4FCS4H14AahRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQj
	HhTq8cXAYAdJ8QDtfQHSzltckJgLFIVoPcVozHFnyv9FTBw/LjUuZhJiycvPS5US5/0PUioA
	UppRmge3CJYuXjGKA/0tzBt2EaiKB5hq4Oa9AlrFBLSqXSAHZFVJIkJKqoHRPUlUvqCoUXyT
	25SLCxZ9EhW6/PJq8t+28PaqW6GH1P54uEX+DYt8rVQ8832H+d/0SlGlMx6+HwtLfqa8a0m5
	9IBjj4GczM7tE+s0eAsap8RoHGP5H5VW139x9uYNK9tU5iVc2tZ7Oob9kd6pY4k9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270556>

This is a reroll of [1]. Thanks to Peff and Junio for their comments
about v1.

Changes since v1:

* Use $_z40 to initialize $ZEROS in test.

* Test that "git for-each-ref --format="%(objectname) %(refname)"
  *doesn't* notice references that point at missing objects.

This patch series is also available from my GitHub account [2] as
branch for-each-ref-errors.

[1] http://thread.gmane.org/gmane.comp.version-control.git/270429
[2] https://github.com/mhagger/git

Michael Haggerty (3):
  t6301: new tests of for-each-ref error handling
  for-each-ref: report broken references correctly
  read_loose_refs(): treat NULL_SHA1 loose references as broken

 builtin/for-each-ref.c         |  5 ++++
 refs.c                         |  7 ++++++
 t/t6301-for-each-ref-errors.sh | 56 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100755 t/t6301-for-each-ref-errors.sh

-- 
2.1.4
