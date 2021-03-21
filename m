Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD90BC433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 23:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFE961934
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 23:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhCUXDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 19:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhCUXDD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 19:03:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250DAC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 16:03:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b7so18310341ejv.1
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=/jpdYK/wAB5qmCoAwOqyUnDhDPuwpl92JJZvkK5YXl0=;
        b=TwKaL54weRkUZ5XqLfBqolBxYSCzpugg5LPrkN4taNGkVzXVEa7xtXsFMzOFu8oFxk
         VnuKIRROHfHogN0mzMJJG1yiESmpTydA9zWi5G7hWQB17vLthmUapn2vZ7nAxJuihXm/
         CSvozqqAHcRuOLPmiabkN0zRUInydi0PlqPhb3LOhgKO6bQJ9ZDksW1pZVOXFtUCRgOj
         oUB90Vyra8LVME+He2rwO8wlvFALn4260M8XYonEO/6kqWmHEA/a1lkSNCvkV0BbVqpr
         qJnlz1yuPINS0DGdKrvFX3I855d7jT966yayvcIgbTC0EWNb6kJJIe1ZngIu9SPtE3xZ
         ZLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=/jpdYK/wAB5qmCoAwOqyUnDhDPuwpl92JJZvkK5YXl0=;
        b=aBqVzMPXXGAnAzXV/QrTP+yRCeeBu3HNelrT87C1QjZivhKOnTtWMGgfIKjNCOOALL
         qjOjqHLG3i2nFFssUaPUPjc4WqMGsG2ull0wVuoMWiVQWadxzdb1EgbehSDjauXSpv85
         YbN5V3ixD6WjGbfX0RhQG1mC5NCB8pjrg2mxPMKDZR3fsTFlVcqCT9k/Uvm+y7VWeNf9
         tBaX2ZALJALyOSKcyl7gNP0JmvI1wHkLFVi0dwnD8ilV6YMERhAzxdXh68adIw4tCZdq
         x+IeRDTKUfEUJsuyy2JRQSSSIgBdFlUZ/Dt2seTv1SsL18wBAlJ3oqm2Z6XUni07LU68
         zIZw==
X-Gm-Message-State: AOAM5329zvlcIJ3lc6YqYYW6DiUQKjjYohHzzvoKfWpojxM8dv1P0LOg
        iYMIH0wyy2IVkU+LvLfcGkZxKmjiJgPHXg==
X-Google-Smtp-Source: ABdhPJyWynQwgKSnywfga94P5HQm2cijrmuJX7ET3AcM/hokOjfwoWS0Jrg+BK3wAmTeFlKh6sa5NA==
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr15961429ejc.133.1616367781792;
        Sun, 21 Mar 2021 16:03:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t15sm9911563edc.34.2021.03.21.16.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 16:03:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
Subject: Re: [PATCH v3 7/7] rm: honor sparse checkout patterns
References: <cover.1615588108.git.matheus.bernardino@usp.br>
 <d25ea10560b501d2ca77b567927a0bb9bc874a1e.1615588109.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <d25ea10560b501d2ca77b567927a0bb9bc874a1e.1615588109.git.matheus.bernardino@usp.br>
Date:   Mon, 22 Mar 2021 00:03:00 +0100
Message-ID: <87h7l4qfdn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 12 2021, Matheus Tavares wrote:

> +	test_expect_success "rm${opt:+ $opt} does not remove sparse entries" '
> +		git sparse-checkout set a &&
> +		test_must_fail git rm $opt b 2>stderr &&
> +		test_i18ncmp b_error_and_hint stderr &&
> +		git ls-files --error-unmatch b
> +	'
> +done
> +
> +test_expect_success 'recursive rm does not remove sparse entries' '
> +	git reset --hard &&
> +	git sparse-checkout set sub/dir &&
> +	git rm -r sub &&
> +	git status --porcelain -uno >actual &&
> +	echo "D  sub/dir/e" >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'rm obeys advice.updateSparsePath' '
> +	git reset --hard &&
> +	git sparse-checkout set a &&
> +	test_must_fail git -c advice.updateSparsePath=false rm b 2>stderr &&
> +	test_i18ncmp sparse_entry_b_error stderr

Calls to the test_i18ncmp function should just be test_cmp now. See
1108cea7f8e (tests: remove most uses of test_i18ncmp, 2021-02-11).
