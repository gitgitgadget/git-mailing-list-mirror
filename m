From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] config: simplify git_config_include()
Date: Sat, 30 Aug 2014 18:07:05 +0200
Message-ID: <5401F6A9.2000104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 18:07:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNlBY-0002yA-CM
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 18:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbaH3QHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 12:07:24 -0400
Received: from mout.web.de ([212.227.17.11]:55717 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbaH3QHX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 12:07:23 -0400
Received: from [192.168.178.27] ([79.253.135.121]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lr2Zb-1Y1Ta62h87-00eZe1; Sat, 30 Aug 2014 18:07:21
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:j2pPmR5V/YKjNEf0x5fe6exsJLrvc27YB5dajUAMdEZ8bYHf7XT
 LG5m798U7y9wMHOmqFU1VBPK4KEA+7a68uiIgH42YbQ7nbBCfYlECoD2N+myMB34GFFc8Qy
 vFih1UYVaGzN1Z1fs2ON5DcxUp2zEobMiQwoG6Hv8X6rFliGx64bCNm3gE2i+oxJEvPqxAe
 RVtzg4s6AG9Vn5O8xnkCg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256257>

Instead of using skip_prefix() to check the first part of the string
and then strcmp() to check the rest, simply use strcmp() to check the
whole string.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 config.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 058505c..c558a21 100644
--- a/config.c
+++ b/config.c
@@ -127,7 +127,6 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
-	const char *type;
 	int ret;
 
 	/*
@@ -138,10 +137,7 @@ int git_config_include(const char *var, const char *value, void *data)
 	if (ret < 0)
 		return ret;
 
-	if (!skip_prefix(var, "include.", &type))
-		return ret;
-
-	if (!strcmp(type, "path"))
+	if (!strcmp(var, "include.path"))
 		ret = handle_path_include(value, inc);
 	return ret;
 }
-- 
2.1.0
