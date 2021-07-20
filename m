Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E312C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 18:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9146101B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 18:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhGTRe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhGTRdm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 13:33:42 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBCDC061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 11:14:20 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r18so13897374iot.4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l7+xL8K91UECUyLSkVVGq6xloiNopdNARzFTltfIuVI=;
        b=RapJeEhyxdWb27TNwOD+70/25xFtVGDfb6brLza/1Dv7rLeiNLoRMCphPPrUDdx6aR
         t/oitm7kRh8GaRTZOyehmfx40TzITT3zC/1gjaz9/kk85Ws1/uxCIko/DnX7946FaYtu
         cgvZOEeDYgrWiVnykLjANSNA+09LP7BMUb3GLLn5kQ6dtKzvIjRaBm+0lTKpmq3kFeg5
         5kVURkppBf6FrHbzABn6LgYrWWVVij7qzoNrHXPerSVifyYKlNkYVvLlpKA3LbvEzDUE
         JZVem/X6w9p8AZyNXntSCnPItA697FzsVUBP3yTFKkENUX7pXvqeBxEjV8K7le2zm5ti
         tiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l7+xL8K91UECUyLSkVVGq6xloiNopdNARzFTltfIuVI=;
        b=DBD6K7eSBdKDBserbQsTK+EVt2tMBkF2/qTMx5rk8IJ6c4IP5cu0l1hmM1XCthX5b6
         YaqmNj742KLDGpodfB5gDHUqYZyjTBsJNoz0uhZRU9rLzqSDI1VQmMqhIOEQxL3F59Cs
         TqzcRO8+baUq1Ao3yqofUsPpjft9uqkNTgi6dz6PjrNXBqJQcxqp4C+5Affup9Jf6Njs
         UT1Ags9ZU8HbQWW4eL4GKMsFWIkyTLhGWzkNrPRf8TsSqKvkeR7bDrlPzKBSb6vAwbQC
         YfxdkayCy9VavQVOXRC/C9g8g/iA5L34URNPTGfFPj8/Ks4R7JZ0obTCNQ2cjIzkh1DV
         rbMw==
X-Gm-Message-State: AOAM531+DeoglXbp38u1SkW/ytR6gO08EWsOxelJnf57GOr1oNP6muHx
        14nP82gpj8yNRt8KZh4VrM4ycA==
X-Google-Smtp-Source: ABdhPJygqrrb77NHrjuO5KdGXqLYus+dm6rj57gOr94fsveMcXyo9nlM2vo4wDzhPb55N+c02Kf9xA==
X-Received: by 2002:a6b:e90b:: with SMTP id u11mr16355527iof.134.1626804859542;
        Tue, 20 Jul 2021 11:14:19 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id m26sm12905338ioo.23.2021.07.20.11.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 11:14:19 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:14:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 4/6] multi-pack-index: refactor "goto usage" pattern
Message-ID: <YPcSemODaPJ8rkOr@nand.local>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <patch-4.6-6e9bd877866-20210720T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.6-6e9bd877866-20210720T113707Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 01:39:43PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Refactor the "goto usage" pattern added in
> cd57bc41bbc (builtin/multi-pack-index.c: display usage on unrecognized
> command, 2021-03-30) to maintain the same brevity, but doesn't run
> afoul of the recommendation in CodingGuidelines about braces:
>
>     When there are multiple arms to a conditional and some of them
>     require braces, enclose even a single line block in braces for
>     consistency[...]
>
> Let's also change "argv == 0" to juts "!argv", per:
>
>     Do not explicitly compare an integral value with constant 0 or
>     '\0', or a pointer value with constant NULL[...]
>
> I'm changing this because in a subsequent commit I'll make
> builtin/commit-graph.c use the same pattern, having the two similarly
> structured commands match aids readability.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/multi-pack-index.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 5d3ea445fdb..2952388a8eb 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -164,7 +164,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  	if (!opts.object_dir)
>  		opts.object_dir = get_object_directory();
>
> -	if (argc == 0)
> +	if (!argc)
>  		goto usage;
>
>  	if (!strcmp(argv[0], "repack"))
> @@ -175,10 +175,9 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  		return cmd_multi_pack_index_verify(argc, argv);
>  	else if (!strcmp(argv[0], "expire"))
>  		return cmd_multi_pack_index_expire(argc, argv);
> -	else {
> +
>  usage:
> -		error(_("unrecognized subcommand: %s"), argv[0]);
> -		usage_with_options(builtin_multi_pack_index_usage,
> -				   builtin_multi_pack_index_options);
> -	}
> +	error(_("unrecognized subcommand: %s"), argv[0]);

