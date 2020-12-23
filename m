Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27109C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 00:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C9022AAC
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 00:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgLWAYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 19:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLWAYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 19:24:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F250C06179C
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 16:23:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r5so14544236eda.12
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 16:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=apAanhlebEk869PkLx055/F8VQbP4JNYXb+pWV+xOgo=;
        b=bNLo2US+9KtaUqYeTUhm7oR+l+Em29IbUgQG9PBk+CQZoq9kr7mTq7bUwWwapYRvLU
         gmiT6BCLdxT82hUNoqZ13POlodgFGrMP2pirEqN5g+/Xy2YXZo35jpnXpedf6LkEz389
         zHLEtHeRP1mKXvpi0hiXw0X7aCp05SbfmXrK8iiuW2+6m0Sh0gV55u2YLZxNXhRwd6sv
         v5xktggTVbV4oXiv25nhIUooSVoPbAeKkxcLEkV6E75/kne0sm0lvinR5Bs7jlhM34O5
         6sadFbV2dbT1ZvElHoLbFgQNr9usNmnFUelE5+eSDCNxoYMEB3Q0+NXKlq7SG46QGNNT
         ypsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=apAanhlebEk869PkLx055/F8VQbP4JNYXb+pWV+xOgo=;
        b=bOLLjCNrCO8ChWfn4FWS9ayV3uRJBAA3N1QFG/IoNU3hRM1mUIGCnv+z/F4lMx7PBC
         NgnOhbpl4ggMhZPrQJ1MCfbVXM8xqnh/5sJxoeZG+iWDbkJKRopp2OpY71DBScE09af4
         p0jpmCec+xFYqkDyuDp2BRl5avQU40FOVFHNF8vXLWD6geJLL9pKoLixOjFAcp6jQ8bi
         VZGhREIJo0xZfpr/I2272wg081ZRw5PXCAsZ8c1KeIKYeUtKdJ0nP9Uy0q4rHGhcFQbH
         xCxDyS9njexuUW3trnDjfvul0w4gGttfjWSxu/p/0GmW5xGFlwHylZNVzs2cHtN08Rmj
         YKYQ==
X-Gm-Message-State: AOAM533DYCfmjVS69k9qXQSNIUqfkiDdYQqFKYIpYKSNSjBH5RgZ84mm
        fhXnxxpalbNmq+se0pwwnd8=
X-Google-Smtp-Source: ABdhPJxPeFZNVmPs9OGahojW5a6MrjYh5Xjrl4dJwEC0uILMltmLqPnjuzX+sSEZT9G+G5xEf9gm+Q==
X-Received: by 2002:a05:6402:3049:: with SMTP id bu9mr22520275edb.127.1608683032843;
        Tue, 22 Dec 2020 16:23:52 -0800 (PST)
Received: from cpm12071.fritz.box ([79.140.123.225])
        by smtp.gmail.com with ESMTPSA id mb22sm10901974ejb.35.2020.12.22.16.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 16:23:52 -0800 (PST)
References: <20201221162743.96056-1-mirucam@gmail.com>
 <20201221162743.96056-3-mirucam@gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 2/7] bisect--helper: reimplement `bisect_replay`
 shell function in C
In-reply-to: <20201221162743.96056-3-mirucam@gmail.com>
Message-ID: <gohp6klfdpbca4.fsf@cpm12071.fritz.box>
Date:   Wed, 23 Dec 2020 01:23:49 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Miriam,

Miriam Rubio writes:

> +
> +static int process_replay_file(FILE *fp, struct bisect_terms *terms)
> +{
> +	struct strbuf line = STRBUF_INIT;
> +	struct strbuf word = STRBUF_INIT;
> +	int res = 0;
> +
> +	while (strbuf_getline(&line, fp) != EOF) {
> +		res = process_line(terms, &line, &word);
> +		if (res)
> +			break;
> +	}
> +

I spotted another place where an optimization can be performed.

The "if (res) .. break" conditional is only used to break the loop,
which is the same job of the expression from the while-loop
itself. Hence, as the purpose is to control the loop execution itself,
checking the response of "process_line()" via the "res" value can be
move to the loop expression itself and simplifying the code further,
as shown on the following patch:

-- >8 --

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b887413d8d..fb15587af8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -988,11 +988,8 @@ static int process_replay_file(FILE *fp, struct bisect_terms *terms)
        struct strbuf word = STRBUF_INIT;
        int res = 0;

-       while (strbuf_getline(&line, fp) != EOF) {
+       while (!res && strbuf_getline(&line, fp) != EOF)
                res = process_line(terms, &line, &word);
-               if (res)
-                       break;
-       }

        strbuf_release(&line);
        strbuf_release(&word);

-- >8 --

This also seems to be similar approach from "one_of()" introduced by
4ba1e5c414 (bisect--helper: rewrite `check_term_format` shell function
in C, 2017-09-29).

Once more, the intention is to simplify the code and improve the code
maintainability.

> +	strbuf_release(&line);
> +	strbuf_release(&word);
> +	return res;
> +}
> +

I hope this helps increase the code quality.
Happy Holidays

-- 
Thanks
Rafael
