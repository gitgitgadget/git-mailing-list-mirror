Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141FEC4707C
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92F0613DA
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhEUSQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 14:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbhEUSP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 14:15:57 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7389C0613ED
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:14:31 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so4790898oot.0
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KHY8/jJtExFUI8fXvKQnfCEA4cXPHeVWeXornq7MFQI=;
        b=iWbONnttlLLqqlYvv6oTGkeU/IYZ3qqMtDIsCQ2Qz4yn0ZwjNXfp6KdSHu67t3R9gE
         DHkG71Qn7snQpbDjdXnVYchfJTsL0uh57Mvs1GPiqJiuA4jkWzCdBChSfGhN/X2gTkrt
         Sg54O6rm6KlZOmhLHLoTlxkiu3O912tgjslkwOkLEOw4EkQuMwNOE/LCf6uIEgOWGw2I
         eIa5kKmYuMLVNb5m+L6JfOZXrhHhI2cPyANRjUWt4kgqCot0ey3NAM+dqD5UtlnAfnji
         OfmY63gVvTWjavWMAX+QBPg0CatFEQoyPqdKG9mu7JBvScZY00bNPFh1fUu6NnV22yz5
         WAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KHY8/jJtExFUI8fXvKQnfCEA4cXPHeVWeXornq7MFQI=;
        b=RMqVhrjJH7K0zmnB16da4bBrEqvZYUXK9vRrFVrzUmulW2Vw1qUmYB8WAf6kOpzJg6
         KgBptcz+ZdJbW1Utf0ASkY3ISj+UL0Mcie80g732O6F5rIPfOlD5ds9KAxDS9K8fv9/y
         9mMIKyVr1BjpaM/NYTF0Jucjpgv1W8Q4si4ab2xkof6/uzXkGOrSXfe1YHbgtfL9soIr
         FAPUT4crIq3qklpbnm7gBXQghkQSuIMeRzaSprEW6jsM+Wsgl1050TfxtLdECzAW2CmP
         bVkgE+IOKZ0okpNlLzCGh+AysiQ7QR8vaMQjwU+fubTgvvf+uhw4p11/0VCeEZ8UdixH
         6CQg==
X-Gm-Message-State: AOAM530GHIU7PgkmA0pTPUjhpdDaRBoJp+gdjYy2/EFAwIgOAQNDtSt7
        kiugdoyOhsRivTFJAWmn1g0=
X-Google-Smtp-Source: ABdhPJzJvguiVR7BLKeT+cQ0kZsqtXbYS+P3gvwJAuACuQ5B03eWyss2+Iz2mvLh9pg8tA0oKaufGg==
X-Received: by 2002:a4a:d543:: with SMTP id q3mr9209194oos.72.1621620871250;
        Fri, 21 May 2021 11:14:31 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id r10sm1257676oic.4.2021.05.21.11.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:14:30 -0700 (PDT)
Date:   Fri, 21 May 2021 13:14:29 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60a7f88565aa8_5503920832@natae.notmuch>
In-Reply-To: <87sg2h9m2n.fsf@osv.gnss.ru>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
 <20210510153451.15090-7-sorganov@gmail.com>
 <xmqqsg2toqik.fsf@gitster.g>
 <xmqqo8dhool7.fsf@gitster.g>
 <87v97pv04p.fsf@osv.gnss.ru>
 <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
 <YKWG0jgYXAnKUJNR@google.com>
 <87sg2h9m2n.fsf@osv.gnss.ru>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

> > I don't have a strong opinion about what the default for -m should be.
> >
> >> I think --cc is a lot better than -m for helping you find what users
> >> changed when they did the merge, but I agree the format is somewhat
> >> difficult for many users to understand.
> 
> I do have strong opinion. --diff-merges=1 is the only sensible
> factory-default. Not only it has no implicit assumptions about how given
> commit has been achieved, it's also the only format even entire Git
> newbie might already be familiar with.

I agree.

> Principle of least surprise is still a good thing to follow.

I could not agree more.

-- 
Felipe Contreras
