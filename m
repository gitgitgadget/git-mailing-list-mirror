Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705E7C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA42613ED
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJJUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhFJJUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:20:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B8C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:18:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so5993157wmq.0
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ma3QL984tcSG1+y1LVKZw+OTnEb7pesQq0DtZ3N9nOk=;
        b=JoyduKaGR1AP8SYBALC2i+GU8dlpCPpE1sCvDGeHtY38q0iFQ563Gm5O0q0bJKIrR4
         SOPiTJe7TPjVzb1GgHD6OMh+x4BzKaI7xC9mAPMUpgmj3eZlt3EZzLR3SDa2eyXZP+2W
         W4vR+YUx6Va0/sSd21hyF2uxosRrRewW3gxS0pcHk+M4GQTjDIWkkI+qNErOGuRdewCC
         Dsi40f+xLFi8dZTbXgN5q9JCOS1UG7lwHr/tEkqgJ6PfC4WPKJY4zG1oCwhCakyj3apY
         lky3xSUP0MeUSbsnIUOiavI/+GpYQhlcNXHf/PZMxiygxMQlGM9EyaQNei/mH1svh6uz
         bDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ma3QL984tcSG1+y1LVKZw+OTnEb7pesQq0DtZ3N9nOk=;
        b=nGAbXex1K0uvuGiiv+lgInpPKtbSZZybXZ6g1YaxR1Uy7P1TckjV5l8S8tyTDe7fRE
         BXIXT81norj7lzNoDb+bLnRmGXOWjhXNUPDimNflhV7i99hnSQf7oVOSe69yTw9X7ZUb
         3c3/pO6EPfKIC8zj1UnvmQWrR/pf5l+JANvaGDt1/5SHGDQX7dnOZQkIeQPZavrbyjh9
         WdZE7g9xFuliIQEINX780lLrxOMUEgF3WibjpoTjm548SOnoTNL2JLIhlhR8uAgrEQcU
         z7IS8stGHbJS3LlXsvQ2/O9gy/iKGFgyyXsMxN2DZqANdkMbMhLdapi/WFhVEdXsQc/p
         U9bQ==
X-Gm-Message-State: AOAM531zrnl1ZOxNe/tJOJarsHNWp2ltWU2N0aZ0z0emcQfQ3Z2Ltcx2
        ECsmI1VEtvOGmc1JVsPHHJk=
X-Google-Smtp-Source: ABdhPJw+tScoedDvooxWw0bxUxCKdLisSc5lVtAP+fsKKIPqSOu+7DuUFtsV6Mdw4j90FGhD9x1gug==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr13833058wmh.127.1623316706563;
        Thu, 10 Jun 2021 02:18:26 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id p10sm2687644wrr.33.2021.06.10.02.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 02:18:25 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/7] test: add merge style config test
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-2-felipe.contreras@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b2436790-bbf0-2623-5e29-a6f6b4959974@gmail.com>
Date:   Thu, 10 Jun 2021 10:18:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609192842.696646-2-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2021 20:28, Felipe Contreras wrote:
> We want to test different combinations of merge.conflictstyle, and a new
> file is the best place to do that.

I'm not sure what this particular tests adds over the existing ones in 
t6427-diff3-conflict-markers.sh. The commit message does not explain why 
a new file is better than adding this test to that file. There are 
already diff3 tests for checkout so it ends up being confusing when a 
checkout test gets added to this file rather than with those tests later 
in the series because there is no longer a single location for diff3 
checkout tests.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   t/t6440-config-conflict-markers.sh | 44 ++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>   create mode 100755 t/t6440-config-conflict-markers.sh
> 
> diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
> new file mode 100755
> index 0000000000..6952552c58
> --- /dev/null
> +++ b/t/t6440-config-conflict-markers.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +
> +test_description='merge style conflict markers configurations'
> +
> +. ./test-lib.sh
> +
> +fill () {
> +	for i
> +	do
> +		echo "$i"
> +	done
> +}
> +
> +test_expect_success 'merge' '
> +	test_create_repo merge &&
> +	(
> +		cd merge &&
> +
> +		fill 1 2 3 >content &&
> +		git add content &&
> +		git commit -m base &&
> +
> +		git checkout -b r &&
> +		echo six >>content &&
> +		git commit -a -m right &&
> +
> +		git checkout master &&
> +		echo 7 >>content &&
> +		git commit -a -m left &&
> +
> +		test_must_fail git merge r &&
> +		! grep -E "\|+" content &&

! grep "|"  would be simpler and just as effective. This is quite a weak 
test, something like "^|||||| " would be a stronger test for conflict 
markers

Best Wishes

Phillip

> +		git reset --hard &&
> +		test_must_fail git -c merge.conflictstyle=diff3 merge r &&
> +		grep -E "\|+" content &&
> +
> +		git reset --hard &&
> +		test_must_fail git -c merge.conflictstyle=merge merge r &&
> +		! grep -E "\|+" content
> +	)
> +'
> +
> +test_done
> 
