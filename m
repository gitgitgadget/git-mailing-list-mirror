Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04EDC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 23:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBBXMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBBXMo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 18:12:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CBD7E6BE
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 15:12:43 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so6660402pjq.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 15:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qScJw9ud5A2l+0259IqZVHqcigi9gBLlPsmS2YIHHVY=;
        b=FNblplLW7CoOxRVp3JvoMdgs7rrRdZSLyH9JZNB3cKw2X9oL91IbDWCfyE/3gBudg9
         t+ZpUnZeg+YNHpdS/DuWhWSXNIA9v+7/R23Oe/zO8YvAuPlFIIzBgbE/DheWHaFs7PSx
         F5sq0bAHWhiHjPiLFMn04Yg0c6TGDyMvysSTo0O3mAiqfEi/kT4V2+TOSy0YqqSJf6xP
         EZyJxxlft2uydc8PMyNRyfRI3Mh7juxfe4tYicqgHfFJb85uC7E9RYRSBCOvc2iLmAg1
         SE7GBVya4GBhh2bbRGn4qfuxhlmzDc/LAXTalAmvpzJTPQpc/P5SJATU0G2p0MepaBkH
         f11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qScJw9ud5A2l+0259IqZVHqcigi9gBLlPsmS2YIHHVY=;
        b=BVatmElJr3d9H1rAebg5I/smJzXyFuQNwxM+pQBMeh9wXIt3LLfuIEv7AkXPTEvBwS
         u2NDhyDxmLKPhwcfPyl3dIRwI+PT+D7i6TpGCfC8iwIk8dr5VPawbSwbpSND3ElBR3ef
         c+pXwU7HVgrj7GhCFO1xG8dqqNLOhWF5jbddYUqKY5z5A+neHMQKtnPGx6VRmP7v0hwd
         Fo88DIALnBKGBTJ0bzyvejbKjApUrdaby5luMdk/fAygz727/oHmNBy1hb97xcLq84hi
         PBRGAsq9gp476DXv/VoroD+bJJFo8pRg/70+tT/LnTGLJ6FUrFUcbQfTHNbw58LUMRKQ
         HjdQ==
X-Gm-Message-State: AO0yUKXPInBBzWb3sLW9f1Xzbr/BYt3TAb3szgExzSc92fr8Q/oB/NMB
        VKIPEwiBPVaffLXxnzG6jJs=
X-Google-Smtp-Source: AK7set8j9E80nyebGdPi52DpPjNmOuiKRhxI8wXuwBW7t7ErAXdMI6PqkUM7q0BONV/UFuPp94w98w==
X-Received: by 2002:a17:902:d4ce:b0:198:9bf8:298c with SMTP id o14-20020a170902d4ce00b001989bf8298cmr10604771plg.65.1675379563304;
        Thu, 02 Feb 2023 15:12:43 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b00195f0fb0c18sm217323plq.31.2023.02.02.15.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:12:42 -0800 (PST)
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
Subject: Re: [PATCH v4 2/9] config tests: add "NULL" tests for
 *_get_value_multi()
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
        <patch-v4-2.9-1f0f8bdcde9-20230202T131155Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 15:12:42 -0800
In-Reply-To: <patch-v4-2.9-1f0f8bdcde9-20230202T131155Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 14:27:14
        +0100")
Message-ID: <xmqqtu03r79x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A less well known edge case in the config format is that keys can be
> value-less, a shorthand syntax for "true" boolean keys. I.e. these two
> are equivalent as far as "--type=bool" is concerned:
>
> 	[a]key
> 	[a]key = true
>
> But as far as our parser is concerned the values for these two are
> NULL, and "true". I.e. for a sequence like:
>
> 	[a]key=x
> 	[a]key
> 	[a]key=y
>
> We get a "struct string_list" with "string" members with ".string"
> values of:
>
> 	{ "x", NULL, "y" }
>
> This behavior goes back to the initial implementation of
> git_config_bool() in 17712991a59 (Add ".git/config" file parser,
> 2005-10-10).
>
> When parts of the config_set API were tested for in [1] they didn't
> add coverage for 3/4 of the "(NULL)" cases handled in
> "t/helper/test-config.c". We'd test that case for "get_value", but not
> "get_value_multi", "configset_get_value" and
> "configset_get_value_multi".
>
> We now cover all of those cases, which in turn expose the details of
> how this part of the config API works.

Good to see a better coverage.

With the "last one wins" semantics for half of these 4 cases, it may
make sense to further extend the tests to cover cases where the last
one is a valueless true, in addition to what is used in this patch
(i.e. a valueless true in the middle of three).

Thanks.
