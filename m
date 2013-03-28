From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] remote.c: simplify a bit of code using git_config_string()
Date: Thu, 28 Mar 2013 18:56:37 +0530
Message-ID: <1364477202-5742-2-git-send-email-artagnon@gmail.com>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCqC-00039X-G9
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060Ab3C1NZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:25:33 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:53889 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711Ab3C1NZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:25:31 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so2213938pad.6
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ClCwXfyC4+4IAlhXWLIFB7k0AL0PN2aXduYFd4gBlbc=;
        b=0IqlPX/VPGWEPiUzarbsYyUmSpXQ0Pz5lDKMQPKG31RdtvzDD8lEULSrVVjtzPW5tD
         TTFzefGSU9M6D4aKK8ZoYSazicBOtA5NkzZfsq0P3qYogvZ4AD/AIZ5EX1/yMbKLC3go
         nDeGv1eBmtv0Ygc6yzH/RiVVHivLdBt+t0cDmAnroEBgBN3tVvRasDG6sUSQ+BeDYedO
         ssK+D0iIysfOjI+KjXlrE6ch8MbgkpBMniTwyJPlLSB8ByOPTRuNJz4o8xKriT7U5K6h
         o0uelmL36kVQw7ZS2EwhQ+AyHV0QWGX1K0/QowXaTL7tgLBbpabG3zTE70JjwKfY1y8V
         GsfQ==
X-Received: by 10.68.11.35 with SMTP id n3mr35169242pbb.220.1364477130527;
        Thu, 28 Mar 2013 06:25:30 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id tm1sm25586603pbc.11.2013.03.28.06.25.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 06:25:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.g3797f84
In-Reply-To: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219389>

A small segment where handle_config() parses the branch.remote
configuration variable can be simplified using git_config_string().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 174e48e..02e6c4c 100644
--- a/remote.c
+++ b/remote.c
@@ -357,9 +357,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 			return 0;
 		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
-			if (!value)
-				return config_error_nonbool(key);
-			branch->remote_name = xstrdup(value);
+			if (git_config_string(&branch->remote_name, key, value))
+				return -1;
 			if (branch == current_branch) {
 				default_remote_name = branch->remote_name;
 				explicit_default_remote_name = 1;
-- 
1.8.2.141.g3797f84
