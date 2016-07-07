Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C19520705
	for <e@80x24.org>; Thu,  7 Jul 2016 21:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbcGGVKS (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 17:10:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751206AbcGGVKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 17:10:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8009A2B9C7;
	Thu,  7 Jul 2016 17:10:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XftVp24MZ5uvLKIuHenjLqVx3+s=; b=WRcAD6
	gdOw1glr1RO+PPym0ED2j7HdZziyzopJ90zWvhxWHxH2lzd2lcPdAlIKbrzmdaKn
	+/ss8ekg54x94tW1MA24d+sB3Tihl1QJWvuLtsqohqFoFb/FSTzIKAmvUJSyZO/o
	Up3ghwjUAxl6gXaL26RHVgfYKm+ra2kaJ7QC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qaiM0pv0w0lWCl1DkSaDFo0mSS/tE0Mw
	3nFYNzDMBPGlTYDnnNxNS6xx2fpcMp61W8aG+Fx3ItkFxQGqNJrBTTC7OYeMOf9F
	wOjshPZ58Sf/s8913L0slZ8+9WyO2ZyBU8GFA2RhdlH/SLygi2siMor11aOw2slv
	PpICxA9DNIo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7897B2B9C6;
	Thu,  7 Jul 2016 17:10:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF4C72B9C5;
	Thu,  7 Jul 2016 17:10:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] notes-merge: use O_EXCL to avoid overwriting existing files
References: <577EB6BE.6090504@web.de>
	<20160707203822.GB11804@sigill.intra.peff.net>
Date:	Thu, 07 Jul 2016 14:10:12 -0700
In-Reply-To: <20160707203822.GB11804@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 7 Jul 2016 16:38:22 -0400")
Message-ID: <xmqq1t35p32j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3318E6E2-4487-11E6-AA82-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Why do we care that the file exists? Should we instead be using the
> lockfile code to get exclusive access to it? That would also switch us
> to doing the write-to-tempfile-and-rename dance, but that seems like it
> would be a good thing. If we hit a write() error in the code now, we
> leave a partially-written file in the notes worktree.

Yeah, I had the same thought when I saw the change.

> I dunno. From my cursory reading of the code, it seems like we'd never
> really expect this file_exists() to trigger in the first place, so
> perhaps it's not worth thinking too hard about it.

Perhaps.
