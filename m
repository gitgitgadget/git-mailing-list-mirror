Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06012C678D4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 12:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjCGMFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCGMF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 07:05:29 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD32A9A4
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 04:05:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cw28so51264666edb.5
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 04:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678190726;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cEv62fkc9u5J5tnv0LHc1spV7ogWaiV1ZB/0h4xbjLw=;
        b=UFrRSSS2ny3lIwNITInXj7PlL91q/VX50vLadWvzDA5zLDvpaeLy1HM/X6ym4XvRzF
         vphHvPdnU33NZets41HPyCH8w+X7gezMjEu8tsfdaLH3jBWoH9nHFBzMnCxMM1sZi1co
         6vT5ZATeOGmiiWa31oRTEBkIXLIwVPfqnc3AZuIZQ5eNHiToLO2EqIlilhxQt92rFmys
         m0gLTy9bd5fAiStOKStTxbfLl9AtnWtxchHZXldLUrohad5D1oGki9ZGo3uJ2guseRHW
         euORGqLUXI9OVEKVEBlGYCOKZO4CCiu7Uuq7JOTxbnNhnNc+G5VYJOned1OssoQAePKe
         c4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678190726;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEv62fkc9u5J5tnv0LHc1spV7ogWaiV1ZB/0h4xbjLw=;
        b=cFFUzT2QGCpqNPtIHeT9YO3pT0O0vwPB4UdSQ8Tx1K6k+SLzGzoOkk/kSlge7+VszR
         G0BE5kBhrkMHYuCftlrL9w0/pTVQg5jQcxSUpGWP2Fw9HuAjFZ2jVL/VkFn15a0yUeLD
         AGUAE8Ww77dw8QReAyvZRQUHd5s/o66FH7nhkYgkpMIZnwyF7O0LqPlZfBV7BN23MGMm
         F6eW90IaQIJWj9hKVUtd95RzmC7tMyejxzel6NjaReOjw4aF/YxOfpv83KH+AgkmqBZ0
         NEMK7aNm+xMXYOUa4msYhMslhJegeQ6IpZgp6oDybX1mGLateaggIxmfvtBhXDg0WccF
         19Bw==
X-Gm-Message-State: AO0yUKVgjdr3SMUNR+WsJDIKr2Grftew1t8ERwoW8W5qWjFZ8xTn+GSi
        2F77ZLx9MlEmZIi8AukH9S8=
X-Google-Smtp-Source: AK7set+WlrHFEUsHHSHDPY1BVQwVrJ76yqqdmzSVmZGamkrOKjNMLZki/NuzC2ewKpYE0m9wne6HeQ==
X-Received: by 2002:a17:906:7803:b0:8e3:8543:8ebe with SMTP id u3-20020a170906780300b008e385438ebemr14201910ejm.57.1678190726149;
        Tue, 07 Mar 2023 04:05:26 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id bn17-20020a170906c0d100b008f7f6943d1dsm5983010ejb.42.2023.03.07.04.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:05:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZW4L-000hHZ-0I;
        Tue, 07 Mar 2023 13:05:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
Date:   Tue, 07 Mar 2023 12:57:15 +0100
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
Message-ID: <230307.86wn3szrzu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 01 2023, Glen Choo via GitGitGadget wrote:

> This RFC is preparation for config.[ch] to be libified as as part of the
> libification effort that Emily described in [1]. One of the first goals is
> to read config from a file, but the trouble with how config.c is written
> today is that all reading operations rely on global state, so before turning
> that into a library, we'd want to make that state non-global.
>
> This series gets us about halfway there; it does enough plumbing for a
> workable-but-kinda-ugly library interface, but with a little bit more work,
> I think we can get rid of global state in-tree as well. That requires a fair
> amount of work though, so I'd like to get thoughts on that before starting
> work.
>
> = Description
>
> This series extracts the global config reading state into "struct
> config_reader" and plumbs it through the config reading machinery. It's very
> similar to how we've plumbed "struct repository" and other 'context objects'
> in the past, except:
>
>  * The global state (named "the_reader") for the git process lives in a
>    config.c static variable, and not on "the_repository". See 3/6 for the
>    rationale.

I agree with the overall direction, but don't think that rationale in
3/6 is sufficient to go in this "the_reader" direction, as opposed to
sticking with and extending "the_repository" approach.

For orthagonal reasons (getting rid of some of the API duplication) I've
been carrying a patch to get rid of the "configset" part of the *public*
API, i.e. to have API users always use the "repo_config_*()" or
"git_config_*()" variants, that patch is at:
https://github.com/avar/git/commit/0233297a359bbda43a902dd0213aacdca82faa34

All of the rationale in your 3/6 is true now, but as that patch shows
the reason for why we have "the_repository" is for the trivial reason
that we want to access the repo's "config" member.

It's a bit distasteful, but that change argues that just mocking up a
"struct repository" with a "config" member pointing to a new configset
is better than maintaining an entirely different API just for those
cases where we need to parse a one-off file or whatever.

I think that going in that direction neatly solves the issues you're
noting here and in your 3/6, i.e. we'd always have this in the "repo"
object, so we'd just stick the persistent "reader" variables in the
"struct repository"'s "config" member.
