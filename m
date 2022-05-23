Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35463C4332F
	for <git@archiver.kernel.org>; Mon, 23 May 2022 18:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243492AbiEWSsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbiEWSrq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 14:47:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E396120BC4
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:31:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t6so22590544wra.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3HZuuxSXblp0YH0QuNmqbuY3tI/jAaLr49xjuJPqrEo=;
        b=RzooqEyMElh0Z0WeMtIkRTrViaVact7maeqhkisA6u20PfrLK63XwRromVclGjbNyy
         pctdGrQJXdSMMqUkgi3mhR8/dX4YOG2kyNAr7Aba63d42w939UYde30SIxggXAgJYUXZ
         bClmyDfVhyOLEsRASiTf9SdFYLTSZHjGtkewtA2Vr1TQzx309+J1HrcVvaRc3TEjgIIa
         WugSLAO022CwGtp4BBPte5Kr+4nHjuMGuSy7sQKZNTpOnYQf9zcq0ySyWpKvrcQ3EsC5
         DSrsqC97JX15C4VTRk2iRZ/k1BTWBFwXIrIqFAjdXI3A3Bp+xmf0/hKtxm3qpSDNoQyl
         6/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3HZuuxSXblp0YH0QuNmqbuY3tI/jAaLr49xjuJPqrEo=;
        b=aCJZWBy9KDu7q5ROWcJzqkg4u6pTiBTgq9ok2/nuvnE1SWBH6Z9Rrc5tXEf69JTfLN
         BmUJPHqPo8eacgfmF1xLEJ526OLliNHxcCk8sX6PaRX4ejX3ChjOIzkASaDdCUpOniAz
         c8xu39iryLUNUBVJFUgASfXFTpt/rpOeAr9mBWu8gcjdy4ZFwQH1FaXDQj5h2ONi1Mll
         d2o2QlYEFstmk/jyx8bJnNQ39NgDazvmcLlAoADR9NkhFpenfc4X5+eytNsMAC9EDx6e
         T/L7uJq00uBCYK69cSgs2kJ+6c9AhXnIsxkgv9PLsRqAi3qpDK9/W6gaAibPr2PPMswj
         v5UA==
X-Gm-Message-State: AOAM532neD0CJv9s5kANdsLDx/QEYPezChHd4Ci6lW2neRfj5VXFjbYK
        WqSptYehqyUCaMLypIyGJI3MJrmbL7k=
X-Google-Smtp-Source: ABdhPJwyrq4vhLWNLz5BrJyVtgdq9SJ3uCXAlyr1s5NA7tXtuHBLOZfLF9+xxJ90GCZBiu+4/PvOyA==
X-Received: by 2002:a5d:568a:0:b0:20d:3b5:6c89 with SMTP id f10-20020a5d568a000000b0020d03b56c89mr20197458wrv.212.1653330699308;
        Mon, 23 May 2022 11:31:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m15-20020adfc58f000000b0020fcf070f61sm6319034wrg.59.2022.05.23.11.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:31:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] diff: fix a segfault in >2 tree -I<regex> and --output=<file>
Date:   Mon, 23 May 2022 20:31:28 +0200
Message-Id: <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1038.gde12b200317
In-Reply-To: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in c45dc9cf30 (diff: plug memory leak from regcomp()
on {log,diff} -I, 2021-02-11), as noted in [1] there was a logic error
where we'd free the regex too soon.

Now we'll ensure that diff_free() can be called repeatedly
instead. We'd ultimately like to do away with the "no_free" confusion
surrounding it, and to attempt to free() things only once, as outlined
in [2]. But in the meantime this will fix the segfault.

Since the rest of diff_free() was already safe re-invoke this only
affected the -I<regex> and --output=<file> options. In both cases our
behavior before wasn't very sensible. When producing a combined diff
we'll go through combined-diff.c, which doesn't handle many of the
options that the corresponding diff.c codepaths do.

Thus we're here testing that -I<regex> is ignored in this case, and
likewise for --output=<file>, but since this is what we were doing
before c45dc9cf30 let's accept it for now.

1. https://lore.kernel.org/git/a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de/
2. https://lore.kernel.org/git/220520.86pmk81a9z.gmgdl@evledraar.gmail.com/

Reported-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sat, May 14 2022, René Scharfe wrote:

> Hi all,
>
> git diff segfaults when it's asked to produce a combined diff and ignore
> certain lines with --ignore-matching-lines/-I, e.g.:
>
>    $ git diff -I DEF_VER v2.33.3 v2.33.3^@
>    zsh: segmentation fault  ./git-diff -I DEF_VER v2.33.3 v2.33.3^@

 diff.c                  |  9 ++++++---
 t/t4013-diff-various.sh | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e71cf758861..183c9f21305 100644
--- a/diff.c
+++ b/diff.c
@@ -6432,8 +6432,10 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
 static void diff_free_file(struct diff_options *options)
 {
-	if (options->close_file)
-		fclose(options->file);
+	if (!options->close_file)
+		return;
+	options->close_file = 0;
+	fclose(options->file);
 }
 
 static void diff_free_ignore_regex(struct diff_options *options)
@@ -6444,7 +6446,8 @@ static void diff_free_ignore_regex(struct diff_options *options)
 		regfree(options->ignore_regex[i]);
 		free(options->ignore_regex[i]);
 	}
-	free(options->ignore_regex);
+	options->ignore_regex_nr = 0;
+	FREE_AND_NULL(options->ignore_regex);
 }
 
 void diff_free(struct diff_options *options)
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 056e922164d..b556d185f53 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -614,4 +614,19 @@ test_expect_success 'diff -I<regex>: detect malformed regex' '
 	test_i18ngrep "invalid regex given to -I: " error
 '
 
+test_expect_success 'diff -I<regex>: combined diff does not segfault' '
+	revs="HEAD~2 HEAD~ HEAD" &&
+	git diff $revs >expect &&
+	git diff -I . $revs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --output=<file>: combined diff does not segfault' '
+	revs="HEAD~2 HEAD~ HEAD" &&
+	git diff --output=expect.file $revs >expect.out &&
+	git diff $revs >actual &&
+	test_cmp expect.out actual &&
+	test_must_be_empty expect.file
+'
+
 test_done
-- 
2.36.1.1038.gde12b200317

