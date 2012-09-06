From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/8] real_path(): reject the empty string
Date: Fri,  7 Sep 2012 00:41:01 +0200
Message-ID: <1346971264-23744-6-git-send-email-mhagger@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:42:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9klu-0007lO-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab2IFWlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:41:44 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:54271 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754261Ab2IFWlm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:41:42 -0400
X-AuditID: 1207440c-b7f616d00000270b-ce-504926a5b0a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id F1.C9.09995.5A629405; Thu,  6 Sep 2012 18:41:41 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MfGJX025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:41:39 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLtUzTPAYOFZQYuuK91MFg29V5gt
	nsy9y2xxe8V8Zov1ixpYLbqnvGV0YPP4+/4Dk8fOWXfZPR6+6mL3uHhJ2ePzJrkA1ihum6TE
	krLgzPQ8fbsE7ox7i26xFkziqFi0+TdTA+MRti5GTg4JAROJiStesEDYYhIX7q0HinNxCAlc
	ZpTYvus3O4Rzmkmi99t5sA42AV2JRT3NTCC2iICaxMS2Q2DdzALnGSX+3GQHsYUFbCQ+N7WD
	1bAIqEpcmTcVrJdXwEXi49ZrzBDbFCV+fF8DZHNwcAq4SkxbIAcSFgIqmff+NtsERt4FjAyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MUKCi2cH47d1MocYBTgYlXh4J5z3
	CBBiTSwrrsw9xCjJwaQkyvtPyTNAiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvxF9A5bwpiZVV
	qUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd6ZqkBDBYtS01Mr0jJzShDSTByc
	IIILZAMP0AYeYFwK8RYXJOYWZ6ZDFJ1iVJQS5y0CmSAAksgozYMbAEsDrxjFgf4R5g0CqeIB
	phC47ldAg5mABos8Azm9uCQRISXVwMi6sNl+ZUho6L+cbVsk5/QcvazfHf4/dYWAx8I3Le8m
	X5wbtkc/pLzt5X6fb5X7krjrjWP/3npxN+5KycM4B+V9Cn84z0Tc0d6Vuyh0vX3WmyWmTxjn
	3NI48oS57JPXuYm6l7hNtxXsC97wSmj7oea4O8Z7v2p/kru24p6IsLZYQ6+0yf8X 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204936>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c             | 3 +++
 t/t0060-path-utils.sh | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index 5d62430..3e8325c 100644
--- a/abspath.c
+++ b/abspath.c
@@ -35,6 +35,9 @@ const char *real_path(const char *path)
 	if (path == buf || path == next_buf)
 		return path;
 
+	if (!*path)
+		die("The empty string is not a valid path");
+
 	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
 		die ("Too long path: %.*s", 60, path);
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 1118056..fab5ea2 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -144,7 +144,7 @@ test_expect_success 'absolute path rejects the empty string' '
 	test_must_fail test-path-utils absolute_path ""
 '
 
-test_expect_failure 'real path rejects the empty string' '
+test_expect_success 'real path rejects the empty string' '
 	test_must_fail test-path-utils real_path ""
 '
 
-- 
1.7.11.3
