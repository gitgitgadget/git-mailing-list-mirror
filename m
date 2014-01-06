From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/17] safe_create_leading_directories(): rename local variable
Date: Mon,  6 Jan 2014 14:45:22 +0100
Message-ID: <1389015935-21936-5-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AW1-0006PI-LF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbaAFNqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:19 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52319 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482AbaAFNqS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:18 -0500
X-AuditID: 12074412-b7fc96d0000023d5-0e-52cab3a98a2b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 68.09.09173.9A3BAC25; Mon,  6 Jan 2014 08:46:17 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfP5021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:16 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqLty86kgg4uHpC26rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzZn0WLLjJXjF7/w7GBsYGti5GTg4JAROJFVfms0PYYhIX7q0HinNxCAlcZpTYdXot
	I4RzjEliwux2RpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAosZJbqmfQMq4uAQFgiSeH4FrIZF
	QFViz+IzYNt4BVwktsw8wA5SIiGgILH6uhBImFPAVWLatMNgJUJAJWsOPWKZwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIQAntYFx/Uu4QowAHoxIP74fHJ4OE
	WBPLiitzDzFKcjApifJyrj4VJMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEl2sBUI43JbGyKrUo
	HyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYJXERg5QoJFqempFWmZOSUIaSYOThDB
	BbKBB2jDlU0gG4oLEnOLM9Mhik4xKkqJ8wqCTBAASWSU5sENgMX+K0ZxoH+EeXVAqniAaQOu
	+xXQYCagwaFxYINLEhFSUg2MUv+Xe3f7lcTdeav0yu/oxyXLp+YdXlLh+KC66fP2O/4rqy85
	lbmbyBU/Xr5rgY/j7Q1NXW8E+R8H9fL3ha1jLK0vn/9y5qvwPdx6V5Ys9VH7r34x4NKqwDaR
	T+03xXUS9co4jlZPX6v6Q/W+Vmd4Sur11hlve3fcXcKl+myp8C6PK+736/ZtU2Ip 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240003>

Rename "pos" to "next_component", because now it always points at the
next component of the path name that has to be processed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 197766d..54202e8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -107,18 +107,18 @@ int mkdir_in_gitdir(const char *path)
 
 int safe_create_leading_directories(char *path)
 {
-	char *pos = path + offset_1st_component(path);
+	char *next_component = path + offset_1st_component(path);
 
-	while (pos) {
+	while (next_component) {
 		struct stat st;
-		char *slash = strchr(pos, '/');
+		char *slash = strchr(next_component, '/');
 
 		if (!slash)
 			break;
 		while (*(slash + 1) == '/')
 			slash++;
-		pos = slash + 1;
-		if (!*pos)
+		next_component = slash + 1;
+		if (!*next_component)
 			break;
 
 		*slash = '\0';
-- 
1.8.5.2
