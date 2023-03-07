Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E1C678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 23:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCGXXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 18:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCGXX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 18:23:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5092C5D474
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 15:23:27 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso405663pjb.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 15:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678231407;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRt1mUnXnUEWD8FnMWmKeT848TwPURbevtP+JawEoFo=;
        b=mNhxNcDaq5iVf4OKWM5fLPJE+5adfPdi8OOV1oPQCZFIOtcJ7jeJKiKmZRwFvEOIYK
         GBMZe2bEZkKvKc/+gOuNPOf7ILSWINl9KziEZSQYA7ZBLirpjnD9Y7q5MAr2eMJjXll4
         kzxTUV3g09WOBe4Ru2pr4CgRHrGBhIJyU75mpP/GHXV2VNnmlHMSNPfEjaUewke1tYxj
         uU115ixvOl66ReE50ZVDGVCdbYXn3tQACcr9ABynyb4O/eCj1IaDcM6SuwW+4M/N7nl8
         /6hr127oMdXABHpLJ9KsCVgR5pd8WK1NakLkja9mmtLRUwgxWtdYt1r886ve82iVIZYQ
         P+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678231407;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oRt1mUnXnUEWD8FnMWmKeT848TwPURbevtP+JawEoFo=;
        b=XqAIVxTaLIPM+Z7EnMRXaRhvwj1Nh1ZjQdOXiS1jPgXtGYJ+ciowFin0/A5RXLJC+l
         oli3CWSAf4R0D0b3rs8nDLzfBpktx0jSjJ0p5zjh5xHkaMMDsw78Uv3AowOrjTeseNpm
         su/GbO+Df2gCh39kpEecRn3WYniayA5VPzce23ZssOqxr02bAx+m2P6V3xHtYoTtVuks
         QtTcDujQdzOvLUUnH0QoU5jGdYLZeRN66aZELgEPtgzfiCOrPrzAn5fVzgogXEz/dpJz
         UIxzi1YmZTMZXr3W17+qbJHPJiiZn40c0pVZoOv0+BF/PH75/HBcwShELCfbN2//cA80
         0G3w==
X-Gm-Message-State: AO0yUKXkSwch5HE2ocqpdROVUQnoGQnEHu6ulp7ybDaNk4YYmlmg+nmi
        UWBSD/5foxLzcaDsLfiDUNY=
X-Google-Smtp-Source: AK7set+YMZ3IKtIXFfqD0MqAHVw2/me6RmCrbfogsCw+LSIbpxkPiOw0TthbBAiPGuI8WfpIGkb5PQ==
X-Received: by 2002:a17:90b:1d0a:b0:237:9858:ebbf with SMTP id on10-20020a17090b1d0a00b002379858ebbfmr16882159pjb.30.1678231406631;
        Tue, 07 Mar 2023 15:23:26 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090adc8600b00234b785af1dsm7936124pjv.26.2023.03.07.15.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 15:23:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] sequencer.c: fix overflow & segfault in
 parse_strategy_opts()
References: <patch-1.1-f6a06e25cf3-20230307T182039Z-avarab@gmail.com>
        <xmqq5ybcxs1r.fsf@gitster.g>
Date:   Tue, 07 Mar 2023 15:23:25 -0800
In-Reply-To: <xmqq5ybcxs1r.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        07 Mar 2023 11:47:12 -0800")
Message-ID: <xmqqttywuowi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This made me look at split_cmdline_strerror().  It is a table lookup
> into split_cmdline_errors[] in alias.c which looks like this:
>
>     static const char *split_cmdline_errors[] = {
>             N_("cmdline ends with \\"),
>             N_("unclosed quote"),
>             N_("too many arguments"),
>     };
>
> So the result is properly localized, but I suspect that the string
> after : should not be enclosed within a pair of single quotes.
>
> 	die(_("could not split '%s': %s", strategy_opts_string,
> 		split_cmdline_strerror(count)));
>
> Other than that, nice find.

I'll queue this on top.

----- >8 ---------- >8 ---------- >8 ---------- >8 -----
Subject: [PATCH] SQUASH: no point in quoting strerror like messages

The error message is taken from a limited and fixed set of strings
and we do not usually enclose strerror(errno) inside a pair of
single quotes.
---
 sequencer.c                    | 2 +-
 t/t3436-rebase-more-options.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cc59a1c491..e4a3f0081f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2885,7 +2885,7 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 	count = split_cmdline(strategy_opts_string,
 			      (const char ***)&opts->xopts);
 	if (count < 0)
-		die(_("could not split '%s': '%s'"), strategy_opts_string,
+		die(_("could not split '%s': %s"), strategy_opts_string,
 			    split_cmdline_strerror(count));
 	opts->xopts_nr = count;
 	for (i = 0; i < opts->xopts_nr; i++) {
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 195ace3455..c3184c9ade 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -42,7 +42,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'bad -X <strategy-option> arguments: unclosed quote' '
 	cat >expect <<-\EOF &&
-	fatal: could not split '\''--bad'\'': '\''unclosed quote'\''
+	fatal: could not split '\''--bad'\'': unclosed quote
 	EOF
 	test_expect_code 128 git rebase -X"bad argument\"" side main >out 2>actual &&
 	test_must_be_empty out &&
@@ -51,7 +51,7 @@ test_expect_success 'bad -X <strategy-option> arguments: unclosed quote' '
 
 test_expect_success 'bad -X <strategy-option> arguments: bad escape' '
 	cat >expect <<-\EOF &&
-	fatal: could not split '\''--bad'\'': '\''cmdline ends with \'\''
+	fatal: could not split '\''--bad'\'': cmdline ends with \
 	EOF
 	test_expect_code 128 git rebase -X"bad escape \\" side main >out 2>actual &&
 	test_must_be_empty out &&
-- 
2.40.0-rc2

