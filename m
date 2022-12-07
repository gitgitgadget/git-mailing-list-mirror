Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17D6C63705
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiLGW3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLGW3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:29:09 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5716C81D80
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:29:08 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so17371830ejc.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EIuFQIaLPKiwGCtDoPJcm7sImAt0w5IJID12ZWkGXp8=;
        b=NUSvm1l7MG6HTyuKEDT03k/6XafYs3LspjpVvM2Z+BgzrJhT/f9peDcjvjnhoKcmOa
         kTgh0jYFiBdza/2OUa+yMcV5JvlsKJGVNcLr6SEkQ4T1/wVjBtNWP1sDZM6V7CEqkq7T
         xjH8RKeYn0r4D4hZdGMZD1hJ0Y3Y8elmXkNAHQiINufcOa+i8vcKcBjuFRoqGHin3Fut
         grHZXaJyxsCRtg+d15MToABsB6LQmJgMKfSU1R9BbWaKL5ENa1sD/Pw6ie3Br7syxovM
         bS3dqr/+61gfC0kdcli5nYhmBxrqOeuldmAFk6WE2JqxaW+FNx1EdMxNIIHGMXH1TPAm
         fnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIuFQIaLPKiwGCtDoPJcm7sImAt0w5IJID12ZWkGXp8=;
        b=YqKKe1slQlQQP3iZqLZS5RyOrcoDicQrr00RyANkHwD9itbvukeJv9hqc9sE4b2Kgv
         mDjAq52+BA7CZH+CWs1tn1cE/jqktg779zi0c3YFmzsRwfUJJtXEDokIFVbRjOmIQNni
         Uae0ZwTWf/Kz3mYQPtd8A/viwmZdOGZ6XsaMHpDMUZv6QXNPIVWfHXOb/tB+N/f/MsqX
         AHw6WSuQAFwmBPmV10w3LN+gS024Lmm4lUbCgsIZtErlweOBRmE8S1U7kR+dtPA5HABN
         Xl04t+uCJcXeuNj3xwfsLV38aG6VQ682PydpCHtxFX2/HcCVyjfrY9SXuf6/8tdtxkgI
         Iyug==
X-Gm-Message-State: ANoB5pkp3PsH0N6zaZ2E1nmU4EFFhDc6Ue/aOrzIiQKn+it8JiJq3qvF
        NhBqvrVzb2VdpqT7w9eEvxF/TyhVMNFEyQ==
X-Google-Smtp-Source: AA0mqf7cb1kBts8qgEBGGXPz5enPWRG1TNovn60fUVe5gSrk5DVm9aOwIS1A1JuYIx32COQoJWxQRA==
X-Received: by 2002:a17:907:8746:b0:7bc:1e7e:6b8e with SMTP id qo6-20020a170907874600b007bc1e7e6b8emr873559ejc.43.1670452146573;
        Wed, 07 Dec 2022 14:29:06 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h5-20020aa7c945000000b0044dbecdcd29sm2684733edt.12.2022.12.07.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:29:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p32uV-004cby-2G;
        Wed, 07 Dec 2022 23:29:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/4] test-lib-functions: add helper for trailing hash
Date:   Wed, 07 Dec 2022 23:27:45 +0100
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <a20bf8de8645c19a02838d70a7c2c3b00378a50d.1670433958.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <a20bf8de8645c19a02838d70a7c2c3b00378a50d.1670433958.git.gitgitgadget@gmail.com>
Message-ID: <221207.86zgby97bk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> +# Given a filename, extract its trailing hash as a hex string
> +test_trailing_hash () {
> +	local file="$1" &&
> +	tail -c $(test_oid rawsz) "$file" | \
> +		test-tool hexdump | \

You don't need the "\"'s here.

> +		sed "s/ //g"
> +}

At the end of this series we have one test file using this
test_trailing_hash, can't we just add it to t1600-index.sh?
