Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF4420248
	for <e@80x24.org>; Sun, 24 Mar 2019 13:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCXNUc (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 09:20:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36486 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCXNUb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 09:20:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so6339596wml.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 06:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fW8o6Nr2d1lnNmQRqdWRyoul6F7yQd/FwUUZlQSLsqU=;
        b=QTs4wkreQRrz66yPgcvlpCCHA/5WEuklBZww3ZhfBFf+dKAWSBpcP8HbC2DizfbGSu
         UB4wmJVE1o66J71IV9zfb+Z7fqgb01PpmFiKMvz0RkoQTX8DvkzRD4Ldj+ESN6ObZSGK
         4hkR5oZwJCehF4VKKYNE//JhpMsmL71x897vPCt61ZCu9+gJIttRPr2H8UQ/FvcjiCa7
         Y8PYll5MsuhyGLm6oPZX6y7hp4NGiohKrpuBmCILPsNIycJ/NroaAtmDbjHZQf/KVKss
         3aU9+rpPzj7nYZH6sc53nMqUK29tdbHlUVp3FZ6wk1V9iCxK6NkoN5pyq4uUE27dEMer
         TzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fW8o6Nr2d1lnNmQRqdWRyoul6F7yQd/FwUUZlQSLsqU=;
        b=MKEES8KBkJDScLMoQJ7QN6BautAIPeEyKwwS59AX5z+OAe6t+qfmFUup4yiDGRBgZP
         dZAOINedn2Vo5+pqPYARmGk3YfEPQ1P9VaM0QXJEUK+PnHyB3T18ipO1JULwettXTyMN
         PZHKb7eFecW3NslNnDJhTQU13VvhbaIRlpBe9l31PcE68HMYeDgnelmSOBump3+wzy0m
         HTPWKQmWVMC8R00dJccZLlAwjs+zfahVMGE7PEKPCHYknCybyxgYNl7gw4rWIEofS2Sr
         a796BDk+W0relneA2o1SBcALqRo0RCt1Bt+XhrqLL9eqa9DIBbYKdlYd0rgCwpFQxjtv
         xeqQ==
X-Gm-Message-State: APjAAAXy+u0WDb13dAcU57dGycIFdutXpRopgP2dntq/yg32A3iUSzFe
        Q1om2psdJPiR3STy44ikQwiLO321/hU=
X-Google-Smtp-Source: APXvYqxE7TrkQLOnHQa/Hq8EF8tJcloZCxMQdUBb5xqid9R7yuc79j/jMAi39EUNLdfVsfXPjPc6gg==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr8494163wmj.111.1553433629348;
        Sun, 24 Mar 2019 06:20:29 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y66sm9457449wmd.37.2019.03.24.06.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 06:20:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com>
        <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
Date:   Sun, 24 Mar 2019 22:20:28 +0900
In-Reply-To: <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sat, 23 Mar 2019 08:25:28 -0700")
Message-ID: <xmqqtvfso1cz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> A common scenario is if a user is working on a topic branch and they
> wish to make some changes to intermediate commits or autosquashing, they
> would run something such as
>
> 	git rebase -i --onto master... master
>
> in order to preserve the merge base. This prevents unnecessary commit
> churning.
>
> Alternatively, a user wishing to test individual commits in a topic
> branch without changing anything may run
>
> 	git rebase -x ./test.sh master... master
>
> Since rebasing onto the merge base of the branch and the upstream is
> such a common case, introduce the --keep-base option as a shortcut.
>
> This allows us to rewrite the above as
>
> 	git rebase -i --keep-base master
>
> and
>
> 	git rebase -x ./test.sh --keep-base master
>
> respectively.

I never use the "feature" myself, but I recall that when "git
rebase" is run on a branch appropriately prepared, you do not even
have to say <upstream> (iow, you type "git rebase<RET>" and rebase
on top of @{upstream}).  

Can this new "--keep-base" feature mesh well with it?  When the
current branch has forked from origin/master, for example, it would
be good if

	$ git rebase -i --same-base

becomes a usable short-hand for

	$ git rebase -i --same-base origin/master

aka

	$ git rebase -i --onto $(git merge-base HEAD origin/master) origin/master

