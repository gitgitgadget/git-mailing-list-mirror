Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1359C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AC7613CA
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhE0OKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbhE0OKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:10:02 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDBFC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:08:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so310556otc.6
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TeeVzln51fDRnkKD/GgON5nc9bZi1HbkhYm3PFCt7S8=;
        b=c8+Bs4VXZjgKXCzbunyHRn69hUQQ48lmV9GQNcaxeBByonxk6BqzNiMKWb2OkxYe3F
         ImJLjYGusvURp9GqTqPy1ulvu61Xm9DF7U3SuB2SnX7WtjeqoFcX5d7nkxwpRfBCixYH
         SCrLqBEy4Vqc7OqF9pDuonCH9iNSB2BstL6wYiQDbd6muf69/PEvR0/xkNVHv+Et+7PB
         0u0ffGUILCCe4YguDTbPL+iisVOg+DwFb6bSsjnjNhxidvammqq3aG7/UDRQfx7CDBBD
         xVkVtTiRzWLbpGJkrSHC0nb5SZaqovcMzukADi6j1s63kKnL1ZSRnAmarQPBY8Ht7J2S
         at0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TeeVzln51fDRnkKD/GgON5nc9bZi1HbkhYm3PFCt7S8=;
        b=L9M6Su1tg+qdv/7YpZyAuqnB4+hezRCfSa7q+NdQJJRlbA3z6WlzEqEFGBP7hBqe6b
         P3KFX2j49b9o/6rQvws2Ou/OhIJmWYquCQvQkJmx07JFhZDoqX7xb5Bi4qtmuFpwrUwZ
         LzKL05SwzH28f5tHMi/9wd/toxUKAzk3TR7EjuzGIxFqo+QysbT6tehreTbAVDWK1sMu
         lndbqIcPDlutQG9ldOkHQh2FLvE8cY1vo8Lmwq1oE1zZxUwqfckLpb4As5t1yLTTvIrP
         mQBw6CUmQR8mieJC0711H+cV4T+G6ceU7LwKx24OASBAftxnhf5GKwgclM3sHafh37sw
         ztVA==
X-Gm-Message-State: AOAM531zAWxk9gHhA7Ym3KkfpTafQzOsipfqYWYAF3+MFBkK6zZFnNZo
        4AIEYb6b9kmzv2K2HqtmcKg=
X-Google-Smtp-Source: ABdhPJxS+d2lPSTD2VxG9kBnnXhsPhNaAO/xTTlzAeTF1oh6jRqRb9IdPHU03SflCXwGklc7lRF8mA==
X-Received: by 2002:a05:6830:1f52:: with SMTP id u18mr2869676oth.298.1622124506901;
        Thu, 27 May 2021 07:08:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m1sm501315otq.12.2021.05.27.07.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:08:26 -0700 (PDT)
Date:   Thu, 27 May 2021 09:08:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Varun Varada <varuncvarada@gmail.com>
Cc:     Robert Coup <robert.coup@koordinates.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60afa7d9d4ca_2056d208d9@natae.notmuch>
In-Reply-To: <20210527114629.GD8544@kitsune.suse.cz>
References: <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
 <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
 <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
 <20210527114629.GD8544@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Wed, May 26, 2021 at 06:49:58PM -0500, Varun Varada wrote:
> > On Thu, 13 May 2021 at 04:48, Michal Such=C3=A1nek <msuchanek@suse.de=
> wrote:
> > > Yet Felipe insists that 'impact' is somehow generally bad word to u=
se or
> > > that it should be abolished solely because he finds it bad and nobo=
dy
> > > objected to the alternative wording.
> > >
> > > Opinions on use of 'impact' differ both among the participants of t=
his
> > > discussion and authorities like authors well-known dictionaries.
> > >
> > > It looks like this is generally matter of stylistic preferences and=

> > > opinions. That is even if there is some slight stylistic preference=
 for
> > > not using the word 'impact' it is very hard to prove such and then =
it is
> > > very hard to request change based only on writing style preferences=
.
> > =

> > The argument is not that it is generally a bad word to use, but that
> > it is generally bad to use words when they don't mean what one thinks=

> > they mean, especially when all evidence says otherwise.
> =

> Not all evidence. There are people who think the use is fine.

What people think is not evidence.

There's people who think the Earth is flat.

> > All major dictionaries define "impact" as "a strong effect" or "to
> > affect strongly". This is not style, but semantics. In the same way
> =

> Not all dictionaries, actually.

You don't need all dictionaries.

If 50% of trials show a drug is safe, and 50% show it's not, you don't
approve bit because "not all say say it's unsafe".

If there's evidence that A is bad, you should consider avoiding A,
especially when you have B, and you have *zero* evidence showing B is
bad.

> > that "per se" being used to mean "necessarily" is not a style issue,
> > using "impact" to mean "an effect" or "to affect" is not a style
> > issue.
> > =

> > As has been stated already, the clear and substantial argument for
> > this change is that it reduces the confusion that arises from
> > improperly using the word "impact" in the instances without any loss
> =

> There is no final authority on 'correct' word use in English.

You don't need a final authority.

There is evidence that A is problematic.

> We should learn to work together with people that use different
> variant of the language rather than insist that the variant that I or m=
y
> teacher uses is the only correct one and everyone else should use it.

Except one variant is problematic, and the other is not.


Do you have *ANY* evidence that shows a problem with "effect"?

-- =

Felipe Contreras=
