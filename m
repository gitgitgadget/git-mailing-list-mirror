Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169AAC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC12A2078E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZBFQwNQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbgFXAKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:10:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59792 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbgFXAKq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 20:10:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86D8169B0D;
        Tue, 23 Jun 2020 20:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TKkopZgosUVbqKP6MpHJkO5psnU=; b=ZBFQwN
        QgYpfrb9jGDsz92X+k447GB+7F38G50WcECExGSJwUWTPydc2cVMgu1bxCjFE5P9
        y/P3x1xnnZFlLOUcr9avwNZ6WUa4vPLbcyC9BH9OjKghQroPEFxjgzEv4vTEcAp4
        7W6guO8v3wgOk6DxR6i8f0jxQ30WZiYkE0yg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gek22hi+ilE06QCNzDfzbtTrzHECUbJ7
        JEd0bHPrWsko/xeMMzvQWhhfKpFi8Rs8Krq4JcOk+BMNml3KgUMkjpGUU58/xFu4
        5Bg8YababTHp3ZfBUsOVivp1NIeCuuJUVTD2iiDilbjbcapojfIQWW5cWzkyDhcm
        5Qf2DNmH5wU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E12769B0C;
        Tue, 23 Jun 2020 20:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 057F369B0B;
        Tue, 23 Jun 2020 20:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] diff-files: fix incorrect usage of an empty tree
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
        <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
        <b9633315a2f09a56a46259a8540f458747250d6f.1592916485.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:10:43 -0700
In-Reply-To: <b9633315a2f09a56a46259a8540f458747250d6f.1592916485.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 23 Jun 2020
        12:48:04 +0000")
Message-ID: <xmqqv9jh9vcs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2572FF12-B5AF-11EA-B22A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
> 2017-05-30), the OID to use for intent-to-add files was inadvertently
> changed from the empty blob to the empty tree.

Well spotted.  Regardless of the other two patches, this is
absolutely the right thing to do.  It is quite embarrassing
that nobody noticed the typo so far.

