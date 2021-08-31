Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039D1C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F026109E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhHaUK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhHaUK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:10:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D308C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:09:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i6so1014472wrv.2
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gRB9XlvF8bwiwl/Sup0ubk6ua4j0xBxZBNhVmH5jfjU=;
        b=kdUyAMWPbsyYA5B0lhalt7DAcglJb9mMKD+jB+D1Q813ljwu7R0k5U6ZwUjUWm9oog
         tNRyi2oPTfhfDSLvaAwBufA+fnlVQL824UqkFNruH/e5Hjw6+4NwoeYaZdh0QnXjfRwC
         LSwYSh94yA6RudaC/w4T7NW8tGYhtU+zXpai6lca3hcmiQ4usSKALeiIQhfYlc4bgaeA
         1d6wKIUY+QHIjWcojOTmUfB1BahVzGRRqXuZyweMDGP8IAgJ0YXWsXICk5PGUEykl5E6
         KVuZdWgkS9aL+KbFqP0Z4q/R2gTnHbbhwIDkB7BUoiL9JhDgdlzSzoiNb1BshjN29n9l
         Zjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gRB9XlvF8bwiwl/Sup0ubk6ua4j0xBxZBNhVmH5jfjU=;
        b=SBL6aq/gxo5rWA/y80OFElx+cYbda76IMG6h3yWQBbv1OE4KS46YBN7Wwgi5iVRZx9
         M9cPFFyPu6EWZpPgVC4RxZOksacP3RODzdta5LIFDpyvHQjpLoeRq9jjUQpQqsGuPblO
         l8IM69h98U/D8n+MCJi1oUy2RI5CpK2lg13lor2FuLc7jDVXWKx43px+ZNcTMKi8Gyry
         ezobgR96eCii1tpKvFu/fYuJYO8ZecbSePrQyeCOJxdbQkcDRxCbNDn+11S0ypOrMFSF
         O7v8g76HxJ6+OuLNz6f7NCNoA4lqOhNU0qjBJaNij+pJ8f4tdCjeXtUjHdHgIR4IvyFO
         8XsA==
X-Gm-Message-State: AOAM532Ew9VNkju+rtN8QnBB31HoCAfSOqTu3M7847UmEhiP/UYI0NX8
        v4UuAecC3bCMBgz4nzPps1RAunRcbNt/VA==
X-Google-Smtp-Source: ABdhPJxYFRICwMIWKQe6fRjXy5g+KPS3xpofudaY3Y+BORpMKrSeNkRlnufqPrhwAIRfdozO2NCODA==
X-Received: by 2002:adf:c3c9:: with SMTP id d9mr32074102wrg.339.1630440568841;
        Tue, 31 Aug 2021 13:09:28 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b10sm20438396wrt.43.2021.08.31.13.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:09:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bruno Albuquerque <bga@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] protocol-caps.c: fix memory leak in send_info()
Date:   Tue, 31 Aug 2021 22:08:43 +0200
References: <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com>
 <patch-1.1-9acbc21cdd3-20210831T134632Z-avarab@gmail.com>
 <CAPeR6H69a_HMwWnpHzssaCm_ow=ic7AnzMdZVQJQ2ECRDaWzaA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAPeR6H69a_HMwWnpHzssaCm_ow=ic7AnzMdZVQJQ2ECRDaWzaA@mail.gmail.com>
Message-ID: <87k0k1wf48.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Bruno Albuquerque wrote:

> On Tue, Aug 31, 2021 at 6:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
>
>  Fix a memory leak in a2ba162cda (object-info: support for retrieving
>  object info, 2021-04-20) which appears to have been based on a
>  misunderstanding of how the pkt-line.c API works. There is no need to
>  strdup() input to packet_writer_write(), it's just a printf()-like
>  format function.
>
>  This fixes a potentially large memory leak, since the number of OID
>  lines the "object-info" call can be arbitrarily large (or a small one
>  if the request is small).
>
>  This makes t5701-git-serve.sh pass again under SANITIZE=3Dleak, as it
>  did before a2ba162cda2.
>
> Thanks for cleaning up after me. Yes, this was my lack of knowledge on ho=
w the internals of Git works. I was also not aware of SANITIZE=3Dleak so th=
anks for
> the heads up. This looks good to me.

Thanks, for what it's worth the series I submitted in parallel to this
to add a SANITIZE=3Dleak CI mode at
https://lore.kernel.org/git/cover-v3-0.8-00000000000-20210831T132546Z-avara=
b@gmail.com
could use reviewers :)

I.e. having some real tests for this sort of thing and running them in
CI will help to catch any such issues earlier.
