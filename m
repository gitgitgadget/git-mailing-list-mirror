Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B9C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E4322283
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lECJlOzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgJTByf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 21:54:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50566 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbgJTByf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 21:54:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83A0BED0F2;
        Mon, 19 Oct 2020 21:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9RA6gQXVRoXn2dvZ8Esb4bjahKc=; b=lECJlO
        zAi7kFhZylkoLfDyRgmw8YeylcgSF8Kf8pnKL3hzhrxqx1qlax0bXQrwnM2nUXoa
        0g+6uj41EZWc2o9GSK+ucmKLwgq/1RrDPtprJG7nPrwMzinxoAzhszTpuYJiK1Rc
        VYP1S2B/Lrfimibl3ACu+0F2M/22l4wQ74Rs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=swMjAg2/jAEyiJPKqjY5UqodInogXvcH
        PC/UBb29tmzcaASc1GFlhfz2QyBtKS3Lyjctevp1xx2Oxh59is1LiLEB60DkhZ18
        Qc6BoXQFAmHHSnfXOR6P44ZcZknMsly44fhTVfolmsoAnGKK/SInFF7Q1LRzE5uo
        a32dJhNvDNE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D0AFED0F1;
        Mon, 19 Oct 2020 21:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C55E5ED0EF;
        Mon, 19 Oct 2020 21:54:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael Forney <mforney@mforney.org>
Subject: Re: SKIP_DASHED_BUILT_INS does not install git-*-pack
References: <CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com>
Date:   Mon, 19 Oct 2020 18:54:29 -0700
In-Reply-To: <CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com>
        (Michael Forney's message of "Mon, 19 Oct 2020 18:27:13 -0700")
Message-ID: <xmqqtuupd5m2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31A4FAE0-1277-11EB-8B56-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Forney <mforney@mforney.org> writes:

> I saw that git 2.29.0 introduced a new make variable
> SKIP_DASHED_BUILT_INS. However, after testing it out I noticed that it
> skips installation of bin/git-receive-pack bin/git-upload-archive and
> bin/git-upload-pack as well.
>
> There is a comment that says these commands are special and expected
> to be in the bin/ directory in dashed form, so unless I'm missing
> something, I believe this is unintended.
>
> This seems to be the offending hunk:
> https://github.com/git/git/commit/94de88c986712e79c20813ba54e797c4ca83137b#diff-76ed074a9305c04054cdebb9e9aad2d818052b07091de1f20cad0bbac34ffb52L2979-R2993
>
> Reverting that hunk restores git-receive-pack, git-upload-archive, and
> git-upload-pack (and only those).

Thanks for a report.  Dscho?
