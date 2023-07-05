Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC65EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 19:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjGETuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjGETuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271B01737
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 12:50:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6fbf0c0e2so27504631fa.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586608; x=1691178608;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s6vbsRn1QenTvSpUJatgMzNh/Aw/QxQzGqsDdX9W7Pc=;
        b=qdxh+oFclX/uCugYX5bTFwY4XF7OpcZFFCMgKnjbuOcogiiO5H0TOO6ObkczYJ+rWo
         +XL1xQLs/QsO+rtgw+/nJdb1ByAKyiW2YGBKeMhx12++Q34PFddbtt58aEXMb9ryYu8K
         ZQNdvjs+pLmGs8my/0ABH6ZYhhX3mKuzBgX7Gf6AboYraAA+4ley7TYZ9cRNH6vqGwy8
         b+kQ2n73i5O4lTR966MK7Hk0wXcJpLgm3394X4kQEAUIC7uOiGTQKGGfMAZQdgD+/Z/C
         qEbBWoCnAYhyFFoD8QUbB+98f2tkjVG7WqPwYQcE5zpGuMX0UMQIVIR5FgtKJpf/OiLs
         gFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586608; x=1691178608;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6vbsRn1QenTvSpUJatgMzNh/Aw/QxQzGqsDdX9W7Pc=;
        b=d5df54Vd/b0OmaGmXMPbrJhYTj4WDYXKeZa0EP3RdRUefj1H7fC6kxxjyf+sUIJowp
         CSQGoGzw10le8CKEwc2l58FsJNWmJmy4DsWIiuxQijDv63mwBbkLTF51Dwu9Q/XjebLe
         ZbtG5oGq26G0C5X2VsoeD/wM1QL5JXNv+lxMN/2XpGz+bugJcMTcvvXZ5TFfOM6F9X/Y
         L0l2UMkmtBuBuU33Rgc+vxX+y9kTOoklkcmfsbPMD1IqOzJ1hz1sEii5hWEO2FOQzQKC
         kW4zOB/UmPOJJLra+pO0lju59HfHReSyNFWhvpbvrehP05/onkngyGEYVAgMOAR8UBqW
         16Tg==
X-Gm-Message-State: ABy/qLbZDzSCA/G3UOHFnvd4FcPOCSse8KfAw+J40xbBO2F6pmMPatHH
        kfQNPFHkoFDr9A8KFZcyuZenvUbn9Ps=
X-Google-Smtp-Source: APBJJlFsFqhoEgdfv7SLRtIqWtsVqlFiif4R5xNiQJ8DkauEMkXPEQIHJ+2cZL8SAubCWXs3FQzVBA==
X-Received: by 2002:a2e:3a0f:0:b0:2b6:dec9:2813 with SMTP id h15-20020a2e3a0f000000b002b6dec92813mr9139991lja.29.1688586608208;
        Wed, 05 Jul 2023 12:50:08 -0700 (PDT)
Received: from localhost.localdomain ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id bx1-20020a170906a1c100b00992665694f7sm10078341ejb.107.2023.07.05.12.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:50:07 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/4] diff --no-index: die on error reading stdin
Date:   Wed,  5 Jul 2023 20:49:28 +0100
Message-ID: <be1d666769f2d6dd028c7d5ade0e9f563e953ab5.1688586536.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.1.852.g0a1e0755a6
In-Reply-To: <cover.1688586536.git.phillip.wood@dunelm.org.uk>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk> <cover.1688586536.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there is an error when reading from stdin then "diff --no-index"
prints an error message but continues to try and diff a file named "-"
resulting in an error message that looks like

    error: error while reading from stdin: Invalid argument
    fatal: stat '-': No such file or directory

assuming that no file named "-" exists. If such a file exists it prints
the first error message and generates the diff from that file which is
not what the user wanted. Instead just die() straight away if we cannot
read from stdin.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff-no-index.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 77462ac2a9..4470e0271d 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -60,20 +60,19 @@ static int get_mode(const char *path, int *mode)
 	return 0;
 }
 
-static int populate_from_stdin(struct diff_filespec *s)
+static void populate_from_stdin(struct diff_filespec *s)
 {
 	struct strbuf buf = STRBUF_INIT;
 	size_t size = 0;
 
 	if (strbuf_read(&buf, 0, 0) < 0)
-		return error_errno("error while reading from stdin");
+		die_errno("error while reading from stdin");
 
 	s->should_munmap = 0;
 	s->data = strbuf_detach(&buf, &size);
 	s->size = size;
 	s->should_free = 1;
 	s->is_stdin = 1;
-	return 0;
 }
 
 static struct diff_filespec *noindex_filespec(const char *name, int mode)
-- 
2.40.1.852.g0a1e0755a6

