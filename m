Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAEBC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 09:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiJCJMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiJCJMH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 05:12:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590B29811
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 02:09:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kg6so5380852ejc.9
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=VldTSlCN+igckWadjJxiW+TTeQgYmMSrQs2hOS9WHP4=;
        b=PtjPeMszNO4YOloMgvSigUw9UXy5LUF1PAgp/FP+Og+1mJBr1Sft9utvMpoet0lzeK
         BUgJheFzQHd44S/HrtKEAiae4nVTKcxOfb3dhADVxxAcbuGmn0zBDtOtk+gVrvZL10/a
         69Eshvki9Y2nngEmPe9qZFYlxiwzSxsC0Q98aJBH+TGTI/VkVAIs7CUnCqqfesa6w20m
         iYZAjiKBbv5hjQBvvKIKOmmfz8lbBwY8u1ATagCW1r0jQf4ewD+Ywi98u9GRAeZ3x9mW
         qIwlINzBpZ9y0D3UhNkNMjHa1iz5jP2MoYpZ42VNLnlQn+fGC7WTKUCALDlF1+JLwJQZ
         RTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=VldTSlCN+igckWadjJxiW+TTeQgYmMSrQs2hOS9WHP4=;
        b=WxMqwPA+tCB7v49SgYIqkdibMFBKpTmBVL89ohbERDIl6N3KE3Mx9O5CxYktWagx5/
         sKimowMzzI6DsSUkh7zMfL+iGjWEBP6n/GMupzXT3GLPbSfDbQw0y5V6Yj26aFZoxIXM
         laKWxu1KtuRkc0gSSYrL1i+2Lm1oZGC/x57KBYYuHTrojGw7LTDZJ/0ffbB+u9Tmfcy+
         kYS+/Hocku0vtOX+W4DROume4SbtRnPLg8z+PaD39zn2/85d+EMK3RXl5Z6G1wyCuFq3
         hWfgAAPYIbwl505BIGZoCNXcamXE3MQkwAU/ghTJeb1yoFqt2GkPwlXpZ5gx9V77eSOP
         gM0w==
X-Gm-Message-State: ACrzQf0pnSSAIpXETb7aIdMzlMcEj1xWeM+/ZTbSII2+XjccSfcdbuyC
        YQQvvVoZzEK6avgXynYn9Mw=
X-Google-Smtp-Source: AMsMyM5oPtRvpagJ+LiZwLxOJPdCsgXCpZUoEtExMPUo5IEcDk00EINJkdLBJWVNcaB7Vt94cADFZA==
X-Received: by 2002:a17:907:31c1:b0:742:28a3:5d08 with SMTP id xf1-20020a17090731c100b0074228a35d08mr14365502ejb.112.1664788185966;
        Mon, 03 Oct 2022 02:09:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090631cc00b007806c1474e1sm5047025ejf.127.2022.10.03.02.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:09:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ofHSJ-0020XA-39;
        Mon, 03 Oct 2022 11:09:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 22/36] doc txt & -h consistency: make "rerere"
 consistent
Date:   Mon, 03 Oct 2022 11:00:28 +0200
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
 <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
 <patch-v3-22.36-702eb747c0f-20220930T180415Z-avarab@gmail.com>
 <xmqqmtaf2xig.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqmtaf2xig.fsf@gitster.g>
Message-ID: <221003.86sfk5tgrs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 01 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> For "rerere" say "pathspec" consistently, and list the subcommands in
>> the order that they're discussed in the "COMMANDS" section of the
>> documentation.
>
> pathspec refers to the entire set of patterns, which consists of one
> or more "pathspec element"s, so there is no need for "..." there.

Maybe I'm misreading this, but are you suggesting that whenever
"<pathspec>" appears in the text the user should understand it as
"<pathspec>...", i.e. as is the case with the special-case that is
"<options>".

I'm not opposet do that, but I really wish we could avoid further
special-cases, there's no current user of "<pathspecs>" (with an "s" for
plural.

If you're saying that "<pathspec>" now should be interpretet like that
then surely e.g.:

	Documentation/git-clone.txt:--recurse-submodules[=3D<pathspec>]::

Should be read as supporting:

	--recurse-submodules some/path some-other-path

We could say that using it in that option context is a further
special-case, but I think this way lies madness, it would mean that
e.g.:

	git some-cmd [--option=3D<pathspec>] [-- <pathspec>]

would have "<pathspec>" mean different things in those two contexts.

We also have various examples of "<pathspec>..." meaning what it means
in the post-image here (including in one of the version of the "rerere"
docs):

	Documentation/git-add.txt:        [--] [<pathspec>...]
	Documentation/git-commit.txt:      [--] [<pathspec>...]
	Documentation/git-reset.txt:'git reset' (--patch | -p) [<tree-ish>] [--] [=
<pathspec>...]

FWIW it should arguably be [<pathspec>...] here, but per 5d2c3b01604
(rerere forget: deprecate invocation without pathspec, 2011-03-01) it
looks as though we want to advertise the other usage.


