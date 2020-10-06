Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA55C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D596206B5
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 15:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdNGrgrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgJFPIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 11:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgJFPIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 11:08:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685FC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 08:08:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f19so970578pfj.11
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bAzo3iYNDNKUooX+T1YXNkCkjFxi/rR/9qrKm0XRhE=;
        b=mdNGrgrwJP+deXuT8TafuV9/etJ/s1Zqtfra6FZcOj0s0hc6qNRBaBke4AklsqXrTf
         0KgCXI8tdiPuP5joJGWeAD0YlrmiQGN2PMN5UpBjveRZovHYEcICcvNzvrqKFapn5Ozt
         6LVfyFOSmbVLvNLdJ44kKzQ+qKC/ssknyPYz30JSmQkmRL0ssPydOO/F5PbIMHg0oald
         /PB0WDTriHL/1rE81YxZcpRUG5DlXiZEP6PLFaB1a8Lw31UsRVKZGeAyhCcaq/B0CaRx
         ynSu9IOyxa0ryiCXivvY0Rdbpbf1c0UlUqFGupSqwtmAXGgePNHeVVQmyQAwYFlVEint
         5yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bAzo3iYNDNKUooX+T1YXNkCkjFxi/rR/9qrKm0XRhE=;
        b=DCNzhxVAy4/ZrXM+oW5aY9DF9J9yjX2SF85QUd4DOQpGxEaeHVO3w4assJHsewsM23
         OIbtq2FOBgcTcbJD/Cy4FWrG1m/jEmLOAfLjiPpBBsCBtFTGTUphOGiwTWJnx1EZDJpS
         TSLst5eopK/O23x4nvvVuEN9fQdELuqB7ff783D9cxMCQ+gpDrRGoUcGU+so1XBd/wYt
         8v8fWTfZEmS5Vbx7PetrC/fEd2NVrQhcVfoTHo83dcRjUIb/m1ls7+/Gb34LgcVyJzWA
         hpQCyQO8m5r3P+7gZCvsBJeBWIrDybB/5Cs+hi4ndYc5ySbuL3FQWxn2Ud8XscLlOEvq
         /zEA==
X-Gm-Message-State: AOAM533BEj+6OeLQndVNMoZvZhKQbJs5E7bwZcZ0G/BHYWxVxwXVUjPK
        h2X8q4NiOnitF/1iKCqZPpiVpW77L0Y=
X-Google-Smtp-Source: ABdhPJxaqmNtfohW3X/FmSGDMI/XHzT8Igc6m9VdjPn7aphX5atGfn6a6QeUbkfhCAayAjYVb7i2Vg==
X-Received: by 2002:a63:1414:: with SMTP id u20mr4186175pgl.297.1601996925105;
        Tue, 06 Oct 2020 08:08:45 -0700 (PDT)
Received: from voidtp.localdomain ([2402:800:63a8:e735:e424:e5d:450a:d98e])
        by smtp.gmail.com with ESMTPSA id ch21sm881473pjb.24.2020.10.06.08.08.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 08:08:44 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] t5534: split stdout and stderr redirection
Date:   Tue,  6 Oct 2020 22:08:18 +0700
Message-Id: <20201006150818.15698-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.849.g665beee440
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On atomic pushing failure with GnuPG, we expect a very specific output
in stdout due to `--porcelain` switch.

On such failure, we also write down some helpful hint into stderr
in order to help user understand what happens and how to continue from
those failures.

On a lot of system, those hint (in stderr) will be flushed first,
then those messages in stdout will be flushed. In such systems, the
current test code is fine as is.

However, we don't have such guarantee, (at least) there're some real
systems that writes those stream interleaved. On such systems, we may
see the stderr stream written in the middle of stdout stream.

Let's split those stream redirection. By splitting those stream,
the output stream will contain exactly what we want to compare,
thus, saving us a "sed" invocation.

While we're at it, change the `test_i18ncmp` to `test_cmp` because we
will never translate those messages (because of `--porcelain`).

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Arguably, I would say it's OK to change the:
 	
 	test_i18ngrep ! "gpg failed to sign"

 to:

 	! grep "gpg failed to sign"

 since the latter will be correct even if GIT_TEST_GETTEXT_POISON=true

 t/t5534-push-signed.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 7e928aff66..af0385fb89 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -282,10 +282,9 @@ test_expect_success GPG 'failed atomic push does not execute GPG' '
 	EOF
 	test_must_fail env PATH="$TRASH_DIRECTORY:$PATH" git push \
 			--signed --atomic --porcelain \
-			dst noop ff noff >out 2>&1 &&
+			dst noop ff noff >out 2>err &&
 
-	test_i18ngrep ! "gpg failed to sign" out &&
-	sed -n -e "/^To dst/,$ p" out >actual &&
+	test_i18ngrep ! "gpg failed to sign" err &&
 	cat >expect <<-EOF &&
 	To dst
 	=	refs/heads/noop:refs/heads/noop	[up to date]
@@ -293,7 +292,7 @@ test_expect_success GPG 'failed atomic push does not execute GPG' '
 	!	refs/heads/noff:refs/heads/noff	[rejected] (non-fast-forward)
 	Done
 	EOF
-	test_i18ncmp expect actual
+	test_cmp expect out
 '
 
 test_done
-- 
2.28.0.849.g665beee440

