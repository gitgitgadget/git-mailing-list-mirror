Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F33C56202
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 13:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8206622264
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 13:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7YMic9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgKTNTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 08:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgKTNTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 08:19:40 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A7C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 05:19:39 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t11so9452342edj.13
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 05:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+6ebaCXiNpED8r17FsYukswgH3BqvnHEEDbS+F2BfPU=;
        b=o7YMic9/2Fi9pcAJFw3w8ysoo8UjDxiUzb8zH0AGhFekTEnsKZxoyZPUllrLoXtRlp
         DU654TkmhPjzleYbgCEMRzF1em2P73NKUK2DZJqLCc6UuPzZfbiyTeiwLTTAQgpCZN/3
         ZBqFoSFEdwjpNx/fA01a5xRlCiGTwGNcyaCJU7QgoBOtTlnZs1EFy25kG1jyjHMuoGGA
         ZELuLvOq2OHd/k8y3e8JR0H5ZnmB0LqxOpcCWvK4l/Ek9NIJ3sLB1I0ZiuOAiGRSh9gi
         AwqM/YDQ7hnMort15N5apKObwwhSePkp68p3eRbeijKW6WobCIXHJ7evwdwiRH76SmgL
         zEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+6ebaCXiNpED8r17FsYukswgH3BqvnHEEDbS+F2BfPU=;
        b=g8hx1BlYv3LiUknuJaCsqa6MVGupBfgiyGD7UHyQJyoJRG4Cibl9uAssurjbAscME/
         n34+XB/ExB2mKD/9tAtnE0dN+7sGTpU2d58NcaPxTgGlpdeLrDBc5kvI/6QQdqCthRCO
         IA7CJq/RB7LZamP56TUqnKgK73VbLKe3mynTuU2yVMQdB93CMOWiU1dqox6nXHQctZYM
         fQGojSASDwMpiDLt5Mzj8tDMLew6T2q0Q1roFtFsUhfbhiUHmpb12gdqkOqA7UDFXgFc
         dKtJb2dTLYtyCKrYEXKpIGP4l6hYv3z53BM4pvwUMNUHQDdWyjLxcBJbREHfPSn3ItGZ
         Mcpg==
X-Gm-Message-State: AOAM532pZ0elDdE+xMb2onKZOoOnfqmZLjhXwDmscA/VKNQE1QwOXIMD
        4J2EOx48974hHZa9doUCtlXgOiKKN3DJDw==
X-Google-Smtp-Source: ABdhPJy/VA3tHoZMSuD+HO1WSlJ34PnKXGnS1fiz1LOaVVEm2+Tp0rwtol0ApLKkiWLCsFvbBjgBRQ==
X-Received: by 2002:a50:950e:: with SMTP id u14mr34811575eda.260.1605878378382;
        Fri, 20 Nov 2020 05:19:38 -0800 (PST)
Received: from evledraar (i157169.upc-i.chello.nl. [62.195.157.169])
        by smtp.gmail.com with ESMTPSA id i4sm1083985edu.78.2020.11.20.05.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 05:19:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/7] config: add --literal-value option
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <pull.796.git.1605801143.gitgitgadget@gmail.com>
Date:   Fri, 20 Nov 2020 14:19:35 +0100
Message-ID: <87k0ugp3mg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 19 2020, Derrick Stolee via GitGitGadget wrote:

> As reported [1], 'git maintenance unregister' fails when a repository is
> located in a directory with regex glob characters.

Just as bikeshedding on the name: Did you consider something
thematically similar to the corresponding git-grep option,
i.e. --fixed-string[s]. I see -F is also free in git-config(1).
