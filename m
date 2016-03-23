From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/21] t1430: test for-each-ref in the presence of badly-named refs
Date: Wed, 23 Mar 2016 11:04:21 +0100
Message-ID: <ec680e35e10657ba1ba17e561ae06f1851b10a0b.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiflj-0000Ak-DC
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbcCWKMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:00 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55483 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741AbcCWKL7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:11:59 -0400
X-AuditID: 12074412-b07ff70000006da4-d9-56f26a45cef9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 91.0C.28068.54A62F65; Wed, 23 Mar 2016 06:04:53 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g19018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:52 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqOua9SnMYPdjJYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZM77MZCuYxVPxbtomlgbGg1xdjJwcEgImEuenHmfsYuTiEBLYyihx
	/+JKZgjnJJPEmhkfGUGq2AR0JRb1NDOB2CICahIT2w6xgBQxCyxglNi4eDEzSEJYIFjixOXf
	rCA2i4CqxIVjG4FsDg5egSiJt5dsILYpSWx4cAFsDqeAhcTJk0vB5gsJmEtsf7CWaQIjzwJG
	hlWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYIeEktINx/Um5Q4wCHIxKPLwS
	Zz6GCbEmlhVX5h5ilORgUhLlPR/0KUyILyk/pTIjsTgjvqg0J7X4EKMEB7OSCC9nJlCONyWx
	siq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mCVwCkUbAoNT21Ii0zpwQhzcTB
	CTKcS0qkODUvJbUosbQkIx4UA/HFwCgASfEA7eUF21tckJgLFIVoPcWoKCXOq5EBlBAASWSU
	5sGNhSWJV4ziQF8K8+4AqeIBJhi47ldAg5mABi/0ARtckoiQkmpglIzOr/k8afP9GNnXbxc5
	ndiYcI7NYtqCRwWLXrhtsnF2sZi10qHOJ272np2X3xz9Iz8rYZbBy2kT3l3PzjL/JMnrKxL6
	8N7e/hLRfu6HV5bdWagwt/Cqev//1/mN20Xnxr+dN7HkSYgtR/FWW94vM2Ibbj+Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289625>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index a963951..612cc32 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -155,6 +155,22 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	test_i18ngrep "ignoring dangling symref refs/tags/shadow" err
 '
 
+test_expect_success 'for-each-ref emits warnings for broken names' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	printf "ref: refs/heads/master\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git for-each-ref >output 2>error &&
+	! grep -e "broken\.\.\.ref" output &&
+	! grep -e "badname" output &&
+	! grep -e "broken\.\.\.symref" output &&
+	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
+	test_i18ngrep "ignoring broken ref refs/heads/badname" error &&
+	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.symref" error
+'
+
 test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
-- 
2.8.0.rc3
