Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A421DC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBFVwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBFVwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:52:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E2D2D140
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:52:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hr39so8724910ejc.7
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pop0egOomsCK7LrOqn69vScV4MqREwecIwhKP8R7ji8=;
        b=bM5vBkRMvttJ3ImX3qL6e9R1rjUlsr0s1u51yF/MuuZ/ubsxAyjlkZOJHHH/JXm9Pm
         SAzhJ3BNAPjwGPaFvzX0/g6wnR6J0Tq0peTk6g1nUxl/5/rRkRbNvz4kocJovA4XhwC3
         TnvPiGLHw8hZaTUEzLWHl8tEXBbCLNdNqeenCAz0VGDxosj+rt9kvAWOiHOaP6cY4M/G
         vGODx1awnDzOuX3wkiDYtJqMyrOsw1VtUpe76J1zLT3iUGR84HGsIpg5EL0ZZeQoXU+X
         sWUI27voZ7WKz4o/NNnj46c3DKVdE8VCifSKcKpHIy/Q5ZbluCaUNurdPgW0R4/QI5b/
         Crng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pop0egOomsCK7LrOqn69vScV4MqREwecIwhKP8R7ji8=;
        b=jIXSGdupb5xEp/pKRRvxvaeEUlx3W3S9UrYwYV2TBQ+reJ/sSPXON4gQiRVs6Zm2Rf
         Xd6ycFYYG/5ZVxliUoDEJmRvlJpY4uLL6sm+W/77CSoTlwh/0YqHk2drr5GxD1QaAvit
         ie9prKRRvE0uqzKvXgHt7Q7oxqZQsun19TF9SzxJBMd2SYiPWLBEaXpsLOJ4QcPVeAIG
         5/bJirXz3a2LFDEuBEJsOdZ/dBZNHVBo3RuCZYZy0rToKv+37AF2oZyeWGmMfI2yvOki
         beHqTWDOQDxO8UqgxHbphqAeUgTcysM+iE091HWFP/CJC9on9bMqZ0K1dU/Li91WzcHT
         YPDw==
X-Gm-Message-State: AO0yUKUYkm2Nzc1HKKIn61maxJUfhLi9moIImMoGHLGFrxCqN8oJUV0G
        xN98iOfctt7KztzxqbR7V+zgDoSkgOjqSrQ0
X-Google-Smtp-Source: AK7set8t7iZyQzZ941sDf5yXPYgEcjaiqSVpCl7cEtOnccpGiyRW1vrjNq677dkcDETrB/KaAz/ktA==
X-Received: by 2002:a17:906:c7ce:b0:8a0:7158:15dc with SMTP id dc14-20020a170906c7ce00b008a0715815dcmr793505ejb.74.1675720328682;
        Mon, 06 Feb 2023 13:52:08 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709063a0f00b0088f132432cdsm5982100eje.61.2023.02.06.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:52:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP9PD-000XgM-2A;
        Mon, 06 Feb 2023 22:52:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
Date:   Mon, 06 Feb 2023 22:50:05 +0100
References: <20230205145245.11078-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230206211823.8651-4-cheskaqiqi@gmail.com>
Message-ID: <230206.86ttzy4g3c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Shuqi Liang wrote:

. ./test-lib.sh
>  
> -# setup
> -
> -cat >test-patch <<\EOF
> -diff --git a/file b/file
> ---- a/file
> -+++ b/file
> -@@ -1,2 +1,3 @@
> - a
> - b
> -+c
> -EOF
> -
> -echo 'a' >file
> -echo 'b' >>file
> -echo 'c' >>file
> -
>  test_expect_success setup '
> +	cat >test-patch <<-\EOF
> +	diff --git a/file b/file
> +	--- a/file
> +	+++ b/file
> +	@@ -1,2 +1,3 @@
> +	a
> +	b
> +	+c
> +	EOF
> +
> +	echo 'a' >file
> +	echo 'b' >>file
> +	echo 'c' >>file

I have not read the rest here, but this immediately fails with a very
large error from chain-lint by default, and even if you manually disable
it (which I assume you're doing, or just not testing these at all before
submission), you'll get:
	
	$ ./t4113-apply-ending.sh --no-chain-lint
	ok 1 - setup
	ok 2 - apply at the end
	ok 3 - apply at the beginning
	./t4113-apply-ending.sh: 44: b: not found
	./t4113-apply-ending.sh: 48: c
	        git update-index file
	        test_must_fail git apply --index test-patch
	: not found
	# passed all 3 test(s)
	1..3

Which shows that even with the &&-chaining fixed you have quoting issues
here, you're trying to execute 'b' etc.

I didn't read the rest of this topic, but please test with chain-lint,
see if there's any unexpected new output from the tests etc. before a v5
re-roll.
