Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA82C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5897E218AC
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BrNMS2N8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgIOVtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:49:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59021 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgIOVtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:49:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 325F87F0DB;
        Tue, 15 Sep 2020 17:49:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ihb+E1flYbzzK8omC7cyMZRDMRY=; b=BrNMS2
        N82Rtzv7td9vKNxnNi9R22jj07xnO8+ULCv9KVMb+VeTcoK0XUcrA6zNEm/C0FnC
        f/uxsJ+o7Nm3PPXVQ2boFn9iVhEFRLif0W6aJCApfB73L1xxd7FfgO5RXNdQs32I
        CFV8KyM50skQ/Fx/0BwSYewpoNSG4/d1S/JyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PHRhybwua9k6X3Ma+OVeum6snpG3/7zL
        nbC3fHtJqyaqYdwrQeTZOfqxxFtifLHiUSgHy78gk/HWD3GGscQZBtKzhCnvqchP
        WjMdapVvJmbrSQ0in4E8abH6PWSemnig6fuUstsmggX3GI/iIkrQjpxFUAS11bkR
        5Q38w1z7K4A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 298EC7F0DA;
        Tue, 15 Sep 2020 17:49:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7FC97F0D8;
        Tue, 15 Sep 2020 17:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, szeder.dev@gmail.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
References: <cover.1599664389.git.me@ttaylorr.com>
        <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
        <20200911175216.GA2693949@coredump.intra.peff.net>
        <20200911185934.GA2871@xor.lan> <20200911192555.GA3612@nand.local>
        <20200914201258.GA12431@nand.local>
        <134d64a0-abb6-bdc9-2c05-7aded01a906a@gmail.com>
        <20200914203659.GA12855@nand.local>
Date:   Tue, 15 Sep 2020 14:49:37 -0700
In-Reply-To: <20200914203659.GA12855@nand.local> (Taylor Blau's message of
        "Mon, 14 Sep 2020 16:36:59 -0400")
Message-ID: <xmqqv9geyaku.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59D1CCA4-F79D-11EA-B97B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> It's getting a bit difficult to track all of these "use this instead"
>> patches. But, I'm not the one applying them, so maybe that's not actually
>> a problem.
>
> The above list is the only changes that I've made, so I'm happy if Junio
> wants to follow what's written there, but I'm equally happy to send a
> new reroll.

It's getting so unorganized to follow from sidelines.  Even
resending just the few steps that needs replacement, indicating
which ones are replaced with them, would be easier to manage (and
full replacement would be the easiest to handle).

Thanks.
