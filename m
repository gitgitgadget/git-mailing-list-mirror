Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC009C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 14:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiGKOlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGKOlg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 10:41:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E542C41D36
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:41:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l23so9193196ejr.5
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Um47RI759H4qgyMRcEthfZ71rzZOnTtGxkFr+Px74JY=;
        b=XG0gestFRtnpEaH4BcYIiAnjKgVcUjPSGYw0MwYeZ3QFpV2oZOzWFAeOCllz35x/l0
         7tiJ6szkTLCWiRsvpCPRXejIx9yOD48wPF0dZ3fod3Rf6GPthYHTKPOVStYTo26htrdL
         mlXVi0Oh0idQWcS1jfeRDh3V2fQsV1BoXEPbmKz6QtWEPXn96s63RufHDS8iTRK8SdC8
         z2pHVJ3eZ2d3q7ECS1Abd004QQJGwan/64j5Zg95fdixezTQk6QH1iIgEj58pZ58+YcU
         hky+zJwnPkr6kIVNL4X7KG5L3/fWml5ui7ztvd9/bgFVZFG59reEx763Hi3JAE3iYIBx
         B4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Um47RI759H4qgyMRcEthfZ71rzZOnTtGxkFr+Px74JY=;
        b=p2j1b9A8ZJM1u0c0VG/kyPVWFEAwulxfeU0RQtteSAodO+ExuBJTWSYPCIJnJhDOQI
         ggDxxWJKd+0Us2Y6/66YEIGh9qLWfsXH1+E0sOr1WtzwWZ0YwIY6rOCvvtbLA1V5IuUt
         wsY/YBZzlJz3cUK9tmBAetlWkIrOwDOtifgYl84HgD94oRmKOJ48soBj51piC46etQCx
         JTrWuqOcYV6zr6oPxbXKUp1Q+UulXYbmMAwsL77CKCR0AleTKXTJqBCDSGgSBkJpsJre
         r0ky3+Tr+oZ/+XCVITa29p8SMUMj+3cQWRij3ZMh7qZwZfWCqrhYKz8ked3a7T/aTpAT
         NtMw==
X-Gm-Message-State: AJIora8pX6uLva0r7pWNyzDf/KQb7nODnrxKOmWfYONJmfM5PMBkePkx
        9W123EHgW5cU6pZ9JUp8Lb8=
X-Google-Smtp-Source: AGRyM1tunH7b2jnNn0fjPAOXD3us2WgQWikeeyAAePkve5mxU5yyiwUbH9DMx0vkf93e1P4HRHcHtw==
X-Received: by 2002:a17:907:9687:b0:726:3afa:fc7b with SMTP id hd7-20020a170907968700b007263afafc7bmr18873273ejc.82.1657550494454;
        Mon, 11 Jul 2022 07:41:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lz21-20020a170906fb1500b0072aa38d768esm2767537ejb.64.2022.07.11.07.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:41:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAubM-000uY7-Lo;
        Mon, 11 Jul 2022 16:41:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 7/7] tr2: dump names if config exist in multiple scopes
Date:   Mon, 11 Jul 2022 16:40:21 +0200
References: <cover.1657540174.git.dyroneteng@gmail.com>
 <c45ead51ffc5a9176493d627da8332d35a31d87c.1657540174.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c45ead51ffc5a9176493d627da8332d35a31d87c.1657540174.git.dyroneteng@gmail.com>
Message-ID: <220711.86fsj77lur.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Teng Long wrote:

> When we specify GIT_TRACE2_CONFIG_PARAMS or trace2.configparams,
> trace2 will prints "interesting" config values to log. Sometimes,
> when a config set in multiple scope files, the following output
> looks like (the irrelevant fields are omitted here as "..."):
>
> ...| def_param    |  ...  | core.multipackindex:false
> ...| def_param    |  ...  | core.multipackindex:false
> ...| def_param    |  ...  | core.multipackindex:false
>
> As the log shows, even each config in different scope is dumped, but
> we don't know which scope it comes from. Therefore, it's better to
> add the scope names as well to make them be more recognizable. For
> example, when execute:
>
>     $ GIT_TRACE2_PERF=1 \
>     > GIT_TRACE2_CONFIG_PARAMS=core.multipackIndex \
>     > git rev-list --test-bitmap HEAD"
>
> The following is the ouput (the irrelevant fields are omitted here
> as "..."):
>
> Format normal:
> ... git.c:461 ... def_param scope:system core.multipackindex=false
> ... git.c:461 ... def_param scope:global core.multipackindex=false
> ... git.c:461 ... def_param scope:local core.multipackindex=false
>
> Format perf:
>
> ... | def_param    | ... | scope:system | core.multipackindex:false
> ... | def_param    | ... | scope:global | core.multipackindex:false
> ... | def_param    | ... | scope:local  | core.multipackindex:false
>
> Format event:
>
> {"event":"def_param", ... ,"scope":"system","param":"core.multipackindex","value":"false"}
> {"event":"def_param", ... ,"scope":"global","param":"core.multipackindex","value":"false"}
> {"event":"def_param", ... ,"scope":"local","param":"core.multipackindex","value":"false"}

This seems sensible on its face, but...

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  trace2/tr2_tgt_event.c  | 3 +++
>  trace2/tr2_tgt_normal.c | 5 ++++-
>  trace2/tr2_tgt_perf.c   | 9 +++++++--
>  3 files changed, 14 insertions(+), 3 deletions(-)

... we really should update Documentation/technical/api-trace2.txt here too.

It does say "..." currently, so we're not lying there, but since we now
add "scope" unconditionally...
