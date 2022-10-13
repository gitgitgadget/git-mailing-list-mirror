Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22925C43217
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJMPlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJMPlA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:41:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0CA55BA
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk15so3402739wrb.13
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaVnoTsNOSI4gzQEQ1vJr/eH+r99p811VxGyvVR9LN8=;
        b=Dx/w/U0P96Rl6qfDtc+NluIc1bU4G9DSCG8JOgldd/uMVjKzE8LMLPZ8C7PeNNqO2m
         fQkUeuhXH8t3BulAhjccNDQ0FEnyHfoR67iCt9S7/eRfxpkgklt4An2bJkwAsMYaC+Gl
         TnfRg+y262LF0tjWDNdE7ChWAu7WGWe85IL3QkwGVP25Y+4r5953bNw35R79YE6Z+nMk
         yMRbvQpQTTm+3oQ9vMsfu7xkplk0eoJwfS6/L7xehut/F2jdldE9/6X4+UNRz7d3LTCu
         4ADZfD8SuQcNc8Uvu1R9Yzeq+wrSgj6tJPCcM1AxspWIVS/EH/DDF46KSZJl5UU3k9O7
         Z06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaVnoTsNOSI4gzQEQ1vJr/eH+r99p811VxGyvVR9LN8=;
        b=Giw87i8am3QmjuCMoFhR5VNHyXah9u3nu5U4JG954WhwNHRPSDEe3DG9K+8OpONmr0
         6vptgdfJ4VnGh7DgiFcA1XvoqjduCiPEOXmCUcP639gcrp1mw+yMwpxRU+jCiaKWwqb+
         x658yhDqJmzptaAUIHLWgGnzX/f3/qRbfbdG6BNwXnVkMico3wIZV41I6hwq4s96MEni
         h86tus+e8dDchHKSJ1YtOYebw6BHIG8VOzNIcNfFKTknR041tP7IRbU1r1skOYReOgCd
         OqXWNp/ngdZ2O9ZWDo7IfnNZxxK1TsKddqetAy2fmTX0TXlhYgjYQhxFv4sfTm20BeD3
         tWiA==
X-Gm-Message-State: ACrzQf0fuXrMoLggM0+gok9wLLiScQF10O9gOxNbk0EeO72X1S4JSfa9
        3qG+PPz/+TYPHBrfxYsodXVYcioSmAQrqA==
X-Google-Smtp-Source: AMsMyM5mjGpPUXjxDQ+47BFi/t5/zFQx7VcuMd/8VZ0EBEv6miiJXxm0WB16R7EzjXw7511LsfpmcQ==
X-Received: by 2002:a05:6000:1f88:b0:22e:3c57:943b with SMTP id bw8-20020a0560001f8800b0022e3c57943bmr401006wrb.65.1665675604510;
        Thu, 13 Oct 2022 08:40:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:40:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 28/34] doc txt & -h consistency: make "diff-tree" consistent
Date:   Thu, 13 Oct 2022 17:39:22 +0200
Message-Id: <patch-v5-28.34-abaffb0b0df-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "diff-tree -h" output consistent with the *.txt version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 23f58702fa0..85e8c81e594 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -83,8 +83,9 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git diff-tree [--stdin] [-m] [-c | --cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"git diff-tree [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]\n"
+"              [-t] [-r] [-c | --cc] [--combined-all-paths] [--root] [--merge-base]\n"
+"              [<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "\n"
 "  -r            diff recursively\n"
 "  -c            show combined diff for merge commits\n"
-- 
2.38.0.1085.gb7e61c3016c

