Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4A1C56202
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 05:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3459F24695
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 05:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g5K8yaVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgKRFnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 00:43:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53224 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRFnL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 00:43:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 169B41023C2;
        Wed, 18 Nov 2020 00:43:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GrmbiyjjXOgz0HqF/hZ+vz4z9uc=; b=g5K8ya
        VwdSlL6sy7csiZfjbAguaX7RBF062S1ETMsJI+uTKpaXi9EobDJv6Ip3bAsMiQAN
        EgESdsy2u8qz2r1WQd+XOiOOEvLqIuILEshvknAgDiRhppO5YBaVaynsJf75YR7h
        y2JHRM9rD5xS+DSllG2fnGN+HdMdCtsVf/3GM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b+l0Isk8dH3nD9Ka/Es2XsYCO9lxzh/8
        rhgr68EpL1d67Gp0IK1J6aszi/QNtBZ7qgCis04BtMAilxheIcdYKwtFWvJ0jLaw
        ubgoRF6ovsYqI245GBtG0W0f6zj0FVdBINDTaWZriQldrCibTrxoEIYBrnTcOyCw
        GeE2VpHlswo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 005681023C1;
        Wed, 18 Nov 2020 00:43:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3AFC91023C0;
        Wed, 18 Nov 2020 00:43:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
        <20201117233313.GB642410@coredump.intra.peff.net>
        <xmqqr1or4jen.fsf@gitster.c.googlers.com>
        <20201118012544.GC650959@coredump.intra.peff.net>
        <20201118024028.GE360414@google.com>
Date:   Tue, 17 Nov 2020 21:43:04 -0800
In-Reply-To: <20201118024028.GE360414@google.com> (Jonathan Nieder's message
        of "Tue, 17 Nov 2020 18:40:28 -0800")
Message-ID: <xmqqima343vb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEA8D5D0-2960-11EB-AF5F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> IMHO, though, all of this is orthogonal to question of what the default
>> is. Unless we are thinking the basename thing would work as a default,
>> but I don't think that resolves any of the backwards-compatibility
>> concerns.
>
> If we think it would make sense as the *eventual* default, we could use
>
> 	[init]
> 		defaultBranchName =
>
> (i.e., an empty string) to request it early.

I am not opposed to the idea to invent a notation that asks for the
basename behaviour, but I do not think it is a good idea to use "an
empty string" for that.  I'd rather see us use some consistent
naming convention to denote any new "non-constant string" thing.

What Peff suggested is a more viable possibility, for example.  When
"[init] defaultBranchAlgorithm = <name>" is set, the fixed string
"init.defaultBranch" is ignored and the algorithm specified with its
name is invoked to come up with a name dynamically.  We may start
with something like 'dirname' as the only supported algorithm but
that way we would avoid painting ourselves in a corner out of which
we cannot escape (e.g. we may come up with a better way than the
basename thing, and we would not have a good way to give it a name
that is easy to use if we wasted "an empty string" for the basename
thing).
