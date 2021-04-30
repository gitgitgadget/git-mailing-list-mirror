Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A80C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 10:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6C961434
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 10:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhD3KDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 06:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3KDL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 06:03:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBFC06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 03:02:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so104340076ejc.10
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=J0Rej5y3zLF+M0YCVLWuZC1NTACK6cn7wrwuqkCljwE=;
        b=Ldju4cTJeTXbRc64i/nZq2+gQQ8wPjDqfBgPTAlQhKfjZMpitsAFryhc8PBuubpa0W
         HFqR12Vb8GY6DDcMh7BjitG4cLxlmx5PSxxxYE/7lckT/TlcKFYxGZQ+61qyz1EzA650
         ZqLK9SUeMfxsGRlv4PPRM91paJdKTpZnr0V+PexMwBjnzAhf7vwANGeP0M47wCA/m7Fn
         mx3hnvrbvujpaMGOskWi9DFqQ8VWH1wI9qNKg3ssGUHRP8opwuF5NcbGcBehScQT0MP7
         QWfvsTXNLxfqzke2lt6hrSP1TEXTAzw90ny/yv0b4LLW2HCtKjh0BEsHX7Y2GWmK/8gE
         yBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=J0Rej5y3zLF+M0YCVLWuZC1NTACK6cn7wrwuqkCljwE=;
        b=DN6lXCGAJ6m9XCH4R1TMAiK6kGYtTYzJPTpIbi0VWrNYgcqbFXL8CylACp/7HQIeCC
         bBNAKpm/bsYfiESpwUWAhoWx9J0oGIUuJW3TNMBMNmfieXoOpz+Btr0f9gNaz0uFyB3p
         UTWWwteLC4js0bX6WJdhYIe8WsCwsYRW2k6JvrGuzfhonWNu69AvzURsrXcEjx6BZUNN
         frJLlwvOXirpaQdvAih2iID0ZUHJnkxeIK6AkimwT7+B+Dzgt6/Ap2N1pz6qLKe56fWy
         aYadUerF+ba1pYpyzEC33SAWx6/S7yRoKrXiB27gtCgH4P/sB0F38F06rrNx256yzV/2
         YWEA==
X-Gm-Message-State: AOAM530K6jko5TR0Ei5J7K/UkCg6Y6XENO+F9QC8t1FA/YNJHwL6oWNM
        JqqdBDUxKyaFhqyO49tDwGE=
X-Google-Smtp-Source: ABdhPJwrEgN14/8XDebpSnrHM93l2tLza7+SzWe8NG0usb2JX1myN9Fn596z9HhEE739YjkOg/rtHQ==
X-Received: by 2002:a17:907:110f:: with SMTP id qu15mr2163637ejb.378.1619776941590;
        Fri, 30 Apr 2021 03:02:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u24sm861545edt.85.2021.04.30.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 03:02:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 10/30] subtree: t7900: add a test for the -h flag
Date:   Fri, 30 Apr 2021 12:01:50 +0200
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-11-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210427211748.2607474-11-lukeshu@lukeshu.com>
Message-ID: <87lf90xf83.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Luke Shumaker wrote:

> From: Luke Shumaker <lukeshu@datawire.io>
>
> It's a dumb test, but it's surprisingly easy to break.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
>  contrib/subtree/t/t7900-subtree.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 5c2510f1f5..9afba2f282 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -37,6 +37,13 @@ last_commit_subject () {
>  	git log --pretty=format:%s -1
>  }
>  
> +test_expect_success 'shows short help text for -h' '
> +	test_expect_code 129 git subtree -h >out 2>err &&
> +	test_must_be_empty err &&
> +	grep -e "^ *or: git subtree pull" out &&
> +	grep -e --annotate out

I wonder if "grep -e --could-be-an-option-if-not-for-e" is portable,
probably....
