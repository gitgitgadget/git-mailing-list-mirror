Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A670C433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 05:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4184561139
	for <git@archiver.kernel.org>; Sun, 16 May 2021 05:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhEPFEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 01:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhEPFEn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 01:04:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94ECC061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 22:03:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t30so2408343pgl.8
        for <git@vger.kernel.org>; Sat, 15 May 2021 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJqnI/IbtTbtRb4SFKBzLWLjbyCuE1yRFPx8Y6eeIn8=;
        b=avAKveat+8trjhCybQPSpyvP+1zaT0Z84auvr3UY11sLb5FKp+NT0O2O6tlBxNI0r+
         wl/sd5lMeeP2UN+EQ5urHP8KGvFPFYQgMUDMwzKybZfW0voF9TE2N2TnIMJd3Q5sql3x
         ri6AqapwqKXKstRCLVXZN6wf3/bw+OIWLtcaSF1GcoK5X17rcidEGF6kjXtRJeXE49bC
         VvDe2EKWmfQ8K1dreTiFWXZDu449mcRub86gCFJYhVSPzHmIFyRRu6pd+U2EeS1ap8eb
         k3I36QLaqLecsYkpQsOIZ7yroNwrL+VtlqaJRmiF2m6qDZ1wYbOrEe9m80TfF+zAQdGy
         eMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJqnI/IbtTbtRb4SFKBzLWLjbyCuE1yRFPx8Y6eeIn8=;
        b=jnCoWTUDnslIQWv9A+l/M8vXxXw9lCimkTwkZDJQCEHs+DDS1mMRr/nlj8bNT/Rwfu
         60w8nUnyQlsxHpVEzLQ2F2T1hF9AJUS3UfVBrptf9mtk2w//spAoXmq1c9NIHIP+UTm3
         wqhIYSiSrP2Rc7mxpq+jvKbopKLMTnD/N/DqWDNn25n8wX4rUzX6j9A89nhl+WldJ/C5
         1O5DrdcuM69iNuro9dVZd+HcrOU2deQN5OB1mUbbHansQF+vrUq5DSPBOwpjunxxidpB
         D8aJSLLTDOy8yOD6QjI327HhQl8GtF+JAS4WbwqYW5qNvfEX+DaCiXUkW3qRpcHJBV6d
         Wi0g==
X-Gm-Message-State: AOAM533F6no9skFVQMRd6IUqLi7iy2CIcMJyAEwzWJ132VAV6wTFhjgf
        0FR5AeBbSKCwpwIiG6LLJaV2HY8PZ4Swqw==
X-Google-Smtp-Source: ABdhPJw4RoCsf7cJD+YJFpB+jMYP2+C4y7qBJIuxoL75NV8mRMTgToNzYMjV3lkN73ujRvp9YZBk/Q==
X-Received: by 2002:a65:618c:: with SMTP id c12mr54866312pgv.296.1621141409201;
        Sat, 15 May 2021 22:03:29 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-61.three.co.id. [116.206.28.61])
        by smtp.gmail.com with ESMTPSA id a16sm7003566pfc.37.2021.05.15.22.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 22:03:28 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] t/README: document test_config
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
 <20210515152721.885728-1-firminmartin24@gmail.com>
 <20210515152721.885728-2-firminmartin24@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <5faaa5a6-8ebf-b2ef-805f-551a36ab7e6c@gmail.com>
Date:   Sun, 16 May 2021 12:03:25 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515152721.885728-2-firminmartin24@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/05/21 22.27, Firmin Martin wrote:
>   
> + - test_config <config-option> [<value>]
> +
> +   Set the configuration option <config-option> to <value>, and unset it at the
> +   end of the current test. For a similar purpose, test_config_global for
> +   global configuration is also available. Note, however, that test_config_*
> +   must not be used in a subshell.
> +

 From the syntax above, when I omit <value>, default value for <config-option>
will be set, right? You forgot to mention it.

> +   Example:
> +
> +	test_config format.coverLetter auto
> +
> +   Is a concise way to write:
> +	test_when_finished "git config --unset format.coverLetter" &&
> +	git config format.coverLetter auto
> +
>   

The description said "set the config, then unset it". But the expanded version
said "unsetting the config is deferred to the end of test and set the config".

The documentation for test_when_finished said:

>    Prepend <script> to a list of commands to run to clean up
>    at the end of the current test.  If some clean-up command
>    fails, the test will not pass.

Is my interpretation above correct?

Oh yeah, maybe it's better to say:
"For example: <blah> have the same effect as <blah>."

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
