Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CACC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9D622B42
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cleeQmHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgGaUMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:12:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51197 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaUMF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:12:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D10577288;
        Fri, 31 Jul 2020 16:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zw7/3OCX8Lpr5H9JKZgloPvTroU=; b=cleeQm
        HKirqtQorP/jKN0K4Ok8aZV5MPje39J3aGxdOCkvikNQt2XKcbXfwLwtKeUMrwo6
        ScumsOoqX63w4PAQ/3WGYnxB7Uo8Mjn/MA0RZewhxz8SG4PGkXDF8jd2iS+PrJBx
        s9zsOwwloGCiHuY/qT9H9syYrv90Hiqy3UIn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wK84/ntRWBJAkcqyqbBZGXKwxLmEEv6S
        dgZhfTRIphC9IKXa8JJqmr53cJbMaXMowAfvrjtbkYdcs8omeRXMHlhHRNmd18r/
        ir4ZgJ7bVUuHWxfQbS3CaelOVOeQcpmkYEBk34GUmqOBsDI7hzTy1k8qzbnZa/v1
        skAJGjr2D0o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 657AA77287;
        Fri, 31 Jul 2020 16:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E712177286;
        Fri, 31 Jul 2020 16:12:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fmt-merge-msg: selectively suppress "into <branch>"
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
        <20200730180237.1392480-1-gitster@pobox.com>
        <20200731004202.GA240563@coredump.intra.peff.net>
        <xmqqy2n04ezk.fsf@gitster.c.googlers.com>
        <20200731022217.GA825094@coredump.intra.peff.net>
        <20200731200306.GB3409@syl.lan>
Date:   Fri, 31 Jul 2020 13:12:02 -0700
In-Reply-To: <20200731200306.GB3409@syl.lan> (Taylor Blau's message of "Fri,
        31 Jul 2020 16:03:06 -0400")
Message-ID: <xmqqlfiz30ml.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 191E8CE4-D36A-11EA-888F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I think that you could do this without treating 'master' as specially by
> making 'merge.suppressDest' contain the value of 'init.defaultBranch'
> (unless set otherwise).

My understanding is that much more instances of repositories come to
exist by cloning than running "git init".  Hence, the value you set
to the init.defaultBranch has no relevance to the name of the
primary branch in majority of your repositories, whose primary
branch is what their origin has designated before/when you cloned.

And the latter, "what is the primary branch name for this particular
repository?", is what we want to ask here.  The answer to "what is
the first branch name for new repository I will create?" is not a
good proxy for that.

Thanks.
