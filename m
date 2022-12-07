Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F176C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLGBRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiLGBRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:17:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD9E4F19B
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:17:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u5so6765486pjy.5
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZLfB1gufI1hVpXZq592SKg2xTBM795QaRlo1mEPPmA=;
        b=YyBuhFYT700QQdl+QycOqKd5IDWMyJ7laZeC8jtH6Dt8Yb+QtukxhZlU7aMSs0PGvd
         HuRcILzxb3eKSZlaUn+af5bQF92ELw9Yvk1hwT7oht2iX7+cJjMSNXdTMWJDMgIvk4HO
         sukgnBaQEmnGdesz5dvQjvsiPuGFz2DXWA02YlnGOJQFbLPDpcU+soXck+CTAZ0rqc1w
         TBt8ccfZf6WV4wyo2rVWNrFW1Htg7VDJbv+BOL3UemDjXaYiZVh3GKTRQQQJhPiCbMAS
         NfzHwOWD1r0nGqjKExzdF6N9nlVEsCuEjhBVt2yeHjawyG9EB78IRi4WsWin4xBNGQ1C
         9yfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wZLfB1gufI1hVpXZq592SKg2xTBM795QaRlo1mEPPmA=;
        b=KtEqBK8kbAetpw3FR7fDU3cjtvIlpHtemFt/k753CFJBXv2j81G21g7MwrlIYRvUyj
         RdYGNEen1xk6wMRqVozv54DPKJHnuskn3LBu1cNIn0ABr8cos6l3t+uKib+wSuClpldn
         tmF+YUaq/h7eI0/5NtZz9NO6OdHbZ3mQYF8wHYs79p2gZnPprtUNnVe48LZZR2HMUUTp
         6TKP/NVLqqHyGwVCtt4/4T+kXzjY52/vI5O6qDV4F+ji/ujcnyq7cBL1U37yg60wst0h
         lH0ohkOekm+3oKgZ6i4A3grCZ579tBZus6MzYqEb8gso5/KQg7CutSjH+iaDDTqazxKI
         8Kzw==
X-Gm-Message-State: ANoB5pmJJ8FVMVjuFo97grfm2xJ9A+HAYzGGDvbtshuF5PfzpUj8mK7Y
        130GSPQLnI6k4JrGGTWf4BA=
X-Google-Smtp-Source: AA0mqf5/J9eAcooGtiyTyqctC3Rsia9zOofjfmJksI7fPi+2yv+Zr3+wPNeprr9pxuJTmSlmtdGesg==
X-Received: by 2002:a17:90a:f406:b0:219:9e8:84b2 with SMTP id ch6-20020a17090af40600b0021909e884b2mr60841716pjb.121.1670375823183;
        Tue, 06 Dec 2022 17:17:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902f38d00b001868bf6a7b8sm13199313ple.146.2022.12.06.17.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:17:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 3/3] commit: don't lazy-fetch commits
References: <cover.1669839849.git.jonathantanmy@google.com>
        <cover.1670373420.git.jonathantanmy@google.com>
        <c5fe42deb04285b85d5354a57e90bf9410cc2420.1670373420.git.jonathantanmy@google.com>
Date:   Wed, 07 Dec 2022 10:17:02 +0900
In-Reply-To: <c5fe42deb04285b85d5354a57e90bf9410cc2420.1670373420.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 6 Dec 2022 16:40:53 -0800")
Message-ID: <xmqqpmcw6mi9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +	/*
> +	 * Git does not support partial clones that exclude commits, so set
> +	 * OBJECT_INFO_SKIP_FETCH_OBJECT to fail fast when an object is missing.
> +	 */
> +	int flags = OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT |
> +		OBJECT_INFO_DIE_IF_CORRUPT;

That's a quite helpful comment.
