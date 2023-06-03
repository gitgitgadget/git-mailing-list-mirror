Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF1C7EE2C
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 00:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbjFCAL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbjFCALX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 20:11:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275ECE47
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 17:11:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b0201d9a9eso21122725ad.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685751081; x=1688343081;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d219LMacdPxvDa6B3SraUCAxYipUOMrYQhsg3GgNUec=;
        b=TAPXoAOCUmocCUqfYb3eyYRE8ogiYwmyt14SBTU1U2MePuOd+IDJb2IP7qeBh2DoPr
         xIu8smbX5onhp2+b2BUwTStKjB7hyfuY1hjfH01K/KOSCp1m17E+WXfB9jrraKJf+VS1
         dJisHV6/Mri94HXnA8V6I/cS14W2pOl+68YgvZEW/WR3/k+3Gs1tiaSdMhwXATiJzPHf
         CfmFmuSWxw1VrV74FKtfc5NkAALIczjp3+2rOVM4XhLN7mYslg0ETSwDDeXSFvSq4G1/
         +PPJKf4fMZmL7lN5G7DHBNyFtYRMj1DGeMOPr1iSbYPJRIaxLYEgva9ZFemI0pjMi2Va
         YkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685751081; x=1688343081;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d219LMacdPxvDa6B3SraUCAxYipUOMrYQhsg3GgNUec=;
        b=VQOd2zdd4QmFijWp2cR2pzXV8X1Ha5mqanXLQcUL5ZoP+2gwlQoXO/VUoju+0OXV5H
         R+27RXKrAckgR2AuAMEVjdvAgcx5BEKN5sDP2rd5AdwDGNv47y1RlP1VbRl9j6bzkfx5
         BCRj0vPbJI9BWXRNcXXvgzl/3rJeGUoNrNX0ZYeRKRHnKMaTayRtLoYOy8/QsgupWeHp
         8aQvDhrrJ4p3z3/vyvk6mWC7rr4oqrcnZ/TwepplmUBuHNHUIJBGYpftMRkoCb+2qifB
         p23pUxyKA0oTFwM3Et5VXzpaqdRQRlN3GyokWaIE2QsT3oJTEsDHNsfBBRnzcUIc/FrQ
         ecfQ==
X-Gm-Message-State: AC+VfDyc1IN2PfaVzxMimY+TbXC6h1tT15CKpVrz2GERWS8mk43kMVLZ
        tbZTCUIspIfFmXZj7UBhCYrfJrJC7KXwJg==
X-Google-Smtp-Source: ACHHUZ74EhmoUGBZtJTdIChW9bihY8m+VzMd/xlj2QYndZpueGYXIWXsIGAhd9cBWS7k9AT+q/ojIQ==
X-Received: by 2002:a17:902:dac4:b0:1b0:62e2:1f84 with SMTP id q4-20020a170902dac400b001b062e21f84mr1516528plx.5.1685751081038;
        Fri, 02 Jun 2023 17:11:21 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001b048e11fa6sm1871627plb.298.2023.06.02.17.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 17:11:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/1] surround %s with quotes when failed to lookup
 commit
References: <cover.1685366301.git.dyroneteng@gmail.com>
        <1f7c62a8870433792076fae30d6c4dc4b61a00d8.1685366301.git.dyroneteng@gmail.com>
Date:   Sat, 03 Jun 2023 09:11:20 +0900
In-Reply-To: <1f7c62a8870433792076fae30d6c4dc4b61a00d8.1685366301.git.dyroneteng@gmail.com>
        (Teng Long's message of "Mon, 29 May 2023 21:27:56 +0800")
Message-ID: <xmqqo7lx8kwn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> The output maybe become confused to recognize if the user
> accidentally mistook an extra opening space, like:
>
>    $git commit --fixup=" 6d6360b67e99c2fd82d64619c971fdede98ee74b"
>    fatal: could not lookup commit  6d6360b67e99c2fd82d64619c971fdede98ee74b
>
> and it will be better if we surround the %s specifier with single quotes.

The only remaining hits from

    $ git grep -e '_("[^('\'']%s'

(that is, "find the messages that has %s without a single quote or
an opening parenthesis immediately before it") are found in
builtin/remote.c where this template

	const char *dangling_msg = dry_run
		? _(" %s will become dangling!")
		: _(" %s has become dangling!");

is given to the refs.c::warn_dangling_symrefs() API function to be
used to show refs found by the system to be dangling.  It can be
argued that these are better quoted for consistency, but I tend to
side with the current code, as there is much less risk (than the
cases you fixed in your patch) for ambiguity and confusion there.






