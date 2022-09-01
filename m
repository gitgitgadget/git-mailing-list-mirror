Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF30ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 03:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiIADpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 23:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiIADpF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 23:45:05 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0D15809
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 20:45:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id cb8so12563508qtb.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 20:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HKHRwgMkGq26fZWtMkz7QIA+4gQspDtNwfC9cvxVvW0=;
        b=nNP4MKOJ+H7cqokOrxdCcB44JVxsef1qj/SUtInaHnwdoUtynvALY4WW6o5bs49saW
         HgW1ifTb8UxXJkgJDhinUKsso8pcR4HMcSMj0BK4qbpnkho9jH+At8jtQi8Sk48A0+Im
         gZTK7RLfjcY+EICjgZ1e7IxCBNNuhUAE19vyXUf4PA4ad1i5r9D0oTvBU4f+iZ+Q+pIy
         IwqMwsauYj+mh+PwLhtP5eEG4MA4+o7NTIP80fC3IETomcfDDP2AEB67E/PETyxS28DS
         peMwza6N2qig1GArYaq4F9UjBY9beqU244y2zfkM7rva7AqpIh3n6XovpeH9AHYMLNuL
         btbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HKHRwgMkGq26fZWtMkz7QIA+4gQspDtNwfC9cvxVvW0=;
        b=ee8hKsD7UKrHFV43u4HF3Gms0J6M0NG8Z6k3AcatCdhGJcPyTKixdrCliMP6iPQpvd
         yIgl8QjZjduJQwMqGwDFVhE2mD8u2dsJ4qCp3OzGGYd6NCqCMzuY03+29FFkNDbmGDh/
         qxgRXKUq7cNjpXGtlawDQVNbAnUNvDAIBNPrgHAk4hAYBz2mNvewD8GX+nFb9qUIP+Tm
         kylo7WFfZSL3W27EM3ore+5lYaaea9tunGsMJ/fIQofPv72ufa3QEXaIfHEk/ATPw6Jo
         xtiatqO/pZ79a6Qfz0koAqVL0eon+kVDO2JOBxNpkigsmLoRu+HfqLVayJHokSzyrguB
         GjAw==
X-Gm-Message-State: ACgBeo3XNaKW7XgMOjACSEXIJzRkMuVMc8u9nO9QGuifHKALotauPfgH
        zjCwY0eieeomBI5i50lsy5YSeMrIPNSOCoKwmUk=
X-Google-Smtp-Source: AA6agR7Ac4S16NbxkCSdsnPMAbvOgv75axgpx4yitOy/tFhPKRzu2V5h4N7lK0NZue0fb8FlL3xW2IIUgsbcr4sBn5k=
X-Received: by 2002:ac8:5f09:0:b0:343:67b3:96f5 with SMTP id
 x9-20020ac85f09000000b0034367b396f5mr22079592qta.470.1662003901037; Wed, 31
 Aug 2022 20:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
 <e4414cf630da284bdb11f5613ca0ce6413c6a443.1661926908.git.gitgitgadget@gmail.com>
 <xmqqedwwdph3.fsf@gitster.g>
In-Reply-To: <xmqqedwwdph3.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Aug 2022 20:44:50 -0700
Message-ID: <CABPp-BEyb9hOWuuG24wp+qwF0Ni2wVvxe4ma4Rsph_eOeWFV8A@mail.gmail.com>
Subject: Re: [PATCH 1/3] diff: have submodule_format logic avoid additional
 diff headers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 3:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commit 95433eeed9 ("diff: add ability to insert additional headers for
> > paths", 2022-02-02) introduced the possibility of additional headers,
> > created in create_filepairs_for_header_only_notifications().  These are
> > represented by inserting additional pairs in diff_queued_diff which
> > always have a mode of 0 and a null_oid.  When these were added, one
> > code path was noted to assume that at least one of the diff_filespecs
> > in the pair were valid, and that codepath was corrected.
> >
> > The submodule_format handling is another codepath with the same issue;
> > it would operate on these additional headers and attempt to display them
> > as submodule changes.  Prevent that by explicitly checking for both
> > modes being 0.
>
> It may make sense to give a concrete name for the condition these
> new codepaths check, which presumably exists in the part that was
> touched in 95433eeed9 when "that codepath was corrected".  I think
> you want to treat a diffpair with at least one side with non-zero
> mode as a "real" thing (as opposed to the phony "additional headers"
> hack), so perhaps
>
>         int diff_filepair_is_phoney(struct diff_filespec *one,
>                                     struct diff_filespec *two)
>         {
>                 return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
>         }
>
> or something like that.  The use of the FILE_VALID macro here is
> very much deliberate, and tries to match the more recent hack after
> this hunk that says:
>
>         if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
>                 /*
>                  * We should only reach this point for pairs from
>                  * create_filepairs_for_header_only_notifications().  For
>                  * these, we should avoid the "/dev/null" special casing
>                  * above, meaning we avoid showing such pairs as either
>                  * "new file" or "deleted file" below.
>                  */
>                 lbl[0] = a_one;
>                 lbl[1] = b_two;
>         }
>
> We shouldn't expect readers to understand (one->mode || two->mode)
> is about the same hack as the other one.

I like that; I'll make that change.
