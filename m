Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E56C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E8A206D7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y79tV8xH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgFOOC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOOC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 10:02:56 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC1DC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:02:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t74so2024873lff.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qL1ALAiReLOJL3OzhlChxpZEM+ihidPQz7kx6qWgKso=;
        b=Y79tV8xHQ18YMlilxTG+OpxFXnIo+kQ7IL4Hyx5D69Qywz4VcKnm8hfL1AvauyLTsY
         /Dsa/coawmvrQPFZQEEF65iEYA8l+6nrlerVpUxrJJ6xDOSOAYkZJcgfc7peUl7hoZfj
         r7nG2fnMgL6qMKArZUTA6kQNOdflr8H9GKABThTfIRpZXvfLA1d7kpkVbAjEcrRVS8+q
         4hGWOdX76KSijsnxRcItC/VEB59l9tebtafcS5IV1HLzObby7jfd5WoPpwLPfS1q2Ulm
         1ndIsAkeHWtiZ+WT8t1wpzVZ4ea0pRiogAAsIw9/C2e9d+ON5ySBt+2gHiosh+d8hQrv
         BO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qL1ALAiReLOJL3OzhlChxpZEM+ihidPQz7kx6qWgKso=;
        b=HDVQT9LZYv4tV8Rz93BQ9gj/CGVHF3BEENkuo92L3p4oUTZU2yKYk4zAsB60BYNoKd
         hRInrpeCXk/eR7O98loK36GWph+mRV8fcW2OzdrdeN8VcPRINuJlCa72r/7a+UMaV7/W
         Argr158NsAKL/5nooXurJzpAa70a+sbbpq3qbprXXpaXLz6mHaJiHFzEtRtfjsCkGwA1
         hXKTQBSvpEWgD7zPD+97jxEC0fZ0A5x94aKi6//TYmTqt/Y1sPMYylTidgiJ4QJT4UDE
         XotVQ+RhvD/wcqO49PFOpNq0QBs7/Rwp0fw7cggMDPwymf6+D20Yngty1aLcMRGjC6tn
         a7kw==
X-Gm-Message-State: AOAM532Cd8WVGyjWObBRtEZPLuc2WijHvhyhs7z/lf+ZvQn+eqzYwusD
        ReT/EqHSp5G/3Am0F0zv+XtKSe+kZiU=
X-Google-Smtp-Source: ABdhPJzb5LQ0ZfmKP5k/5oxG4aNEVyQErM3//baehuQvkCqG/4VP7d+YIbatmDzXMJVxaC7vij8R3Q==
X-Received: by 2002:a19:c216:: with SMTP id l22mr1652635lfc.98.1592229774203;
        Mon, 15 Jun 2020 07:02:54 -0700 (PDT)
Received: from no92wrk-walle.osl.infront.as ([195.204.99.197])
        by smtp.gmail.com with ESMTPSA id 3sm3846334ljc.140.2020.06.15.07.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:02:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sibisiddharthan.github@gmail.com,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: Re: [PATCH v4 4/8] cmake: support for testing git with ctest
Date:   Mon, 15 Jun 2020 16:02:36 +0200
Message-Id: <20200615140236.1707-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <db05180e98af42b5d0887298adbb2f2db6c1d6e7.1591986566.git.gitgitgadget@gmail.com>
References: <db05180e98af42b5d0887298adbb2f2db6c1d6e7.1591986566.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +
> +if(BUILD_TESTING)
> +

This variable should perhaps be declared as an option using option()[1] since
it's a knob the user is supposed to be able to switch. This makes it listed by
`cmake -L`, and shown in ccmake and cmake-gui. In short, it's made more
disoverable.

> file(APPEND ...)
> file(APPEND ...)
> file(APPEND ...)
> (...)

Maybe make this one multiline string and have one file(APPEND ...) at the end?
It looks a bit... big.

Øsse

[1]: ttps://cmake.org/cmake/help/v3.18/command/option.html
