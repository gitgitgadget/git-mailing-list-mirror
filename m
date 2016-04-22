From: santiago@nyu.edu
Subject: [PATCH v8 6/6] tag -v: verify directly rather than exec-ing verify-tag
Date: Fri, 22 Apr 2016 10:52:05 -0400
Message-ID: <1461336725-29915-7-git-send-email-santiago@nyu.edu>
References: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:52:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcRW-0005C3-Iy
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbcDVOwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:52:22 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35644 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbcDVOwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:52:16 -0400
Received: by mail-qg0-f51.google.com with SMTP id f74so54495830qge.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhohPyhN/SALINgv3+ZmaXEZuCaRtvKN5O9czn34M/k=;
        b=j3N57Rdzj+lP2LkK8nYn1WYIDwYoI/y6Ssc0DjWvJyHnQhmG+LSHzLCniZfTzgaiG9
         iVerr4a/w/6J617CM3Ej2rXOwsoSJg/p/2THJL+Y/gSDmijmGFseKkXYVecQ1sfwDi6a
         JLljN+7PKSNwQdXQo6AVGGGH98IA1uxXCJhK/hnZqpAKXZ9uJkjf8aO+cYH5yeNGw+QS
         CZ7fZgHbiU4Xp/UWgiCwRdcOVFYEK+oqJgnIWwpu6/DVm+iEQ48NOWXtkiuo7OKKFd3K
         j/Py7MU4ikTZgqsQK14J0vXau8cwwkMfH1JctWVpHcTiWnByY7NBY3QPu+w/iRuPeY5i
         4brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhohPyhN/SALINgv3+ZmaXEZuCaRtvKN5O9czn34M/k=;
        b=Mb8Zfdms2f1o8QCHcnlSqlsKJXtVGhNDuqrM0BaZGBkkWtOtYgaO7wMwVldkZI4aFv
         hgY+sxZUPegd622xq2pHZyg84GffHWxBmRRoR7Os1nkNXBu6gzVIu8nijTde4t0DDqG4
         TfblBYHjO+eQskcqhxREnlh9gtXGD41S6wnv8EJLRtOSLOkn5mQrhozArG22dsS6Smp/
         e//R4vMAGNAMsoehxHIYFAgCyL7z+uE/hjPDBPpCWPOAUWGzNEdq6phzAmYf51Lrpc1b
         N+wudci9geg1jGapiVKpMg/NSjzDg3+lgo/rryPNtqkpbuu2yrgXAyiPaCE0wISVeQLg
         4Wuw==
X-Gm-Message-State: AOPr4FXcPfsX5A/a1CNzIAYo8M805aSqQ7pT4TSmckja67QeLWCsjeTcfa9nC/t8zBt0E91Z
X-Received: by 10.140.203.72 with SMTP id y69mr2102288qha.79.1461336735751;
        Fri, 22 Apr 2016 07:52:15 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-18.NATPOOL.NYU.EDU. [216.165.95.7])
        by smtp.gmail.com with ESMTPSA id s67sm2583005qgs.48.2016.04.22.07.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 07:52:15 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292224>

From: Santiago Torres <santiago@nyu.edu>

Instead of having tag -v fork to run verify-tag, use the
gpg_verify_tag() function directly.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..7b2918e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -104,13 +104,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	const char *argv_verify_tag[] = {"verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
-
-	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
-		return error(_("could not verify the tag '%s'"), name);
-	return 0;
+	return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
 }
 
 static int do_sign(struct strbuf *buffer)
-- 
2.8.0
