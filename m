Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E6C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 12:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJRMni (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJRMnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 08:43:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A4C34CD
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:43:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ot12so31928009ejb.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SpvvMEhq2RzIEb0Svin4vBf2MyWsN/PXsfBuHDOqi20=;
        b=FuLczRaAOxo+0/ZTp4FqybjxeuDePvEb0im1Ck6RA+SOfVGJ7vyyU4k9mDBwmFVDKK
         0j1KglWznHAz1lzzJ6iaNQwythAzh48FBXE40FKTWMAziVNAAyD5ekxPaaj3Rp7pmEN4
         2ylnLkLjd//QuYQsE4j2NkT7EgkXAlmm5jYD/MnMrCGAwNViSlLGExSlSSlO5kstHILC
         r5+wKt5Ml4o8kTAykIb9WHiWlMc/UITJaCq2eKN1Lu4qdURvKNO/n+BkS59+mbbCa58x
         ijmKg2qextzEknYyHZnsqdUZnqM/6rVtf8DK8jmuCwUTdINuy8IYIWIcjiGReynnGNNA
         38Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpvvMEhq2RzIEb0Svin4vBf2MyWsN/PXsfBuHDOqi20=;
        b=BPlb3wE9GX/+hrhZbbQRpbSE+LDQ3Z9psrXpGd40JRyWLe0IFd/qDzLOXJCa9Uou5X
         zgaMSQDrq775eCW1NaiUpBW9FWQsiGowwYJVMI7at7/s7p94Q9b6LJMEaGrt02BXYCQy
         hO6CSHAotJn73Kdv3cWuQEOSEdVJdXWIF25Ju17o1b9I0gGRW/Y1qEPDQeNg9raSe9jg
         73EY+gebWISoOjDJi9WR/SI7NNfcuBehWtwQz4iQknTHC7Yz7wZ8WBkt96jvgGu/stHF
         0H96VMETqS81GF7ZwbQmaWaERX3KsgjhQWCg7HYGdEC4SB00KKYdcgU11pLJcJOHntt6
         zAlg==
X-Gm-Message-State: ACrzQf3+GMoHCFbkcq7zugsrVIMe1SQKcO627/5wM/DtKR8qWB7G90Te
        Z3ae7vLNoOmR0HqrNmQh290s+a/9wtmpEg==
X-Google-Smtp-Source: AMsMyM4bnJ40vKD62t5DPNwpsQCkmSCg3YLw42C/lY9305q64k44TbWvinh0HM7a3qR8q6jzKvZaKQ==
X-Received: by 2002:a17:906:4783:b0:780:5be5:c81b with SMTP id cw3-20020a170906478300b007805be5c81bmr2324095ejc.76.1666097015054;
        Tue, 18 Oct 2022 05:43:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906701300b0078d25e0f74bsm7466906ejj.46.2022.10.18.05.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:43:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oklwT-005k7R-1S;
        Tue, 18 Oct 2022 14:43:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 11/12] fsmonitor: test updates
Date:   Tue, 18 Oct 2022 14:42:15 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <743bdacded5183b5b11c9f19c24b07fa26eded24.1665326258.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <743bdacded5183b5b11c9f19c24b07fa26eded24.1665326258.git.gitgitgadget@gmail.com>
Message-ID: <221018.86mt9ti9oq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 09 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>

> +wait_for_update () {
> +	func=$1 &&
> +	file=$2 &&
> +	sz=$(wc -c < "$file") &&
> +	last=0 &&
> +	$func &&

Odd not to quote "$func" here, but anyway...

> +rename_directory () {
> +	mv dirtorename dirrenamed
> +}

...uh, we need to wrap "mv"? Why?


> -	mv dirtorename dirrenamed &&
> +	wait_for_update rename_directory "$PWD/.git/trace" &&

Just to get around some quoting issue here?
