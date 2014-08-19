From: Bernhard Reiter <ockham@raz.or.at>
Subject: [PATCH] imap-send.c: imap_folder -> imap_server_conf.folder
Date: Tue, 19 Aug 2014 23:27:11 +0200
Message-ID: <53F3C12F.3020606@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 23:27:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJqw5-0001xW-TE
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 23:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbaHSV1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 17:27:17 -0400
Received: from mhub.domainplanet.at ([92.43.99.119]:54570 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbaHSV1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 17:27:16 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 1833D9D46A1
	for <git@vger.kernel.org>; Tue, 19 Aug 2014 23:27:12 +0200 (CEST)
Received: from [10.0.0.88] (62-46-147-229.adsl.highway.telekom.at [62.46.147.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 53FBCBFB8A
	for <git@vger.kernel.org>; Tue, 19 Aug 2014 23:27:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255519>

Rename the imap_folder variable to folder and make it a member
of struct imap_server_conf.

Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
---
As discussed in
http://www.mail-archive.com/git@vger.kernel.org/msg57019.html

Bernhard

 imap-send.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index fb01a9c..05a02b5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -69,6 +69,7 @@ struct imap_server_conf {
 	char *tunnel;
 	char *host;
 	int port;
+	char *folder;
 	char *user;
 	char *pass;
 	int use_ssl;
@@ -82,6 +83,7 @@ static struct imap_server_conf server = {
 	NULL,	/* tunnel */
 	NULL,	/* host */
 	0,	/* port */
+	NULL,	/* folder */
 	NULL,	/* user */
 	NULL,	/* pass */
 	0,   	/* use_ssl */
@@ -1323,8 +1325,6 @@ static int split_msg(struct strbuf *all_msgs,
struct strbuf *msg, int *ofs)
 	return 1;
 }
 -static char *imap_folder;
-
 static int git_imap_config(const char *key, const char *val, void *cb)
 {
 	if (!skip_prefix(key, "imap.", &key))
@@ -1339,7 +1339,7 @@ static int git_imap_config(const char *key, const
char *val, void *cb)
 		return config_error_nonbool(key);
  	if (!strcmp("folder", key)) {
-		imap_folder = xstrdup(val);
+		server.folder = xstrdup(val);
 	} else if (!strcmp("host", key)) {
 		if (starts_with(val, "imap:"))
 			val += 5;
@@ -1387,7 +1387,7 @@ int main(int argc, char **argv)
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 -	if (!imap_folder) {
+	if (!server.folder) {
 		fprintf(stderr, "no imap store specified\n");
 		return 1;
 	}
@@ -1424,7 +1424,7 @@ int main(int argc, char **argv)
 	}
  	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" :
"");
-	ctx->name = imap_folder;
+	ctx->name = server.folder;
 	while (1) {
 		unsigned percent = n * 100 / total;
 -- 2.1.0.3.g63c96dd
