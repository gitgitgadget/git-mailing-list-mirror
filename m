Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308A7C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EEA604AC
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbhIGMel (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhIGMek (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:34:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048E4C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:33:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id jg16so19375053ejc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=B2knAvCnRKI99BpRlmDBLu8XBckplJ6cRE9ohZjlgBw=;
        b=XoFaq4a3scEfQH5jCvYUbWBZJ4f5VvAoiJg/JM/lbfisNI9QnzUwmH3qeZ/NRWpnm4
         lg3Jant4+K21ONNrljBv8mLI0rH5r9gcc7Ou8YEUxkh78vrOk1eItdA3XsNMWCJOLp/0
         vVTgKIQRQuz3HWuRmRe+nN/YkK9RfwJCWvJN8xMSkGXrYJc2hnjmV5LE8/Z0kE4xtoeq
         Du6wb3qknkGj/JfftNagag8QWwh2i84rvDJpZSeAr4gXbxl/Sij3blbgjYZAp2aLHTQF
         wR9OOTD7Ns+VHmEGeY4vjWhoZuY8W3kTsckFZx8hBeSKOtx8T+ebJoJIRBAbcmic+Dbf
         Ugow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=B2knAvCnRKI99BpRlmDBLu8XBckplJ6cRE9ohZjlgBw=;
        b=dUtNtueE7fIkbIFmC89FnuCKkGe+6SHRq6EzyxQYMRnWdLeSRIFzRV1XI6BuBxFlTG
         ZsHP11ZBUU6uq8Fo1S0RtU0O53RCIQ9053qvDq9BUhX5gdRAFNimm9+QvcJaepx/Fgm2
         IDJzRL8KskMuWUls58PzIwyPwfSgQ5OCuYpGltmyF+cRRUHOKhmlSzCDmf6E8gtXCJnf
         69XUpp/Sv3PSmVHxcvDHzgvq4RGXiT9EPUyYsTzJRlB/hoqlfNaK0Mze8PWRdkc4NjSM
         AtIS9FTouRFVrFTxMnkDSmH2fshbz/XBVKl7mAXUKpuUgFUT4I7N4AePLIh1V4thYcio
         4/sw==
X-Gm-Message-State: AOAM530Zcxew6MRfjXZi9eBAOCNbX0Vpb/6m2StFyMgow2Ug54FlVord
        HgT2Ew62A+Ju7GEBVLSZoPE=
X-Google-Smtp-Source: ABdhPJy7DTmcI7gasNvaLlcbBnj73wkn+XOkw+VLKOD7OBz4h2xzy7GfASLy7x9BR/q5GAi+E8SAuQ==
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr18288249ejc.196.1631018012439;
        Tue, 07 Sep 2021 05:33:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dc7sm6487863edb.46.2021.09.07.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:33:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH RESEND] bugreport: Add hint to answer questionnaire in
 English
Date:   Tue, 07 Sep 2021 14:21:20 +0200
References: <20210907104928.16099-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210907104928.16099-1-bagasdotme@gmail.com>
Message-ID: <87a6komup0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Bagas Sanjaya wrote:

For what it's worth Junio's sometimes behind on list traffic & it may
take a bit for interested reviewers to reply.

I had your [1] on my "to get to soon" list. No harm no foul, but just
for the future resending after just 4 days of inactivity & Junio not
picking it up is probably a bit much...

> Depending on system locale, git bugreport may launch the localized
> bug report questionnaire (and thus users respond it in their native
> language). However, many Git support forums (including
> git@vger.kernel.org) expects bug reports written in English.
>
> Add a hint that answering the questionnaire in English will increase
> chances for bug reports to be responded.
>
> Fixes: 238b439d69 (bugreport: add tool to generate debugging info,
> 2020-04-16)
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>
>  In [1], Junio suggests to add hint for filling in bug report answers
>  in English. That stems from my responses to Krzysztof =C5=BBelechowski's=
 bug
>  report [2], which advise him to re-submit the report in English.
>
>  [1]: https://lore.kernel.org/git/xmqqeeaiodxc.fsf@gitster.g/
>  [2]:
> https://lore.kernel.org/git/22496693-cf63-a278-c85e-d9e4376e2a59@gmail.co=
m/
>
>  builtin/bugreport.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 9915a5841d..56ccd0fc41 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -96,6 +96,7 @@ static int get_bug_template(struct strbuf *template)
>  	const char template_text[] =3D N_(
>  "Thank you for filling out a Git bug report!\n"
>  "Please answer the following questions to help us understand your issue.=
\n"
> +"Answering in English will give a better chance for your issue to be res=
ponded.\n"

That sentence seems to end abruptly, perhaps "to be responded to"?

I think per [2] (and while I remember that original discussion, I don't
have a link handy, having it in the commit message here would be a good
addition) we explicitly wanted to be friendly to reporters.

I.e. sure, if someone's bilingual and can just as easily fill this out
in say Russian and English we'd of course prefer the latter, but if
they're struggling to submit a report in English having it in Russian is
way better than nothing. There's always Google Translate, other list
members that likely speak the language and can mediate etc.

So perhaps something like this will be better:

    If you are sending this report to the Git mailing list its preferred
    working language is English, so if you could fill your report in in
    English that would be preferrable. If you feel that hinders you feel
    free to submit it in whatever language you're comfortable with, the
    list will try to figure the issue out anyway.

The "if you are sending" is also important here, i.e. the manpage of
"git bugreport" states that you *can* send it to the Git ML, but the
tool itself doesn't assume that, and e.g. one might be sending this
report internally, or to a local package maintainer.

So having some matching wording here would make sense, we don't want
this to start recommending that you send reports in English, if existing
users e.g. documented this internal to their workflow as "send this
report to the local maintainer", and those users all use translated
verions of git...

1. https://lore.kernel.org/git/20210903115823.622715-1-bagasdotme@gmail.com/
2. https://lore.kernel.org/git/xmqqeeaiodxc.fsf@gitster.g/
