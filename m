Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C885C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0720461221
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhGJXVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJXVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 19:21:34 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B1C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 16:18:48 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so14011100otl.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=F1YOz4zmatJUvHwOZAL3q8V6T8VQHEhZOut2FGCVmDc=;
        b=pl5Rtuegk/uM9zNRwKAXb+9A/Ppqs7HL8I6OnaNFib/1l5h+ArLadHEFC00Zq8yZhe
         jKmHzWSzPo+UyzupFIvyVALdPe/ubdcZr5UYKWIL2qlBDklU5FPwLHIvZ46e0TNlmRYK
         smBriUBSBpix4bdjO+Brqbt2q3wUVKSwHodwN/xKoE3URLnHhXrASyNK+zyDgAjp26Bj
         q4wKLKHA0lHLXXOFBGOtm/TfqkWztEXM5YATsO5B3xpu4gENEgDn14xnBIYJp4J+3Mik
         b14dYJMWZtgZLBA48l5i99I7jz4uV1ZniwlPrWH0cLegR2/BgIwKlZBDM1a6ZRBrTm+S
         HGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=F1YOz4zmatJUvHwOZAL3q8V6T8VQHEhZOut2FGCVmDc=;
        b=AuLJyZtdeq9RDolOOo5Su2u5jYNTy/LAumHs3v3V5U6gcbkFImZscd2bUWgol697hI
         ZTIyvsb5735mpTTaf8celi0M14SYGsb7ozDMnfSCbe6ybwfwYehfRPfr7rb40+UYb1lp
         +Ej7dVZwVDwarr40YMYrBMupSG8IqPRzPsi1dgktw3M6Y2sXmM0VaxJLDlqcIOBB9QpM
         3ZxT1/2P7umG2QEPXATXW1jKQ72yJWjHefHBHCzg60sxUafnAyvFL80VgyF4xVP5NQvu
         8pKkSE/J0A5v/A/DMusYfsBoOeM8ceiFSWaE5fIx/ju4wRs2zRMPLuwVEGhrpLk0uNBN
         NpCg==
X-Gm-Message-State: AOAM5337WSSNfrGmvmgAD59k4luc7gpJnzUgNoLUAZxfpaHQr6pFo04e
        r40ZmgJ5/+AfezKlUsWh4zq2hdmQ74E=
X-Google-Smtp-Source: ABdhPJxlZmAN2OI4IonSLzHr52U1c1TST+I0nixJsldk1kC4bQHSP+zOB6z0juX3JtRhUWzmersUUQ==
X-Received: by 2002:a9d:77cb:: with SMTP id w11mr8306437otl.117.1625959127875;
        Sat, 10 Jul 2021 16:18:47 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id d3sm2195103oia.36.2021.07.10.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 16:18:47 -0700 (PDT)
Date:   Sat, 10 Jul 2021 18:18:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60ea2ad64878_2a692084e@natae.notmuch>
In-Reply-To: <43b8d0bb-67f3-11dd-ec31-e102ce8e3b31@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <43b8d0bb-67f3-11dd-ec31-e102ce8e3b31@mfriebe.de>
Subject: RE: Naming the --forec option [[Re: PATCH: improve git switch
 documentation]]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 10/07/2021 22:49, Felipe Contreras wrote:
> > Martin wrote:
> >> For each force-needing action, you should have to specify it's own force 
> >> flag. >
>  > OK, but I don't see the concrete proposal. What would be the
>  > flag that
>  > makes -c "forceful"?
>  >
> 
> Well that starts yet another topic.
> 
> At the moment, it is
>     --force-create which is absorbing the flag into the option.
> 
> And by (apparent) convention it also is the uppercasing of the option
>     -C
> same as the uppercasing of the -B in checkout.
> 
> I am not really sure if the uppercasing is the best idea.

Me neither, and it's not something I generally use.

> If your suggestion "core.advanced " were to come, I would vote that 
> uppercase single letter force options should be restricted to advanced.

I would not count on it. I suggested core.mode back in 2013 [1], so...

> If -n is introduced, we can think about what to do about -N.
> Should the  --force-*  style be kept?
>     --force-new
>     -N
> 
> Or the (unfortunate? / see below ) "--discard-changes" style:
>     --discard-existing-branch -n <branchname>
> 
> I am against using --reset instead of --force-new.

That's OK, and in fact I can see how '--reset --new' is clunky, I'm just
saying it is a possibility. But the main point is that something like
`git switch --reset` is missing, although `git switch --move` would
probably do the trick.

> At least I can say, if I use "-N", I want a *new* branch. I don't care 
> about any old branch under that name.

Right, I would as well, but in fact I would expect the same from -n
(although I can see how a newbie might not).

> Also "--reset" does not have the same alerting properties to me, as 
> "force" or "discard" have.
> This may be my English, but to me "reset" does not have the same 
> alerting property.

OK, maybe it's a language issue. I'm not a native English speaker, my
mother tongue is Spanish, but I'm pretty sure my understanding of
"reset" is what most people understand: set again.

Using Merriam Webster [2]:

  1: to set again or anew
  2: to change the reading of often to zero

And there's plenty of corroboration; reorder: order again (whatever
order you had is lost), reassign: assign again (whatever assignment you
had is gone), replay: play again (whatever you were playing is gone),
and so on.

> The general problem is, if there is more than one force-needing action, 
> then which one does -f  act on?
> 
> Any force-needing action, that only applies with another option (such as 
> -N) can have a --force-*. So the plain -f is not used for it.
> 
> But, what if more than one force-needing event can happen (not just 
> switch, but any command), even without any extra options? (May not yet 
> be the case / not checked).
> 
> git switch has attempted to solve that.
> The result IMHO is a disaster.
> "-f" / "--force" is made an alias in favour for
>     --discard-changes
> What changes?

I see.

So *if* --force was not an alias for --discard-changes, then this would
make sense:

  git switch --new --force topic

It would _force_ the creation of a _new_ branch called "topic".

Is this close to what you are thinking?

[1] https://lore.kernel.org/git/1379426871-6823-1-git-send-email-felipe.contreras@gmail.com/
[2] https://www.merriam-webster.com/dictionary/reset

-- 
Felipe Contreras
