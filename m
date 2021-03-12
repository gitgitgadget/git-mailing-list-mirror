Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFE7C433E6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49EAD64FF5
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhCLJYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhCLJX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 04:23:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D40C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:23:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id dm8so6958424edb.2
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Y17jFmdhAyJYwbi+XaVCH+deIwmA33agErNPaHkxJkk=;
        b=rVoakcxiAr3cG/NDxxr2xVbarVVouq3v59M2B4Ls1CgjSbIgpatI4Tn5hKLNVbvnzq
         bpNibmLGLDVXoNMnPb4IhmKTN2zDbpU5F4KOMDsydER4D2Q/hHeStDy/t0Q1MGJEvEN9
         +9rdQEVkLl1anNU6pAPxvjJDkVzVlaoA+Y0PebDziCdWazOBWszC46sNAs52A1Y2UqgV
         u0fTTznyV0f34LivfiX022iRTT+e4sHxZj0nWHluXVQnWG85WkcJjQEPT+DH3cIpBr94
         UUGxxffwR7wJoPZdM1/lOH7F84G81pCrp4fDNBLpYyLFYuG8eDieb7ryLDb5edoCvuRg
         Gabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Y17jFmdhAyJYwbi+XaVCH+deIwmA33agErNPaHkxJkk=;
        b=K1W8bNIpuvxbEySaMLeeVZEbOUKZ7gvy71XMLJ2DrjAvfLofcaPIWxdbEGPgGHFWIy
         DDnwHsC7Z5f80ufude1A+QTf3XYjoejjSOElqMveQz7fTlUNmy8Nwm0r0idWbgWEMFXS
         yrfy2lACI0RTbrCPwNcPe80JUBDZiBOxCcPwmfYThj/6uhUWmItpQEq/7SRNsj++dU04
         dbrKIbXAydJuZ3OMMZ0Nf4prAoSIgrmdKMzV2Fop7kPf4tuxWFnGjtgkAfCxWuNhRXzz
         WKqTt7YV5B5vRXOfeF/JkpK9d3e3qEh6hyi+gVshJEkWR4g5Pyv4sqOGMRgeWql1ksQj
         5wIQ==
X-Gm-Message-State: AOAM530pesfgGyPY9CGpuMEwWl4D/0FIzztvZE0zXtJMiazMZ50f649w
        uqWlBctuhcOGWtzgtQwiqIM=
X-Google-Smtp-Source: ABdhPJwi6FApEMCbadISFJU2IhVB68/Xr+PP2WYKXB2xUQYsQzye6anKLuk3a5eHWCsSEkXEuLyQrg==
X-Received: by 2002:a05:6402:b21:: with SMTP id bo1mr12879913edb.368.1615541036655;
        Fri, 12 Mar 2021 01:23:56 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id 11sm2357687ejv.101.2021.03.12.01.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:23:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 36/37] run-command: stop thinking about hooks
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-37-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-37-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 10:23:55 +0100
Message-ID: <87v99wg1xw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> hook.h has replaced all run-command.h hook-related functionality.
> run-command.h:run_hooks_le/ve and find_hook are no longer used anywhere
> in the codebase. So, let's delete the dead code - or, in the one case
> where it's still needed, move it to an internal function in hook.c.

Similar to other comments about squashing, I think just having this
happen incrementally as we remove whatever is the last user of the
function would be better.

E.g. find_hook() is last used in one commit, run_hook*() in another...
