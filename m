Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE81C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 18:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DC7206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 18:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di0GYFcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgFNSXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 14:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNSXe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 14:23:34 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAED9C05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 11:23:34 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dp10so6742113qvb.10
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=isFDb5KNyGINuxHmpMS/nYjBzGUZoIFGHYdupjnK9bs=;
        b=di0GYFcMh87aTFH+YngnQds4G5E9ALzHklC9Fqzd6wNVNiNbm7UdAoZkgxyTCkovKm
         NxQ0fBZZhbyRS5EtQfBh+GbCbgwz2LQkszmOMWJh3pG7hQ2qzkB6hb0sVr/kNe8JKurN
         xV+3QE9UrD/vj0QGIyKOEsqxJxnMHmwNAug7n2sP3OVYisi4522cOXvCzwSabKDeqQy5
         eSt4MuUhJgpb8dQgDbq427+gjfRQNjBnCOLb5OumSnDA9P6bbgK5TkUQqYNbRXVXRg8i
         wVHIQ6UgLORNNFtWanzT1MuS8Paja3j6wZf4pghS3kcD+NQ4q+H9znXEKByQC8kxu7MC
         8P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=isFDb5KNyGINuxHmpMS/nYjBzGUZoIFGHYdupjnK9bs=;
        b=S+SkwhUQWdlG5wWXHYZ5rS5b88nkh519K1tZ0n3EQocVgPamWq7UE+JeSaVv7j+uFg
         JAEK1/zLPdhlzAeIhTaQmmtbwntGpnTMWggrZoojXdBtgEpuT37FUGpN5lipSuNkXhPL
         NO0Lsc9YhxBFdsZA0dsJy1N2nJcqI98Pv3RIiSSuxc/QRk3NlTnX6vFuQ+5RBxJD1NuY
         cztCFAziYejhBcyxwNIbi9pw2uqWiewH4Nq0/RBIfQobeeNC4CaU4elihrRLggyuxSdu
         sbipepV5pk9UNeM9DomH4Xb42eowXEOOwWvxdtGtoghejciNmgODtk5yQDEuvmB+KKVD
         ozRA==
X-Gm-Message-State: AOAM530O5toC1NK7OkQbmY0Fn2p2QoMLbZRooKlqleS3hplxa/BXr1/B
        kE/7WRl1k8jLIwvu6qGUbBU=
X-Google-Smtp-Source: ABdhPJyi+mS+gDorMsb4+CtjNGkkeigwURE2DlGm+zQul+HJsTV1GPhH3zKtVD3rg8IxGb3V2CPr7Q==
X-Received: by 2002:a05:6214:b33:: with SMTP id w19mr20476784qvj.7.1592159013448;
        Sun, 14 Jun 2020 11:23:33 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id k20sm10100105qtu.16.2020.06.14.11.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 11:23:32 -0700 (PDT)
To:     konstantin@linuxfoundation.org
Cc:     Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        philipoakley@iee.email, sandals@crustytoothpaste.net,
        sergio.a.vianna@gmail.com, simon@bocoup.com, stolee@gmail.com
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
Date:   Sun, 14 Jun 2020 15:23:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, can you show me a single instance where "master" was confusing or 
not descriptive enough? Mind you, this all comes at the expense of a lot 
of friction in the LITERAL WHOLE WORLD. Bugs, stuff breaking, 
incompatibility issues, you name it. And let's not forget that people 
already have all the tools they need to NOT have a master branch if they 
don't want to. I think half dozen people can spare a few seconds instead 
of wasting literally everybody else's time fixing their respective 
software. Also, literally no one cared until americans went hysterical 
with the death of that guy in Minneapolis. It only shows it has never 
been an issue and is not an issue now. This is just 8% of americans 
trying to virtue signal at the expense of literally everyone else.

