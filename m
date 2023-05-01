Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD71C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjEAWCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEAWCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:02:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5468D1FC1
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:02:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b52ad6311so3523025b3a.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 15:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682978524; x=1685570524;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzD8SCdhMRLFPcg/TSjm1Xsft1E8+ONl/Bi+2T+MRB0=;
        b=krlt5tYpvB0ldzDGkZTzadctZgkTUitIaE2Q3Mk4nGumuucZ/jh0lIcYAtV30iaIyf
         in9enqFbBDo1PUbV5FHMQGim7lcfTM0EGFjs/oPqAZ+vArOUKXQl3Tmy0FzHFLbRfwCk
         +WK0Y5S54plUJjV756DDK5AlfZcOAKQo+rkL+ziMb0FojP4e5nyPRkPVettIeaJS97uZ
         gK/IAODfTFFMmBbmVqc44VENt/EizKoakC7sEuCpTxDtsNKWEZR7HjI63rA7zAuNOotP
         za0xBGzX7dwVV7xE71UtjTKbZ/X0+lqz0jWhZegLePNOCZ+OVc6p0sbFo+qYw+jJEbH+
         erXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682978524; x=1685570524;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xzD8SCdhMRLFPcg/TSjm1Xsft1E8+ONl/Bi+2T+MRB0=;
        b=j9td4EPMfKhLxIghYl5BodXr03SHf3De506HcWZDsCePRX5LZNmPzsDa2OLzLYJos5
         34D7LTABKUHD85t115kDK8M0CYoZqrqeg6XvIMbzmaZrssGERqVXyaou0RAfM2R3haw2
         w71t8UJlOpzPHMC4FNkWy7Zmqr6Re5BJB1xq8OJYRdtEQdceR83hTnWbke6xO4+28oKG
         FkYQEBYptvkz1hCWaLQCbKF/qmufZDQuwT8h8LCpJJtFUxk3vp85deIvJKtyCNPr4rCo
         tvfQfdODttA/GFq2LNtPHUPIiJ/RF7DUuKki/cNmInCJxVpDnAd/t3z4UdTne4d0CsJ6
         7wiA==
X-Gm-Message-State: AC+VfDxIGmP/FxQ4UELBHNfdOfmYHO3k94QhnlWqoCOFm9nyeNct+fbr
        s3Fo4kZl7jVtA0qr1oxGvzQ=
X-Google-Smtp-Source: ACHHUZ6BnQ7OtZpZjswlcv4C1O2hjRZ4hY+cv8jnoEICBepL9/avbjgc/Gn9LSWM9BRQwgY2Uqutkw==
X-Received: by 2002:a05:6a20:7487:b0:ee:bd92:4b3b with SMTP id p7-20020a056a20748700b000eebd924b3bmr20541038pzd.19.1682978523738;
        Mon, 01 May 2023 15:02:03 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id o131-20020a62cd89000000b0063b7bd920b3sm21021743pfg.15.2023.05.01.15.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:02:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v3 0/3] git config tests for "'git config ignores pairs
 ..."
References: <20230418175034.982433-1-rybak.a.v@gmail.com>
        <20230423134649.431783-1-rybak.a.v@gmail.com>
Date:   Mon, 01 May 2023 15:02:03 -0700
In-Reply-To: <20230423134649.431783-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Sun, 23 Apr 2023 15:46:46 +0200")
Message-ID: <xmqqy1m73e3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Clean up existing tests and add new tests in t1300-config.sh.
>
> v1 cover letter:
>   https://lore.kernel.org/git/20230414081352.810296-1-rybak.a.v@gmail.com/
> v2 cover letter:
>   https://lore.kernel.org/git/20230418175034.982433-1-rybak.a.v@gmail.com/

This hasn't seen any further reactions.  Is everybody happy to see
us declare victory and merge it down to 'next'?

Thanks.
