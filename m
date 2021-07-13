Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F0C11F66
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 01:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E7161152
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 01:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhGMBV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 21:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhGMBVz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 21:21:55 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5794C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 18:19:05 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so20862678otp.6
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2lOaGfmNS+waisfQBtEOzaeFC8fnlLEqy1bIttt1yFI=;
        b=LxGDMqlqkmF4t1EI+oJ+KdkLBSyJ8g4/IoGO1RkwvQ1TtuOcRNfvZvPBnc5D1BHPac
         OlWUuDubASQgckMlyxnR0TxB1vhxv0+0KZ1ZD5uYLQTTysg5bhgnZP23Y2NV7Vcg6Oso
         vbCmphXefmnRkM3+2yO5lQUzGqGUfr4tyTIPzd5yAEk/kadYeW30RuwdJvaO5wfXqsFa
         ig1tkDLzhqVJQDZcrIw6RBe5ZdfJCAUyTZUh3Qi0srJZ38b3B9DVUcjxwZZZnGlxf+L0
         Wcss7QKnm1KOVhhQIExZERh8UcJhNJEKfALssqlJkY9nZFuHrxZMYedhe8MQxfx8mTDO
         YMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2lOaGfmNS+waisfQBtEOzaeFC8fnlLEqy1bIttt1yFI=;
        b=jm+BjCjUu0t6llxpXgrkVYKjXfaMT/88eItqvyc2uyZSXtyBANV00wocrhTsbU7uQE
         BZefc7cfJ0bawvOVXlId0T5fS+4CqJzGfn+vYULHHicqcqc9n0vOKvURoup6O00XuqoG
         oBxLMD6ExQc7dKN2w+IABO2rQDT+GLi25D+aE5UV7GGBFs1VsKH6YCKxd87QjD1MTb4F
         erakroRx6mjeAn2SCUZdFUhmwstwVJz7YVlTH/13j5juOzr6+ZVuGbdp7a6kOpGAtKQv
         1ipyzNCWoVa5+QZN9zPbK1hUHZbAWO1ZZ4sUl/hVETEHe5JElMLIGb+S8ADzewnqrd2p
         kUeQ==
X-Gm-Message-State: AOAM532kafaUWN0SWIbSDB0Zwlp8Apsduz3iAEcPQ75LyOWOwzxSL5Ns
        u4dPG9AzGQP8AfRyM8QeeoQ=
X-Google-Smtp-Source: ABdhPJxaMhnNhRspJA8dUX++F+8KFQha4SIf1sfgxoPfERuIyD07EfVg+fBb8puf38dd50EkWY+s7Q==
X-Received: by 2002:a9d:6b0b:: with SMTP id g11mr1476611otp.240.1626139145208;
        Mon, 12 Jul 2021 18:19:05 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id l2sm3497730otl.27.2021.07.12.18.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 18:19:04 -0700 (PDT)
Date:   Mon, 12 Jul 2021 20:19:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luke Shumaker <lukeshu@lukeshu.com>
Message-ID: <60ecea068fd7a_a79ec208e9@natae.notmuch>
In-Reply-To: <xmqq5yxf2hkj.fsf@gitster.g>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
 <c530dedb-8cad-2a73-5b56-a32173046382@gmail.com>
 <xmqq5yxf2hkj.fsf@gitster.g>
Subject: Re: [PATCH v2 0/2] extra: new concept of extra components
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
> > in a worktree created by 'git-new-workdir'. I do not think this enough justification
> > to include 'git new-workdir' in 'extra/', since 'git worktree add' does the same thing
> > and is a builtin command.
> 
> "git worktree" was invented primarily to properly solve what
> new-workdir wanted to, so I agree that all efforts to promote,
> upkeep and extend the latter should be spent to improve the former.

OK. What about $subject?

-- 
Felipe Contreras
