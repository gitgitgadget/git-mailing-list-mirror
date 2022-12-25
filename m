Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F14EC4332F
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 11:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLYLGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 06:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYLGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 06:06:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92469F17
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:06:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n3so5847641pfq.10
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ixgw5yuJ8KSO7rx5IFK3Zp30S03niTlBwl1uUMyeCBo=;
        b=bxDa0K8EZHJ2EcE+fK3XUx5f4hK9uBTcwortgLWL8Vy5vGVxL7uo73HbMX/zkfAAyP
         cbxZuLtylTrBI9JtY/9hOQaAM5gJObVB3RQtT3jN0tbNnzNG+fuVsWI/XUtdzaq+eBrk
         QgWLeHJ1ipB7lPX8+EjIbrGuWdtp54G8YeZ4fsHhTFLqwylmELoUTVYo7BbDdSvxklA5
         I/0TlmNgeSFrLHahD11niQEVVCfy/QfbSHnj61/No+ePeAa0zzCbB42rhR8DsP8y65M2
         aQRaztTvjb8Fqqua4jJULG/1fgCD3Gc8FzKK15UaKGH8H74mC/f24lnGY3vqRieYpIQ3
         yEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ixgw5yuJ8KSO7rx5IFK3Zp30S03niTlBwl1uUMyeCBo=;
        b=rFJfSCUZF31+jDyj2lnP9uW0xtVVSpOTi2cy0PyLzJsFA6S3gGrehFGV9iWQo6BXoM
         M4aMT5Eg0s8BtrOBO8lV/0VQVGLd3W8XYPSaTgQ/jTosZ+N8xPbIkmF1ksbnfzP6aGND
         nU4lKxBd27OOs6QMUtj/yAklYOA/oG/vql4F+fjdoI0pgin1x0iPJvcOGGfy6t0qtZ4A
         +sbFMkzSadKksqzWIZV3ZRAvh/U5wrzuM1bqLaPjdUISM/xqr7sQIEm0VpSpnSQRHOp9
         IE4SZ4GwHlLtf5O/7kaus4+Fh0FEvEqMmYiGPp5rzLcvSizqnJLBM+O5vgioSdUeytcH
         CEKg==
X-Gm-Message-State: AFqh2kqYJxi8X67istsTDxzNqorQplW2SOyGPFVccHUOqIZJXYqktl4N
        iRJ2BcIwtGsEEdsAZ+vsX0XHXoJMwDWSBQ==
X-Google-Smtp-Source: AMrXdXsZL+YVvG7sygeEOi8Jls7GdCPM9uG3xnjtzOH0UYk7n7DoFUm2keaj9pHDa1ptiQ6TG7Tfcg==
X-Received: by 2002:a05:6a00:1248:b0:576:9455:4c5e with SMTP id u8-20020a056a00124800b0057694554c5emr20805019pfi.24.1671966361046;
        Sun, 25 Dec 2022 03:06:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p62-20020a625b41000000b005765a5ff1fasm5127632pfb.213.2022.12.25.03.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:06:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Hubert Jasudowicz <hubertj@stmcyber.pl>,
        Derrick Stolee <derrickstolee@github.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] bundle: don't segfault on "git bundle <subcmd>"
In-Reply-To: <patch-1.1-2319eb2ddbd-20221220T133941Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Dec
 2022 14:40:18 +0100")
References: <20221220123142.812965-1-hubertj@stmcyber.pl>
        <patch-1.1-2319eb2ddbd-20221220T133941Z-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Sun, 25 Dec 2022 20:05:59 +0900
Message-ID: <xmqq5ydzpwtk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> As an aside, this could be safely squashed into this, but let's not do
> that for this minimal segfault fix, as it's an unrelated refactoring:
>
> 	--- a/builtin/bundle.c
> 	+++ b/builtin/bundle.c
> 	@@ -55,13 +55,12 @@ static int parse_options_cmd_bundle(int argc,
> 	 		const char * const usagestr[],
> 	 		const struct option options[],
> 	 		char **bundle_file) {
> 	-	int newargc;
> 	-	newargc = parse_options(argc, argv, NULL, options, usagestr,
> 	+	argc = parse_options(argc, argv, NULL, options, usagestr,
> 	 			     PARSE_OPT_STOP_AT_NON_OPTION);
> 	-	if (!newargc)
> 	+	if (!argc)
> 	 		usage_with_options(usagestr, options);
> 	 	*bundle_file = prefix_filename(prefix, argv[0]);
> 	-	return newargc;
> 	+	return argc;
> 	 }

That would actually make the intent much clearer and if the code
were written to update argc instead of introducing a separate
varilable, this bug would not have happened.

Thanks, will queue (without the clean-up at least for now).
