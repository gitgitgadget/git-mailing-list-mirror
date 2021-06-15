Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAA6C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09F661474
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFONeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFONd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 09:33:58 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8F2C061767
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:31:53 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id im10so21489358qvb.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XAjgkxKkCbIUpOBOH/0wk5T9gfO2Vnlw9dykSiWh0pc=;
        b=DMn0b8QgDP+M02p6AOR4IqXd88uHU3SqbJ+0nYeSt7EX6DGkIa7FBPWXvo2TQLbKpU
         m6r4Xea7mvO5KcIdVsa4khDUmp7RRMMd8ZKMVZ0zvaXxPdjGxiEaIkYlKG6tMhFugsSs
         zGTJo9EhPVbjPApJuz+n3wPdi+hMhZF3OFmwur7Zrq1O6PRYDR5c/iRxRWaBwlOnoGWT
         EzErGeZMydimN32Lvbse9bljGH4VEdBzAfVFhTeEM0KbCWVp/1aNRL7Mlu/eUS5+l2b6
         W9wgpUgwK1XlVE/FElg/sm1vAQDUsVMS2GSuJmzDeoQTrQ+rCOKU2rnkWxd3J6jgTo1T
         THcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XAjgkxKkCbIUpOBOH/0wk5T9gfO2Vnlw9dykSiWh0pc=;
        b=BjdE7gq4K9SV7GH+xLreaaDDdgpsycs+wj+HnTHdPL10/TIVjeX67NmggUfdQl/E8W
         cJe48nxdfP9B+SmHt+azJXJ7RuIki2U9lCwSYeHpLzpyMsqppfpZGh+lxM4P6vAEGwjO
         gRzMWx3JsIAWFimrNBVMzZ/nDf6tw4jER9qZt5xnlrZkhnNZ2MfxPpcCHH2gFEE0ZzD1
         MQTaxsdLdoCbbmbIhUWN1ppJJwcdSoXUAHhPTexJIX68PjJQykRHs9QqoRaSP0xgPsEU
         1/1Gqo0TxaN+m3CfNBQ4HrU3iPoxGSnNHMZkzzCfh0SGxEI0BcqfmUK/0NZivqPJ0Uwg
         jmIw==
X-Gm-Message-State: AOAM533Au0DkTqaJsgOeYb9L1aivFxlCvsb5okIAIOVUCP2grMwHS7nk
        FoMmcN25Ai4fLgVgsPYlWlE=
X-Google-Smtp-Source: ABdhPJz/gOT+3V95donxrZTF/kEBGOjkKwAdNEiwmwCHKPs5KffYUn//1XJKMVmHPSp0AjRRyRSt3A==
X-Received: by 2002:ad4:5561:: with SMTP id w1mr5249471qvy.47.1623763912419;
        Tue, 15 Jun 2021 06:31:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:113f:4437:94ed:3bef? ([2600:1700:e72:80a0:113f:4437:94ed:3bef])
        by smtp.gmail.com with ESMTPSA id 6sm12673096qks.0.2021.06.15.06.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:31:51 -0700 (PDT)
Subject: Re: [PATCH 2/2] comments: avoid using the gender of our users
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
 <20210611202819.47077-3-felipe.contreras@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <94ce6d7d-f923-edb3-12f5-4b11149c9f6f@gmail.com>
Date:   Tue, 15 Jun 2021 09:31:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611202819.47077-3-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2021 4:28 PM, Felipe Contreras wrote:
> We generally avoid specifying the gender of our users in order to be
> more politically correct, but sometimes due to lack of time and/or
> creativity a few slip by.

s/politically correct/inclusive/

Instead of "lack of time and/or creativity" perhaps be more
generous to our fellow contributors and instead say...

  but sometimes a few slip by due to habit.

> @@ -908,7 +908,7 @@ int parse_expiry_date(const char *date, timestamp_t *timestamp)
>  		/*
>  		 * We take over "now" here, which usually translates
>  		 * to the current timestamp.  This is because the user
> -		 * really means to expire everything she has done in
> +		 * really means to expire everything that has been done in

nit: s/has been/was/

We can be a little more active here.

-Stolee
