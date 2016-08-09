Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4F01F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbcHIR7u (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:59:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932212AbcHIR7D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:59:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A80A932306;
	Tue,  9 Aug 2016 13:59:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HEhD7uboZWhnv5r3gFmnWTpBznY=; b=wBN2Cg
	FM/xbs0tXtVCC4QHYqZ9eBYw506Qdwa65+4mgET4N8tVxPcsf+6vzROpIH1V4wcy
	dompbJIN9dUtY5FrpRUXu1amyIcWR/+NtKqu9oW54GQs0pJr7zgQBtXBbKfhiQvq
	z6FJoZng0NutalMYiSaUSXd+A5L6y0L5yknK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SFSu3PGOrC4M/jgbySQr9FNC3VnDQkCv
	4WA+SFM52y17qsnqxJN3sBg9M5sVlVGYiWib/5NHBXadgASTXO4T2u72UTroVtSL
	F+6Wyq4yPkaupW778q1X1ozdfNZcJ8TKAdgIRcgX3y7tYeElUwMN8GSBfWgvJ5Rj
	guBpc3WBvwk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E78432305;
	Tue,  9 Aug 2016 13:59:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3597932304;
	Tue,  9 Aug 2016 13:59:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, mst@redhat.com
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
References: <20160809040811.21408-1-sbeller@google.com>
	<xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com>
	<xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 09 Aug 2016 10:58:59 -0700
In-Reply-To: <xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Aug 2016 10:47:10 -0700")
Message-ID: <xmqqziolaknw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F46E1A64-5E5A-11E6-8CAA-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> "you did ask me to use alternates once and for all when setting up the
>> superproject: now for this added submodule I don't find the alternate;
>> That is strange?"
>
> Absolutely.  I do not think you should expect a user to remember if
> s/he used alternates when getting a copy of the superproject long
> time ago.  Giving "info: using from ..." is good; giving "warning:
> not using from ..." is probably irritating, I would think.
>
> Stepping back a bit, when the user says --reference-if-able, does it
> warrant any warning either way?  I.e. "we made it borrow from there,
> so be careful not to trash that one" may be just as warning-worthy
> (if not even more) as "you said we can borrow from there if there is
> anything to borrow, but it turns out there isn't any, so the result
> is complete stand-alone."  It feels as if we can go without any
> warning at least from "git clone --reference-if-able", unless "-v"
> option is given.
>
> I have a very strong opinion what should happen when the end-user

Too many proof-reading and rephrasing.  "I DON'T have a very strong
opinion" is what I wanted to say.  Sorry for the lack of last-time
proof-reading.

> facing command is "git submodule", but if I have to choose, I would
> prefer to see "git submodule update" tell what it did with "info:"
> either case, i.e. "info: borrowing from ... because the superproject
> borrows from there", and "info: not borrowing from ... even though
> the superproject borrows from there".
