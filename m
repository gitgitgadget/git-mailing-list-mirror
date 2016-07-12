Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5501FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbcGLPtq (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:49:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753197AbcGLPtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:49:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0568429736;
	Tue, 12 Jul 2016 11:49:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LsbXJVHA0HWHOg1k3n/Q9JcSaPc=; b=DhDy1L
	z8SnF5wneoBEH1sOrt62cHY7atvCSvOvAs+EguL69b4EpCkVz5w6j0BQXvDyPsv5
	1h4wMrr96T3PegNP7yHsoX7J+Zgh+vVXnOHtOcQn80BxBH787bLBrE3A/IShNWQg
	lZAPfPcc2NqVXWa96Ho5ZswM6/hoRuwXIdZTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CPdqihBg6Maq2brcZdS0r2InE0idO5L3
	mtnPFd4K3K/aGXyWQ6wJH/P1IZdxG+pCO3m4ZOW+XP8893ZiRODR/qfZ1uffzDEK
	dWEvsJBhIJa685ApCKU1xPgrbZh2J51xl6cVeyRBN+rLl8pmjAslUAqZNQxNjP59
	JqdsYRNgfv4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F22D329735;
	Tue, 12 Jul 2016 11:49:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E6C029734;
	Tue, 12 Jul 2016 11:49:43 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	lists@haller-berlin.de (Stefan Haller)
Cc:	dlightle@gmail.com (David Lightle), git@vger.kernel.org
Subject: Re: Fast-forward able commit, otherwise fail
References: <xmqqr3bokeib.fsf@gitster.mtv.corp.google.com>
	<1mqa4a5.1ykwh5b8vc9q7M%lists@haller-berlin.de>
Date:	Tue, 12 Jul 2016 08:49:41 -0700
In-Reply-To: <1mqa4a5.1ykwh5b8vc9q7M%lists@haller-berlin.de> (Stefan Haller's
	message of "Tue, 12 Jul 2016 15:24:48 +0200")
Message-ID: <xmqqeg6y7t62.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40513FF2-4848-11E6-8866-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

lists@haller-berlin.de (Stefan Haller) writes:

> I have read and re-read this thread a hundred times now, but I still
> don't understand why it makes much of a difference whether or not Bob
> rebases his branch onto master before pushing his merge. In both cases,
> Alice and Bob have this race as to whose push succeeds, and in both
> cases you end up with merge commits on master that are not well tested.

One crucial difference is that at least you _know_ that $tip^2 has
been well tested, when you do not rebase, and you can check out
$tip^2 to study and understand how it was supposed to work, when the
merge of the topic into an updated mainline is found to be faulty.
That knowledge helps you to go forward--you'd need to adjust some
untold assumption $tip^2 made, which was broken somewhere between
$tip^2..$tip^1 on the mainline, to an updated reality.

Once you rebase, you end up with "This series of changes once was
working well, and during the rebase somewhere it stopped working",
unless you say something like "these 7 changes were originally
developed and tested on commit X" in the rebased commit.

