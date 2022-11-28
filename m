Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B1C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 09:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiK1JlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 04:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiK1JlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 04:41:06 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6C66153
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 01:41:05 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q1so9416873pgl.11
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 01:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FwPTulx6hfMlaLFIsy4HeNYMJPxkWm07k8HM6CdPP4k=;
        b=oc2jgb7dQOgaFxwbmM06tbQvW1AMIz+DD2v2EEVBVk7cvWeiZ5yrqwC1QmXQCd2FYO
         NGXPMvDsocdA7jc9Wfg/6CAWAtcLRMI82elPt559ti3Wvx3Yc00lLPTn49OdYMvvvbsJ
         ygXd1BEIcQf4aWcpRLneXh/Rjs4XdVLRPS3d9yI+2qWuHc1mAdttCVUrB3FongpHZCzG
         lhS2/RZ312vhfZ8WnRhZutQipRUpRrK6fLjXIFehHgZjr3Q6ev6QRjKwp2SjWF1ZdYYj
         O0uxmyAinJGe4OY/ZiCYf/3NGDToRly2qVtev1OscCkHmae5GUxlG2hZfaC+id8iu0BF
         HSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwPTulx6hfMlaLFIsy4HeNYMJPxkWm07k8HM6CdPP4k=;
        b=lHkdpQSbWWXLvn6DguwDHCOXtlB4/pQ6iz6rsC6TjxSDxv3Xyd+pHbEwLAYDF5IS24
         G4qaM2/9Y3z7f0eKzhlBOSd7zJjHj/XR2UXwLuEUalHQ7JmqJHojsoBW64RX2Dre4+0p
         FlFgNzP5Nrhi4owgYDbNq5S4rD6kI0FFT6/r3iGp6oTYvaFUZkCtJ6JxsryEA1NkvnZO
         jgY9NCkCbrLta5/Z1UI56rUjUAtq7Bt6dxpI/HKOUDFCVNco6dELhDmlwpDI1MQtfDFX
         uUHyoSfUKzmrmRvUtOz3IoKvDJ0LlFwwZoE2X+8aImSqj3N1tEEJpmON1Y5eqmgI13CY
         MLgQ==
X-Gm-Message-State: ANoB5pk22r5Y58Y6QXsp9Y7b9FldKMDgWfHNAGiz42FRJYCTanxnbifW
        FagYcPM36A3gkPGaifS6UAqQepAWenxF4w==
X-Google-Smtp-Source: AA0mqf4kVfZn4qdKvfNLpEF9TShC79sqifFRZDSGEnn3TUPDLN3oCSReO9gF7sAPkSa/LAlrslJtYA==
X-Received: by 2002:a63:5425:0:b0:477:cce0:45b with SMTP id i37-20020a635425000000b00477cce0045bmr17732562pgb.606.1669628465248;
        Mon, 28 Nov 2022 01:41:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b00177faf558b5sm8343888plf.250.2022.11.28.01.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 01:41:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] send-email: relay '-v N' to format-patch
References: <87edtp5uws.fsf@kyleam.com>
Date:   Mon, 28 Nov 2022 18:41:04 +0900
Message-ID: <xmqqzgcb5scv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 01c74b8b07..152bd2c697 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -2334,6 +2334,12 @@ test_expect_success $PREREQ 'test that send-email works outside a repo' '
>  		"$(pwd)/0001-add-main.patch"
>  '
>  
> +test_expect_success $PREREQ 'send-email relays -v 3 to format-patch' '
> +	test_when_finished "rm -f out" &&
> +	git send-email --dry-run -v 3 -1 >out &&
> +	grep "PATCH v3" out
> +'
> +
>  test_expect_success $PREREQ 'test that sendmail config is rejected' '
>  	test_config sendmail.program sendmail &&
>  	test_must_fail git send-email \
>
> base-commit: e7e5c6f715b2de7bea0d39c7d2ba887335b40aa0

It seems that this new test, by invoking format-patch, makes a leaks
check at GitHub CI fail.

  https://github.com/git/git/actions/runs/3562362890/jobs/5984036422

Dropping PASSES_SANITIZE_LEAK from the test script would certainly
be a short-term workaround, though, but it is a rather broad
mechanism.  There should be a better way to control the leak
checker, but that is what we currently have X-<.

