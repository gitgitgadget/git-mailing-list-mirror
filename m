From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/17] safe_create_leading_directories(): reduce scope of local variable
Date: Sat, 18 Jan 2014 23:48:46 +0100
Message-ID: <1390085341-2553-3-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:49:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4ei1-00054S-83
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbaARWtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:35 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50653 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751693AbaARWtb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:31 -0500
X-AuditID: 1207440f-b7f306d000006d99-c4-52db04fb487c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 82.EB.28057.BF40BD25; Sat, 18 Jan 2014 17:49:31 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN8t030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:30 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqPub5XaQQc9BQYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M64svkxc8EXloq1L68zNTB+
	YO5i5OSQEDCRmP51IhuELSZx4d56IJuLQ0jgMqPEwwetLBDOCSaJw92nwarYBHQlFvU0M4HY
	IgJqEhPbDrGA2MwCDhKbPzcygtjCAtESi6bOAbNZBFQl3m6eygpi8wo4Szw4vQQozgG0TUFi
	9XUhkDCngIvEkfkXwEYKAZXcfP2EfQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6
	uZkleqkppZsYIaHCv4Oxa73MIUYBDkYlHt6DTLeDhFgTy4orcw8xSnIwKYnyKoOE+JLyUyoz
	Eosz4otKc1KLDzFKcDArifAGb7gVJMSbklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBa
	BJOV4eBQkuD1BsaEkGBRanpqRVpmTglCmomDE0RwgWzgAdkAUshbXJCYW5yZDlF0ilFRSpw3
	HCQhAJLIKM2DGwCL6leM4kD/CENU8QATAlz3K6DBTECDRWJvggwuSURISTUw8j/4IPBFxvXq
	+Yy2s4fU8g95ee9qaFdhXLfkksCT+0KMFmKvpjDb3l8Tei+xbOrto5ZFh/4s0akI/sY38+Od
	43M0XCLfsFzRnF65e+PdPU131huK3Fh4dv6OwAofJ/eQwACdG0GS/zdNPG7lc7WhzM/FaIKO
	Q80Fu+o7rRMTJSwORaxo+qm2WImlOCPRUIu5qDgRAJOR4ErFAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240654>

This makes it more obvious that values of "st" don't persist across
loop iterations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8031d51..d8647c7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -108,9 +108,10 @@ int mkdir_in_gitdir(const char *path)
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path + offset_1st_component(path);
-	struct stat st;
 
 	while (pos) {
+		struct stat st;
+
 		pos = strchr(pos, '/');
 		if (!pos)
 			break;
-- 
1.8.5.2
