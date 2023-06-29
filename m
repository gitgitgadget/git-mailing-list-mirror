Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD18EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 20:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjF2Usi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 16:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjF2Use (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 16:48:34 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2E02D4A
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 13:48:31 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a3790a0a48so576280b6e.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688071711; x=1690663711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10PBsWnyyZiRpzCY11O8ySWiTdAcg/lodUW5cGu5FZ4=;
        b=GzNYW7JHAzgA9ghtfsvD1Io0RDNKuWA88WWwPGydrr7PBcrJH8wLzFrLsesKqlBol/
         X2QepPcqpc09iBuFuORFs1jz+F6uGsdswAWRq9/u6LaO9KO7TbgAKYz6gA8EiwVbx3kQ
         q5aePYL0PYzSUfc67RxNVn2mBYMcZob/tIyLNhOGGs7X1wCrWL2TUJTVRa+KJda5rRIl
         JmHvvQA1BvdFtdtwY4wkYH0vt7D2d+Rmm2i7v6+hgZ/nvRCjxEcLJFlypP5O8FEQyaEs
         /LXHnsiRoLj4GiFBtET9iCljmjRnlODaALOpcZgVGRrfw4QSkKbgCpfFY4X0yYtuK14m
         /XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688071711; x=1690663711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10PBsWnyyZiRpzCY11O8ySWiTdAcg/lodUW5cGu5FZ4=;
        b=P7uON7gI52YRAORpPtFyuDAlfqeVpP3lTDmYBPaqsKUvpQIhYBHXUhmYPdL7pne65A
         6BvIhkOmtvyEzeHVFA8JmlmfKGLg2q8rVr4MRHqIuBF28CTritw5rrD3U/SJU05+he50
         nTkJpMiywUEQkvCvBQdeRyOC394HZa4O8gZt+dbkdQnv8DxsjVyUcWM8T3kW8Ta2XNyI
         z83Gq0ErJ+8+LydbhjCjbjyEAh42oktT1VMwWQ7LavsF9xe/BhebNnbp7lpwnqgc6/kl
         DIyKb/52O3H85tSfUqtAhVEe8NLWLxKLw0u5E5GqRKp6o/lpaikNtbV3lRpZ/g5EIe4u
         mFbQ==
X-Gm-Message-State: AC+VfDxMBf4potaCP2W2zyi8JRlpdDxVummP01KFx9eF2woRTUVjDd94
        YZKBHhJAYWIm34AzqR7iIZxLSQ==
X-Google-Smtp-Source: ACHHUZ6NbDPiM+Ra5V3O7o0E/FbHG8mJ1iUs2j8qjMNwTjAXeeG4kUCEtoo+RInRqOIcHoqNWQYrQw==
X-Received: by 2002:aca:d06:0:b0:3a3:78dc:8c4e with SMTP id 6-20020aca0d06000000b003a378dc8c4emr445019oin.32.1688071710895;
        Thu, 29 Jun 2023 13:48:30 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:aca4:f28:b5c7:624f])
        by smtp.gmail.com with ESMTPSA id m9-20020a654389000000b00553d42a7cb5sm8160702pgp.68.2023.06.29.13.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:48:30 -0700 (PDT)
Date:   Thu, 29 Jun 2023 13:48:24 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org, calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
Message-ID: <ZJ3uGBEEvYmbPnoQ@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Linus Arver <linusa@google.com>, git@vger.kernel.org,
        calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
 <owlybkgy837j.fsf@fine.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <owlybkgy837j.fsf@fine.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.06.29 12:42, Linus Arver wrote:
> Hello,
> 
> Josh Steadmon <steadmon@google.com> writes:
> 
> > In our current testing environment, we spend a significant amount of
> > effort crafting end-to-end tests for error conditions that could easily
> > be captured by unit tests (or we simply forgo some hard-to-setup and
> > rare error conditions).Describe what we hope to accomplish by
> 
> I see a minor typo (no space before the word "Describe").

Thanks, fixed for V4.

