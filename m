Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C691F461
	for <e@80x24.org>; Mon,  9 Sep 2019 17:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfIIRx0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 13:53:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55627 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfIIRx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 13:53:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C60C929F7B;
        Mon,  9 Sep 2019 13:53:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fgT2jdo/ORHdfe4Urodh8QpwGZs=; b=RCgg2e
        YypxL/P6JLIyzg+yUgskIjF1lILwpMev3NuK6DPc+/TN16lbRkUmXnOZCl45UxT+
        2AA25uGhYR+M6GMpDq8NqiiWfV0u5jFWw1/i9oNPuePzkXFyIBuATfpl6DrpT+PC
        Kv0M751b9SS1nVsydmdzghgs+kIHjPlGS3XiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=udi1w3CV5xZ2fbvgjyAvw0poQcaNNzZk
        WWGRFHWoj+H1z2vZqm9GzAoTCMW1ou888ncKYYlo1K5n8o+ramG74rRGLsp17Tui
        kTO7UmqieY7Fn790UAgQqCvlPxPUlUcj2JrW3WXPtZrCfhA/d08Ei7SVG4NDpPK+
        asbXntWAgm0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE4B929F7A;
        Mon,  9 Sep 2019 13:53:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11FD229F79;
        Mon,  9 Sep 2019 13:53:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
References: <pull.328.git.gitgitgadget@gmail.com>
        <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
        <xmqqef0xtd3p.fsf@gitster-ct.c.googlers.com>
        <d550ac23-cb65-b547-d9dc-1428ee2e9420@gmail.com>
        <xmqqlfv1m72p.fsf@gitster-ct.c.googlers.com>
        <20190907045101.GD24463@sigill.intra.peff.net>
Date:   Mon, 09 Sep 2019 10:53:23 -0700
In-Reply-To: <20190907045101.GD24463@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 7 Sep 2019 00:51:01 -0400")
Message-ID: <xmqqmufdl5kc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8056A6C-D32A-11E9-A966-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Generation numbers are a little trickier, though, because they imply an
> actual topological traversal. It might actually be easier to couple this
> with the connectivity check we do after index-pack finishes (though I've
> often wondered if we could drop that check in favor of making index-pack
> smarter about finding the boundaries).

Currently after scanning the incoming objects with the fsck
machinery, we count the number of objects that are pointed at by
these objects in the pack and are not in the pack in the
builtin/index-pack.c::check_object() function; at that point, we no
longer know who points at the object in question, which is needed if
we want to compute the boundary, so we need a bit of work here.

With boundary information, we could be smarter about lazy fetching,
I presume?
