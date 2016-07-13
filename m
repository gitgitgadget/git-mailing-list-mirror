Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A614920196
	for <e@80x24.org>; Wed, 13 Jul 2016 17:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbcGMRht (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:37:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752772AbcGMRhr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 13:37:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C56912B751;
	Wed, 13 Jul 2016 13:37:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YBoGqqNlgbnh
	f2nM0gyr5+AxGRE=; b=eLIYMTA/iOC0q87iRt2/LpJD6VTzDXIBq5xPou2WG/eI
	Rm9TgGtcmGfkKl7pF0wLNndJGuiFnwNf9OYOlTk74A7KYoYIL3u5IUFYq4L/AV8q
	Bh7a38RovOMBSQY1u0KpgFBh2kBnK887IB5MIetihYonmQ0YDARL1Qpkizg0dJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OGyQ6i
	SDDQVqTJBEcYhdIPa3I/uLdYl1ggi1tpViQfsAH0HEYN8MCes9hWrcV1cFDIwKmh
	QGoQTXzkreg/0DN9OFL28q2XwwzxBCoWGK10/whHNfsnmtErzqR37vvtrvZlL5D9
	UmqHfsPPU9+N5CzJ/pvZ3XDiqXYcpRXCFVWic=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE5E02B750;
	Wed, 13 Jul 2016 13:37:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 585A32B74E;
	Wed, 13 Jul 2016 13:37:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jehan =?utf-8?Q?Pag=C3=A8s?= <jehan.marmottard@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Bug report: --invert-grep and --author seems to be incompatible.
References: <CAFgjPJ-E0k8KQjdcRki4Qr1tPjwfJVtuFWOKYV-+f6POgb-=wg@mail.gmail.com>
	<xmqqtwft1nbi.fsf@gitster.mtv.corp.google.com>
	<CAFgjPJ-E=eW_ZiAUf2jKu6z3WfW_p+BMbEJwf=OSGUXQB78kwQ@mail.gmail.com>
Date:	Wed, 13 Jul 2016 10:37:38 -0700
In-Reply-To: <CAFgjPJ-E=eW_ZiAUf2jKu6z3WfW_p+BMbEJwf=OSGUXQB78kwQ@mail.gmail.com>
	("Jehan =?utf-8?Q?Pag=C3=A8s=22's?= message of "Wed, 13 Jul 2016 19:16:31
 +0200")
Message-ID: <xmqqlh151lst.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F3ABF26-4920-11E6-9583-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jehan Pagès <jehan.marmottard@gmail.com> writes:

>> I think --author=someone greps the "author " field in the commit
>> object looking for the hit with "someone", and your request asks to
>> show commits that either do not have "something" or was not written
>> by "someone", I would guess.
>
> Note that I can still see commits with "something", and I can also see
> commits by "someone" in my results. So my request actually ask for
> commits which have neither "something" nor are done by "someone".
>
> Anyway I don't think that's the expected result, hence is still a bug.
> Am I wrong?

Unlike "git grep", "git log" works with boolean expression that does
not explicitly have a way to say "--and" and "--or", so only one
interpretation has been chosen long time ago.  All the terms are
ORed together, and then the whole thing can be inverted with
"--invert-grep".  i.e. you are telling an equivalent of

    $ git grep --not \( -e "author someone" --or -e "something" \)

with the command line, and there is no way to combine the requested
match criteria (there are two, "author must be somebody" and
"something must be in the message") differently.

Given that, that is the "right" expectation, and as long as you get
the behaviour, there is no "bug".

You can call it a lack of feature, though, and patches to implement
a more flexible combination of match criteria like "git grep" allows
is always welcome.
