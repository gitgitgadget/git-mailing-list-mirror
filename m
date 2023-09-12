Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEADCA0ECA
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 13:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjILN0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjILN0o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 09:26:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A4310DB
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 06:26:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40078c4855fso59536065e9.3
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694525198; x=1695129998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xQAKnuEKN+YM9mygnyn2oSiURSR1RNYCmiDOUkKBtwE=;
        b=FFBdEcdCr/HbTPr8lB6e5L+oIQO58E4cuyO/ksu4C+g2skiWTSalLt+qvMkZ8Iwkn6
         +tRC7n+pxwfARRZVPCFa+ZrSXCXlvKn6lS9DSmxC/W1meVDZZCNt+FZOkEKdqlutt5us
         IxmyVeNdS8B5sCovdVNpzmtPDdXDTZC/aBLrsG3IeOixAAZ1vOVOLMA/816FkzzW6yNw
         Xxwh1fxXlyg4LEZrCPv9oTEwZUVcFHmuk9QEOKNyW6MdMD7Iqi0EopscRoQb+E31c+Td
         8W1a602yTBO3Ow3pCsKG4XYyUqIdJse2sWMKfTLWhgPG19xok1LRiDLx0dGo5PsnJ3NM
         HZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525198; x=1695129998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQAKnuEKN+YM9mygnyn2oSiURSR1RNYCmiDOUkKBtwE=;
        b=fOn40Od8VoXQtVHUNL/22zyqJMCyaVW/MoQNdVmyt045u58F6szvBgveHU8NwVjChd
         2TFmSo4VI/ocTUjBGvYUK1kfuBimlAVprA/4Pwb9k8RY73oVLKV9tUahSHbZjKFmQmu9
         4FWWxXlgCYHISeLng+2LA77vcb/nShfvw7019rhMu83sWgen/hqqEGIhUnJaMc24MrQZ
         r5zckjLD7IxHjKx3LpyEPnkEylaUG3Y+WqKu16hX1GBjZ/Ls04xrskhxR8wgwqUg8jll
         sWHY1FIyzBCLXqDSloLUgzr/0iboVxgf7Pw3KxdmBp9/3qzZq8RMqs0+YBzeKN9Dqfc1
         SUEA==
X-Gm-Message-State: AOJu0YwEPhuDeV2v5kfJlliru4O8X1gvEeZuGzHKbmIglHKD+x+QwjsQ
        1yYt3njZsKuBrAs1vYlRdqs=
X-Google-Smtp-Source: AGHT+IFKRUTGBgrMQYvkaoSySdSZw+8lfZri/ViMNeI/ZTNrN0qGtMVhZfGs36s9YijYbxq7Tdcghw==
X-Received: by 2002:a05:600c:354d:b0:402:f500:fcee with SMTP id i13-20020a05600c354d00b00402f500fceemr10243741wmq.0.1694525197676;
        Tue, 12 Sep 2023 06:26:37 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id h19-20020a05600c315300b00402bda974ddsm13300516wmo.6.2023.09.12.06.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:26:37 -0700 (PDT)
Message-ID: <76c36744-b821-450b-9817-e0cd8811de65@gmail.com>
Date:   Tue, 12 Sep 2023 14:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] t3404-rebase-interactive.sh: fix typos in title of a
 rewording test
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <45ee4ad1-f7a3-43d8-99ef-329efc9fcdba@gmail.com>
 <20230912104237.271616-1-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230912104237.271616-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/2023 11:42, Oswald Buddenhagen wrote:
> This test was introduced by commit 0c164ae7a ("rebase -i: add another
> reword test", 2021-08-20). I didn't quite get what it was meant to do,
> so here's an explanation from Phillip:
> 
> The purpose of the test is to ensure that
> 
>    (i) There are no uncommited changes when the editor runs. I.e., we
>        commit without running the editor and then reword by amending
>        that commit. This ensures that we have the same user experience
>        whether or not the commit was fast-forwarded [1].
> 
>   (ii) That the todo list is re-read after the commit has been reworded.
>        This is to allow the user to update the todo list while the rebase
>        is paused for editing the commit message.
> 
> [1] https://lore.kernel.org/git/20190812175046.GM20404@szeder.dev/
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

This looks good to me, Thanks

Phillip

> ---
> v2:
> - actually, it's kinda a new patch now
> 
> Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
> Cc: Junio C Hamano <gitster@pobox.com>
> ---
>   t/t3404-rebase-interactive.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 96a56aafbe..bf94eb28b9 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -758,7 +758,7 @@ test_expect_success 'reword' '
>   	git show HEAD~2 | grep "C changed"
>   '
>   
> -test_expect_success 'no uncommited changes when rewording the todo list is reloaded' '
> +test_expect_success 'no uncommitted changes when rewording and the todo list is reloaded' '
>   	git checkout E &&
>   	test_when_finished "git checkout @{-1}" &&
>   	(