> > +=== Comparison
> > +
> > +[format="csv",options="header",width="75%"]
> > +|=====
> > +Framework,"TAP support","Diagnostic output","Parallel execution","Vendorable / ubiquitous","Maintainable / extensible","Major platform support","Lazy test planning","Runtime- skippable tests","Scheduling / re-running",Mocks,"Signal & exception handling","Coverage reports"
> > +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/[Custom Git impl.],[lime-background]#True#,[lime-background]#True#,?,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,?,?,[red-background]#False#,?,?
> > +https://cmocka.org/[cmocka],[lime-background]#True#,[lime-background]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[yellow-background]#Partial#,[yellow-background]#Partial#,?,?,[lime-background]#True#,?,?
> > +https://libcheck.github.io/check/[Check],[lime-background]#True#,[lime-background]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#True#,[yellow-background]#Partial#,?,?,[red-background]#False#,?,?
> > +https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#True#,[red-background]#False#,?,[lime-background]#True#,[yellow-background]#Partial#,[yellow-background]#Partial#,[yellow-background]#Partial#,?,?,[red-background]#False#,?,?
> > +https://github.com/silentbicycle/greatest[Greatest],[yellow-background]#Partial#,?,?,[lime-background]#True#,[yellow-background]#Partial#,?,[yellow-background]#Partial#,?,?,[red-background]#False#,?,?
> > +https://github.com/Snaipe/Criterion[Criterion],[lime-background]#True#,?,?,[red-background]#False#,?,[lime-background]#True#,?,?,?,[red-background]#False#,?,?
> > +https://github.com/zorgnax/libtap[libtap],[lime-background]#True#,?,?,?,?,?,?,?,?,?,?,?
> > +https://nemequ.github.io/munit/[µnit],?,?,?,?,?,?,?,?,?,?,?,?
> > +https://github.com/google/cmockery[cmockery],?,?,?,?,?,?,?,?,?,[lime-background]#True#,?,?
> > +https://github.com/lpabon/cmockery2[cmockery2],?,?,?,?,?,?,?,?,?,[lime-background]#True#,?,?
> > +https://github.com/ThrowTheSwitch/Unity[Unity],?,?,?,?,?,?,?,?,?,?,?,?
> > +https://github.com/siu/minunit[minunit],?,?,?,?,?,?,?,?,?,?,?,?
> > +https://cunit.sourceforge.net/[CUnit],?,?,?,?,?,?,?,?,?,?,?,?
> > +https://www.kindahl.net/mytap/doc/index.html[MyTAP],[lime-background]#True#,?,?,?,?,?,?,?,?,?,?,?
> > +|=====
> 
> This table is a little hard to read. Do you have your patch on GitHub or
> somewhere else where this table is rendered with HTML?

Yes, I've pushed a WIP of this to:
https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation/technical/unit-tests.adoc

However, this doesn't render the color coding in the table, so you may
also want to just build it locally:
`make -C Documentation technical/unit-tests.html`

> It would help to explain each of the answers that are filled in
> with the word "Partial", to better understand why it is the case. I
> suspect this might get a little verbose, in which case I suggest just
> giving each framework its own heading.

Yeah that is coming in V4.

> The column names here are slightly different from the headings used
> under "Desired features"; I suggest making them the same.

Fixed for V4.

> Also, how about grouping some of these together? For example "Diagnostic
> output" and "Coverage reports" feel like they could be grouped under
> "Output formats". Here's one way to group these:
> 
>     1. Output formats
> 
>     TAP support
>     Diagnostic output
>     Coverage reports
> 
>     2. Cost of adoption
> 
>     Vendorable / ubiquitous
>     Maintainable / extensible
>     Major platform support
> 
>     3. Performance flexibility
> 
>     Parallel execution
>     Lazy test planning
>     Runtime-skippable tests
>     Scheduling / re-running
> 
>     4. Developer experience
> 
>     Mocks
>     Signal & exception handling

I didn't state it outright, but they're roughly but not perfectly
ordered by priority. Of course, other people may prioritize these
differently, and I'm not set on this ordering either. Grouping by
category does seem more useful.


> I can think of some other metrics to add to the comparison, namely:
> 
>     1. Age (how old is the framework)
>     2. Size in KLOC (thousands of lines of code)
>     3. Adoption rate (which notable C projects already use this framework?)
>     4. Project health (how active are its developers?)
> 
> I think for 3 and 4, we could probably mine some data out of GitHub
> itself.

Interesting, I'll see about adding some of these.


> Lastly it would be helpful if we can mark some of these categories as
> must-haves. For example would lack of "Major platform support" alone
> disqualify a test framework? This would help fill in the empty bits in
> the comparison table because we could skip looking too deeply into a
> framework if it fails to meet a must-have requirement.

Yeah, right now I think supporting TAP is the only non-negotiable one,
but I'll add a discussion about priorities.

> Thanks,
> Linus

Thanks for the review!
