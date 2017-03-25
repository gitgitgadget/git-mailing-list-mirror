Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F5C1FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 00:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935927AbdCYAg1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:36:27 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32964 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934689AbdCYAgX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:36:23 -0400
Received: by mail-pg0-f50.google.com with SMTP id w20so2676283pgc.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 17:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mW7xvZbmb7ouqtMRBNeN4ffajwr5MHx6rrVdNkTLRx8=;
        b=MrtIU83F37vbwOaxVxE/wG41A2dZiuPkOJPX3VpSMbbOpmGK1GTjIxAEBr0Wb2nXx8
         /jujDAsuPHPh4yZ0OpuhYwFDLlH9ck1aQ/jAwGHksZQ1qfZkITNpErzXLpaxuzE1L2Ju
         kk7Nc6an7Z5QfNrFjR3nvvVB3OeDnUWqdQt38DoCaHfDQUSpAgwrPsNBkLcf/WTWZdAe
         DEDWxh/kWGhe8cDiy5FcnIzjAOx/npGtVj2c5YIo/CaKpNpC8lYNkP9nohROb9n8TjwQ
         lhLATvRIjW8BKcBxQGp02hAXyJdwjMsav1XkNU9yylVgggQCWbis3ofcPYccdAK72SsM
         xpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mW7xvZbmb7ouqtMRBNeN4ffajwr5MHx6rrVdNkTLRx8=;
        b=k882CPrwEMnt5LJJUVvdvqWSv7Fpuk5mqN+JdGv3XApZqBK7HJOXB4S0oKuHL7kyLe
         DqEBO4P8MuDKo0v/uzl/3mdbRzBhssu7YBTm3RTMqX2X54/NlUOaB/B5xbyOQOrPyC0u
         yjiOQhNYtowLMyraeJyMSYqulEE3g6EWkuEDM/2i0kLW+NC9T0wk4xNzjZQtQxb1J+hy
         XGyONIUE1EE0DvZh6AmLly7jrJjp8WO/4++wc0feqHdd26xX0leqbr4I1bmF5UuSzkHs
         RlZHOUzM2gKI87975a/4i6nGUJc33QyeG01USRujABOcPCAiPyZItDrwlD9lXxRTcOdQ
         8AIQ==
X-Gm-Message-State: AFeK/H0l14KZBGFrhe50PhNK5ZT4Et6aE1qUtagcWZaROomzi8wHNNJ01HloZwmq5kKPTv9x
X-Received: by 10.99.185.1 with SMTP id z1mr12079344pge.165.1490402181571;
        Fri, 24 Mar 2017 17:36:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id a62sm6702681pgc.60.2017.03.24.17.36.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 17:36:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] submodule.c: factor out early loop termination in is_submodule_modified
Date:   Fri, 24 Mar 2017 17:36:05 -0700
Message-Id: <20170325003610.15282-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.gdeb397943c.dirty
In-Reply-To: <20170325003610.15282-1-sbeller@google.com>
References: <20170324182902.19280-1-sbeller@google.com>
 <20170325003610.15282-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier for a follow up patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 submodule.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2c667ac95a..93e3fefd39 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1075,16 +1075,16 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	len = strbuf_read(&buf, cp.out, 1024);
 	line = buf.buf;
 	while (len > 2) {
-		if ((line[0] == '?') && (line[1] == '?')) {
+		if ((line[0] == '?') && (line[1] == '?'))
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				break;
-		} else {
+		else
 			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-			if (ignore_untracked ||
-			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
-				break;
-		}
+
+		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+		     ignore_untracked))
+			break;
+
 		next_line = strchr(line, '\n');
 		if (!next_line)
 			break;
-- 
2.12.0.rc1.49.gdeb397943c.dirty

