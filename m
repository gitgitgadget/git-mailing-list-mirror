Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD728E7D26A
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 09:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjIZJFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 05:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjIZJFE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 05:05:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C2DD
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 02:04:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5044dd5b561so8094229e87.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695719096; x=1696323896; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+HtewvZVc6V1QfP3F3Rq3O3aKbJodSn+ylcJPuwl+Y=;
        b=f0hCRrsuNRzB7YinIwL7XCae1B+zTYgZ77/vO/s854NDG/pbjkyyCx7/PGjXTx8VeT
         qFh4wk5OBWl1LYNYlnOzm0pXdhf8VDyVIB0LhFs4VC9OC4Ra9goNgiBgnHMelmnLTgm9
         RMvIVZGm2+OdtfoVk7GRuRd6vWZV8cuxWTDXVimfKFuhB1SujDKL5q8w7uYRM8/okkFI
         uz0/+48PXCRY701QgqhUOMajvsvCUuUbLKnIX0AKtD0Fo5ldj9b7g+GQvdXo31c3eLKE
         avQyhSyuf/ocAX80xlzKulDtFveCPKgTOLdbMycvka2NRTyhbeEPmNADNcwCAIV7mIk0
         zN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695719096; x=1696323896;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+HtewvZVc6V1QfP3F3Rq3O3aKbJodSn+ylcJPuwl+Y=;
        b=ORksk8CyCMIh3IO+abbM1Rw077Y3NmfURc9uDIB7md4SMgoHS8fqIudT8NBBdk0qkq
         /zYIUAPcMyI7KY+MauvWrhUXG+ds6LBdtEgBz75sBY8UdmW+OwU2IuOk5su3DFca8iNC
         sajNVniUUaV1Cxc/aDdSEMy0fpdv1zBXrpmFIlL78kCS+uz/VOQQi3hXdLiorFKYZUs+
         +O8B/jnMGQQNtFL4FTqbfo2qVfS6c0gZGjtNtbjuyYnbEeuDFn75P0wBgPaUpDBrBfbY
         JKZTpH3XThMpweZjAXZ1eKaEyymPz9AwAmQQVU2kqZi06ZrTBO44Q79BDLSChQSlT/V9
         0Mhw==
X-Gm-Message-State: AOJu0YyuqukowuBLEC7wUkLRzNQVBM6nSx7mCe7oleq7LRmQPxPEt0rK
        SUitkw/Bo0BG0kYMIRidXmzM6/TOL2I=
X-Google-Smtp-Source: AGHT+IEsfYekUQ0XlFZbfYm+llITEgzalPoGoHZWGDlx3d0/jmv77ZUGvuCafoOUpKRPprnKJ8RtcA==
X-Received: by 2002:a05:6512:3d1c:b0:503:383c:996d with SMTP id d28-20020a0565123d1c00b00503383c996dmr10794749lfv.12.1695719095415;
        Tue, 26 Sep 2023 02:04:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d24-20020ac24c98000000b005008cd9396bsm2143431lfl.25.2023.09.26.02.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 02:04:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
        <xmqqtts0tof8.fsf@gitster.g> <87o7i7hler.fsf@osv.gnss.ru>
        <xmqqled8h01w.fsf@gitster.g> <87y1h8wbpo.fsf@osv.gnss.ru>
        <xmqqzg1nfixw.fsf@gitster.g> <87ttrudkw9.fsf@osv.gnss.ru>
        <xmqqjzsdps0h.fsf@gitster.g>
Date:   Tue, 26 Sep 2023 12:04:54 +0300
In-Reply-To: <xmqqjzsdps0h.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        25 Sep 2023 19:50:22 -0700")
Message-ID: <87bkdpl2yx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> P.S. I also figure that maybe our divergence comes from the fact that I
>> consider merge commits to be primarily commits (introducing particular
>> set of changes, and then having reference to the source of the changes),
>> whereas you consider them primarily merges (joining two histories, and
>> then maybe some artificial changes that make merges "evil"). That's why
>> we often end up agreeing to disagree, as both these points of view seem
>> pretty valid.
>
> It rarely is the case that two opposing world views are equally
> valid, though.

Yes. In this particular case the two are not opposing though, rather
orthogonal, as they reflect the intrinsic dualism of the concept of
"merge commit". Merge commit is both a new state, and history junction,
neither of which is more or less valid or essential, and I use both
views myself, depending on situation.

An electron is both a particle and a wave, and one just uses its side
that is more convenient for explanation of the case in hand.

I promote features that I routinely need in my workflows, yet respecting
the other side of the coin as well, even though I may rarely find this
other side useful. I mean, for me, this -c/--cc (let alone -m) output is
only confusing, yet I won't be saying that it's somehow less valid than
proposed -d.

> If there were an option that forbids any comparison output from a
> single parent commit (say --ndfnm "no-diff-for-non-merge"),
> then those with "merges are the primary thing, single-parent commits
> on the merged branches are implementation details" worldview would be
> commonly using "--diff-merges=first-parent --patch --ndfnm" and (1)
> viewing only the combined effect of merging side branches without
> seeing noise from individual commits whose effects are already shown
> in these merges, and (2) traversing the side branches as well, so that
> merges from side-side branches into the side branches are viewable the
> same way as merges into the mainline.

No need to ask for a new option, as the behavior you describe is already
there, and is spelled "git log --diff-merges=first-parent"
(--diff-merges=1 for short).

> But because no such option exists and nobody asked for such an
> option during the whole lifetime of the project, I highly doubt
> that it is a valid world view with wide backing from the users.

Your concern above seems to be void, so this doesn't hold either.

As a side-note though, something like this has been asked recently, as
what you describe by --ndfnm should in fact have been what --no-patch
does, but surprisingly does not (please recall recent discussion of this
issue).

> Even if it were a valid world view with wide backing,

Apparently it is valid, otherwise there would be no need for diff to
first parent at all, let alone "git log --first-parent -p" have used it
by default.

> the combination "--diff-merges=first-parent --patch" would be less
> than ideal presentation for them (due to lack of "--ndfnm").

First, as we figured above, --ndfnm is not needed, and second, me, being
one of "them", tries hard to convince you it is the best presentation
"them" can get, while "ideal" simply never exists.

> And as I already said, it would not be useful without --first-parent
> traversal for the worldview git has supported.

Yes, you said it earlier in this thread, and as well I already explained
how it is useful without --first-parent.

> That is why I find it of dubious value to let short-and-sweet '-d'
> be squatted by less than ideal "--diff-merges=first-parent --patch"
> combination.

Hopefully I do understand your concerns, yet I believe
"--diff-merges=first-parent --patch" is way better for "-d" shortcut
than "--first-parent --patch", for the reasons I already explained
earlier in this thread.

> Shorthands are scarse resources, and we want to be careful before
> handing them out.

Yep, agreed.

I believe I carefully thought it over though, weighing all pros and
cons, and thus -d fits nicely among -c and --cc, being yet another
frequently desired format for merges, plays nice with -p as well, and is
very mnemonic, giving us convenient, user-friendly, and consistent user
interface overall.

Thanks,
-- Sergey Organov
