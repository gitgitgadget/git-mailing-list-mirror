Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C65C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 15:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhLGPlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 10:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhLGPli (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 10:41:38 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCEC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 07:38:08 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id v30-20020a4a315e000000b002c52d555875so5506971oog.12
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 07:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WtZCqizsFqBCouzvA0QYgxIAuCpfk9iZbj4I8Gc/kUc=;
        b=F2ulL3FdBoHU4r7TXTXEgU7ZIgtm98zLpYyaX6n5YfSsNago8asRUKmmgBvCMg3WzM
         Jku/vJYgTnYSnbALJMEpOsirJFNWglqNBZYsncQZ/KrdhIfH+QawC0fpx7X2SnNsFcAI
         iGwqNnOq3/noPe2GqfjmPOluo+hRsX9rnAkVZGN6JFWIFigMky/nnXOpiNiEqKN6VBAY
         mx3WBUs3pM/H8edGhO0o0xnn5RM9YPLfs8V5UcrruCbaZlGP2gluZGldRzv8v1i+8eRi
         mlz9uyD8bgbgtflZidOBomy2AnK/cuKMZ8Cb1FKIzsyFMMap+UJwrzOuVJx04/G2cE+j
         n0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WtZCqizsFqBCouzvA0QYgxIAuCpfk9iZbj4I8Gc/kUc=;
        b=K4O10HP87Qy8oQBeSjchVi8MZDnVnRtnos6rYmvjq1ZT7EK0emBR79b6a9YgeQY80c
         s4U/IcMz426BPCH8DeqAv9k6QrypLXqskW1RdMPynD4VoJJJ2TcSU1Or7qynR3HbD30K
         4NTARxwhg036gt7QnzUneg2na+nsuXay2a7FgJeCvi7ZcSM1eFNW6mVz2sFc6TrA8l68
         /FArWBOV7hs2g88Ex/FmEl6Qu9PY/SsC1XuFJXKxPAb/Caqqf2R1HySW+Tx19cZKO7zn
         xbsa3B0Vt54C+wAp2kVB623ST87q/JMUJ71r0hyaYldsKyjisIMCZa0F+1Agve2VsfjO
         KMTw==
X-Gm-Message-State: AOAM5336I9vH99F3235LXMj62Cpu6X0/1tr1PwSuhueoNF/peYB1SC+o
        t9AMP6Y+2ehshhobQ+N1zuk=
X-Google-Smtp-Source: ABdhPJyboMIwdKYvA8hZ5fy063E13OLsf3xzxeJbKa6IYd3/8ol2btwzrUXMQlHDyb75uJglpERMZA==
X-Received: by 2002:a4a:5a43:: with SMTP id v64mr27483465ooa.26.1638891487431;
        Tue, 07 Dec 2021 07:38:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id g2sm3210399oic.35.2021.12.07.07.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 07:38:06 -0800 (PST)
Message-ID: <c9437c89-9258-4034-9886-8a2aec46aa6b@gmail.com>
Date:   Tue, 7 Dec 2021 10:38:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 12/17] builtin/repack.c: support generating a cruft pack
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <a05675ab834ac5e8bc3ab72847b0621a563e0e1b.1638224692.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a05675ab834ac5e8bc3ab72847b0621a563e0e1b.1638224692.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 5:25 PM, Taylor Blau wrote:

> +static int write_cruft_pack(const struct pack_objects_args *args,
> +			    const char *pack_prefix,
> +			    struct string_list *names,
> +			    struct string_list *existing_packs,
> +			    struct string_list *existing_kept_packs)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct strbuf line = STRBUF_INIT;
> +	struct string_list_item *item;
> +	FILE *in, *out;
> +	int ret;
> +
> +	prepare_pack_objects(&cmd, args);
> +
> +	strvec_push(&cmd.args, "--cruft");
> +	if (cruft_expiration)
> +		strvec_pushf(&cmd.args, "--cruft-expiration=%s",
> +			     cruft_expiration);
> +
> +	strvec_push(&cmd.args, "--honor-pack-keep");
> +	strvec_push(&cmd.args, "--non-empty");
> +	strvec_push(&cmd.args, "--max-pack-size=0");

This --max-pack-size is meaningless, right? The config that would change
this is already ignored by 'git pack-objects'.

> +		OPT_BIT(0, "cruft", &pack_everything,
> +				N_("same as -a, pack unreachable cruft objects separately"),
> +				   PACK_CRUFT | ALL_INTO_ONE),

I can understand the use of OPT_BIT here. Keep in mind that --no-cruft would
remove the '-a' option, if it already existed. Perhaps we should just use
OPT_BOOL and update to add the ALL_INTO_ONE if PACK_CRUFT exists?

> +		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
> +				N_("with -C, expire objects older than this")),

Here, --no-cruft-expiration will set cruft_expiration to NULL and not overwrite
the --cruft option, as expected. Just pointing out that this is different than
the option in 'git pack-objects'.

> --- a/t/t5327-pack-objects-cruft.sh
> +++ b/t/t5327-pack-objects-cruft.sh
> @@ -358,4 +358,157 @@ test_expect_success 'expired objects are pruned' '
>  	)
>  '
>  
> +test_expect_success 'repack --cruft generates a cruft pack' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		test_commit reachable &&
> +		git branch -M main &&
> +		git checkout --orphan other &&

Here is a way to make objects unreachable!

> +		test_commit unreachable &&
> +
> +		git checkout main &&
> +		git branch -D other &&
> +		git tag -d unreachable &&

Thanks,
-Stolee
