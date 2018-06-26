Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B705F1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 19:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeFZTP2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 15:15:28 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:54004 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbeFZTP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 15:15:27 -0400
Received: by mail-wm0-f42.google.com with SMTP id x6-v6so3137382wmc.3
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gp9v0X4wXTbqPW72dTfJJkNT/+k8iJXjtDWtvmLu3BQ=;
        b=JpQSYrqDyL4ee6ppZhtjT2H8/O6qWj3Kuz48yRqlkco5KrhtqWMQUfIzv7jN6cJYeo
         GD8jRe2vU+WBzbS0FNcWGE9Z80v3uIWg03MXCMJ1aIZQbMt61qJJ8u+ukylsD2/C11ZF
         d8EXT+T9JPt4AZERbGzRZmRkf+8BlFBcyyfDeuK7bn8q397L+jRu0o15HCPb2gYZnpg6
         aKuCkVfpkstgV2TD/tgBkyHeMoWodCHm3iqS818IWkUzpFoeKDAz5lFp35pMM/iwgPwI
         toRyH2OZnt2/CESKUj9fub96KmkMXElZAkQH6ff4G8AE1NaGWbh/5pJyBVq/WAJfI3AG
         yp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gp9v0X4wXTbqPW72dTfJJkNT/+k8iJXjtDWtvmLu3BQ=;
        b=bGnUruYgAYY3s62cNYb1Kyg29N/n5SXAiblLCMYFGgSuN3EQaQynX2X7vso+XyjrOG
         8gILoBAIAuanx32eWvAn7p6kITGX+FrZ4TzGrLLVBIISidoe8Ta27xHOroJ/w8gBuVj3
         idSdo0266cUOvWpneiXd0aTJSLESAvNI9EtrezE5H2vUb8FvI7S6Sv68CEKSXSUaa680
         R2wr0Pwyp9BwjKTmw6OPBT7KixLUaACKVlSPopm253gHzdgKrJgb/1mtWWh4JkrQ1cm5
         UWWRrF3rI/HUV9yGk4nYywxQtVNBs6nvyim6QVpoAQnR9Ubb4H5QXbA2tJg13YPdCFCT
         uLaA==
X-Gm-Message-State: APt69E0J+kqgssE/hpRhlEbUTuLZEJE+ft/pQ9/bROgGwTo0fsQBpTDk
        y/QpMKDWq0hfwWVXJRzMol8=
X-Google-Smtp-Source: AAOMgpc9n/j03mGOh+0E4IfsaM8x+BS9wUXmwjH28Xk34K1oZpUV09xTBzCZDXcmazCQeQnyX7ri4A==
X-Received: by 2002:a1c:5c82:: with SMTP id q124-v6mr2768396wmb.24.1530040526396;
        Tue, 26 Jun 2018 12:15:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l78-v6sm4391506wmb.39.2018.06.26.12.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 12:15:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
References: <20180626073001.6555-1-sunshine@sunshineco.com>
        <20180626073001.6555-30-sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 12:15:25 -0700
In-Reply-To: <20180626073001.6555-30-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Tue, 26 Jun 2018 03:30:01 -0400")
Message-ID: <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The --chain-lint option detects broken &&-chains by forcing the test to
> exit early (as the very first step) with a sentinel value. If that
> sentinel is the test's overall exit code, then the &&-chain is intact;
> if not, then the chain is broken. Unfortunately, this detection does not
> extend to &&-chains within subshells even when the subshell itself is
> properly linked into the outer &&-chain.
>
> Address this shortcoming by eliminating the subshell during the
> "linting" phase and incorporating its body directly into the surrounding
> &&-chain. To keep this transformation cheap, no attempt is made at
> properly parsing shell code. Instead, the manipulations are purely
> textual. For example:
>
>     statement1 &&
>     (
>         statement2 &&
>         statement3
>     ) &&
>     statement4
>
> is transformed to:
>
>     statement1 &&
>         statement2 &&
>         statement3 &&
>     statement4

so, with --chain-lint, we would transform this

	mkdir -p a/b/c &&
	(
		cd a/b/c
		rm -fr ../../*
	) &&
	statement 4

into this sequence

	(exit $sentinel) &&
	mkdir -p a/b/c &&
		cd a/b/c
		rm -fr ../../* &&
	statement 4

and then rely on the non-zero exit to cancel all the remainder?

We didn't create nor cd to the t/trash$num/a/b/c thanks to the &&
chain, and end up running rm -fr ../../* from inside t/trash$num?

Hmmmmm....
