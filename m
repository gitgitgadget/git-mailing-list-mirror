Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80655C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 09:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E29A206A4
	for <git@archiver.kernel.org>; Tue,  5 May 2020 09:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcebYPD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEEJxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 05:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEJxe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 05:53:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F89AC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 02:53:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z6so604161plk.10
        for <git@vger.kernel.org>; Tue, 05 May 2020 02:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W908UAuysw5MqFGdzt6EEgAK/TIINEp2lMzjQKFLtu0=;
        b=LcebYPD5fR6ESrUM5/bgeShA07QNG45cc9squhvGozn3dHUKz8P86iFxyMqAqqm/ws
         TQ3xhH77z5a0yiq5DFCANmng2p2CDGp/oD7KsON6av2qVUmEIuF7oOzauE4fKZ0eWo7s
         1OzBd5YrnFs+qIeIeZ3ti8vET/myIfI9I914sxxy7KRYFs41GFsbn42grWpWmpigdPT1
         UkLWMihFbOFoxI8phZBm0tbSufBOJ9mtI1Eh8t0EiFQutIgQtUkrTcO6eYz+m4z5f0lY
         iRmO2DxALqRb8pMt2xLRrq/uU3YbfaWeCvxT6e3G8Qd08eGqUIefXblO+qEn2qX5oajX
         d2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W908UAuysw5MqFGdzt6EEgAK/TIINEp2lMzjQKFLtu0=;
        b=rRUn8vXJexT/euFvsXzUqr7/afPsw6OECK81AtyDUXNV3G/ShezpGen4Lh3lLPY2nf
         SJygP/RDJgNdlkUzzKb2oCqVq0fKnibNywhApfeHP4Y912CXghIXy86diHuNt99GnVf9
         qFPedLdVL0p9hzHux7KhUtQcf6y37R/rjD4fIGPHuyhw+pEdzZfjKPLsH8NHj/msAN8K
         7ECmH4Ces/y9ZC4V81K+S8yF3xKt/k1dL8DIz9F0ki9fzOQkYkA9708D+//G5JwN+0Tq
         ByaMBC/dDs0aUGfvM7y2DjauLhuG05eRxYCOURE53XaIfEp+DF/5VnoYf8ttMZqip4k/
         inSA==
X-Gm-Message-State: AGi0Pubdf6hs/CF4UScaug9sEJYk8iDwLd1e9tN7GyN+Wlwxq18/6CaO
        2m/JxA42brbFjOUX0a6pzwIlRTod
X-Google-Smtp-Source: APiQypLSBuEey4Upj0BLD10mjJZR1Wp2oNxpeop6M5dIqGOjDIf03He6Xtj09uBNhTC2/wAfoRU5ig==
X-Received: by 2002:a17:90a:840e:: with SMTP id j14mr1881363pjn.85.1588672413188;
        Tue, 05 May 2020 02:53:33 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h14sm1565094pfq.46.2020.05.05.02.53.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 02:53:32 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] builtin/receive-pack: avoid generic function name hmac()
Date:   Tue,  5 May 2020 02:53:26 -0700
Message-Id: <20200505095326.36374-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200505054630.5821-1-carenas@gmail.com>
References: <20200505054630.5821-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fabec2c5c3 (builtin/receive-pack: switch to use the_hash_algo, 2019-08-18)
renames hmac_sha1 to hmac, as it was updated to use the hash function used
by git (which won't be sha1 in the future).

hmac() is provided by NetBSD >= 8 libc and therefore conflicts as shown by :

builtin/receive-pack.c:421:13: error: conflicting types for 'hmac'
 static void hmac(unsigned char *out,
             ^~~~
In file included from ./git-compat-util.h:172:0,
                 from ./builtin.h:4,
                 from builtin/receive-pack.c:1:
/usr/include/stdlib.h:305:10: note: previous declaration of 'hmac' was here
 ssize_t  hmac(const char *, const void *, size_t, const void *, size_t, void *,
          ^~~~

Rename it again to hmac_hash to reflect it will use the git's defined hash
function and avoid the conflict, while at it update a comment to better
describe the HMAC function that was used.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2
* cleaner commit message that even has an SOB

 builtin/receive-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2cc18bbffd..39b0c3d70b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -418,7 +418,7 @@ static int copy_to_sideband(int in, int out, void *arg)
 	return 0;
 }
 
-static void hmac(unsigned char *out,
+static void hmac_hash(unsigned char *out,
 		      const char *key_in, size_t key_len,
 		      const char *text, size_t text_len)
 {
@@ -463,10 +463,10 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 	unsigned char hash[GIT_MAX_RAWSZ];
 
 	strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
-	hmac(hash, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));
+	hmac_hash(hash, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));
 	strbuf_release(&buf);
 
-	/* RFC 2104 5. HMAC-SHA1-80 */
+	/* RFC 2104 5. HMAC-SHA1 or HMAC-SHA256 */
 	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, (int)the_hash_algo->hexsz, hash_to_hex(hash));
 	return strbuf_detach(&buf, NULL);
 }

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
2.26.2.686.gfaf46a9ccd

