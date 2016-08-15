Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F0B1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 17:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbcHOR6F (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 13:58:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753204AbcHOR6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 13:58:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2780233C27;
	Mon, 15 Aug 2016 13:58:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=17GWPL1SZCz22W3cnPZhie6q780=; b=u1NPu1
	Lmxvar2OrjG/7KZefc3ME5zn2CxnU4JipDYhCSwXJFwyIeRBidDfs+4wJbcQFPXy
	fcnYnlGXu/cToYLys4q79d7FYSzIhAKLNFWRIsLMUQ4kcMm+XIRNivpwh3BZJ7V1
	6ggTv107xHpgmhSVt8keMHigF8Sa1QyD9ErFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=azH+iVBcoBnwbkcwnzW9hScxE7E2g07W
	CrZdWO0brOnOhwXsl6MXbr3M1SQWb4ZQSG/kd8RTCX2pWOMMQqvQZYDlXHGKrDo6
	F+5ddH6c8jihbyZqIxIwmU/7Ir7bjkrTwUJrYl3Zwlk+1FrvZsjPGYY2/C6jr9OT
	Qoqxj5kQOVw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F6B433C26;
	Mon, 15 Aug 2016 13:58:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9870A33C25;
	Mon, 15 Aug 2016 13:58:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	"Ralf Thielow" <ralf.thielow@gmail.com>, <git@vger.kernel.org>,
	<larsxschneider@gmail.com>, <me@jnm2.com>
Subject: Re: [PATCH v2] help: make option --help open man pages only for Git commands
References: <20160812201011.20233-1-ralf.thielow@gmail.com>
	<20160815053628.3793-1-ralf.thielow@gmail.com>
	<D954CB3E6C3445AF9358C6941362B69D@PhilipOakley>
Date:	Mon, 15 Aug 2016 10:57:59 -0700
In-Reply-To: <D954CB3E6C3445AF9358C6941362B69D@PhilipOakley> (Philip Oakley's
	message of "Mon, 15 Aug 2016 12:25:40 +0100")
Message-ID: <xmqqr39phq3c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF6CCEB6-6311-11E6-9C0E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> I'm still not sure this is enough. One of the problems back when I
> introduced the --guides option (65f9835 (builtin/help.c: add --guide
> option, 2013-04-02)) was that we had no easy way of determining what
> guides were available, especially given the *nix/Windows split where
> the help defaults are different (--man/--html).
>
> At the time[1] we (I) punted on trying to determine which guides were
> actually installed, and just created a short list of the important
> guides, which I believe you now check. However the less common guides
> are still there (gitcvs-migration?), and others may be added locally.

I think we should do both; "git help cvs-migration" should keep the
same codeflow and behaviour as we have today (so that it would still
work), while "git cvs-migration --help" should say "'cvs-migration'
is not a git command".  That would be a good clean-up anyway.

It obviously cannot be done if git.c::handle_builtin() does the same
"swap <word> --help to help <word>" hack, but we could improve that
part (e.g. rewrite it to "help --swapped <word>" to allow cmd_help()
to notice).  When the user said "<word> --help", we don't do guides,
when we swapped the word order, we check with guides, too.


