Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B111F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbcHOUYh (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:24:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752941AbcHOUYg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:24:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B107E343EA;
	Mon, 15 Aug 2016 16:24:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P7deqHb1uChhyU7SgRmXVvvMiPs=; b=XOxhSm
	QKGKDusMjhHTxd9YSA8Uu9UzwlOPWNCvHXiGzmlyEsKgv2E61UwHmRn6v+WZ4zRT
	4Y3EPyG+BIu48dDA6BYZYAOzrJ4Lt/nHhaBgLM+xIZE0EGFhxoJDDiZrQr4ek9uL
	NVLUDG8joc38sP49Wzgq4bAzxKumgnhIIEjGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cpmZwAEpSaYT1S/NS5i9nCgm1A4Gm4JZ
	s4X8PYnVtXFB3iSKym0h/irkWyw7TEBNQcvh07eHtIr2FUiCrLYCFUVXt0L58EKD
	jzPLQgkkS2UBPseNYhKjuEq2uLn23SxKYOHZ4F3iOtEVAusKqvVCLGXjHLyt0S/w
	ZCPOWCMWs94=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A85EE343E9;
	Mon, 15 Aug 2016 16:24:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1FB57343E8;
	Mon, 15 Aug 2016 16:24:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jakub =?utf-8?Q?Nar=C4=99?= =?utf-8?Q?bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
	<20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
	<e4232cba-aae8-8426-c730-7914bb750363@alum.mit.edu>
	<20160813085904.lykoihh4v2lf4yuj@sigill.intra.peff.net>
	<CAGZ79kaMSkRfkBng_Epq+2T_q--VkKQ6-m=M_jPkzeYcxuDKWA@mail.gmail.com>
Date:	Mon, 15 Aug 2016 13:24:33 -0700
In-Reply-To: <CAGZ79kaMSkRfkBng_Epq+2T_q--VkKQ6-m=M_jPkzeYcxuDKWA@mail.gmail.com>
	(Stefan Beller's message of "Sun, 14 Aug 2016 23:33:46 -0700")
Message-ID: <xmqq60r1hjb2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 482AF800-6326-11E6-A7D4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Maybe we can enable Michaels heuristic with the same
> config/command line flag, i.e. "the flag changes its algorithm"?

I think that is a very sensible proposal.  After all, the name
diff.compactionHeuristic only tells us what part of the diff process
the heuristic is used, and does not say anything about what the
heuristics does.  It is neutral between "take a blank as a hint" vs
"take indentation leveles as a hint".
