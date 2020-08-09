Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A265C433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 08:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C5720658
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 08:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXxZYOti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgHIIce (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 04:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHIIce (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 04:32:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD7DC061756
        for <git@vger.kernel.org>; Sun,  9 Aug 2020 01:32:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id p8so3256576pgn.13
        for <git@vger.kernel.org>; Sun, 09 Aug 2020 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=sgolpwDuvYgv0r39iYDrz8q8XC0ENE7HLjs/jhxsZeU=;
        b=VXxZYOtiNSqhea4gxHO83VBd5adyr1VtrRoHw4Wc2OrKaQ+a65iRoXA+cQNVkilT1s
         syVY7jnKJoDsJTsdjfLjg7l0uWHvWhpfcC8v1N+/yOLd4aRZF37+62K1U9sN5zUjOO1F
         49DagmTLHdPRO6Zbf2SWTkleWt85R++AjXDE9i8pBClNvJ2akxA8q8EjHFTa/iQpugaM
         wrQPukTs1a9JcLWkzpoYIpdDtF1nB4tqXvpLChSPC3oQ9yYZurCiLQqKGu5KGu67ta0C
         1Ccqvv04X1AQ/RViPwdn5w5/eI5S6NqTS7D8erhGnR/6Noz1FGit5Yk8gTyoHJHzOifw
         ZjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=sgolpwDuvYgv0r39iYDrz8q8XC0ENE7HLjs/jhxsZeU=;
        b=PoKpm4D+s6rpwUQaogDn0xB1Lmb3NSODT7UDiqNL94Z1Vx1g7IriMtG9PiWmByD3f+
         aQAtRZ1ka0hLhVci73U8ik4VFZhFpFeQQXDvgoocuiBB+sQmr4gFIzqc7UMerABUc+dv
         Y4eVAR1R4Flh5UyICozM9409e58L06P9gSgZ/6Tvm2nOYqYK+FG6wgSvQWTnIZNTXRIC
         tN1UyMImhpKc5qQ+u1Cp6QrpwTF+lgOPHf3CAUw4yy7cgQr4rhNH66g8yxSqHyWJCgTO
         UnodnlqrJp0oczyNqpgaJNazi5bDcTcVXesZ0sYeTq/nDaYdZic5LB3EOZbzn8UYxc3S
         Vnpw==
X-Gm-Message-State: AOAM53159bhbqESqsam8D5DL8h/ihNbgdXmSNfZtaYQHcg43HcRIK4Ae
        0s7xMe3Fkj1Cs3Ah79wib9M=
X-Google-Smtp-Source: ABdhPJx1Gnc1uWTKarHYFuwbsrvD1i7oSBqIl6Ca+Xk1xmjebpjinx5x2tnwkAfEgmDNYAJBXM/aTQ==
X-Received: by 2002:a05:6a00:c9:: with SMTP id e9mr20528966pfj.224.1596961952937;
        Sun, 09 Aug 2020 01:32:32 -0700 (PDT)
Received: from konoha ([45.127.46.120])
        by smtp.gmail.com with ESMTPSA id hi13sm15859210pjb.26.2020.08.09.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 01:32:32 -0700 (PDT)
Date:   Sun, 9 Aug 2020 14:02:27 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH] test_cmp: diagnose incorrect arguments
Message-ID: <20200809083227.GA11219@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809060810.31370-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Eric,

>  test_cmp() {
> -	eval "$GIT_TEST_CMP" '"$@"'
> +	test $# -eq 2 || BUG "test_cmp requires two arguments"
> +	if ! eval "$GIT_TEST_CMP" '"$@"'
> +	then
> +		test -e "$1" || BUG "test_cmp 'expect' file missing"
> +		test -e "$2" || BUG "test_cmp 'actual' file missing"
> +		return 1
> +	fi
>  }

I reckon we could be just a little bit more precise here by bugging out
with the exact filename which is missing instead of 'expect' or 'actual'
so that the user has more idea as to what happened. What do you think?

BTW, I looked up the 'test_i18ncmp' function as well and if we have
this small loophole you mentioned above, I think maybe we could make a
similar fix for it too. What I mean is that in case of absence of the
required locale, it should error out kind of like what we did above

    BUG "locale missing"


so that the user it is clear to the user what was the failure point.
Though I will be honest that I have not really encountered a locale related
error or seen what the error looks like, so maybe we can ignore this
suggestion.

Regards,
Shourya Shukla

