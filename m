Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6801F404
	for <e@80x24.org>; Thu, 15 Feb 2018 20:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167167AbeBOUwQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 15:52:16 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55564 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167057AbeBOUwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 15:52:14 -0500
Received: by mail-wm0-f65.google.com with SMTP id h74so3216673wme.5
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 12:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g0HjWDet/ywfOQrPti3NCRnkFRyg3SueF66yukSQhrk=;
        b=faV02HAU1VhAop7T4r3Xm07r+vYi9GkOIBOd0cMAYS333nmuy4I2xgR9aEXLjn5HnT
         VnJWXg45P0ZCWyShGAYN66mso7MV1n6lDxYoCakSe2DDkF40urzan2HvH7hrb08ccfaX
         gD6opnJP9gSQYtoQF4/e9CAOfMFnTskefhWT2W8+doCF86lo/LY8IliUSUEZePxfcaCw
         WGavc9yQkk9rr+bD6U9Cpir7ezTyXtGQgEkP2Wzy+Blp1DFb6U/YXg68kDduhg1fn+CC
         WWFTOkXmVAcaQmyPAZBDOzL7nj9kS2mIwo0J2U800n9+epkUXRjo5vhabn61BN7rNAfm
         eANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g0HjWDet/ywfOQrPti3NCRnkFRyg3SueF66yukSQhrk=;
        b=ipDF7XJyqgbQssSkkMH15efCPz257CX7vDjdbULvrbFGK/X290myfHBs7ogPviWytx
         t1Xd1Mj8Ra2FWWMEtbaAgJslVEhmOkbKYj/CG/eVD+JgrGnbToJeV1tfF4FIB3CSSOh1
         sRTS5XWEZSWP2LyVVFaRT+1VZSFQMu698cu8Ytl0tcjh1LAnmPjlgHyOhQ+Yex4us0Xy
         P54vqwyhqq2yutiBI4XoRtKyc3BdDroDYYNOeWFonyufYhaKHdypVj9wratAoKhU/l+4
         wAAkIewUSJlpTGt7d1bpvz9SgAt3nVeN+G5iBb42S9o9l81EBjY8U1RBPAxrX3TJsdCP
         Jlnw==
X-Gm-Message-State: APf1xPBAGCX5oo1O1tvoB+2vIxXjL6XNL7HYyq+XSgytLTBi03hWBQ+e
        FXRJLF/RmH5hP3w4+sYNWqI=
X-Google-Smtp-Source: AH8x2262oAn/KkH6PCBonGxubFYIkNS1yJfMPwtltJsXn1CQmlKRJT39xJCCq9U+JRfy4SMKM0aDhg==
X-Received: by 10.28.133.129 with SMTP id h123mr3285216wmd.146.1518727933374;
        Thu, 15 Feb 2018 12:52:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c56sm22138200wrc.82.2018.02.15.12.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 12:52:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com
Subject: Re: [PATCH v2] worktree: add: fix 'post-checkout' not knowing new worktree location
References: <20180212031526.40039-1-sunshine@sunshineco.com>
        <20180215191841.40848-1-sunshine@sunshineco.com>
Date:   Thu, 15 Feb 2018 12:52:11 -0800
In-Reply-To: <20180215191841.40848-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Thu, 15 Feb 2018 14:18:41 -0500")
Message-ID: <xmqqh8qi7z7o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>  test_expect_success '"add" invokes post-checkout hook (branch)' '
>  	post_checkout_hook &&
> -	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
> +	{
> +		echo $_z40 $(git rev-parse HEAD) 1 &&
> +		echo $(pwd)/.git/worktrees/gumby &&
> +		echo $(pwd)/gumby
> +	} >hook.expect &&
>  	git worktree add gumby &&
> -	test_cmp hook.expect hook.actual
> +	test_cmp hook.expect gumby/hook.actual
>  '

This seems to segfault on me, without leaving hook.actual anywhere.

