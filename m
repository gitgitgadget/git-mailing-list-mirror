Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2810AC433F5
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 07:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350135AbiFAHcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 03:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbiFAHb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 03:31:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318213CDA
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 00:31:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd25so969397edb.3
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=avqrFbZ5Bc9Axdg5AItVCXViH6vq0YsimtqW8wOPW64=;
        b=BuJrZ3oNeUsXsit48/o08IdcTeZaE45IqDz5kbBbfPDmn+nfTzFmVtRfWQY4XDAvns
         fjbvVCPgIo8Ynw+IDGVMyoT6WnGAsLNlqB4tFj/MZ/YR6jQZ5lFo0RG4Ljce/wiRPoei
         Utr1PY/qN/mEYBhA3RUf9dt4/gziBP0BfLtaSbyl7eBk2zbpOna8s9XbTml4WfmbOawy
         4VkyLlEbpiCLp6cZ2wCE7UCTwVc30HLfUulKcjJOat6zFQ813OT4Sfn06ourbIKJb+qo
         XvqmbZCs2XhKIX5NsqrYJs9z6T3AbavtQjntl6c3EeTYEDdCDpKa9NgWpeVRHexQWLVQ
         7CVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=avqrFbZ5Bc9Axdg5AItVCXViH6vq0YsimtqW8wOPW64=;
        b=fwZwFO3Mll+o6nHlGM3XHqgzP92Q7GBh4/xR6KSO+bwlkF94pNGuITWBLvFuc0vZke
         guqUNrqFUxObVu1aYXA/QlKDirUnAzM4+6kuw8U3pZByNzOaqSRNxHobMF6A3xIavckL
         WwrT0jRco6h/IjlLAzrM/GChJN7853QNKYdI421RNQIRSJYmXBqEFHSmWK+wdEkjoFCq
         XYDBElkDaadSdCHEGxa9uy37w04HAipYQxmlEeSyVntaiMqTFvkWVKFmu68aRYC2FYqe
         nK+Ub1fSjfZedbGl7Mq0+0p9mOS5nZR39UeLcVoya70sk0OE7fxTzJqMoxppF/rcavaV
         Q45Q==
X-Gm-Message-State: AOAM531QoWvsN/Tr2N1DF5JFR+gcQzpINM9+2mLZJSU8VdTe+t1JZfhe
        cRA/BLI6RErFxtzEDcs79zk=
X-Google-Smtp-Source: ABdhPJzczS6Zkl+RfUdMa4UcHcc5LCMeFYEMf4YII+mzRJa5KzMtSNjzHDDUx0dzI4m0Ja8FpiqADg==
X-Received: by 2002:a05:6402:1cb5:b0:42d:ddda:7459 with SMTP id cz21-20020a0564021cb500b0042dddda7459mr9879780edb.16.1654068714374;
        Wed, 01 Jun 2022 00:31:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id pk16-20020a170906d7b000b006fee526ed72sm348531ejb.217.2022.06.01.00.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:31:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwIpc-0012ze-Ni;
        Wed, 01 Jun 2022 09:31:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 2/2] remote.c: reject 0-length branch names
Date:   Wed, 01 Jun 2022 09:30:21 +0200
References: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
 <f947cf221c0b5320d0b7438b88a0d94a5bd3a70b.1654038754.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <f947cf221c0b5320d0b7438b88a0d94a5bd3a70b.1654038754.git.gitgitgadget@gmail.com>
Message-ID: <220601.86leug261j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 31 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> Branch names can't be empty, so config keys with an empty branch name,
> e.g. "branch..remote", are silently ignored.
>
> Since these config keys will never be useful, make it a fatal error when
> remote.c finds a key that starts with "branch." and has an empty
> subsection.

Perhaps this is fine, but I think this commit message (and I checked the
CL too) really needs to work a bit harder to convince us that this is
safe to do.

Are we confident that this is just bizarro config that nobody would have
had in practice? In that case I think it's fine to start dying on it.

But as I understand we previously just ignored this, then if there's any
doubt about that perhaps we should start with a warning?

Or are we really confident that this is an edge case not worth worrying
about in that way, and that we can go straight to die()?
