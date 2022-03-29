Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC01C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 09:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiC2JFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiC2JFn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 05:05:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0850222A2B4
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 02:04:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pv16so33753830ejb.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=K9iRa361P2a116aL1SG9ZPcpBE/EVIr1Q+YniYwCHOQ=;
        b=lPYA52FQ0VlDxW+BdNiZNYvgRsD1qxRSen7mWxL4ECtTNiZxYZBQTWcxUmtc4jY3d/
         CXL+/wKj85M6zEHEeuseWNnpZQUZFkM9qpe4SEs1QuM9WTwqxTKgfiEpkPEyrL1k1gWI
         Giejvuf1E0kmNrXhqfPFI1uQkZy0Y5M4qVRpd34E53jzb2ikd8BibiuKC/KDW/QVET0O
         PbltnWySkqZZ2dfK9GNjsEnlH4ZGp2GFBoeEbk+cZqa29WcJG63VQzxz19HzAKnLIxBb
         ivtPjhOHDj1+uSs91aHH9m/k2Y6pMTkjoK3IUBmM4v+IcWmeX3MQ4IDwvW6ir02l4MMF
         xaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=K9iRa361P2a116aL1SG9ZPcpBE/EVIr1Q+YniYwCHOQ=;
        b=s0hF/6+zNlssH01tI/c+0BJ9xPGH83HB9+0XZI0z61rBkMV0x+vToU1oo03K+/TK6L
         b3fzrui35nuBGKoc8XHLHuK5Dn4qI+wSkS0yOsCb1fwSTU0AW8gbxbVDykhO8w0mkFVs
         xUlHBppxFXn4vLLRfm3qKi9+Bm2JMhXEL7/8LEbR7E6W0kd9+dylMJoxZsIHdiAI0pgY
         uuxvum7Gc7bqXHSMPeRqwjJ8Qk9tTPURO0ftKWVuDgY2SSbIr3+P7dlM+T+xWz9BwcXn
         sYOzJdGcR28nnwNac1MseW8EQrmPyn7+KvrsLLFAAfx1SVJAT32lX/3o6Tv860Ml03Cc
         EgHA==
X-Gm-Message-State: AOAM530/0eHVUgfrlv84oXNls/nu6VP2tdfo5fxcI5HFGxtJRNTuMsQQ
        G8bmDJNZgK2VfZvaNh4J8xI=
X-Google-Smtp-Source: ABdhPJyZ1zYpOUc/Bvj6zmXIHC2yvRt5SNEH/FmuIANpZlY7Q0/xhjfP2uU+xRlqrmsPWog7Gp+z3Q==
X-Received: by 2002:a17:907:2cc4:b0:6df:a036:a025 with SMTP id hg4-20020a1709072cc400b006dfa036a025mr34610938ejc.554.1648544639357;
        Tue, 29 Mar 2022 02:03:59 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906518e00b006dfd441fc80sm6948402ejk.52.2022.03.29.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 02:03:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZ7le-003Wc3-3x;
        Tue, 29 Mar 2022 11:03:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Date:   Tue, 29 Mar 2022 11:03:14 +0200
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <Yjt6mLIfw0V3aVTO@nand.local>
Message-ID: <220329.86lewt2kqp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Taylor Blau wrote:

>  	/* Boolean config or default, does not cascade (simple)  */
>  	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
> +	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);

If this ends up being kept let's add it to its own commented "section",
the comment 2-lines above it is now incorrect.
