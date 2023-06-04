Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC60C7EE2A
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 04:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjFDEml (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 00:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFDEmj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 00:42:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477BFCF
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 21:42:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b025d26f4fso31483565ad.1
        for <git@vger.kernel.org>; Sat, 03 Jun 2023 21:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685853757; x=1688445757;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwCnFVw6pvsD7qgy9NCQhlO7xnK9EeYr6iH2k/0ntE8=;
        b=sdTJFOSLindyRObw9yJ8xK4d88iGIqNbcJR2pSyOWCA5SzipuSi/ly/SQnMo+N/c/e
         gDVtZGOpiRzIW9M8hcGRlRwOQcaIOPbh9Oa7RiVtpGhrKbmLkm+4Puvgc2VYykXNRELQ
         ld6yCvSFkFmVGjRvv369jXtQvuw/HvtQDl5qMjOA6bjkayMhx4STUlxCWG4ED6GatijG
         dAYcTKWzkpz1PtOoLoe6ifPTS6vBaQAbeBADTI53X6SZqvwX5N1f9LBeKTaNmEAuh5ny
         +8itKOFtEdfpCK/k3f6UMtd6Esqsnnb+AW3RHkciPDhdQpeaTqjGhcrGOxvKFP+fZmXM
         7WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685853757; x=1688445757;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwCnFVw6pvsD7qgy9NCQhlO7xnK9EeYr6iH2k/0ntE8=;
        b=cqZ8HnygEQ2sWg7M0NvHVHP0k6Kn0gLNU2bLVawGyyWCXWyvaboj9mGHpb27J0k5pa
         ghQsWu+yJUHBw7rB9TRagW80m41XYjYQuEKwZpFGMai477FXMlKa0J1oz+0bSRadhvOa
         DHGbkLTi9irns/fID0aquRFz7SL9L7ldBEbg6NsB8AaC2OFmYg85oSekSx6mt0IVEDQI
         +F+TAQgvtdDHb7CWsbBlhWNMzYWT06eqaOrHC3/Jo14XZJf+x8KpZPsFUQmPm/NC4pBJ
         YNAvPMQo7XhkVkEui897oG1hI5r5gCV8HXFwIiIr/wM36aXvjxhmX0s0R2kzbioYNbmN
         r5/Q==
X-Gm-Message-State: AC+VfDx01wfOaO7qJ7WGtJqqnbxlvslJea7+GKNQc8XWV9xCybRLn1qJ
        EnBaCXjKb1V8PPnts7anMD0=
X-Google-Smtp-Source: ACHHUZ5HDdp7TsZr0tMoueZMRoTJenQbu4BGp6/MWW9ViHRMpb8ely7vLlDeLfOMj8BmWshdtpCMZw==
X-Received: by 2002:a17:902:da8c:b0:1a1:9020:f9c7 with SMTP id j12-20020a170902da8c00b001a19020f9c7mr4880663plx.44.1685853756612;
        Sat, 03 Jun 2023 21:42:36 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c28300b001a245b49731sm3973651pld.128.2023.06.03.21.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 21:42:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix memory leak in get_reachable_subset
References: <20230603002819.1122129-1-mh@glandium.org>
        <xmqqedmt7167.fsf@gitster.g>
        <21d3f105-ed32-e397-a1fe-53344894bd44@web.de>
Date:   Sun, 04 Jun 2023 13:42:35 +0900
In-Reply-To: <21d3f105-ed32-e397-a1fe-53344894bd44@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 3 Jun 2023 08:02:51 +0200")
Message-ID: <xmqq7csj6dok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Stolee reviewed it already when the patch was sent the first time, here:
> https://lore.kernel.org/git/20230421234409.1925489-1-mh@glandium.org/T/#u

OK.  Thanks.
