Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBC2C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191A960E08
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhGLTK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbhGLTK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 15:10:57 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD5C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 12:08:07 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so19925377otq.11
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=5loe6NkP8DLf04JA9eAwIxRYB9IRpgkp/Dt2oB4Yf+Q=;
        b=rIKARY3sJf/VnX9LprtMMmPtMWKBte+76caSb/F/zAPBTStqyvRXXuTzjtSkTTI2m6
         kNOyi884bmbp171gD7gxooqOD0rxTncizAoXOam7GphhUX+VQWVEILlcszM4jSzSwEUP
         XL6hivOCo9EoH7GMOjrtZ/M9OwQQEBBAHqwGMescYfUe6VoTo1yVC9PUYORGwwMGntP5
         n5GtcrDtMMK3Eu0uCRKxIFftZjlSojwue7S2CAkoRSrZC24qRCL/Gxrt6x/xjYOMi+0K
         GZrewJPEYt9YByy7OlM+ektn2XRkVunbGIQEjRnEc+6YLDcTeKcu+EccaTSiskCrrm6D
         v4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=5loe6NkP8DLf04JA9eAwIxRYB9IRpgkp/Dt2oB4Yf+Q=;
        b=XE3ZxNu7ENheNC+9GWBElbm4kWseOasXBTDw8i7Cjk1s6d/f5cfGdi4mcvydDFqSbA
         RUi5ifpukXQs2CeJ3C1j0V6bM9KQKOCsE5GXCisOe0+n1IXAYeh7W9SA6sGZjoPxH7Xt
         nB60hZo7s0okR+OrB3uVMxIpQJriDMIelBCkUEBN4likcps1b8nctDsn52ouT2VxjDFU
         wH0mJI2PmOrKXBbgLq06gfK+kKQTUiLPWh+kG6nO+bCReJtpcPlmUm7Q0wfQzaGTpY6f
         aEQKaiIlT0X19LNTO4ErEbiLPrNtAWBkEzQOAmA+7dutSTIOkiLUcGbFP4vgzOfoSDjY
         jhvg==
X-Gm-Message-State: AOAM5319oDjdheOCNxe03PKvXtJ1RaoAWyg3G22DwxWh0IHDg+SMXVzY
        JGEMUZocpphnm/7oAlGGiuw=
X-Google-Smtp-Source: ABdhPJzo8L3Lq3dm4CMjPjI4ydmlMtLOsTqmIEYq+l520O3LxQKpaakN42g8fKqeIkhENbPnbhlbjg==
X-Received: by 2002:a9d:24c5:: with SMTP id z63mr401741ota.43.1626116887147;
        Mon, 12 Jul 2021 12:08:07 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id w7sm1494859oik.34.2021.07.12.12.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:08:06 -0700 (PDT)
Date:   Mon, 12 Jul 2021 14:08:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60ec93155663f_a231f208fb@natae.notmuch>
In-Reply-To: <0d7bd249-2aba-236a-9f93-3a5b30182d15@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
 <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
 <60ec6d91deced_a452520825@natae.notmuch>
 <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
 <60ec74c513b2b_a45252081b@natae.notmuch>
 <0d7bd249-2aba-236a-9f93-3a5b30182d15@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 12/07/2021 18:58, Felipe Contreras wrote:

> The "-C" option could then be (incorporating the "could be lost" from a 
> prior mail.
> 
>  > -C <new-branch> <commit>
>  >    Same the --new option.

But it's not the same as --new.

>  >    But allows to use an existing branch-name.

If this is an essential part of the previous sentence, it should be part
of the sentence:.

  Same [as] the --new option, but allows to use an existing branch name.

But this is wasted space:

  Shouting is the same as talking, but with a different volume.

There's no need for another sentence explaining in what way it is
different (higher volume), do it in the same sentence.

What happens when we use an existing branch name?

>  > The [existing|old] branch [for the name] will be removed,

Except this is a lie. At no point is the branch removed; the branch name
is never gone, neither are the commits.

What is actually happening is that the branch head is changed. That is
all. And as I already explained in the subthread, everyone understands
what changing the branch head does to the branch.

Everyone knows what happens when you reset your computer without saving
your Excel spreadsheet. The word "reset" implies loosing state.

If you don't want to use the word "reset", or the term "branch head",
then you can say:

  Same as --new, but if the branch already exists it's replaced.

This *still* doesn't explain what it is doing, you would need to read
--new.

  Create a new branch like '--new', but if the branch already exists
  it's replaced.

Now it is actually self-contained.

> > and its commits could be lost.

The commits are not lost, they are just not part of this branch anymore.
They could easily be part of another branch already.

  Create a new branch like '--new', but if the branch already exists
  it's replaced. The commits that are initially part of the branch might
  not be part of the branch afterwards.

I think the last sentence is superfluous and obvious. Everyone
understands that if A is replaced by B, B might be different from A, and
thus not everything of A might end up in B.

If you want to send a patch with that unnecessary information, go ahead,
what I'm saying is that if the first part is written correctly the last
part is obvious.

Cheers.

-- 
Felipe Contreras
