Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB81DC433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 11:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF7464FD7
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 11:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhCJLd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 06:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCJLc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 06:32:56 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D196C061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 03:32:24 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id l8so17449085ybe.12
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 03:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tj6RBRz48EAhEvpDSIFvmemp3F29hB3gbLIIvu0zVUA=;
        b=ZpSwishquV30fHFNoXM5R6kKbszvZoMI+88cK/k3SQP04qJjvH9T4EAlwa9oFzNRij
         2SCW/QVqrb45zwm91zC9HxSj7vYkK4YwfFJQly38LLvrtlMSg5ScTxsEtBa/1EAJE8V+
         0BcI1WdDy6gQdH6PV855DNshNqnWhLFAb0m+XTd3AnfVh0S+2oKLQQTwlmLz0FCTpwF3
         S0k4v3h4xrX58YEgL4qkwNlEdar5NsQmN0TTjz5OUl1uRx/iyxi2GS3+FaGeYY5sC+MR
         Y+fMalGZzXqyTsSqg3M9Wjm6J0OlCfDRgZC/GT11YFmfG29tN+cQJ5+6I7ViM6QjdOWb
         pJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tj6RBRz48EAhEvpDSIFvmemp3F29hB3gbLIIvu0zVUA=;
        b=Vfu08JzyH4Rp/8CyxWH6BzbTe8APpdlNm7YeAC7pa4k0tYTaCyTV5egoXWZ6oF7UVU
         0fj85YxVAl3RbFVJ8s8qeW5Cywi/YwSnAm4stTtijTwV5wg4btKdchxd4+ZF0Kfp8YZd
         LLoSZvB187IC+Bov1bP0f7CwlsKRC4UqHPId1jfOhj2iGq4FayZXSPgfPV4K/tdaTS5t
         vVzHYWxoRioYP2QK2x0SGanxgGqHajWhilWjEblSEJdlNsWuxVmbS7Sk/4UsMp+REoJm
         jcKMMoiVikheIx/71Rw4aY9VooPaAxUxjEucZvNy5GQs5AgC7ODhD+oodGiIf/VDVIsa
         MwJw==
X-Gm-Message-State: AOAM533Wu/xZyx31vbQNloa7J+BzRAULcfcM+1lebFiSPGnReJ3XKua/
        yZudnTTFSokquQv/kfRQ1+vo+kdfGXt3HlRa2jIXgP3JMNo=
X-Google-Smtp-Source: ABdhPJzUF/3K5MoFjReAmKyXxf7zH8vZO2REWavYC9kPdYGikfRjJg/NWRUAX3gXKR/bQQTEB77dFMuSfkpeMmCGGNc=
X-Received: by 2002:a25:bc4f:: with SMTP id d15mr3221101ybk.41.1615375943491;
 Wed, 10 Mar 2021 03:32:23 -0800 (PST)
MIME-Version: 1.0
References: <d536f4fe-a857-0307-db3b-139ff4ff25b2@gmail.com>
In-Reply-To: <d536f4fe-a857-0307-db3b-139ff4ff25b2@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 10 Mar 2021 19:32:12 +0800
Message-ID: <CANYiYbFFwBXFEJwAd4ft7A-KLMrfjd0+Cw+An0oo0VbC3TJp2Q@mail.gmail.com>
Subject: Re: Core translation should be documented on po/README
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> I had learned the following when I submitted Indonesian translation [1].
>
> The documentation at po/README missed mentioning about "core translation"=
,
> which IMO is minimum translated messages needed to complete the translati=
on.
> So the l10n coordinator had to instructed me to complete it.

When we started l10n for git, there were only about 700 entries in
"po/git.pot", but there are over 5000 entries now for git 2.31.0.
Providing a complete translation is not a piece of cake for a new l10n
team. So, I defined a minimal l10n template based on source code for
some daily used commands, such as wt-status.c, builtin/clone.c, etc.
The first contribution of a new l10n team should cover this minimal
l10n template, which I called as "core.pot" (I'm not good at naming).

It's a good suggestion to add notes in "po/README". But without a
helper, it is hard to describe how to generate the minimal l10n
template. The personal used helper "po-helper.sh" may have bugs, and I
want to rewrite it to check author date and committer date in order to
prevent unecessarly calibrated the corrected committer date in
commit-graph.

>
> To translate core messages, I ran `po-helper.sh check id.po` first and
> do the translation work on the generated po/core-id.po. Next, I merged
> po/core-id.po to id.po by `msgcat`, however he didn't tell me the order o=
f
> PO files to be passed to `msgcat`, so AFAIK I `ran msgcat core-id.po id.p=
o`
> and fixed "fuzzy" errors (such as misplaced translated messages).
> I think these above should be mentioned in po/README.
>

I think the order of PO files to `msgcat` is not important, commands
are as follows:

        msgcat <input1.po> <input2.po> -s -o <output.po>
        mv <output.po>  XX.po
        msgmerge --add-location --backup=3Doff -U XX.po  git.pot


> NOTE: po-helper.sh can be found on po-helper branch of l10n coordinator
> repo. [2]
>
> [1]: https://github.com/git-l10n/git-po/pull/500
> [2]: https://github.com/git-l10n/git-po/blob/po-helper/utils/po-helper.sh
>
> --
> An old man doll... just what I always wanted! - Clara
