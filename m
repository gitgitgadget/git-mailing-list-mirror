Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD21720248
	for <e@80x24.org>; Mon, 18 Mar 2019 02:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfCRCEB (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 22:04:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46529 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfCRCEA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 22:04:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id 33so15252899wrb.13
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QXfDrt+kfAVt1GzeB7gjAtcFWQpR+keV4/bhJ52V++c=;
        b=U1Nrq1mb3TR3tzHgUaPKqPRXBSFPqb460HekZxkDi2/D02YU8J4dMT8mvRAK/whhU6
         HxJNWb/BI0XDxhGKxAz10Uko/5JDE9vTW0UZJiic0Tm/BJCSLbWHAOv549rJizM+wpog
         6nmMUblScr8Zh+qZaiLi24kzU00z8VgACjMp85X8xYQah+vRialYQXZh/uTMjBsKIvzz
         MfGr3CBLVo/MJyuqA5EycAFqplGLc1COxV3bhNJ2gVvK5k712Wb0YNtLDE2Sd2X6EMYS
         XLBb57Dk/neubqg/os2xD6Zbz53v89PGz+Hnt3wzDv78LdCYwsdxiZAjkwjdFTKK3mmr
         ByHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QXfDrt+kfAVt1GzeB7gjAtcFWQpR+keV4/bhJ52V++c=;
        b=IX3aVpn433+eSfPXMNOAb7KF7sQeuytJx67m5xEmfwc046C5TK897qnudWNXacpSdT
         o1xP34VCefmuwUjkYTmii3QO2AU8OidzeYkyqYwpLceOYAZmegebCuTnx0BoL/fbhOfe
         UEYIcPLnAeadtYh/9/8yHmHlKOFDTB6diyQgARNFds4ghLNz4xWpYEKzQBeLBIWQu1Nl
         k1SZ/L0CosWCu/MtNWwUn40KSWt9Dd5ai7YOyEqu7JwZjlMROfCniAOlFTJFaa6B9e5H
         2QGXJuUXrEnpNmgkRvYBS085z2AwCCy3uOcrzcPf30OJy9JqoSKr1TeGyNbpiAth9rEH
         GewQ==
X-Gm-Message-State: APjAAAVNbbWEtlBEvTPypgK86/+YeBjqF2pH5pbg6fIHjvt39yqv9DM+
        nyP6VdiNrybPM9XuY9jZvPM=
X-Google-Smtp-Source: APXvYqzO6Up1XKATtTuHL6XiUxBjtdD2TaCjV/UhHZ3kBWxPpczTvdJq/L08cAgg63t/SsfujasYlw==
X-Received: by 2002:adf:a10b:: with SMTP id o11mr9740375wro.91.1552874638843;
        Sun, 17 Mar 2019 19:03:58 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g8sm2273698wro.77.2019.03.17.19.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 19:03:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
References: <20190308095752.8574-1-pclouds@gmail.com>
        <20190308095752.8574-11-pclouds@gmail.com>
        <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
        <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
        <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
        <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
        <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
        <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
        <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
        <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
        <20190314091753.GA9852@ash>
        <CABPp-BF3_p3+fmQcWYEu2z3J4FfPmDmiMyFiBRXyz8TxKLL7jA@mail.gmail.com>
Date:   Mon, 18 Mar 2019 11:03:57 +0900
In-Reply-To: <CABPp-BF3_p3+fmQcWYEu2z3J4FfPmDmiMyFiBRXyz8TxKLL7jA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 14 Mar 2019 07:46:51 -0700")
Message-ID: <xmqqr2b56ir6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I don't see why <start-point> even makes sense to use with --orphan;
> you should error if both are given, IMO.  The point of --orphan is to
> create some entirely new history.  So, I'd expect "git switch --orphan
> <new-branch>" to:
>   * not create refs/heads/<new-branch>
>   * set HEAD to refs/heads/<new-branch>
>   * empty all tracked files from the working tree.
>   * empty the index
>
> Alternatively, you could allow <start-point> to be passed with
> --orphan, adjusting the above steps so that both the index and the
> working tree are switched to match <start-point>, but ONLY if
> <start-point> defaults to the empty tree when --orphan is passed.

Do you mean that it's like <start-point> is not really a start-point
but is an initial tree, i.e.

	switch --orphan --initial-tree=<tree-ish> <new-branch>

is a mere short-hand for

	switch --orhpan <new-branch> &&
	restore --from-tree=<tree-ish> .

I think that does make sense, but at the same time, I think a major
reason why people say "checkout does too many things depending on
the arguments and conext to be easily explained" is exactly due to
its many "if you give X, it is like writing this longer command
sequence" short hands, so...

> How about:
>
> """
> Switching and creating branches always involves knowing the
> <start-point> to begin the new branch from.  Sometimes, people want to
> create a new branch that does not have any commits yet; --orphan is a
> flag to allow that.  --orphan overrides the default of HEAD for
> <start-point> instead causing us to start from an empty history.  The
> use of --orphan is incompatible with specifying a <start-point>.
> """

With or without the short-hand to say which initial tree to populate
the index from, the above description makes sense to me.

