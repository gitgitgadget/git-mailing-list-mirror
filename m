Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96669EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 09:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjFZJhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjFZJhi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 05:37:38 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682C7AF
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 02:37:37 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69923a715so19542121fa.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687772255; x=1690364255;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hJ0mPVoTX6Qqq/IjJHcPNCQ4oYf5zosyhIVUsuSENpI=;
        b=DlVSribRak89qWPEUO3svZaCkz4nNm1Wwy17Ivrg7OcUAGEe2JN2etwhkk3mdcUNBW
         ticiSruPafwNlRDC0qS6hfK8JIVzGVfQD14iTnT9AWR8zVnQtSt7HZJ8FaG41pBTD2Y9
         nPfPUaIck0azUboabAORfec9mPLWmIRuQ2tIEKNiIFh8n+VlGTRidxE7I8puwNlLhnmv
         JqKLWQYwAfhHyNaMCjbC/yHFtUar9cze8X3qu7y1h1TO/TO5vXNeTeISVy9uCii8nLj3
         puf/4O5LZd/Y20BmVnlwvnNWwBgCwiBa/YgwCJ/a3rT/D2eoDA+JRdkhnXj0RNqElAg4
         XY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687772255; x=1690364255;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJ0mPVoTX6Qqq/IjJHcPNCQ4oYf5zosyhIVUsuSENpI=;
        b=T7LWkLrSZeywAm+0Lpslmuv4tknDSHGhW7jcsNXvVefOK1+hVEsRTH2HTAsa3aIFJM
         fCbKUM0SRILun4H0gtk5U1WFpoCYcgYmAFgxlKcGPlkChZLSP7KfUoHRJkG1qB2fh4bP
         tpRNebkDlxAQ4sEOZlyS9JEvJvIbMW7abBHm7DFZbfB8jEXqYTOD5zIuJkQ4noIzuZDO
         +xOYquq03R5q/xUn2gmmXPB3eHmNuEvrC2gz7L0A20bcY2vOhI3KUjtcfOveYw3FRKt3
         rKr60vH+rgQ6pojVHn4p3nDcM/tSVjtF1FJLILytvv3t6vU5PmkvI9aR9x1HQswaooBy
         3XEw==
X-Gm-Message-State: AC+VfDwl0d53yS7ES7/gXKezt5VSURwXCdy1/Eg7VtxL85MPybxf8pWb
        CbzYuq1mIwxzPGLf41Bw+F8cr65If7I=
X-Google-Smtp-Source: ACHHUZ5deLIraXsyUv2cCsyPGcESo+6o/W5wiSFhjZ1qjg37ALKu9mPxCZEtesSMVv7KTlRoctkAKQ==
X-Received: by 2002:a05:6512:2249:b0:4fb:751a:98db with SMTP id i9-20020a056512224900b004fb751a98dbmr1471400lfu.63.1687772255090;
        Mon, 26 Jun 2023 02:37:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d46c8000000b00300aee6c9cesm6827006wrs.20.2023.06.26.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 02:37:34 -0700 (PDT)
Message-Id: <pull.1552.git.1687772253869.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 09:37:33 +0000
Subject: [PATCH] apply: improve error messages when reading patch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit f1c0e3946e (apply: reject patches larger than ~1 GiB, 2022-10-25)
added a limit on the size of patch that apply will process to avoid
integer overflows. The implementation re-used the existing error message
for when we are unable to read the patch. This is unfortunate because (a) it
does not signal to the user that the patch is being rejected because it
is too large and (b) it uses error_errno() without setting errno.

This patch adds a specific error message for the case when a patch is
too large. It also updates the existing message to make it clearer that
it is the patch that cannot be read rather than any other file and marks
both messages for translation. The "git apply" prefix is also dropped to
match most of the rest of the error messages in apply.c (there are still
a few error messages that prefixed with "git apply" and are not marked
for translation after this patch). The test added in f1c0e3946e is
updated accordingly.

Reported-by: Premek Vysoky <Premek.Vysoky@microsoft.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    apply: improve error messages when reading patch
    
    I haven't changed it but I found the test a bit confusing as it
    superficially looks like it is generating a valid patch that is too
    large, but it isn't actually a valid patch because the changed line is
    lacking a leading '+' and a trailing '\n'. As we are checking for the
    error message that does not matter but it might be clearer to just do
    
    sz=$((1024 * 1024 * 1023)) &&
    test-tool genzeros $sz | test_must_fail git apply &&
    grep "patch too large" err
    
    
    if we don't care about the patch being valid. Alternatively we could
    create a valid patch with
    
    sz=$((1024 * 1024 * 1023)) &&
    {
        cat <<-\EOF &&
        diff --git a/file b/file
        new file mode 100644
        --- /dev/null
        +++ b/file
        @@ -0,0 +1 @@
        EOF
        printf "+%${sz}s\n" x
    } | test_must_fail git apply 2>err &&
    grep "patch too large" err
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1552%2Fphillipwood%2Fapply-error-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1552/phillipwood/apply-error-message-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1552

 apply.c                    | 7 ++++---
 t/t4141-apply-too-large.sh | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 6212ab3a1b3..21c7f92ada8 100644
--- a/apply.c
+++ b/apply.c
@@ -410,9 +410,10 @@ static void say_patch_name(FILE *output, const char *fmt, struct patch *patch)
 
 static int read_patch_file(struct strbuf *sb, int fd)
 {
-	if (strbuf_read(sb, fd, 0) < 0 || sb->len >= MAX_APPLY_SIZE)
-		return error_errno("git apply: failed to read");
-
+	if (strbuf_read(sb, fd, 0) < 0)
+		return error_errno(_("failed to read patch"));
+	else if (sb->len >= MAX_APPLY_SIZE)
+		return error(_("patch too large"));
 	/*
 	 * Make sure that we have some slop in the buffer
 	 * so that we can do speculative "memcmp" etc, and
diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
index 58742d4fc5d..20cc1209f62 100755
--- a/t/t4141-apply-too-large.sh
+++ b/t/t4141-apply-too-large.sh
@@ -17,7 +17,7 @@ test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
 		EOF
 		test-tool genzeros
 	} | test_copy_bytes $sz | test_must_fail git apply 2>err &&
-	grep "git apply: failed to read" err
+	grep "patch too large" err
 '
 
 test_done

base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
-- 
gitgitgadget
