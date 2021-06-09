Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A261CC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839A3613DC
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFIUUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhFIUUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 16:20:34 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4D1C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 13:18:25 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso8993404otm.11
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ayk9LMsAY2PazgO98xFZlmRE7CFnH/XW2sTWLs5mcwI=;
        b=O2ELV7yMf+V3x0XWK5cPS5D4lJgT0JyxLg26T36gwFj9j1l639G2S0kYvm62K2QQgb
         2wwT4TvgtW7xg4kGu4SJc+d74tu8/iOS9t/PZK6Lnqiwdwr1bche4LiL/C7oLhlVtaQa
         hWchYO/mknXEYsAiDQ+6WW1NutvjbgUL1mT2JP6BXQ3U13HpI0DWUvGOwHoX1+UcxOO1
         3htZdNMB2lJbt8p4e/8eky42i4seXdaO3McnpaWMfagoHtCYShEOUyfFti5OCTh+gT3S
         VU1+NIVhPIDYUahCvsZBhYkN2JVH+yD+/OEk3JBWxwy6pg2EqkErI8LDV5LGwqxGVnBv
         g8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ayk9LMsAY2PazgO98xFZlmRE7CFnH/XW2sTWLs5mcwI=;
        b=H5757PWX75l8YM6hnbimJQbDeHFoq8i4SmhIjLmrRsoZwFMISW2n984gIljCuXZhW4
         sxuPejVE4Vwwe8DRTm/xJNN0OZyzOn0RjVT17s/PkFoyRgk4OvJ23sWk5IJadFB5mMJ/
         zJtU73H2GCayr9eAiV8/WPnMARWbmSkUVFAGxerTa9Ma5Q/2wzbqqn/kjIjJQ7x8tLYY
         VFHyprV3ykD4qqMas6VyxdBMrRuW7cLvMhtPwBjE92cTZTboO7ilFFFFVW2SAz1CKRG/
         66ky+nRrMqtkZ8X5FZfMweSNHUd+5FTDMfc7FfMG2ZmO+k7eRh7tbaEnhwT7wb7PFIiJ
         khFg==
X-Gm-Message-State: AOAM531eXQdS7UfSoA05D4BsLb7GiH3RsDJfJkzQxPuOk9wiI1rJ7pUi
        CpqKjpCA6/9Ck5HkNclDF7KnJkwYGND+Gg==
X-Google-Smtp-Source: ABdhPJwLJXZvi+UTOQQx+7+uo3M027Dhyi1nrJUmNPLglvcRznhfYD1XoDJ0hd/oug8OAXbKE6b9cA==
X-Received: by 2002:a9d:718d:: with SMTP id o13mr952995otj.271.1623269905076;
        Wed, 09 Jun 2021 13:18:25 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w186sm157141oib.58.2021.06.09.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 13:18:24 -0700 (PDT)
Date:   Wed, 09 Jun 2021 15:18:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Susi <phill@thesusis.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c1220f1ce69_aa2ee2088c@natae.notmuch>
In-Reply-To: <87fsxq98xq.fsf@vps.thesusis.net>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <60be7adcdf3b_db9162081e@natae.notmuch>
 <87fsxq98xq.fsf@vps.thesusis.net>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Susi wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Derrick Stolee via GitGitGadget wrote:
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >> 
> >> Technical writing seeks to convey information with minimal friction. One
> >> way that a reader can experience friction is if they encounter a
> >> description of "a user" that is later simplified using a gendered
> >> pronoun. If the reader does not consider that pronoun to apply to them,
> >> then they can experience cognitive dissonance that removes focus from
> >> the information.
> 
> Why should the pronoun apply to the reader?  If the documentation wants
> to refer to the reader, it should use "you".  If it's using "he" then
> it's referring to someone else previously mentioned in the
> documentation, not to me.

Indeed, and the patches don't apply exclusively to the reader. Here [1]
the relevant person is somebody else who rebased a branch. It is unclear
what kind of "cognitive dissonance" would a reader experience when she
reads that that somebody happens to be a she.

> > You can use "nucular" if you want (many people do). I will use
> > "nuclear".
> 
> You can use "nucular", but you will look stupid.

I do think so, but that doesn't stop people from using it.

Such is the nature of language.

> > Both can be valid, and we shouldn't demand the use of one over the
> > other.
> 
> Sure we can; one is not valid.  You also may not "axe" me a question, or
> drink an "expresso".

According to some dictionaries "nucular" is valid [2].

Plus, I don't think "valid" is the right word. Some people have a
descpritive view of language, and in that view all words are valid, or
rather: no word is invalid.

What makes words land in a dictionary is simply how much people use
them. The word "cute" used to mean "clever" [3], and it was "invalid" to
use it as we use it today. But people didn't care, and the meaning of
the word was forced to change. Dictioaries simply recorded the will of
the people.

> Also you argued against using they because it is not standard English,
> but then argued that it is fine to use non standard English.

I didn't argue either of those things.

Yes, I did argue that "single they" isn't part of standard English (with
a semantically singular antecedent), that doesn't necessary mean we
shouldn't use it.

And I did argue "nucular" is part of standard English (many people use
it), that doesn't mean we should use it.

Basically whether or not a word is part of "standard English" is
orthogonal to the fact that we should use it. In my view.


Let me be clear on what I do argue: we shouldn't ban perfectly standard
words such as "she" and "he".

Cheers.

[1] https://lore.kernel.org/git/fb7a7573782ae8ba3bc5341d6aaee704af88fdcf.1623246878.git.gitgitgadget@gmail.com/
[2] https://www.lexico.com/en/definition/nucular
[3] https://slate.com/human-interest/2015/02/cute-etymology-and-history-from-sharp-keen-or-shrewd-to-charming-and-attractive.html

-- 
Felipe Contreras
