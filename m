Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5819E1FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 09:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbcHPJxP (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 05:53:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753439AbcHPJxN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 05:53:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25C20319D6;
	Tue, 16 Aug 2016 05:53:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WpRfyrcur77h
	Iz8cru94JoYERd0=; b=T/tnFYPZ9L2YvAJxoMyeZ8AsY9rbjJVeaW8/ombiL/2F
	IbJrJEUJNb/gFFaXEkpJEa/gvrCkIGDmpv72NBQHcM41zN6Dkp/FPU8l3cPnHsFP
	IeckcEwcEIXySSNQCwq1mW1Dbhxx0g7dlp91g7XKT7b2Y6yGPE9XfobQ4j8+4JA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rVSn0L
	dHxvHDrPK3pYtSCQtM3Fa9vwLZM5s7Z/U14Cank/CEUD5zcf8RM3v4VlGMNoYUdF
	aebb0CUHpmawwU902xqWnpvlKAbHD8lsqMCROY/mjWe4wmRyxl4ciLJjCtoAgyNE
	rIT2TbXj+HaDhq7LMbOWtLcCOFORsLMdY9PyQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E677319D5;
	Tue, 16 Aug 2016 05:53:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AE11319D4;
	Tue, 16 Aug 2016 05:53:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly platform-independent
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
	<xmqqk2fihv90.fsf@gitster.mtv.corp.google.com>
	<xmqqoa4tg2yi.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608161026110.4924@virtualbox>
	<alpine.DEB.2.20.1608161035320.4924@virtualbox>
Date:	Tue, 16 Aug 2016 02:53:09 -0700
In-Reply-To: <alpine.DEB.2.20.1608161035320.4924@virtualbox> (Johannes
	Schindelin's message of "Tue, 16 Aug 2016 10:42:19 +0200 (CEST)")
Message-ID: <xmqqmvkddoqi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3E2DE6DE-6397-11E6-B091-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > > By the way, doesn't ls-files take pathspec glob, saving one extra
>> > > process to run grep?
>>=20
>> I specifically did not do that, sorry for omitting the rationale from =
the
>> commit message. The reason why I have that grep is so that the backsla=
sh
>> can also catch non-ASCII characters, such as "Hell=C3=B6-J=C3=BCni=C3=B6=
".

That's clever and I did miss that.  It deserves an in-code comment
next to the use of separate grep to prevent others from making the
same mistake in the future.  Having an explanation in the log message
would help but not sufficient for a subtle construct like this.

The trick to catch non-ascii depends on core.quotepath set to true
(which is the default).  You would need to run ls-files with an
explicit "-c core.quotepath=3Dfalse" to be safe.

It also means that the addition of HT to the grep pattern I
suggested is not necessary, because ls-files will always use "a\tb"
form for a pathname with HT, and you will catch it by looking for
the backslash.  You can lose '"' from the grep pattern for the same
reason.

Two other tricky things are

 (1) the test may be run inside a tarball extract and "git ls-files"
     may not report the pathnames in t/.

 (2) the user may not have a working Git yet in her path.

The invocation of "git -c core.quotepath=3Dfalse ls-files" needs to at
least have 2>/dev/null to squelch an unnecessary error message.  In
such a scenario, we may miss a new offending pathname, but we will
not have false positive and I think that is the best we can do.

Thanks.
