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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47961C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D28613BC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhEEOBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhEEOBz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:01:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3134C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 07:00:58 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k127so1539948qkc.6
        for <git@vger.kernel.org>; Wed, 05 May 2021 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bhKBfMIhS+5qfEyCF9zX6q4Y/lRr0t97VmlDmBRFv2U=;
        b=gqUxj8cYR5O5dkaoHBK2TyVYK2fprcqFvi1Cswy1mG0v6xUaoqUuCDJfrq2NUgmjiU
         NqUf0bMemehG5xvZMpbBMSxZyDbXedtVQJB17Xl/Tw1NjXevXtFd0Czi70c6u0hOrq4k
         6c1q3M7qaZ4GeQ6aiQBqv8xhsgLnX9sGtlu0+9cFsm9wtAhTIDWtKrf0Mx1nQfd0UP6z
         j/2fbRPyurUhLnyxrjucHcWBdAJgVq7W+zluJldLZZmxu26Uej3t/rAJshZvPvBZ6kYK
         lKu6HEyUMFhQsToGu7ybLycgYLyCaI3tHuhCzHv8+O4Bd19STjYeN3tD4EDnUuPwWf80
         kmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bhKBfMIhS+5qfEyCF9zX6q4Y/lRr0t97VmlDmBRFv2U=;
        b=PH1YRxue/k8KcgjYR6yftagvkXKZJtlhrncjZ7oewbHSYp91TlkKDDcBVRlvkCvF+i
         msWc3VZ2q1cU98qmPPW8WsRRZPJM2FpC3Wmxnm0WNy5ZlUSUKgAuiMjGhRHPVf8iV8VR
         NOaKn4+Ql7OIAlyA6TjEisCCmWmvTs1yWgzQIrdiFy4wXsNw5TFNfx781h/qD6njdNpo
         8P6oRzYq+4sorSqLJ/aLqADkVVSIR2WebsXlVMSi0t9D7UApYGppRbGhKlgfXNOWof5p
         rt7Qi33HnhSr4XGgW6sDNicTLt+b1EqmESWr9nYn0wV0+VakK7UBmaR3jbun3YLCcAgR
         SStQ==
X-Gm-Message-State: AOAM532G/W9Hrgy/aVQR6xf1oBMGbI0qdQ/nNS+ZdcZbZpTOQwV1ehXQ
        CzUzhzkXGsOI2PIQZqN26zM=
X-Google-Smtp-Source: ABdhPJw15nzJOGQ4M2YOWpTVaZonGLOvw2NZbJRtovZFbq+aJnXhGQ+GiVPKKp7XqWxJRBCS02PXpQ==
X-Received: by 2002:a05:620a:8dd:: with SMTP id z29mr30189416qkz.84.1620223257919;
        Wed, 05 May 2021 07:00:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d2a:f5d6:d0e8:8a60? ([2600:1700:e72:80a0:d2a:f5d6:d0e8:8a60])
        by smtp.gmail.com with ESMTPSA id y4sm3254368qti.53.2021.05.05.07.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 07:00:56 -0700 (PDT)
Subject: Re: [PATCH 2/2] sparse-index.c: don't call prepare_repo_settings()
 twice in a row
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
 <patch-2.2-8bca02efcee-20210505T121028Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7954338a-bb44-1345-61b6-787782063c3c@gmail.com>
Date:   Wed, 5 May 2021 10:00:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <patch-2.2-8bca02efcee-20210505T121028Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/5/2021 8:11 AM, Ævar Arnfjörð Bjarmason wrote:
> Change code added in 58300f47432 (sparse-index: add index.sparse
> config option, 2021-03-30) to only call prepare_repo_settings()
> once. We know that our own set_sparse_index_config() has just finished
> calling it, so we don't need to call it if we're acting on "test_env".

I'm not sure about the value here. prepare_repo_settings() returns
quickly if the settings have already been prepared, so a second call
is negligible in cost.

> @@ -133,11 +133,12 @@ int convert_to_sparse(struct index_state *istate)
>  	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
>  	if (test_env >= 0)
>  		set_sparse_index_config(istate->repo, test_env);
> +	else
> +		prepare_repo_settings(istate->repo);

The change presented here to either call set_sparse_index_config()
_or_ prepare_repo_settings() seems like it knows too much about
how set_sparse_index_config() works.

Thanks,
-Stolee

