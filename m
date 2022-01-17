Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36603C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 13:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiAQNHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 08:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiAQNHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 08:07:48 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCEC061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 05:07:48 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id 2so5535572uax.10
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 05:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pLWlLFvHSp5fZ8E9DIdTvW7rhekM7O1fVhlSDI/1tN0=;
        b=ZnepJXbF4ooYn0YWOgRDoowl0qdjTb3j3YCv992IdrWWDwss9TQIor3emHwgJslQim
         KP+vnTK6mKNkobXyzudfENX/5zucTFWsB4jDUGDUdxVesRgZ7QlqXCMwmgDvUBVcNwS1
         me1pO48yGtDLyS+Z5Lj5zJemoLiHPB1F1MkBFKNiu/ADdbCqKX/QonUfyzkB4Tyr/s+X
         YbOz0R8Xh/OLlwqSmL/Zz2B0zqeBXckVy1+zwadOu2AwdCONUw9m8ICQhXMi1q3/aNiW
         y3K0x2ajGSqLwBfQJ8FGoT8uypspnYSyAY1YkYmiPyYgLmyK8MsnWxdBhl9xNiRFnd22
         +pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pLWlLFvHSp5fZ8E9DIdTvW7rhekM7O1fVhlSDI/1tN0=;
        b=KothzRBgwos+6GxIN4yCrwWlgMU2waNSS5pkg+mkUODSVUSwQQ5AlEnaAByQKVmHFi
         qJ4ps+kudVYhx/RFXa8xMnhHKol49vu9uqemneS7E9MonySVyY0rqGGxZ0Rj+Jbh5ZiL
         BcQa/6dkxo96Z3HlzGgxZPExLZr2DAGtoui3NmHypk0h8JdPKTTatUK8HVIXVIZmyf5r
         UdHsm9tbHh/i9g5TmzZ7GZmNZj2smlTRsYpJSuBqk+LdbbsWRUhQbvcR9Q9PDQVahnmt
         KgbNZNgL79K7UfkG3UFjQdI+rOfA9CmG97HzDBsSv5+mLX2FaPZuwc0Rqy9kR9RYhVmM
         mkBg==
X-Gm-Message-State: AOAM5327hFqE2VmYjA7QM9MLEgqm9Ueul/c57eH4VHXOrrixabj6Ohgk
        1QkLk7FTdVv/Cn9K+rF2xnwdAPevAhQbo+As3bQWXQ==
X-Google-Smtp-Source: ABdhPJxpM/H458eYulb2sk1atyJDh3mPGYFSzemA02gx2CFksNZTr5381GJzzVVs6+1uanh/bLTmSA7PfofBV/TOnkM=
X-Received: by 2002:a67:df0c:: with SMTP id s12mr7188494vsk.10.1642424866943;
 Mon, 17 Jan 2022 05:07:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1188.git.git.1642092934523.gitgitgadget@gmail.com>
 <220113.86r19btv5a.gmgdl@evledraar.gmail.com> <xmqqy23jh2h3.fsf@gitster.g> <xmqqtue7h0dd.fsf@gitster.g>
In-Reply-To: <xmqqtue7h0dd.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 17 Jan 2022 14:07:35 +0100
Message-ID: <CAFQ2z_PNRb6HLUD81=_HkRrX0cMLfzz4NmVJaTUQ37EC61MXbg@mail.gmail.com>
Subject: Re: [PATCH] reftable: avoid initializing structs from structs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 9:00 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Would make sense to steal the compiler version etc. details from my
> >> <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>. I.e. eventu=
ally
> >> we'll be able to change this & other code back, as nobody will care
> >> about that older compiler version. It worked before in the pre-image o=
n
> >> a more recent xlc.
> >
> > If so, wouldn't it be a better option not to worry about such an old
> > compiler at all from the get-go?
>
> The above was a genuine question.  If that "nobody will care about
> the old compiler" will happen only after a few years, then it may
> not work to just ignore the version of xlc which might still have
> a meaningful number of users.  I just am not in a good position to
> judge that.

I'm all for not worrying too much about ancient compilers, but there
is no downside to this patch, so it seems fine to let this one go
through.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
