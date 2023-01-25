Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67697C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjAYWXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 17:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAYWXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 17:23:02 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E80729E19
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 14:23:01 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so3572688pji.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 14:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsS3juUuKOuxXjH/dSnjFVp8odWO3yOwGCBBtHTOEA4=;
        b=paGOdUw+/7fjlQzirXUdeNRjTDRmuE77AeOFNmW+Z3PsvPWjtPX5f0IqOITnyJSQsE
         lK/dTCDwRuF/bPUiAFt4LZHgcmHp2wkuXwdvbyOQxdUR3/2SYm0OpphlFOmsFGFoWooR
         cv/KPvyt5B3ZMtm2lewrnLHhWuGhz0IDq59JgXzRXLB9aw0Z15/TMgdlrn40P5CRdfzu
         AuxoWJ66yoPbgxLbtprscEb8IVbddg+G9wNkOdKCEaJDDy0EvzlSLZyGHsr6r1fC/UBx
         hZfugQ7584QiQBwqrHU61TXelQX9RFkVV9zBBD6mNSgbx0zhf7pT4fzUKMjMEHry51Kk
         CtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GsS3juUuKOuxXjH/dSnjFVp8odWO3yOwGCBBtHTOEA4=;
        b=05Y7Npy/CA77OBzgUnXfdHKHuPitoZ0FXdsubMgUhsfRj2S+5rK510bQTOXd7TdSP6
         9PDkXWxS/EF8nE20F1JV7+dwz6y4OnVeuiVzJ1o86MgY1wn4j+ZW5nX4CmdUTHlQQfbr
         BWG/yCqGryYOuqMrpJZqzaF02L3X/fU3xNH4lwVWJA33AjGRFfeJbplZ8+DAARQY8yOA
         oNhaB0m2YMNu9lhjHqcWwoBt57gRb1OzQwEh29dOFbxCEtbkgorYaMWHHYNRu4uHn42d
         Nku+1iIJYUtUKV6VGFsFy08H+1fM6BMhorx6Yusasya9MEbUdwPx66uhzXzvBWdeH353
         3M8A==
X-Gm-Message-State: AFqh2kq4xk3c1LigpqlkJ0eZNWnRIojDJ3ZcYH506aBUQM15K/xVmsRc
        3jbU7eBQWBtdkxOB8/hg4wY=
X-Google-Smtp-Source: AMrXdXuMtAdacKpWAjVRC5cpsaG9zvsOse/FhyMDkQm0KN1VSRrAZuUNOw79fXJMljZwP7t96BhXVw==
X-Received: by 2002:a17:903:2348:b0:195:ed3e:cfa8 with SMTP id c8-20020a170903234800b00195ed3ecfa8mr24405726plh.9.1674685380797;
        Wed, 25 Jan 2023 14:23:00 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id bb3-20020a170902bc8300b00192d9258532sm4122163plb.150.2023.01.25.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:23:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Adam Szkoda <adaszko@gmail.com>,
        Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v2] ssh signing: better error message when key not in agent
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
        <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com>
        <xmqq1qnjhlbf.fsf@gitster.g>
        <CAEroKagUY5PfuC2CDn=pTJ=brPsjPy6MVz54mH1tvN8E-Pvk7g@mail.gmail.com>
        <CAPig+cTNk1RvfdFembKcxTOUs0UsiXmz8rsEnab-0fQp-QE3Lg@mail.gmail.com>
Date:   Wed, 25 Jan 2023 14:22:59 -0800
In-Reply-To: <CAPig+cTNk1RvfdFembKcxTOUs0UsiXmz8rsEnab-0fQp-QE3Lg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 25 Jan 2023 16:42:26 -0500")
Message-ID: <xmqqedridzjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jan 25, 2023 at 8:05 AM Adam Szkoda <adaszko@gmail.com> wrote:
>> On Tue, Jan 24, 2023 at 6:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > > Range-diff vs v1:
>> > >
>> > >  1:  0ce06076242 < -:  ----------- ssh signing: better error message when key not in agent
>> > >  -:  ----------- > 1:  03dfca79387 ssh signing: better error message when key not in agent
>> >
>> > This is a fairly useless range-diff.
>> >
>> > Even when a range-diff shows the differences in the patches,
>> > mechanically generated range-diff can only show _what_ changed.  It
>> > is helpful to explain the changes in your own words to highlight
>> > _why_ such changes are done, and this place after the "---" line
>> > and the diffstat we see below is the place to do so.
>> >
>> > Does GitGitGadget allow its users to describe the differences since
>> > the previous iteration yourself?
>>
>> No, I don't think it does.   It got generated automatically without
>> giving me an opportunity to edit.
>
> Yes, the user can describe the differences since the previous
> iteration by editing the pull-request's description. Specifically,
> when ready to send a new iteration:
>
> (1) force push the new iteration to the same branch on GitHub
>
> (2) edit the pull-request description; this is the very first
> "comment" on the pull-request page; press the "..." button on that
> comment and choose the "Edit" menu item; revise the text to describe
> the changes since the previous revision, then press the "Update
> comment" button to save
>
> (3) post a "/submit" comment to the pull-request to tell GitGitGadget
> to send the new revision to the Git mailing list

Thanks.  I thought the above would make a good addition to our
documentation set.  Documentation/MyFirstContribution.txt does have
this to say:

    Once you have your branch again in the shape you want following all review
    comments, you can submit again:

    ----
    $ git push -f remotename psuh
    ----

    Next, go look at your pull request against GitGitGadget; you should see the CI
    has been kicked off again. Now while the CI is running is a good time for you
    to modify your description at the top of the pull request thread; it will be
    used again as the cover letter. You should use this space to describe what
    has changed since your previous version, so that your reviewers have some idea
    of what they're looking at. When the CI is done running, you can comment once
    more with `/submit` - GitGitGadget will automatically add a v2 mark to your
    changes.

before it talks about doing the "/submit" again.  Expanding the
above into a bulletted list form like you did might make it easier
to follow through, perhaps?  I dunno.


