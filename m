Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6392EC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjEAPyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjEAPyI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:54:08 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1478B1BCA
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:53:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5529f3b8623so24803447b3.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682956436; x=1685548436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Rj7sYJXjVNVdcz5mH90uvdN31oyZO1DhIrx/Ty//rE=;
        b=1XHY7wesAsr5xOoaBQ8SkQ1L4s/S0ZAiaqiEU097cLKwYe776d1Y1l6lrjjwJfIwk4
         pr1MQvTSY+GhLC0jB2kpF0tAwqgnsC9jAsbcs/b/FZfzTGWpXjdyRG0c1idt8t7yLe7c
         +cM38YD//RD9rrIssc5xgIOcjMRVdB5/CYu5RPY+vroB7jOvqrIVpsqAnqxV+QBdOR0A
         4zZn2Q585t25lRmKCZJLBTTV0CuVTCKpFXLg7a64/m8RsCEtbB1B3whTr6qPBqODWLG2
         JCrsOQPvAF4iVo+TG1y4MsuPB6WOzp0Nhjnct5Pk4QM6iIxbuCNi7Z+b7/f56I5MmTsU
         IHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956436; x=1685548436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rj7sYJXjVNVdcz5mH90uvdN31oyZO1DhIrx/Ty//rE=;
        b=MRcN2Jq18XFjNKcdW8r8SdVNJ2GogPxzPTEqGZk4CavcIcN21AzDl9ubGWWq8Dd2SC
         ykRu7f15eT5P8KFR/PRsRs6vJmckHdtGPxpQFaA/NYXXMo0Yv2zmAjVRMfg9iR15NhB8
         gqJ7YK/BtLgJ9iLVlEqR6EZ0YKrnQk/3u8c4Lj5zbi5327XitcJE8ru9oiRZqTZmQn8K
         HHLHIaSejhWSchR2SCd2XJUucUvlJ6Y/6ouUONV3UVWKt7zaK8jPnkaOgdMcHEWM00RO
         aet5/3JRSVllLOMyP41vlfk3OC6E96nVaolS/Eve4w+CUFiV/B69R6PJS7FR5PiHh628
         h+dA==
X-Gm-Message-State: AC+VfDwBhW6DKp1wRbxvURGD/ZULQb8SVJ3LN0GzgVd9cwao+FsN/ob7
        FUx+XN9KjbBk06u/T64zOf/Dk9L3yZuSPRXNU6tTYg==
X-Google-Smtp-Source: ACHHUZ4HJF19UqhILQrW/eJ2gcYT8m23W4fYkE3Spo4/T06woVq2H/XYMGVBg2xxPYqnpDKD7PVWfQ==
X-Received: by 2002:a25:5345:0:b0:b97:4b7b:945c with SMTP id h66-20020a255345000000b00b974b7b945cmr12811421ybb.57.1682956435702;
        Mon, 01 May 2023 08:53:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s62-20020a255e41000000b00b92579d3d7csm2608525ybb.52.2023.05.01.08.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:53:55 -0700 (PDT)
Date:   Mon, 1 May 2023 11:53:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 3/7] contrib/credential: avoid fixed-size buffer in
 osxkeychain
Message-ID: <301bc27a5b4500ff6681bbf5a113d763b8f0b4c9.1682956419.git.me@ttaylorr.com>
References: <cover.1682956419.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682956419.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The macOS Keychain-based credential helper reads the newline-delimited
protocol stream one line at a time by repeatedly calling fgets() into a
fixed-size buffer, and is thus affected by the vulnerability described
in the previous commit.

To mitigate this attack, avoid using a fixed-size buffer, and instead
rely on getline() to allocate a buffer as large as necessary to fit the
entire content of the line, preventing any protocol injection.

We solved a similar problem in a5bb10fd5e (config: avoid fixed-sized
buffer when renaming/deleting a section, 2023-04-06) by switching to
strbuf_getline(). We can't do that here because the contrib helpers do
not link with the rest of Git, and so can't use a strbuf. But we can use
the system getline() directly, which works similarly.

In most parts of Git we don't assume that every platform has getline().
But this helper is run only on OS X, and that platform added support in
10.7 ("Lion") which was released in 2011.

Tested-by: Taylor Blau <me@ttaylorr.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .../osxkeychain/git-credential-osxkeychain.c           | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index e29cc28779..5f2e5f16c8 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -113,14 +113,16 @@ static void add_internet_password(void)
 
 static void read_credential(void)
 {
-	char buf[1024];
+	char *buf = NULL;
+	size_t alloc;
+	ssize_t line_len;
 
-	while (fgets(buf, sizeof(buf), stdin)) {
+	while ((line_len = getline(&buf, &alloc, stdin)) > 0) {
 		char *v;
 
 		if (!strcmp(buf, "\n"))
 			break;
-		buf[strlen(buf)-1] = '\0';
+		buf[line_len-1] = '\0';
 
 		v = strchr(buf, '=');
 		if (!v)
@@ -165,6 +167,8 @@ static void read_credential(void)
 		 * learn new lines, and the helpers are updated to match.
 		 */
 	}
+
+	free(buf);
 }
 
 int main(int argc, const char **argv)
-- 
2.40.1.452.gb3cd41c833

