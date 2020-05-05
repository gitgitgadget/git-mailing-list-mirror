Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0F6C47256
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C3F20721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omFpI+gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgEEFqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 01:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgEEFqw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 01:46:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A201C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 22:46:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d184so372337pfd.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 22:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IB45ZXd9N9RZMZja/BNF40+kZn6/vxIWxiBorJv8+IY=;
        b=omFpI+gtHX5+mxCp4z4SRIywbWca68cSTZcinBhxO8jfmo+YzX8isO80RPhxO/ISY0
         3WfVIbD8+30MtR2lDKLcEuGgoHcuN2TWzRx4CpFH5POiUK1KDbv1j/Zf7sgKlI772+Co
         N4fHX+WR3IuXfcx4Unwbbdu9kj9kfi7Kmbd/euSA4Z/QHU+PVbIK8Dx+ySOUG1h4s7NE
         q9Da79Sy7d5bu29Ekm3cWtOj6j39sAZwJjq09sQDnRSx4+p5TgvU4Cbek0xEeB+uD9wW
         AiRGYSjO5qjct7EQ7ljlvazwprBHpYkQciWFeriO5EL5wE6Na0TjOnraENufAEnm5iPV
         +niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IB45ZXd9N9RZMZja/BNF40+kZn6/vxIWxiBorJv8+IY=;
        b=BYMx/Z7Cd+fIzIZ5D2eaXDjh1x7sOsrLs9EyW/p47ZM6xQoU9tCPPlxe8b/QOwUGIJ
         uu1vLLuSeOolNoyIB6ZW+sARhU4FgR8u+iBfSSNxIuHaLdNKXxqh508TxePp2cHsrAIA
         RsFbfgLyWumle5zJkZJIyX2WzQWfklB/Xltewcd9iqk5XuZasCOu8FF3YiAWCUQ2fyZR
         L2y+FNLsOCO+QIyQd6KSxOPIdfB9INeATBmgI735ufor902FZyZCAHGXEQe0zXz+Kzu9
         O8vdO7LtWHpS+iKuReJW688gi05wf7zfR/C4CUj4Mxg4xAj6zbrSpd6Nm3Pla7KM54je
         EOIQ==
X-Gm-Message-State: AGi0PuYJK6Tg6hmNAljhAl/46XqXVa5+4WpFGuROO0dPFlFsQ8XTekt2
        Q9IQlOAeyJtcaKwvHj4yCh+F1FO6
X-Google-Smtp-Source: APiQypL+zvrj6wElDL5HQSt4UhOImi9SS5PA6YsnvMMzVLOSJdSgvSyTkFeEIMpB18G/1AV0aB/N8w==
X-Received: by 2002:a62:6dc3:: with SMTP id i186mr1509256pfc.12.1588657611269;
        Mon, 04 May 2020 22:46:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d12sm896298pfq.36.2020.05.04.22.46.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 22:46:50 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] builtin/receive-pack: avoid generic function name hmac
Date:   Mon,  4 May 2020 22:46:30 -0700
Message-Id: <20200505054630.5821-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fabec2c5c3 (builtin/receive-pack: switch to use the_hash_algo, 2019-08-18)
renames hmac_sha1 to hmac, as it was updated to (optionally) use the hash
function used by git (which won't be sha1 in the future).

hmac() is provided by NetBSD > 8 libc and conflicts as shown by :

builtin/receive-pack.c:421:13: error: conflicting types for 'hmac'
 static void hmac(unsigned char *out,
             ^~~~
In file included from ./git-compat-util.h:172:0,
                 from ./builtin.h:4,
                 from builtin/receive-pack.c:1:
/usr/include/stdlib.h:305:10: note: previous declaration of 'hmac' was here
 ssize_t  hmac(const char *, const void *, size_t, const void *, size_t, void *,
          ^~~~

While the conflict, posses the question of why are we even implementing our
own RFC 2104 complaint HMAC while alternatives are readily available, the
simplest solution is to make sure the name is not as generic so it would
conflict with an equivalent one from the system (or linked libraries); so
rename it again to hmac_hash to reflect it will use the git's defined hash
function.
---
 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2cc18bbffd..b1d939e7ed 100644
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
@@ -463,7 +463,7 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 	unsigned char hash[GIT_MAX_RAWSZ];
 
 	strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
-	hmac(hash, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));
+	hmac_hash(hash, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));
 	strbuf_release(&buf);
 
 	/* RFC 2104 5. HMAC-SHA1-80 */
-- 
2.26.2.686.gfaf46a9ccd

