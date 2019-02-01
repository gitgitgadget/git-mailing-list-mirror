Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C991F453
	for <e@80x24.org>; Fri,  1 Feb 2019 21:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfBAVtn (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 16:49:43 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:36543 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfBAVtn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 16:49:43 -0500
Received: by mail-qt1-f178.google.com with SMTP id t13so9395832qtn.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 13:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFZ/mZ3cCF4FcIvayzlvYNz2V1EPmwoy5n2TuVf70bk=;
        b=BKyFFFVNvJUk3K/xcJS6PZVi44Aanxt7+NikFC6f1IepvG9XmbuCpuG7c4zfRXITM8
         wE/HVrCKyqgKOf1V7wsl8sG/MwfW2Kd8JGzoQV49Dfzf4xOfttZr9+D4QZWgPpKYjn46
         oX3uJz9BXIJeEBExR6OKAtuju6ub9/NwwWYP9Wt4NGI9C5kH3Lw6dw5G9ow7J/ipxhDn
         PcC73BotvWt8aFxjQa72Nt20FHgIZXPE5rmw9Ll+vlwCd0ogY6S+ts0PAgegYNdyN6nK
         oaabAtx5aZxxBFF7B7P0OAia+X73Z2UmgPSO8+VrJWvyY1sHAwOor2nIglACgYnKUjkU
         Ye0A==
X-Gm-Message-State: AJcUukexr+QerEFuPvJ5opZtuERAXdsj+Kc5RWQX3+Zql2AhhQcVzMtn
        USVC+x2OUH4p203Hu4WsCbP9nZVFTL7eop0bUcSCw9Eh
X-Google-Smtp-Source: ALg8bN6AQB8evQmSTzN8N0F8cTyUTS5/8MLD7+q3MAFm7pw+aShzTBeky88iClHgjaXe5rtvPK4BAARfPqSnLxi7zLA=
X-Received: by 2002:a0c:981b:: with SMTP id c27mr39939879qvd.184.1549057781432;
 Fri, 01 Feb 2019 13:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20190130114736.30357-1-worldhello.net@gmail.com>
 <20190201162152.31136-2-worldhello.net@gmail.com> <CAPig+cRX=ttHWe1C6m1u9-02oT-TpBtHWb48N=-wX4jSYaFuew@mail.gmail.com>
 <xmqqva23xlun.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva23xlun.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 16:49:30 -0500
Message-ID: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] t5323: test cases for git-pack-redundant
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>, Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 4:03 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Fri, Feb 1, 2019 at 11:22 AM Jiang Xin <worldhello.net@gmail.com> wrote:
> >> +# Note: DO NOT run it in a subshell, otherwise the variables will not be set
> >
> > Which variables won't be set? It's not clear what this restriction is about.
>
> >> +# Note: DO NOT run it in a subshell, otherwise the variables will not be set
> >> +create_pack_1 () {
> >> +       P1=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
> >
> > Which variables? Note that you can capture output of a subshell into a
> > variable, if necessary.
>
> These helper functions set a bunch of variables $P1, $P2, etc. as
> well as variables whose name begin with P and followed by 40-hex.
> The script wants to use them later when preparing expected output,
> and with the most natural way to organize the code, that "later"
> happens in the process that would have spawned a subshell to run
> this function.
>
> It would have been easier for you to grok if the note instead said
> "this function sets two global shell variables" or something,
> perhaps?  Such a variable would certainly not be visible if this
> function is called inside a subshell to the main process.

Yes, better function comments would facilitate comprehension both for
the reviewer and those working on the code in the future. For
instance:

    # Create commit for each argument [...with blah properties...] and
    # assign [...] to shell variable of same name as argument.
    # NOTE: Avoid calling this function from a subshell since variable
    # assignments will disappear when subshell exits.

or something.

But, looking more closely at the patch, I'm wondering why the various
create_pack_#() functions are defined at all since they are each only
ever called from a single place.

    create_pack_4 () {
        ...
        eval P$P4=P4:$P4
    }
   ...
   test_expect_success 'create pack 4, 5' '
        create_pack_4 && create_pack_5
    '

I haven't been able to convince myself that this helps readability --
especially since the function definition is often far removed from the
single point of use -- over merely inlining the function body directly
in the sole test which calls it.

Anyhow, this is all pretty minor, not necessarily worth a re-roll.
