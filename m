Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D242018E
	for <e@80x24.org>; Mon,  8 Aug 2016 18:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcHHSIj (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 14:08:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752054AbcHHSIi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 14:08:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36F8633C8C;
	Mon,  8 Aug 2016 14:08:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c4AQYRC4LcwdA4pqYhORUZaqfVQ=; b=vI1tLy
	cpfpO25vVTwslifgrQl8oDDK7w8+D7c/LHZuy8Eds0ct3+y+wYmDzooxQ6YNXK5b
	i9m2RAV+ka2mEdZCeQQ3NWHwUwnJ611lEQwK35WghePk9GxzDC3pJw413Ap3vekR
	SoktaQHmka9qxfYDXQgYVwe7nVEJka73V+qzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eYJKEYJ9VbGUeh6X7CO/OeXJ8LPRehYo
	8wkJjQwqUtK2NeAooh1gJ+DWIU+GeIxBjY35tNdhIAhDvF+XxwDiqmAxLjKVRgkm
	1oP1nBzo9ZNalH7G6vQyfFSyZySCjaHv6IcYoswNeWmNrEA7DRl/9RzH9RT2Jsm1
	r0sDE2cKzEw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DA6533C8B;
	Mon,  8 Aug 2016 14:08:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93C5A33C89;
	Mon,  8 Aug 2016 14:08:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pack-objects: Teach it to use reachability bitmap index when generating non-stdout pack too
References: <20160729074051.GA5987@teco.navytux.spb.ru>
	<20160729074746.31862-1-kirr@nexedi.com>
	<20160808135600.c6hdlqwwtqe7thd5@sigill.intra.peff.net>
	<20160808154054.GB3995@teco.navytux.spb.ru>
Date:	Mon, 08 Aug 2016 11:08:34 -0700
In-Reply-To: <20160808154054.GB3995@teco.navytux.spb.ru> (Kirill Smelkov's
	message of "Mon, 8 Aug 2016 18:40:54 +0300")
Message-ID: <xmqq60rbf80t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 206A9606-5D93-11E6-A237-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> Thanks for the info. I did not knew about show-index when I was starting
> to work on this and later it just came out of sight. Please find
> corrected patch below.
>
> ---- 8< ----
> From: Kirill Smelkov <kirr@nexedi.com>
> Date: Fri, 29 Jul 2016 10:47:46 +0300
> Subject: [PATCH v5] pack-objects: Teach it to use reachability bitmap index when
>  generating non-stdout pack too

Please don't do this (not the patch text itself, but saying "Please
find ..." and attaching the patch AFTER 60+ lines of response).
When going through old/read messages to see if there are patches
that fell through the cracks, if it is not immediately clear in the
top part of the message that it contains an updated patch, such a
patch will certainly be missed.

Please say "I'll follow up with a corrected patch" instead of
"Please find ..." and respond to that message with just the patch.
