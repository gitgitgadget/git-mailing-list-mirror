Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858D8C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 23:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiBVXNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 18:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiBVXNm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 18:13:42 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B5F8BF46
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 15:13:16 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 75so18275555pgb.4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 15:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uRfxqqGYMHxLtmQuXXKi7bfC6PX4cis9pntiey94poA=;
        b=GpabyfXEdzHXoB5uZGwOeJtqupjwL1zk6q0A6W/XqeDUx2AumDjRIQTzpeaknLMG8F
         DtPQoFrOuTjdWc3RCsRCzB/fs7nDDBDivqSwUxRfZjHydijuzEBNhuVqPgzpIDhIvh/z
         dpRUb19+TDzy9GdcDtnHWED2AzXQQX8l0ap6JPLigB8HO/m1fAS+izbrSfRx5QMzx/bF
         Wmsyy8heYI5YUOtTWcXudfmJUTLLUKTV8r78XIu5FDtjTI06bRVZA77sfl8ibHlwwMp4
         VuQ3y6z6oXpvMnDMpRDcN8SByfJYZuO1qizBYd3VtJa+Yihi1rXkm0BaSvG7Wft0ObHP
         0g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uRfxqqGYMHxLtmQuXXKi7bfC6PX4cis9pntiey94poA=;
        b=7DhgdPePLW0P2ccbY6yF70ApVSGVTkV5ff/cwL7CCK09Nh7M3TmCb/JEVxYCYaIgVc
         CwQOBMq7o/XQdIoqjiIqYqJPCKSKBG9ovChqzxFVzkkb/m5hYE24Vbwy3J4N6jSYMoDn
         iCHX/7D0eUbgT6j5JRkVR4bmIzOy342R/7CrEz7haJ27TRon53iTJmJkFRw3QG2O0+T/
         ZO6qobzvRRvdbWco9TtfQxe77g8VjmJf6uZi0ZITtH1hdSTQS3q2eCYIh8pLscMsQ5S4
         hzBuN+IZAtMUSGtatZD0FgOnbvA1/Xxzi2hHNj5ghYgNoltA3ICUOiVEsuOg6Lesv9FM
         jVmQ==
X-Gm-Message-State: AOAM530H1uqdAJnANhh1d7eIoNySzlG6r5FWyZFFSznW/8MXfau1sP7J
        jDBW40HcJvClRte4HiYfDiE=
X-Google-Smtp-Source: ABdhPJyzHkYxOFzos55YN8ZbLOIrEKzr+PynMSdVQHTHv1t7afVp1jk9IzOykGzQ4N7Ba7DCOJqdtg==
X-Received: by 2002:aa7:918f:0:b0:4cc:3c00:b2dd with SMTP id x15-20020aa7918f000000b004cc3c00b2ddmr27075322pfa.77.1645571596340;
        Tue, 22 Feb 2022 15:13:16 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:2ada:62da:c2a8:ce2c])
        by smtp.gmail.com with ESMTPSA id a22sm14283550pfv.73.2022.02.22.15.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:13:15 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:13:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
Message-ID: <YhVuCfDgFF/K5Gtl@google.com>
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
 <220221.86a6ejakun.gmgdl@evledraar.gmail.com>
 <CABPp-BHmU8-a+McANE2bdAndGEtVudr74FHEEj6K6NwYECEZ6Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202221311480.11118@tvgsbejvaqbjf.bet>
 <220222.8635kb832w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220222.8635kb832w.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> To a first approximation what makes it core.* is that we have a
> core.sparseCheckout.
[...]
> Anyway, as noted (and I feel I have to comment as the originator of this
> thread) I think the bikeshedding about namespacing is less important
> than making sure from a user perspective that these are discoverable.

Agreed.  Though there's already also advice.updateSparsePath; even
though I suspect that ctrl+F for "sparse" is what people may already
be using in practice, a pointer from the git-sparse-checkout(1) page
would be welcome.

> E.g. core.sshCommand doesn't reference ssh.variant or the other way
> around, and in my "man git-config" they're at ~25% and ~90% in to what's
> now a *huge* document. You need to read the whole thing or have the
> foresight to search through it to discover both.
>
> So for core.sshCommand and ssh.variant, and core.sparse* and sparse.*
> cross-linking etc. would go a long way...

Agreed as well.

> Aside: I do have some local patches (waiting on a couple of other things
> I have outstanding) to add a "CONFIGURATION" section to all of the
> built-in commands with some including/splitting up of
> Documentation/config**.txt, so "man git-sparse-checkout" would have a
> section listing the subset of "git-config" applicable to the command.

Oh!  I was about to do a quick patch for git-sparse-checkout.txt, but
this is even better, so I think I'll wait for you to send those. :)

Thanks,
Jonathan
