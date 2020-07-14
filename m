Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF2FC433E3
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542E020773
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="irNHDBKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgGNE1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:27:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52169 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgGNE1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 00:27:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38DDBD1978;
        Tue, 14 Jul 2020 00:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rpHhp0nHdbgjLCVjrc7SLdq3s0M=; b=irNHDB
        KHKgi6K8/jZAmCCZQax3ugK/2bs69oBfLDs/+X6apnq2UfPQvoridAIGpQ4pvkqR
        8V3Zc0uske9GASPEzlYdUPdFdWG4E0sD27/Ic8J4AJ8pbwvvVESCWuwsM6vsxD4r
        0/j3HFwPEoFJsxOxPMtTtK2VL+a2FO4xvf+1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dFx1VJ5k5sPg9H0Mi2GYqDptmei5n34r
        2Sctk+0NaR6yRzeoQjqTAqPEAyVHWuq2pUpPDyrJg80q4D6ex+kT3JFRkCGy7zrJ
        VvQzzNnEVoaOGQVyt0oXrZ5xRC+mE/38aG3wdl/WI1soPScWf3VtyzJ6tq1SdNUy
        WG8//FZiiKM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31333D1977;
        Tue, 14 Jul 2020 00:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 744EAD1973;
        Tue, 14 Jul 2020 00:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] setup: tweak upgrade policy to grandfather worktreeconfig
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
        <xmqqblkjnr5m.fsf@gitster.c.googlers.com>
        <xmqqy2nnmbh8.fsf@gitster.c.googlers.com>
        <xmqqpn8zmao1.fsf_-_@gitster.c.googlers.com>
        <b8ae18f7-a0af-bd62-2553-92989e1dbe7e@gmail.com>
        <20200714040616.GA2208896@google.com>
Date:   Mon, 13 Jul 2020 21:27:28 -0700
In-Reply-To: <20200714040616.GA2208896@google.com> (Jonathan Nieder's message
        of "Mon, 13 Jul 2020 21:06:16 -0700")
Message-ID: <xmqqa702n2kv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54ABCAA8-C58A-11EA-8ED9-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> It's too late to go that far for 2.28.  It would be tempting to try a
> simple revert of 14c7fa269e4 (check_repository_format_gently(): refuse
> extensions for old repositories, 2020-06-05) to get back to tried and
> true behavior but that does not do enough --- it still produces an
> error when trying to upgrade repository format when any extensions are
> set.  So how about such a revert plus Junio's patch plus the analogous
> change to Junio's patch for
>
>   extensions.preciousObjects
>   extensions.partialClone

My illustration patch was done "assuming that worktreeconfig is the
only thing we wrote by mistake without updating the format version",
and if these two also share the same problem, I obviously is 100%
fine with covering these other ones with the same approach.

I like your "v0 and v1 are the same, but the repository is declared
to be corrupt if the extentions that are not known by today's code
is found in v0 repository", by the way.  Assuming that the two you
listed above plus worktreeconfig are the only ones known by today's
code, that is.  We seem to also know about "noop", so shouldn't it
also be grandfathered in?