Not the fault of this patch, but since we jump to this from the "if
(!argc)" conditional, reading "argv[0]" is UB. Some compilers will print
out:

    error: unrecognized subcommand: (null)

which at least doesn't segfault, but is still ugly. I don't mind calling
it ugly since I was the one to introduce this behavior (by accident, of
course).

I sent a patch [1] yesterday to squash this, but we should consider
combining the two (or dropping this patch from the series and then
coming back to it later on).

If you want to combine forces, here's what I think that could look like
(without your s-o-b, which you'll have to reattach).

[1]: https://lore.kernel.org/git/8c0bb3e0dc121bd68f7014000fbb60b28750a0fe.1626715096.git.me@ttaylorr.com/

--- >8 ---

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Subject: [PATCH] multi-pack-index: refactor "goto usage" pattern

Refactor the "goto usage" pattern added in
cd57bc41bbc (builtin/multi-pack-index.c: display usage on unrecognized
command, 2021-03-30) to maintain the same brevity, but doesn't run
afoul of the recommendation in CodingGuidelines about braces:

    When there are multiple arms to a conditional and some of them
    require braces, enclose even a single line block in braces for
    consistency[...]

Let's also change "argv == 0" to juts "!argv", per:

    Do not explicitly compare an integral value with constant 0 or
    '\0', or a pointer value with constant NULL[...]

I'm changing this because in a subsequent commit I'll make
builtin/commit-graph.c use the same pattern, having the two similarly
structured commands match aids readability.

While here, fix an issue since where cd57bc41bb
(builtin/multi-pack-index.c: display usage on unrecognized command,
2021-03-30) we sometimes jump to 'usage' without any arguments.

Many compilers will save us from a segfault here, but the end result is
ugly, since it mentions an unrecognized subcommand when we didn't even
pass one, and (on GCC) includes "(null)" in its output.

Move the "usage" label down past the error about unrecognized
subcommands so that it is only triggered when it should be. While we're
at it, bulk up our test coverage in this area, too.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c  | 11 +++++------
 t/t5319-multi-pack-index.sh |  6 ++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5d3ea445fd..e3a684c842 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -164,7 +164,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();

-	if (argc == 0)
+	if (!argc)
 		goto usage;

 	if (!strcmp(argv[0], "repack"))
@@ -175,10 +175,9 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return cmd_multi_pack_index_verify(argc, argv);
 	else if (!strcmp(argv[0], "expire"))
 		return cmd_multi_pack_index_expire(argc, argv);
-	else {
-usage:
+	else
 		error(_("unrecognized subcommand: %s"), argv[0]);
-		usage_with_options(builtin_multi_pack_index_usage,
-				   builtin_multi_pack_index_options);
-	}
+usage:
+	usage_with_options(builtin_multi_pack_index_usage,
+			   builtin_multi_pack_index_options);
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 5641d158df..fcde6dcded 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -824,4 +824,10 @@ test_expect_success 'load reverse index when missing .idx, .pack' '
 	)
 '

+
+test_expect_success 'usage shown without sub-command' '
+	test_expect_code 129 git multi-pack-index 2>err &&
+	! test_i18ngrep "unrecognized subcommand" err
+'
+
 test_done
--
2.31.1.163.ga65ce7f831

