Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0951F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbdAYWzB (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:55:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65316 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752418AbdAYWzA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:55:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C464637DB;
        Wed, 25 Jan 2017 17:54:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xj1jMJVHIPSG3m0Kh1/O4PCUxdw=; b=laHybM
        2vqafxqbFNPfOMfFxE5aEgpMeczO3fMGFvVjOaSOlnASBwYtY5JWJnecnDAawsDN
        d3ffJ+xDCSNQWrvZ8MODA6eeulxnxmFCueBNkYh7dMw71KdpHb+4nBYNOdGyHi5l
        s8uTOVWb/Ww7bWk44VNsUTNvX7B359jZQAWbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZoIaif3xVF3sidW30rDK5aax5RJa9jYQ
        VLP1S4lrOnWs9f628a6GWUPxgqu9UjE+m/u53XEGFA9IJqKR9BsjhgvJEji1ATIW
        U0kkkdA9YtWvnqbFg8bSj+pb+eGShvlMWSw5diM9hqjhzsELNx1n7YRkL1E9W3js
        ld4PWbkvYfM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 624B8637DA;
        Wed, 25 Jan 2017 17:54:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA9C4637D9;
        Wed, 25 Jan 2017 17:54:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net
Subject: Re: [PATCHv2 3/3] submodule absorbing: fix worktree/gitdir pointers recursively for non-moves
References: <20170124221948.GB58021@google.com>
        <20170124235651.18749-1-sbeller@google.com>
        <20170124235651.18749-4-sbeller@google.com>
Date:   Wed, 25 Jan 2017 14:54:57 -0800
In-Reply-To: <20170124235651.18749-4-sbeller@google.com> (Stefan Beller's
        message of "Tue, 24 Jan 2017 15:56:51 -0800")
Message-ID: <xmqq37g692da.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BF83280-E351-11E6-B5B4-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Consider having a submodule 'sub' and a nested submodule at 'sub/nested'.
> When nested is already absorbed into sub, but sub is not absorbed into
> its superproject, then we need to fixup the gitfile and core.worktree
> setting for 'nested' when absorbing 'sub', but we do not need to move
> its git dir around.
>
> Previously 'nested's gitfile contained "gitdir: ../.git/modules/nested";
> it has to be corrected to "gitdir: ../../.git/modules/sub1/modules/nested".

That sounds like a sensible way to make things consistent.

