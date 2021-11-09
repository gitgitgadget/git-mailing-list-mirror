Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D516AC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2076610F8
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbhKICD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 21:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbhKICDY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 21:03:24 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB9C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 18:00:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m14so69667748edd.0
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 18:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wcNWjXK705uegavO3BOwz52W0qeymqjb/pT2yjGVzMQ=;
        b=FuuakudoTwCOjvQZXtXdznJ4PwR7i5gyB3SIaUUoqDgRj4rcq/uRMLRlrAG37vbMeO
         kYxIhJvdpRjTRTiSV/3ePZ6lv2Skc5IauO0unxM4QKY5Cy5NwrTbyWw3miN1TdIxKgdq
         +I5qFgkCAR/DA/u2ipAqbWfnoNqdWgE9E4AA5QVDAGnEbzP3KDUrjybMgKZ1xhcQUc9n
         OP2N4UGfFGyZjIdlN5L/YrOjknbkD4J+nBu+EchoxSKzl7k9KiQBLTO19nyBHCOOqMkB
         0zT7fKpeqWWeaBrG8ykKharkFVI8aGTH5T5FBYBKQ0GSE+zNLGcTrnM9ViaV5fyUCiT8
         plQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wcNWjXK705uegavO3BOwz52W0qeymqjb/pT2yjGVzMQ=;
        b=JmZWPz8273fRP7S6bIL0bZdzrZNIMkv9XL78midn5gCdqhglKpIKBX5eEsgVguJD6V
         kwTF2A2KeSd5t4FjBHAf3FVE8LNKH3TIND6/GKqFCecGRgN9kAo2m3iKM+Q54wJw7ycg
         Y2vTTe1zX0o5zt3VCbbHp5HQoRxF6b4rYt6ojeDxPOvPNpfwoUybqblJ5bO1x+dZOVl7
         spDwqRZVxnVcyAxXFiydGPtuFak9jbqn5BtHbD4ulLdsf/wO9DXyE8xHW8JpFulv8cN7
         NRzvDxc77YyyGtRkHuJkWG4li29RetsjPnS9GPmkUFAoXKfiG150SRmjL+B6QN67ouvI
         RtLQ==
X-Gm-Message-State: AOAM533kGWK8Se++nWBxzQO6GdUVCeUAiXk94gnyJqFIeQDAF1ka7syt
        vP2o6e0192HZnAspuGosSq4=
X-Google-Smtp-Source: ABdhPJxqh6ionA9drjOExeH6ofM+sh5IVhvCIS97RYEKxBmMqtbndNPiblKG+pfeFhMmmFCmes0gvA==
X-Received: by 2002:a05:6402:5242:: with SMTP id t2mr5128667edd.27.1636423237855;
        Mon, 08 Nov 2021 18:00:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ec38sm10246697edb.40.2021.11.08.18.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:00:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkGRA-001JDy-Vb;
        Tue, 09 Nov 2021 03:00:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH v4 2/2] http-fetch: redact url on die() message
Date:   Tue, 09 Nov 2021 02:54:42 +0100
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
 <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
 <c7f0977cabd4ba7311b8045bc57e9e30198651fd.1635288599.git.gitgitgadget@gmail.com>
 <211028.86sfwlw10o.gmgdl@evledraar.gmail.com> <xmqqpmrnfmiv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqpmrnfmiv.fsf@gitster.g>
Message-ID: <211109.86ilx2dr5n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> +			if (!git_env_bool("GIT_TRACE_REDACT", 1) || !nurl) {
>>> +				die("Unable to get pack file %s\n%s", preq->url,
>>> +				    curl_errorstr);
>>
>> small nit: arrange if's from "if (cheap || expensive)", i.e. no need for
>> getenv() if !nurl, but maybe compilers are smart enough for that...
>
> They typically do not see what happens inside git_env_bool() while
> compling this compilation unit, and cannot tell if the programmer
> wanted to call it first for its side effects, hence they cannot
> swap them safely.

*nod*, but since that function is just:
=20=20=20=20
    int git_env_bool(const char *k, int def)
    {
            const char *v =3D getenv(k);
            return v ? git_config_bool(k, v) : def;
    }

I was hedging and pondering if some compilers were smart enough these
days to optimize things like that.

I.e. in this case getenv() is a simple C library function, the env
variable is constant, and we do a boolean test of it before calling
git_config_bool().

So a sufficiently smart compiler could turn that into:

     /* global, probably something iterated over env already */
    static int __have_seen_GIT_TRACE_REDACT =3D 0;
    ...

    if ((!__have_seen_GIT_TRACE_REDACT || !nurl) ||
        (__have_seen_GIT_TRACE_REDACT && git_env_bool_without_v_bool_check(=
...)))

But probably not, since it wolud need quite a bit of C library
cooperation/hooks...
