Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF9ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 22:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiHaWSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 18:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHaWS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 18:18:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6443E992A
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:18:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w63-20020a25c742000000b006960ac89fedso3121808ybe.18
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date;
        bh=npQIBSKFB5LZ1+KVreQCRs7X0t7AUvIBRT0qbG6XGFs=;
        b=G7JjN93Re/WcqZVSQNAsqgZq8y053h7ubRPKOY+zrVxvsZWVRBmRYQhmMAx99rdj7W
         zBHaw6ASIFJJKzo34JiKi/uz7O4Dqy6mL/v9dvyBcGBV82qImeSX/a1tuw/6CpHV/HQw
         LJOCV5BeoIJGHBe4n0pMJKQ1EFLSFHF7On8/O6iuw89C0m4C7nqaKdAoRyYTypFru4hc
         qO3i9UTjlVkbgqzLea8eXlRaTX5hbWpUQW3MfsY5AwQw/AtF02Y3A4uDohTAVPH9DeLx
         UUtgBdlraDX67niTQh69qsGZB0xLHMaozOu+vSUaYtVgGx2fZLh+g757XetPMSo+0ugV
         cXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=npQIBSKFB5LZ1+KVreQCRs7X0t7AUvIBRT0qbG6XGFs=;
        b=sMFkPAwbPDbpBBxQAD0fpiDu8XzFjACT3aA4NmHHl/8UQ9NY4iz+pQDICXprvX5o4S
         /3Cv3S3dw/qYCZJTDxxkSKYqplPcD/qUvL2dma9YDuPYQ+PPPs/nGpNUDSdqpjd3ijKJ
         uM+5OhqWPF32UEysS2O1NmOAX1p4JICVRZWnI8XHEbMlyFKZNXObv9K9Dk7o9+zAzKYT
         IznOr1xd68epfYJg6NMakJI/TsnGEZFffNlxsNKiewt2DCz2IqrIBJmcMIvyvWy59X35
         i4uso3npf/y32TZYnQs+IFJG04S5VolSGIum8lo8PWvmW0zsSOQZA/y63AlJ2ZcM14TN
         UO0Q==
X-Gm-Message-State: ACgBeo2cMKniT9ZGZpzyfxqsdK/wHpJqJw+2QaOeH25dxNlzzZXM2lGo
        RwNN5xseySYfvcZae2KD/HLAw04pJZ4rjUvzCUfV
X-Google-Smtp-Source: AA6agR7usEKf0PdeqyMwyFfpQFA1Ky3PAZG+3CZBkf8LjRRbNCw8oNiqiK3TVsY6WfhVJHFsEQ2wO3oIKiPwSFsqT1rS
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:32c4:0:b0:695:540e:c6b2 with
 SMTP id y187-20020a2532c4000000b00695540ec6b2mr18420063yby.155.1661984305031;
 Wed, 31 Aug 2022 15:18:25 -0700 (PDT)
Date:   Wed, 31 Aug 2022 15:18:22 -0700
In-Reply-To: <xmqqilmkcc7i.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831221822.374872-1-jonathantanmy@google.com>
Subject: Re: [PATCH 5/7] bundle-uri: parse bundle list in config format
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > To allow for the incremental fetch case, teach Git to understand a
> > bundle list that could be advertised at an independent bundle URI. Such
> > a bundle list is likely to be inspected by human readers, even if only
> > by the bundle provider creating the list. For this reason, we can take
> > our expected "key=value" pairs and instead format them using Git config
> > format.
> 
> "can" does not explain why it is a good idea.  "As a sequence of
> key=value pairs is a lot more dense and harder to read than the
> configuration file format, let's declare that it is the format we
> use in a file that holds a bundle-list" would be.
> 
> I do not personally buy it, though.  As I hinted in an earlier step,
> some trait we associate with our configuration fioe format, like the
> "last one wins" semantics, are undesirable ones, so even if we reuse
> the appearance of the text, the semantics would have to become
> different (including "syntax errors lead to die()" mentioned
> elsewhere in the proposed log message).

One reason for using the configuration file format (which perhaps could
have been better explained in the commit message) is that we plan to
have a way for a repo to advertise a list of bundles during fetch.
I think that config is a natural place to put that, even with its "last
one wins" semantics.

It could be argued that we can just put a single URI in config and only
allow advertising of a single URI (and then use a different format for
the bundle lists with semantics that are stricter than "last one wins"),
but that seems unnecessarily restrictive (and would make the client make
one more network request). And if we're advertising multiple bundles, it
seems reasonable to make all bundle lists have the same format (whether
they are in config or in a separate file).
