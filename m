Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17430C43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 03:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996A7207EA
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 03:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tjER/2Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIED0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 23:26:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62540 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgIED0P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 23:26:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7329180F10;
        Fri,  4 Sep 2020 23:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XRhQGFy7Gvw6MfcwE7T3Yi28mh0=; b=tjER/2
        UaUZGEaMwb2VhVW7ikUWLu8WaU5R3ncosS1AtSiMEbmj2AdSW22W2tLqOMmC52j9
        sRfmQQfeyWAULidNgyDp1cUQEzHLwQZZBne9TFa8UmTMyWfEMbVITTFCvdLJZP45
        r51uhT+cQUZfRGcRem3gCcXIdW4gv8wBInoaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P4E6qet2JpnnWZ6/exk58BqIW+1ENBaq
        xanneVbEoqRnLrmPK3DVLcjLjQJZU+fPY9zwA9MEvdW7cnRhUNGTBe29Rfsv4IPF
        Whuk7MJziuebP/MOk7dD8Lp8sO/bekjgQLaHzNUis48UrKhafYHkwJueXUN6OyEk
        skzFH2E3Gsw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5884D80F0D;
        Fri,  4 Sep 2020 23:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B818580F0C;
        Fri,  4 Sep 2020 23:26:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emma Brooks <me@pluvano.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
References: <20200808213457.13116-1-me@pluvano.com>
        <20200809230436.2152-1-me@pluvano.com>
        <20200810100249.GC37030@coredump.intra.peff.net>
        <20200811041728.GA1748@pluvano.com>
        <20200811045509.GA81227@coredump.intra.peff.net>
        <20200905025518.GA1524@pluvano.com>
Date:   Fri, 04 Sep 2020 20:26:11 -0700
In-Reply-To: <20200905025518.GA1524@pluvano.com> (Emma Brooks's message of
        "Sat, 5 Sep 2020 02:55:18 +0000")
Message-ID: <xmqqr1rg7vl8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C78FFE8-EF27-11EA-93B8-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emma Brooks <me@pluvano.com> writes:

> However, I couldn't find a way to get "rev-list --format" to separate
> commits with NULs.

A workaround would be "git rev-list --format='%s%x00'", iow,
manually insert NUL

I would have expected "-z" to replace LF with NUL, but that does not
appear to work X-<.


