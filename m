Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB74C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 15:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjDTPy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjDTPyx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 11:54:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30643C0F
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 08:54:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a6670671e3so11646915ad.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682006079; x=1684598079;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icQu06iorNNgIkmbrx/OK7L7EZ5xmANT25G28TaMFSE=;
        b=rLMSNkMpsZ5QcUjWx+fRoZkznnAxXMco3s2LizDSVua0JIPGasaAVJTyDC8kIZxlrB
         gXODHz4yy2OlUSCzHIKZDzNbOwbawBrqPW1qvkK2HVnlnypdM9IbZ0I39LuqnvHyeQJf
         pw7SXsqR9ARxDjFVZaxSznYE9RhB0cvxQSaXWFqezOJnNEEHM8F+WXtLooddWPAgeYsy
         orCcn0lqJhzIRo1uKOf7akWKNe1W2T2XNmVCpkoB49Z4eJPGE5CSh105HsS1Qh7Hqiak
         1zR7HZs6aU1xU8tDcfrvdGVG7HWEcLNDNYo1KowobRLL1i9SeO1POAyAdCxLs+3czot5
         PxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682006079; x=1684598079;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=icQu06iorNNgIkmbrx/OK7L7EZ5xmANT25G28TaMFSE=;
        b=TOSiwAqeBbWSfev0rwxgcLTDS/xMucWPESleAIVgHCh0cozvBC1xY2ozI/tu9ESJyb
         lhSTF8aln3dN8WnlsYbq5/HbPdgFZ7dpKoa48wyrg9PfZqAncNAdPbk5P+zAjMhuCKVj
         ICdvcxm8kS1wjM5EvmBEfb1VClR4nmOaF4AdRrpo/RV3V7f78Wmwc0bmK5hx6a6yK9Mv
         4RNxQqSMA5NySi34alRm/yJhnW+7eGgJPurHcWKWnG6OQ3FzFBba1N1WhjrPUKq9bc0K
         Eu/ozSH9fmVYmZ2Yd2qOT1ZP1dsAv7Hn+h918/ZsyWuTfPrqN/3dWM5eq2fY6AHpdGPo
         Ss8g==
X-Gm-Message-State: AAQBX9cCZGDuX9EZg2hp6QhaK4ZFpWOfhx8g7P7ziIcz5u0pHcZFhcrm
        Pwt9hYzg+OndxZkuKzhVI6Y=
X-Google-Smtp-Source: AKy350ZVfwzj8YrmX9tOhKMs9bcsXXcPm60iKLpkKl2hid4lxQp63vfFVGO0RrXxKejp4ts4kYS0Ig==
X-Received: by 2002:a17:902:ab8f:b0:1a6:8f8c:fa1a with SMTP id f15-20020a170902ab8f00b001a68f8cfa1amr2006157plr.16.1682006079139;
        Thu, 20 Apr 2023 08:54:39 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902868d00b001a221d14179sm1302745plo.302.2023.04.20.08.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:54:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 14/23] hash.h, repository.h: reverse the order of these
 dependencies
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <1c6989ae456c86850761b079384f1505735e317a.1681614206.git.gitgitgadget@gmail.com>
        <ad90e716-ba23-040f-66be-4c4faff02ea8@github.com>
        <xmqqedogbwh3.fsf@gitster.g>
        <CABPp-BELApT-6YrYJ5qwme9uwP_2gqERdiLiE7mJu_b0bXmCbg@mail.gmail.com>
        <947db4da-13d9-d81a-1c0c-d8fe62a9279f@github.com>
Date:   Thu, 20 Apr 2023 08:54:38 -0700
In-Reply-To: <947db4da-13d9-d81a-1c0c-d8fe62a9279f@github.com> (Derrick
        Stolee's message of "Thu, 20 Apr 2023 09:14:10 -0400")
Message-ID: <xmqqpm7y4kht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> This is mostly because most consumers in the Git codebase will want
> these methods, and only the most fundamental hashing code will care
> about hashing separate from the_hash_algo. So, the most-natural name
> for "the header file that lets me hash stuff" would be "hash.h" and
> "hash-basics.h" is for "I'm doing very simple, low-level hashing".

I do agree with the reasoning for "most people want 'hash.h'"; what
is called the "basics" sounds more like for advanced users of the
low-level machinery, but somehow I expect "basic" would the one to
be used in sample programs in tutorials or something.  "ll-hash.h"
for low-level hash features?  I dunno.

But whatever the name for the header file meant to be used by
"advanced callers to low-level machinery" would be, I like your
choice of the latter variant between the ones Elijah presented.

Thanks.
