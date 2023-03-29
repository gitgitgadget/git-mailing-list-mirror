Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D20C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 22:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjC2WRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjC2WRj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 18:17:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5507D5BAA
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:17:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d10so10194736pgt.12
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680128240;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpUNE7SRuOBWoMrs7TyXqt+zKO5xkH2aHjYf7+Va8E4=;
        b=OKERIlJf6M9ZHty6FtXXRWs4v9m0y2EnUl8KRcPQBy3nRnAb7j9TOt6upF9nieHsEw
         xC+Rajc2BryA1XGC+KJxMuyvAC82i/pkznQgy9FWEpjAaEKamXSyFoDpHbE90RIJslSS
         eHhhJSW72nDg4Mz9eJKciJ+uNoc0cgcbEeweFN+G2OdcujFjqK1c7a7RiKtyPeyjb7j9
         xfUtiiNGjuq8CVtDJVDcSgn1DB+9dV4GKGICF95R0hjbeXNvBJHwBhHDtNQSOp0cbyD7
         gjta/dAj2T8czRp59Ly+C2ubGYHusPHDardyhYgDShl8e/qaCIquHsfOQI6ozGD39ytv
         torQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680128240;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpUNE7SRuOBWoMrs7TyXqt+zKO5xkH2aHjYf7+Va8E4=;
        b=vSdql2G6oIiDuv5O4/bqastaBlZjE1rXLw9SK6RSGBHun8yjBXjgUL/BH7UjEACJw2
         RxekS9T8nlriNAFxWNcyJyAfDO2OTg5cngvvDbJqK4n47bWehNcChrrklLIFlDF6nt9u
         6X7zMGnn8BTSUiQyhAsKzf0dJAdl3bFVwOfaTRNg2ap4MiWX01rpMr7afgWbiiu1GxBO
         dvtv9hkei9UvCzrSJz12+2nwN2V+5xBrTcTjvUEg32zWrz7QT6r9ITkzwjiYRwgq5jBj
         OhM0eLwEj+YWN5/Ny/+/15ODvVWcteqE7PuG/nKC2W/+wlda2ZKLUXW4xc+DfRzd+Ke2
         r1Zg==
X-Gm-Message-State: AAQBX9dUhrqsnYbJq0vXZAilrasTT01bZg8CEl2x5X68l7Is7cgnfThT
        8RfzSO9Id9/7Sp9OQU3AufM=
X-Google-Smtp-Source: AKy350Y9hr66zichLmeGdwvoPyTLgzpY+I+s6hDpHZailiGr2rriKzZRpD+jm8w651zjOrkH/D9QEA==
X-Received: by 2002:a62:4e51:0:b0:62a:5152:cba3 with SMTP id c78-20020a624e51000000b0062a5152cba3mr20528452pfb.24.1680128239649;
        Wed, 29 Mar 2023 15:17:19 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x7-20020aa793a7000000b005dd65169623sm10900839pff.190.2023.03.29.15.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 15:17:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v8 0/9] config API: make "multi" safe, fix segfaults,
 propagate "ret"
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
        <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
Date:   Wed, 29 Mar 2023 15:17:19 -0700
Message-ID: <xmqqwn2z6w40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A larger general overview at v1[1], but note the API changes in
> v2[2]. Changes since v7[3]:
>
> * A trivial documentation change to 3/9, to clarify which doc in
>   config.h refer to what. As noted in the v7 discussion I think that
>   config.h could use some larger cleanups in this area, but let's
>   leave that for some future topic.

Thanks.  Will replace.
