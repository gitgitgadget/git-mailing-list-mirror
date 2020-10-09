Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E81AC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F74222365
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 21:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RP0Wtod1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbgJIVNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 17:13:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57009 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgJIVNE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 17:13:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAFB472F66;
        Fri,  9 Oct 2020 17:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sk7yw7r1YgGxznuyrG2OxYlAjgo=; b=RP0Wto
        d1jFkiuW/PVq2EPGzT2W6RQqitZ5Q/EmgbKSFHlbic+S5HBRfHr+syQoXj/ybguC
        QQ+BLIT7Im+gM2C96EEkg/FSXOCxjx0fhMlwfl0N/DqFrrYjITp5cfBisnWM3aK1
        FeNcTjqKTYDYP4azoSeWRegs24C+1ouTbfNIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U7zdPZaPCD2Yog7nzh+W4VFT2555QEtt
        T2z1rcl1mBtlyMvsPe88t2vt+ggXkU54hKZUApRMhs4ehxAgzZkfihWJ53ginEHC
        iqXmFSluVqr1THuCWMZlUxkRfKDYG3xGNllWupCOscAMyOrBTP3us/u6F1i/F87B
        6LKvLJufuLY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6646472F63;
        Fri,  9 Oct 2020 17:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 883BC72F62;
        Fri,  9 Oct 2020 17:13:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 2/2] commit-graph: don't write commit-graph when
 disabled
References: <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
        <pull.747.v4.git.1602276832.gitgitgadget@gmail.com>
        <4439e8ae8fdc9abf28df29d3038a1483d9084cf2.1602276832.git.gitgitgadget@gmail.com>
Date:   Fri, 09 Oct 2020 14:12:59 -0700
In-Reply-To: <4439e8ae8fdc9abf28df29d3038a1483d9084cf2.1602276832.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 09 Oct 2020
        20:53:52 +0000")
Message-ID: <xmqqft6nrtlw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3624E3BA-0A74-11EB-8E69-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (!the_repository->settings.core_commit_graph) {
> +		warning(_("attempting to write a commit-graph, but 'core.commitGraph' is disabled"));
> +		return 0;
> +	}

Makes sense.  We probably would want to short-circuit invocation of
commit-graph related tasks in the maintenance by checking the
feature, if we are not already doing so.

Thanks.
