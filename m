Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BDCC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED62619C6
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhGFVR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhGFVR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:17:57 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19CEC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 14:15:17 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so187540oti.2
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sXCnWgi84E2frjI/ruTsHjXak0tEexoSH/Fiw/JELAw=;
        b=fCFG0TPCkFtZqKY82Kf7/+QgjIXu2ugIIm2yTbc19Etk0zLuojWQ8HvNMedfNl915c
         8EkRNdf6L9RZyHrLVWEPtKaxk6y1yZfqPJP5mjhTo4UgcEzIR59dt23emfLw0Tdu6eEM
         VG2FXFVIGivPdQzR/HNQDuvYMR+1rgrz0Aml+2bicOQUKQYAVgbgfM+3hB0U6k8B2vOS
         u1jGuA2SVBWZ32+bSEfRg+dkWLYVoPCbUgr1z9ZjSfZqZJ+9wNEKjRnTn5dE8ktLj3L1
         lu1yNHbz60/QKxW+tJr1VH3bLg8t6lhBG3fWkEHu8H/eIq6VzycoB/5XNs8/R/i7r7ev
         nAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sXCnWgi84E2frjI/ruTsHjXak0tEexoSH/Fiw/JELAw=;
        b=J7ESKJ702xU4e607pcNqjr4fS/HqfQD5o961OXAvM1tIQCbMG1iXDGQxPrQpMs404P
         kylwDRCjU+D7PM8i1c19c3oZIxqvMyB5nwqhMjx8YkD7pa3h9ADdRNMqgiAvlLvgvOHQ
         MJj8B8Tt19CSKo3vq+e8DzaRZTUmSXZXJrI3hkfbj54WxUeUsG8CQuR1gXEXt4ABMB5m
         76MuakB2rejJZfft7xql9dfTWQUGHUSo4J6TmnwJ+OXTOoG/YBVeo0qGaYfaRc8e2kTB
         0k3W/AM2RrT6AYSLHku+eqbwzLE2rdI3qcrDr5MQJ+iiiZ2ZiCRq6BovJSTPptjdr+RC
         X5LA==
X-Gm-Message-State: AOAM533O5wjyvM43K0X2nthHCcrr5u3bdDaZfU5E+ty+QM6bbIpF1ATo
        nMdpr9lbBWANSoUrF9p1abc=
X-Google-Smtp-Source: ABdhPJwBHqRYNbimkaXSq65HCUOl6U95/c6JDqPib6EXHopjPkbYMaci3jK39+nxUCG6jGaydJUpjA==
X-Received: by 2002:a9d:74d5:: with SMTP id a21mr6595735otl.175.1625606117079;
        Tue, 06 Jul 2021 14:15:17 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id l8sm2165078oie.0.2021.07.06.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:15:16 -0700 (PDT)
Date:   Tue, 06 Jul 2021 16:15:15 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Felipe Contreras' <felipe.contreras@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        'Alex Henrie' <alexhenrie24@gmail.com>,
        'Richard Hansen' <rhansen@rhansen.org>
Message-ID: <60e4c7e33bca0_1c428120827@natae.notmuch>
In-Reply-To: <xmqq1r8bi2l0.fsf@gitster.g>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-2-felipe.contreras@gmail.com>
 <87bl7f5ho1.fsf@evledraar.gmail.com>
 <60e4bf9a6a628_1c4281208b@natae.notmuch>
 <04de01d772a8$540c6690$fc2533b0$@nexbridge.com>
 <xmqq1r8bi2l0.fsf@gitster.g>
Subject: Re: [RFC PATCH 01/35] merge: improve fatal fast-forward message
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> >>If you do:
> >>
> >>  % git merge --ff-only
> >>  fatal: Not possible to fast-forward, aborting.
> >>
> >>That "aborting" part is redundant; we know `git merge` should abort
> > if the fast-forward is not possible, we explicitely told git to do
> > that.
> >
> > `git merge` is a special operation where errors (conflicts, for one)
> > may leave the repository in a merge pending state where you
> > subsequently may have to use `git merge --abort` to reset the
> > situation or `git add` to continue. The `aborting` output makes it
> > clear that you do not have to do the `--abort` and *cannot* do the
> > `add` because there was an implicit `--abort` done resulting from the
> > failure. This is important information for the user.
> 
> If so, adding ", aborting" to the end is misleading.  In this
> particular failure mode, the command pretends that the merge did not
> even start.

That's true.

Whatever is the case for that "aborting" to be there I don't think it's
adding any value.

-- 
Felipe Contreras
