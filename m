From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 4/9] url: add str wrapper for end_url_with_slash()
Date: Thu, 25 Nov 2010 16:21:05 +0800
Message-ID: <1290673270-4284-5-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-2-git-send-email-rctay89@gmail.com>
 <1290673270-4284-3-git-send-email-rctay89@gmail.com>
 <1290673270-4284-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>, rctay@nus.edu.sg
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLX6b-0008Tt-PI
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab0KYIW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:22:56 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab0KYIWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:22:55 -0500
Received: by mail-iw0-f174.google.com with SMTP id 5so389iwn.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SOcZ856J/EiEyyN1jL+66imh9EKgw0nmDfxG1ZxMLbc=;
        b=m172wrUlpMeOaJiBZNpQNF6xPhZr1iS+tdj4j1BCadXQuig4TSP5y5BLMtXWt8uE5W
         t6nN3GIFxjoxMSnR8vVXB9czZuar5ov7QPqVt0I5BUm3LH3jRNcqyNULtA6S76AvKGKG
         Mu5cWketqurcBL0jHELE7K+KVpeCWV7N2M5mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WidVTSDUFDINyYgUnE17WoqnRwVWe7IF6xvR+Z4vlfmL9g/oPGMNGnI4tuoM9jUfQX
         cejrgP5jUIzwcOTszgUa+FubCZfgNbIVQ/6fWUBhvM0g94gWjI9K8Ydi+msSgh8zw+09
         FBlHyOjq9pV2eCxyuG7H0BKGP2LKBlIFTtPBY=
Received: by 10.231.39.198 with SMTP id h6mr367049ibe.21.1290673375164;
        Thu, 25 Nov 2010 00:22:55 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.22.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:22:54 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290673270-4284-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162109>

Helped-by: Johnathan Nieder <jrnieder@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed from v2: removed pointer check before free(), as suggested by Johnathan.

 url.c |    7 +++++++
 url.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/url.c b/url.c
index 7cebc64..6a54959 100644
--- a/url.c
+++ b/url.c
@@ -132,3 +132,10 @@ void end_url_with_slash(struct strbuf *buf, const char *url)
 	if (buf->len && buf->buf[buf->len - 1] != '/')
 		strbuf_addstr(buf, "/");
 }
+
+void str_end_url_with_slash(const char *url, char **dest) {
+	struct strbuf buf = STRBUF_INIT;
+	end_url_with_slash(&buf, url);
+	free(*dest);
+	*dest = strbuf_detach(&buf, NULL);
+}
diff --git a/url.h b/url.h
index 8cb74d4..7100e32 100644
--- a/url.h
+++ b/url.h
@@ -8,5 +8,6 @@ extern char *url_decode_parameter_name(const char **query);
 extern char *url_decode_parameter_value(const char **query);
 
 extern void end_url_with_slash(struct strbuf *buf, const char *url);
+extern void str_end_url_with_slash(const char *url, char **dest);
 
 #endif /* URL_H */
-- 
1.7.3.2.495.gc7b3f
