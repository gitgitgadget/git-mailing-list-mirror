Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82E3C6FD1E
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 19:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjCGTq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjCGTqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 14:46:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2AAAB8B1
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 11:36:51 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id bd34so8800495pfb.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 11:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678217810;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yucB8t2y6MNoDlA5fa8JiBMQ8hriLcNsjzME6f+GROQ=;
        b=MzBOyw70XAAu4H7efptuzTuPqk/kgNCtgizd3h04qIsM0co/HnAnszQr34aKgU1Q9X
         L9fytL4hCk9zWi/kBZxrG8OL/eEg796SpDl2W28gsdvGb4zDIPYUSSc+6GUHKRx9jPMy
         1steDp6vkrqqMUKey5RNps7JDIrLLKzy9rgMkkHDWnBucDwLJgxU1kY461Rvs1wlDu2f
         9OzyYPYDsRBoN8SwKhcxPK/0Pv6GxD8gRUwp9/Qs1dLQinu079JmGRGGlfeI/wNz0SOV
         RR7djmuczIPosVDJC2E9pxJqBGZ8K2Dvoxyy0pKPRMH7vMtYl/ck5J16BG3JuZKovgOL
         CskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678217810;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yucB8t2y6MNoDlA5fa8JiBMQ8hriLcNsjzME6f+GROQ=;
        b=d9QB1keeuoucy/Bwjf5WjB777YznQKOJVQmXZ2jrFhZElAZeQyHoh8qzTCaUTMW8lD
         Pdlwnaf12y4KM0EMfu0oze1+pOwG4Zl16MEOpQ2MiZ0o7edEC25Hb4F8ioWidXipJI9J
         8Vt/fVdwVw05Lr/0/z5v32CHZR0MYsK5/lQWMRAE+eXEHeOoi6vceffcLaFuEmYNsnq+
         DdcOnz666lOMS0R88e6bN4WjYVdgdONsZ6Cw1rwvjbjwh5zfrDtWw+TccxHVmmeAbo5j
         RLZYrHaybVNwmte9GpByPQZMeajcbEyJ1+Rfhcq3fZ33hUCcM8syVXYqIB5hT1d7tRrU
         PThg==
X-Gm-Message-State: AO0yUKVKgHRpTpL88jygAfs2DIQKAfs89Xw9KN73lYpQLAu+alDwC1lw
        VXUQ49zHBQY79swFpaOcj2M=
X-Google-Smtp-Source: AK7set8nbrxTxQT6e+5+V4sq7rZXU92bKxfjGQ1evBXGKBWQkw/cJHga3qhNxZscGcxIm63K9M8iUQ==
X-Received: by 2002:a62:5210:0:b0:5d9:f3a6:a925 with SMTP id g16-20020a625210000000b005d9f3a6a925mr11864222pfb.24.1678217810386;
        Tue, 07 Mar 2023 11:36:50 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b005a91d570972sm8150644pfm.41.2023.03.07.11.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 11:36:49 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <230307.86wn3szrzu.gmgdl@evledraar.gmail.com>
        <kl6lfsagifpc.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 07 Mar 2023 11:36:49 -0800
In-Reply-To: <kl6lfsagifpc.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 07 Mar 2023 10:22:55 -0800")
Message-ID: <xmqqbkl4xsj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> ... In the spirit of
> libification, this feels like a kludge, though, since we'd be reverting
> to using "struct repository" for more things instead of using more
> well-scoped interfaces.

If you include "populate from system-wide, per-user, and repository
specific configuration files" as part of the API being libified,
your configsets cannot avoid being tied to a repository.  But I do
not think the reader needs to be in the repository.

> IMO a better future for the config_set API would
> be to move it into configset.c or something, where only users who want
> the low level API would use it and everyone else would just pretend it
> doesn't exist.

Isn't the use of the reader object purely transitory while you
populate the keys and values in a configset from a single file?  At
the layer to read and populate a configset from a single "source"
file, you still do not need repository.

Only when you say "I have a 'repo' instance and I want to read the
config variables from appropriate places", you call such a "read and
populate configset from a single source" helper three or four times
to populate repo->config.  Once a configset is populated, it or its
contents do not depend on the reader instance to function, so I do
not see how it benefits to have the reader in the repository object.

