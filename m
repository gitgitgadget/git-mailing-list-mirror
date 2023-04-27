Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F61C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 18:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbjD0SkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 14:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbjD0SkB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 14:40:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE95BE
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:40:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a667067275so69176175ad.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682620800; x=1685212800;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVCNj3SbCQTkDJda2oa6PknnTMsFGeHCFVVHyUI2pjc=;
        b=knLyfrClQZVPKARkh/ndN4fOT9r13TnhgNZXQrnuyS5OK/rdf4rp4wyMzJ72EOY4KX
         RpiA3eDzlTj+7SnMf2WYv4Gx6qAnvMfnV0ldYzqxkl8QfC+ozqdBgO+Hqs39tndSFPmb
         Tdt0DK1OXLyOvrwSsVWGzc+G9mEEa1DJ7KVn6EruoI9eU0Y4dpD7Zcp4XAq78s4rNBmc
         LyO0mcnlow0QtUgIlDnvyO0EbDpssy4j5uriokJ5uKM8cLVzzoUx6vKyx7GF1xTAsh4d
         O4mTy4KJ9vqidgGsNCWg9x8KzavkMv6WKqLKvsVTs7xOekWp8/E3r1Zl18dJuVkeNirq
         HW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682620800; x=1685212800;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kVCNj3SbCQTkDJda2oa6PknnTMsFGeHCFVVHyUI2pjc=;
        b=U5AyDiAPD18NMISm14G+ZbJR4IzbodDbrFzQFHTro3AtFTja9xR62yIMYkurjSAM7M
         pJfPPY61JKjU6yXJB1DaWTkgnK05jI03AnH9lyCDlIYwFasfj5vBkEYA6KiwrZ9K7iZr
         YQSCNbBcMdGSl7wTxQ7Ili4PsAin/w2DHA0a4nN/DXpOZlZNrYV2jIwBQYfyp6SiqwXZ
         kUvETzVRg+42nubjdeakJtgY5cFn/Pbs4gEC9tUlQhw0gfnUFNIpk4627TK2PgnoP7Wd
         +IpTEfmrQ9PdkRA9nLMwnKhjk22+Z9WKAk4om1lw9rb4bXztlNfFWezG7h1Nb/e+vJM3
         mqMQ==
X-Gm-Message-State: AC+VfDz5JUUJZS6m2rQx5IsoV4z4RMFUYu61FGSWATwdWRUhwwNbEjjF
        tXPcmIcaI1krbceRlFcGmrNfiymC0qg=
X-Google-Smtp-Source: ACHHUZ7GLlRlwX5oEEBu7AORsZtwhmk7wfFiOOh86s6miDcI1oJ0SnAmdWFI3rHva1rt0YrYwq2neA==
X-Received: by 2002:a17:903:2012:b0:1a0:50bd:31bf with SMTP id s18-20020a170903201200b001a050bd31bfmr2081928pla.32.1682620800061;
        Thu, 27 Apr 2023 11:40:00 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001a6ef7bd435sm11969011plb.104.2023.04.27.11.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:39:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] add an external testing library for unit tests
References: <20230427175007.902278-1-calvinwan@google.com>
Date:   Thu, 27 Apr 2023 11:39:59 -0700
In-Reply-To: <20230427175007.902278-1-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 27 Apr 2023 17:50:05 +0000")
Message-ID: <xmqqr0s5jhj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> ... Unit tests additionally provide stability to the
> codebase and can simplify debugging through isolation. Turning parts of
> Git into libraries[1] gives us the ability to run unit tests on the
> libraries and to write unit tests in C. Writing unit tests in pure C,
> rather than with our current shell/test-tool helper setup, simplifies
> test setup, simplifies passing data around (no shell-isms required), and
> reduces testing runtime by not spawning a separate process for every
> test invocation.

Good goal, except that unit tests are not panacea---our ultimate
obligation is to give a stable behaviour to the end users and
end-to-end testing is still needed.  We would benefit from having
tests at both levels.

> Unit testing in C requires a separate testing harness that we ideally
> would like to be TAP-style and to come with a non-restrictive license.
>
> Fortunately, there already exists a C TAP harness library[2] with an MIT
> license (at least for the files included in this series). 

Yup.  Consistency with our existing test framework would make it easier
to adopt for all of us.  Good goal.

