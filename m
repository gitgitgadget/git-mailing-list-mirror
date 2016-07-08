Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C806206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbcGHWT5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:19:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756446AbcGHWTz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:19:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2DFB2A641;
	Fri,  8 Jul 2016 18:19:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZOpJqd+gzV5UuHcmeZ5DrxK4pzU=; b=BSC42c
	Cjtx1LwGD1ehwA/tqLH2qsumgUCr7EYGSrMho/oiyQLkeYg+2y22S62ny4IDc7J2
	XDqBcp3mRoIZUC98tvBJxWWXFxsiNilBwaEbb1YZDx+65fiYR9chyLmPg2vsX4J0
	MH9PR9+Jc2t94/inss9nRid4oH3tWY5VelMzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNi826IFwadXd3Zp5nKBGuijp5wZVmiv
	DAL7QGpf40VSUXMS6RPZKv+tb/it2kCCjiDLkQGymh+mH4HElGq2rASRDSId0JyI
	RsoctB5M73JlP2cNuQFHKiWmTYtiKJfcRBVEywHCUJYp94FtJ7WAZZv9Bp7/Weee
	/uWPQSX0E0s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DC2D92A640;
	Fri,  8 Jul 2016 18:19:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 671FF2A63F;
	Fri,  8 Jul 2016 18:19:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Lightle <dlightle@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Fast-forward able commit, otherwise fail
References: <CAP4gbxqjHzqHhPuNK8UOwPMa46g2=vcNSk1AvGjxN8s+ou-0Dw@mail.gmail.com>
	<xmqqh9cnrvp2.fsf@gitster.mtv.corp.google.com>
	<xmqqr3bokeib.fsf@gitster.mtv.corp.google.com>
	<CAP4gbxp6qKntysrkyTSWxkQNpqPzf2gHLiKpJzA-TmqO71sHyg@mail.gmail.com>
Date:	Fri, 08 Jul 2016 15:19:51 -0700
In-Reply-To: <CAP4gbxp6qKntysrkyTSWxkQNpqPzf2gHLiKpJzA-TmqO71sHyg@mail.gmail.com>
	(David Lightle's message of "Fri, 8 Jul 2016 14:28:02 -0500")
Message-ID: <xmqqbn27lqm0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 180E84DC-455A-11E6-819C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Lightle <dlightle@gmail.com> writes:

> In your above scenario with Alice & Bob, wouldn't that same issue come
> up in _any_ rebase workflow (--ff-only)?  From what I've read this is
> a typical consequence of requiring fast-forward merges; to be
> effective, the rebase step must  be more likely to succeed in a time
> window than for someone to have pushed additional changes (otherwise
> you end up in a loop like above).  But I don't believe that's
> inherently any worse with the change I'm asking about which  would
> only take that existing flag (--ff-only) and additionally create an
> actual merge commit when those conditions are present.

True, but that does not change the fact that you would be adding
_more_ code to support a workflow that we know to be bad.

> In fact, I just noticed that GitLab has built in the functionality I'm
> looking for even, which is what they call "Merge commit with
> semi-linear history" but I'm asking whether direct support for this
> approach would be reasonable.  These approaches can all produce the
> "untested merged product", but they support the way the users want to
> use the system as well.  I'm not saying any approach is right or wrong
> as I'm not qualified enough to say.

We, not being a for-profit entity, do not have a strong incentive to
add features that encourages bad workflow to the users.  Of course,
we also do not necessarily stop them if users really want to shoot
themselves in the foot ;-), but such a change would inevitably be of
lower priority to us.

