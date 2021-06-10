Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DFCC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409D9613F8
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhFJOpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:45:39 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:44698 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhFJOpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:45:39 -0400
Received: by mail-oo1-f43.google.com with SMTP id o5-20020a4a2c050000b0290245d6c7b555so6822574ooo.11
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vN0kncrnG2NPFWOENZFIPLevmWBpGAG9s1fWblbtKc4=;
        b=OylSVQouPnVS3bv2FKr85Rmz18LRPpOkdDp6xIXqoFS9VoSejM5DJN6gw2/Td4u0lK
         OAH4HV6M02SFeZGCnp1vjyn3XKUdXUrTpg23qg49nZFxwrtzSJTb1wczC1b0wcAi3v5B
         4WTN+ekOZYNcePyWDgfQffmc1XLoH1lHchN8ZWVGRKs+ftgm1p+tKX4bKL1jIne/0Jir
         wJ/QSYAhOgzzQ0Cv7dolIyxAEpKHvWlFBLkK6RZGqpt04YHhv8m+fBr1DzdmAR1JId4G
         ComSelFTy6K1ybBTDWzh0PgkNKxwUA6t/ZKJhOohHCUPBW958au2CAh/ajxMH6WNRJ+5
         TlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vN0kncrnG2NPFWOENZFIPLevmWBpGAG9s1fWblbtKc4=;
        b=B5zbEi/VUCDxR4rXWmsymG66UoWDlndC0+lRSt8KCeObaa6s8WZ5CDE+b0IOEa5O3l
         ca/WAFYXTL1DuHzxnHsbYezLKlw7taJnwndnQNa8oJIJRMnDuP+43qD7gzwO8S/Jh4aE
         K3rg0CVSn3eBADGR/dijbjwK0tOwrVqEuKf52vYA70/fS7fzF7f5srQw4hAL/2hCiki6
         8GbRoyue/86bCewzVjqpPm5/EmRZYC23TJMC928cbL5njFLEuV/r+Bk7C4/+zhTcqWXp
         1S1GbKVxGyOJdjq1EcWJyv9FcwfYTDcuWiuA9/Qj5JVWJUSPxoRNyGnvSf6UnWNj7iXn
         PhFw==
X-Gm-Message-State: AOAM530kcYBAo8/r+CyP70/K7QJquAOoOf/uy47jrSg8zv8f05mxuPWy
        2ipjoLb87+XxYlfUYVKwM2s=
X-Google-Smtp-Source: ABdhPJy+Gx5x6vL44tQCn9fQrPcFUs6HxEUOZfL0q1R/s3hOw+dBhTsdGLXJqLmvwVD3dQ9Fh8I5Ng==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr2641937oou.23.1623336162606;
        Thu, 10 Jun 2021 07:42:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 90sm186643otq.20.2021.06.10.07.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:42:42 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:42:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c224e0ed2d4_b25b1208f5@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2106100947170.57@tvgsbejvaqbjf.bet>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <YL+p+MlgJ754YoqB@google.com>
 <nycvar.QRO.7.76.6.2106100947170.57@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> It is all too easy for male readers such as myself to not even notice how
> effortless it is to read text that includes you, whether by the pronoun
> "he" or by avoiding any gendered pronoun altogether.

I am a male reader, and I have no problem reading "she", as many other
(presumably male) readers have stated as well.

> In light of this experience, even if I generally agree with your point about
> using "she/he" by default, I believe that Stolee's direction is more
> diplomatic.

Except in diplomacy you are supposed to work with your counterpart, not
completely ignore it.

*Nobody* has a problem with using "she/her" in the documentation, and
yet you push for the option guaranteed to increase conflict.

That the opposite of diplomacy.

-- 
Felipe Contreras
