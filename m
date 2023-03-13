Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69FEC6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 21:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCMViL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 17:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCMViJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 17:38:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D50ECA12
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 14:38:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p6so14548572plf.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678743487;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ezDQA4p4o/aBC6YW/CwynPs2gKMXDuU+7dDjEGQTkY=;
        b=BhpZXoLtkxBcVfB7kln+vOsoYGyfNqYKJUMEGM0Zgz1U6uXjNtHf59u8EWuwyrwZpq
         H+cvKDA4SqAV8aPrvqTgDwj3+bL+mryWMPqP5Of87lAexog3qcDDC55uCSEIBF+pCTcd
         Pf3mMggSTxcplujTsFwSbuCXeTCfm5K6FzD/WKsU4ynrAj9npE+r3y8wycDzPMJdsfvE
         tNe9xU9+WnSp0SFdTUerl88NpxV3WQB3kfzd89EZBNTsqqgeKHYjUaybN+rdg2l32qem
         hE1YBmszI6q8SX+fXnNAcSm9Bq3VOlQCCyoMmXIfnHOuztD4xktjEBs34Q2WH2a1NWOn
         EXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678743487;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ezDQA4p4o/aBC6YW/CwynPs2gKMXDuU+7dDjEGQTkY=;
        b=NpwCZo+KM1xwyBTU0Sn+0Uv3bcfpAdJix7AO6OBla+MZVPhIq+Iv3e344KbqW7Kw8C
         rWx2W6WuGHSu02/CeiWmUPyEvMc7Va//vkcY2UFEM75ymhU9ktbdmjcqElax/rEYzxwh
         MMXOVSXoyz1fKWm2bs7U/nPPGhWE2gf3hNqsUAcExrdMNhTGSYERle1zFQCFuatHjK8K
         Dcp3FH5G7brv/8c4dzMDY8P4jYMwL67wBkuepwor0FZZCNdW8rJ1y3aiCTKxlwbPmL1e
         O6LbVKsuzv6je3a98E5omnMfoazcL5E4EEJ3GrXnqPPSPGZiL0h0cdpgBn0T5dsoIvKH
         O/TQ==
X-Gm-Message-State: AO0yUKU6fRrlZuLW0/dplwrDjvW+SYeI1Ad974peVn3+r5vU5eJYew9K
        o2woKN+AqnGqxUYVeQXdtlLdy7S9mmI=
X-Google-Smtp-Source: AK7set8wmrSyMOH7MkfZAGgWM3tWS9ilm+cusUqE/RZSVIjQPp8YQmgGw8Rt6pU3kaXawdGG0EscZA==
X-Received: by 2002:a17:902:d4cc:b0:19d:af20:3fe8 with SMTP id o12-20020a170902d4cc00b0019daf203fe8mr43828661plg.21.1678743486977;
        Mon, 13 Mar 2023 14:38:06 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b00195f242d0a0sm291883pla.194.2023.03.13.14.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:38:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v1 3/7] t1010: assert empty output of mktree
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
        <20230312201520.370234-5-rybak.a.v@gmail.com>
Date:   Mon, 13 Mar 2023 14:38:06 -0700
In-Reply-To: <20230312201520.370234-5-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Sun, 12 Mar 2023 21:15:16 +0100")
Message-ID: <xmqqsfe8s56p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

>  test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
> -	test_must_fail git mktree <all >actual
> +	test_must_fail git mktree <all >actual &&
> +	test_must_be_empty actual
>  '
>  
>  test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
> -	test_must_fail git mktree <all.withsub >actual
> +	test_must_fail git mktree <all.withsub >actual &&
> +	test_must_be_empty actual
>  '

I am ambivalent.  As long as a failing command signals its failure
with its non-zero exit status value, the consumer of the output
should not blindly use the output from such a failing command.  Is
there a strong reason why we want users rely on the command to be
silent when it fails?

An obvious alternative is to stop producing "actual" file, and it
might be a better idea; unless there is a good reason why we should
expect the command to be silent, that is.

Thanks.
