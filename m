Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B072C54EAA
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 22:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjAWWa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 17:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjAWWa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 17:30:56 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7941037570
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 14:30:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 5so7617408plo.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywRD+d4Ryd81neAq4nm9tUpaf19w25BPVf7e/mExqls=;
        b=efxxKjuP36AuctpevLcYRMia8/qYM9Uw8Ict0C6AQVTsQyobhNs7hx+8O0wDW50CxG
         IZHMNutnNJB6kdb6YHZiOdj8V3AQYZ0wb0AzHde1fEgl9Udfp/drvobIuzURxaj30rlg
         +5m8trgXmbRe23ODX4xNFMLIBclP+ELKKSKnz+aYDf7b27JwFqm7hhCwtJtWnqwrxv1Z
         hAlGaI3X0yx74OJgjfm8yJJemmtawpMP4yIpAdfge/ot+xkvAOBH2TVV0W606y5Omq7H
         Vi+ynMWeE/hYTX//wlhqfMl+Rbvc+lYaRMHCvhxmF6Zk0C4OeNRt78+j28m+uIriFQJ/
         yWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywRD+d4Ryd81neAq4nm9tUpaf19w25BPVf7e/mExqls=;
        b=ZBkeaxIUMJJvjwtlDN4Mu5BlXJ/jcp+ZcJvfG7YrdhOajGDWj2UeLREoyUhDPebusy
         JADcdc6fUo3h9vqJvWDeH47FHYTrwP+wp796LZyFyV7jWtStHaSidLMoVQjQKSa6vWZE
         DJ4nfya6IH9YooRimHO1IfhEqecS6RLTDtvpO7M4U2WJAvFstaNfxSGvuYbvzZZ0+AdW
         hfkGNdRTy4fHzrS8gDp5elNYwZlA+89L8CN2qELUQPEUOrGezFRQKIVhymRUNOSAvf/0
         6zyKISOVDZkaoztn1ToLRWEY9cQTDvQxD9X4QHNUBOK331uXi7EsiQQy5Q32sOklR+oN
         JtYg==
X-Gm-Message-State: AFqh2krgnGFaZlDtNPmBS7q6Kt4ddtURX/h041AUjY+SVBtERLyZ44uo
        0p2cfQnvrGiq7eo059L/K6M=
X-Google-Smtp-Source: AMrXdXtPeTvTbmLbYI5KMEOYkbxrpVv2RQ/RIRBxvGnRhMzeBpNuROJN3x9JzaF7g78zwJdnEtdOew==
X-Received: by 2002:a17:902:8688:b0:193:19c3:4915 with SMTP id g8-20020a170902868800b0019319c34915mr23980410plo.67.1674513054814;
        Mon, 23 Jan 2023 14:30:54 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b00192e0f0e021sm186438pll.257.2023.01.23.14.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:30:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH v2 01/10] bundle: optionally skip reachability walk
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
        <xmqqsfg1m8l6.fsf@gitster.g>
        <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
        <xmqqilgxm2ky.fsf@gitster.g>
Date:   Mon, 23 Jan 2023 14:30:54 -0800
In-Reply-To: <xmqqilgxm2ky.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        23 Jan 2023 12:13:33 -0800")
Message-ID: <xmqqtu0glw81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> A repository having some unreachable objects floating in the object
> store is not corrupt.  As long as all the objects reachable from refs
> are connected, that is a perfectly sane state.
>
> But allowing unbundling with the sanity check loosened WILL corrupt
> it, at the moment you point some objects from the bundle with refs.

While all of the above is true, I think existing check done by
bundle.c::verify_bundle() is stricter than necessary.  We make sure
that the prerequiste objects exist and are reachable from the refs.
But for the purpose of ensuring the health of the repo after the
operation, it is also OK if the prerequisite objects exist and they
pass connected.c::check_connected() test to reach existing refs.
verify_bundle() that is used in unbundle() does not allow it.

In a simplest case, with a single ref and a single strand of pearls
history, with a few cruft history that are connected to the main
history but are not anchored by any ref (e.g. the tip of 'main' was
rewound recently and we haven't done any GC).

                             7---8 (cruft)
                            /
   0---1---2---3---4---5---6 refs/heads/main

And they have another repository created back when '5' was the
latest and greatest, which built three commits on top of it.

   0---1---2---3---4---5---A---B---C

They create a bundle of 5..C to update us to C.  In the meantime, we
have created three commits ourselves (6, 7, and 8) but threw two
away.

If a bundle requires commit '5', because it is reachable from an
existing ref (which points at the 'main' branch), we can unbundle it
and point a ref at the tip of the history contained within the
bundle safely.  Commit '5' being pointed by a ref means the commit,
its ancestors, and all trees and blobs referenced are available to
the repository (some may be fetched lazily from promisor), and
unless the producer lied and placed unconnected data in the bundle,
unpacking a bundle on top of '5' should give us all the objects that
are needed to complete the new tip proposed by the bundle (e.g. 'C').

                             7---8 (cruft)
                            /
   0---1---2---3---4---5---6 refs/heads/main
                        \
                         A---B---C refs/bundle-1/main

And existing check that I called "sticter than necessary" easily
makes sure that it is safe to point 'C' with our ref.

Imagine another party cloned us back when 'main' was pointing at '8'
(which we since then have rewound), and built a few commits on it.

                                   X---Y refs/bundle-2/main
                                  /
                             7---8 (cruft)
                            /
   0---1---2---3---4---5---6 refs/heads/main

As they did not know we'd rewind and discard 7 and 8, they would
have created their bundle to cover 8..Y.  The current test will fail
because '8' that is prerequisite is not reachable from any ref on
our side.  But that is too pessimistic.

As long as we haven't garbage collected so that all objects
reachable from '7' and '8' are available to this repository,
however, we should be able to unbundle the bundle that has '8' as
its prerequisite.  For that, we only need that '8' passes the
check_connected() check, which essentially means "we shouldn't find
any missing link while traversing history from '8' that stops at any
existing refs".

Again this relies on the fact that unbundling code makes sure that
incoming data is fully connected (i.e. bundle producer did not lie
about the prerequisite).

