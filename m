Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B53C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 17:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiJFRFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJFRFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 13:05:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D939C7D3
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 10:05:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g28so2593590pfk.8
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfECKiwpulj9y4rZi3s2Bb9GKHXj5OynKNH2FfW0weQ=;
        b=gr9zQkbp2yzn/Z9SVjnMtOgeCPL3NDSP3kRPzTQhuVIjo4BvWBd2Y8PHeRRmLxhsQd
         G6gMYfUHlCtgS6Sfh4cuJMcyotgMkK4S0K2VuV4BRcup6fQvbES1DmURW5se/faVjtKZ
         YqA48OUA3eyFZuL6lzWF/1R5gzJ+Ch+NzJ193yzMfrnz58CexQctPwC8mvyseLL2QN5i
         +pbPsK6CISRfUAgz3rm22Si9UhkpGPfUgouvM6x0ng7ARG10/KPuSmkQowU4XZFq+G49
         PiT545ft4OrYib3+ZONx7NR2xCqT4FtaR1oKKlDGXeMDTTzc11iZNYS0sBrXK2zBin7t
         Z6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfECKiwpulj9y4rZi3s2Bb9GKHXj5OynKNH2FfW0weQ=;
        b=T4yyDva/7h6vooNuR2jwBN2FHo3c85ZbrDBkXU2dIGzWJDfEFxKMRdl0W8q0CU6lST
         nD29T8FAPbcL0z9uwwC/M1Wr9keeQboUW+0bN3Amn5RuU6hZ/VpnKhYA+V2z+OJjdQnU
         bMEREWy7sf1FAJfyvmy5t/U6pUzNUKuO3UiELZ0Qcz12sGdpaIs/3KFe+A80JffzCidN
         GRLC5DlMEYsTsSbFe0YBf0q4vyUj+hke3J6KI8S/cAxXhC0rxXioiuJbfTHW+g7EW/6C
         gp5sKFE2sC8a8g9s4kCT3LtGkz/EYvF1lU27XRnHy8/5WFPgJgjK2EOadj1mgZn1Jn1R
         Fw/Q==
X-Gm-Message-State: ACrzQf2Sq5pv+ncArx8LFDzTNY4v0UzrlELw4cyxtcqGaJC/7M1KiYPD
        4y1x6oHzHT41zIxoFrZ/mj4=
X-Google-Smtp-Source: AMsMyM66Te6Qog0e5Nd3nG/prCjbiNw+nTqrNwnaThD8FEwNFFzGc//IVgzfRE+p19pAg0CqUrKNiw==
X-Received: by 2002:a65:6055:0:b0:42a:7b2b:dc71 with SMTP id a21-20020a656055000000b0042a7b2bdc71mr694537pgp.23.1665075932668;
        Thu, 06 Oct 2022 10:05:32 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902d2d100b0016be834d54asm12744636plc.306.2022.10.06.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:05:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/3] [RFC] tests: add test_todo() for known failures
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 10:05:31 -0700
In-Reply-To: <pull.1374.git.1665068476.gitgitgadget@gmail.com> (Phillip Wood
        via GitGitGadget's message of "Thu, 06 Oct 2022 15:01:13 +0000")
Message-ID: <xmqqsfk0lw6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> test_todo() is intended as a fine grained alternative to
> test_expect_failure(). Rather than marking the whole test as failing
> test_todo() is used to mark individual failing commands within a test. This
> approach to writing failing tests allows us to detect unexpected failures
> that are hidden by test_expect_failure().
>
> This series attempts to keep most of the benefits test_expect_todo()
> previously proposed by Ævar[1] while being simpler to use.

Great.  We discussed this some time ago and I am happy to see the
work re-ignited.

Thanks.
