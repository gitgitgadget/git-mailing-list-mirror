Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 374AA1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 22:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbcHLWxI (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 18:53:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751953AbcHLWxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 18:53:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A613A35CF4;
	Fri, 12 Aug 2016 18:53:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7h9gvSMsOi6lwVFUVpBHwfm8GSc=; b=QVen1M
	FklNVoqlNvrZuros8X3Rbrl4/sFwQyzhLdU5NZL8Y6cmu3PW1Pe3fXq5UjY79u9S
	iKkV8GWZmxNRR7aJgNu/6Iiq5Wi6xzGezZBeyUJ+l9R4xDBEj3erBpz5B/SkIaNW
	BW7GN+ED0cwtthj4WWIqPQriUEzN16EaJN5uU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kwBVbvF6s5Gk2287G7ZsMsne6FzvtZDZ
	lAJIfpB/i0hA8Oj3ZPX4MalWRbc1yvMcQXB/R6RtCZKnmvnUk/EJvTORSZIrRevN
	SLAgvGD4FhkWui/o6fknV3co4FPaHH6yrf7qyBwZpP7kLIW9bHe3JwJDyhMCy2gy
	5kDfKEE3VYo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E82135CF3;
	Fri, 12 Aug 2016 18:53:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2748035CF2;
	Fri, 12 Aug 2016 18:53:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ralf Thielow <ralf.thielow@gmail.com>
Cc:	git@vger.kernel.org, larsxschneider@gmail.com, me@jnm2.com
Subject: Re: [PATCH] help: make option --help open man pages only for Git commands
References: <CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com>
	<20160812201011.20233-1-ralf.thielow@gmail.com>
	<xmqqk2flvfhb.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 12 Aug 2016 15:53:03 -0700
In-Reply-To: <xmqqk2flvfhb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 12 Aug 2016 14:34:24 -0700")
Message-ID: <xmqq1t1tvbu8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88472F88-60DF-11E6-8A61-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I love it when I say "This shouldn't be too hard; somebody may want
> to do a patch", with just a vague implemention idea in my head, and
> a patch magically appears with even a better design than I had in
> mind when I said it [*1*] ;-)

Having said that, I wonder if we could do a bit better.

    $ git -c help.autocorrect=1 whatchange --help
    WARNING: You called a Git command named 'whatchange', which does not exist.
    Continuing under the assumption that you meant 'whatchanged'
    in 0.1 seconds automatically...
    No manual entry for gitwhatchange

We are guessing that the user meant "whatchanged"; shouldn't we be
able to feed the corrected name of the command to the machinery to
drive the manpage viewer?

