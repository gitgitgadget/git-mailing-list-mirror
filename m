From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 14/19] ident: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:33 -0700
Message-ID: <a2787757af5e33b84346d1ebd2ae7084682a086e.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wR-00015K-DR
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbaFIWVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:18 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:54575 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:16 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so5492469pbc.4
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yFih8vsVHZJs9I4TZMR64X46r0P7MqayaaxBl1W7kF4=;
        b=fXUKUaOJG7WYaufbgKYUHRPvLa0W+SJ58+uOyk8lo8/cYz75Z7elqRGTPHB3rKBzqI
         h16ZLEObL9FDet6xYLKFTS6p14Jqh2oBhuRI8WzNMLhzBg4F2oTkfPEX6SFC2tXN5wo5
         3I8cZEBC37GqPTCNJeOKoqqzUNCPR5t4tsKYkhCOpW3Q4Lnb3zwnJ4uNXZKXTmDvuhb8
         Gp5A9gwp7mfH+OShs3/6beflTcrn62ruLiEh5MsJxNIWcH+igLkUFlRRCEfXsMZMzRnC
         w5Z4ZOShwGwfionEJBDpkfs8vFAeGTJ/174va1Bmn+ykOgMvCrz7AuUfnFzEMJ9HMZ9a
         q6yg==
X-Received: by 10.66.183.11 with SMTP id ei11mr1207549pac.116.1402352476589;
        Mon, 09 Jun 2014 15:21:16 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id vk5sm25356723pbc.44.2014.06.09.15.21.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:21:15 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:21:12 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251122>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 ident.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ident.c b/ident.c
index 1d9b6e7..523e249 100644
--- a/ident.c
+++ b/ident.c
@@ -397,8 +397,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
-		strbuf_reset(&git_default_name);
-		strbuf_addstr(&git_default_name, value);
+		strbuf_setstr(&git_default_name, value);
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		return 0;
@@ -407,8 +406,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 	if (!strcmp(var, "user.email")) {
 		if (!value)
 			return config_error_nonbool(var);
-		strbuf_reset(&git_default_email);
-		strbuf_addstr(&git_default_email, value);
+		strbuf_setstr(&git_default_email, value);
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		return 0;
-- 
2.0.0.592.gf55b190
