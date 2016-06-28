Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B282018A
	for <e@80x24.org>; Tue, 28 Jun 2016 21:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbcF1VNx (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 17:13:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752227AbcF1VNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 17:13:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C31FA260A6;
	Tue, 28 Jun 2016 17:13:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jpw6oDOAtxpjkAUzJtLRGjgBZ6g=; b=l6rFSa
	KyJK4BaGqM6MNqq8HuSndsbZv87m/TnLnmGH7uyTRp2ebZyC3S+KKLM8RY8gPGcF
	B28Y1vNKjnHBAOHhk7uc9IW5ws96IzEjOCZC8TLgzWju5TzA98/fnBbyji63/bJg
	nqaMj5ZEx3ORVt4t9BbXje//2de1M+2lkDEJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qeOJoP4p7FsjDgjqCG3isu49HXGJBQIu
	1K/W06FIvE+ew/oAQF19jr7LXia9sYtCnWXejVG++tgHDPzQOzwIBioFiWJWH18k
	Zzwjo1MWi1m5xB/wMyQ1LtlY4AEM9x2tG2jGSiEW9hBWvpLqzx+wpOcixQrW53+4
	7tY4Zchlb5c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BBACF260A5;
	Tue, 28 Jun 2016 17:13:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 444BB260A3;
	Tue, 28 Jun 2016 17:13:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Hahler <git@thequod.de>
Subject: Re: [PATCH] rebase -i: restore autostash on abort
References: <20160628175704.26095-1-ps@pks.im>
	<xmqqa8i587cx.fsf@gitster.mtv.corp.google.com>
	<vpqvb0tqc46.fsf@anie.imag.fr>
Date:	Tue, 28 Jun 2016 14:13:49 -0700
In-Reply-To: <vpqvb0tqc46.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	28 Jun 2016 22:42:17 +0200")
Message-ID: <xmqqshvx6mpe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 365789D0-3D75-11E6-8185-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> It is "interesting" if you mean "matches real-life use-case", as it
> corresponds to the case where the user killed the editor (as reported by
> Daniel Hahler indeed, "Abort with ":cq", which will make Vim exit
> non-zero").

Yes.  It is an interesting failure mode in that sense.  But breakage
of such a basic mode is something an end-user is likely to notice
immediately, so in that sense, having such a test alone is not all
that interesting.

> If you mean "likely to trigger nasty bugs", then indeed testing the case
> when apply_autostash fails is interesting: for example, calling
> die_abort when "stash apply" fails is tempting, but would lead to
> infinite recursion (it doesn't seem to be the case, but a test would be
> nice). Setting the editor to something that modifies uncommited-content
> before 'false' should do the trick.
