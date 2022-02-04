Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D8C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiBDVVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbiBDVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:20:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E55C06173D
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 13:20:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f17so13613816wrx.1
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 13:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQSmv4OyqGoFcndv1QyfnS6MQ3Tn6Evr3TWj8Tgygls=;
        b=DBwSPpfAlp+4GCOeZH1pZpaZeTNi5epKfM5no17JBx0q1FC/J6rWlYwak5ZnmwCvRu
         VnrCNj35EC/RrZWq8NvBl4CBZkQlte4HtmY33042l4XWJ1mNr+JherkgDcFxicWlP7lY
         ybSfWmtGJGM9/1vjUaGkKluHz4qGkBN4Ei9xoQB6ciI96OypYouVs1jciVWsDioBBMX2
         0+1yHGnvqjLC5Ga49Ldpx0PUCMdaI7/pGYM3ZhT4w7H8QiXwmMcy+SwZekN1htZF6LUI
         pAik5Xw5C5jHzoDK/foVt6vD/DZgGpc/RMbTyLWrZwxCx+Npy37DsHXNRzHXpF9xpFo3
         ii4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQSmv4OyqGoFcndv1QyfnS6MQ3Tn6Evr3TWj8Tgygls=;
        b=mzhRok4XOEMz2cZS1+EU3IRK7Cb+vxyJilkpPjqrGdZTN2aKN2a1nfbBOJtVjBTaAz
         Xy2a2RiNB5OokbxUxN1FLei7F+XGV6u2lPzdE9FgAc6ZCNmyG1tk9Rc8y6oXmK76kmN7
         qMPMBgCadUFOBTioiE7eAhJFJsh0JZB0O+JU4cy1ky/hZ5D5rzpNFEwOoVAGIDwf/UmW
         nElWoKi1Yj1cJ006KQd1yGhsbMUz4XK9kDYSPrlrv0weRWD+VJhwjhzMalko0t63fCwf
         sjYKouV4tOWWqH3nKvg14UO6WpuZkyZZuC0Rv5yLiaqtgHq8mnl8dFDx9Dr23JYY6LLj
         RkXg==
X-Gm-Message-State: AOAM533u04CCQkQUZyeeCFEMgYVMfNlbRT1okoy5KwQ/Z+2F569okM4S
        ASajuf3zUVak5lKfX9f9fMN9rI3hMmhH4A==
X-Google-Smtp-Source: ABdhPJxpbYPLt/AxuZNvUM+bFxN94m/lt6jZzG7HLhBIf73vIuwK53MnxN4HBQCeWR3iQACrZHl0Hw==
X-Received: by 2002:a05:6000:84:: with SMTP id m4mr603738wrx.257.1644009655401;
        Fri, 04 Feb 2022 13:20:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o21sm2321598wmh.36.2022.02.04.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:20:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 1/9] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Fri,  4 Feb 2022 22:20:43 +0100
Message-Id: <patch-v10-1.9-184f7e0c5bd-20220204T211534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com> <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "regex_t" in grep_opt has not been used since
f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
we still use a "regex_t" for compiling regexes, but that's in the
"grep_pat" struct".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 6a1f0ab0172..400172676a1 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 
 	const char *prefix;
 	int prefix_length;
-	regex_t regexp;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.35.1.940.ge7a5b4b05f2

