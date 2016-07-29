Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3361F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbcG2SEF (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:04:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751695AbcG2SEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:04:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D63712F2A2;
	Fri, 29 Jul 2016 14:04:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yP9w4+wB7mI/WhYLW9CGTM/cxZ0=; b=IuOmQt
	TZZMA5WE7ZmmbvONmJ/5gKnfOzrLS1bvlt65VtFGhgv6VlvIuxHJbg8O4YTUz4+Z
	xK51U/VgMxs+YO5FhQALwRAQqHsuXx3bFiUsP0jxi6FWzdi58caKxghGsE4k0gT3
	7x0ti+q1HoeSxSS6jyaqlAUyHXwTngBykPLKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QssY16ZjcFlj2V0HvvpEaw/WmcVZxfBM
	zjp9NHZz+T/uJgMef25ba5zeQPARpP6HDyr3uuQ1TBZXcygXmzolNjq6H5S9fBck
	OfRUSQH1XWyC8/r0s5djBjRjkEqnI8nCRJuNN5zW9MQk7t9i+OeAVTxZQhu2p4aC
	KucG1OgjpUM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CEDF92F2A1;
	Fri, 29 Jul 2016 14:04:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 554782F2A0;
	Fri, 29 Jul 2016 14:04:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Oleg Taranenko <olegtaranenko@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: git bisect for reachable commits only
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
Date:	Fri, 29 Jul 2016 11:03:59 -0700
In-Reply-To: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
	(Oleg Taranenko's message of "Fri, 29 Jul 2016 10:53:56 +0200")
Message-ID: <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4C6E094-55B6-11E6-B1FB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Oleg Taranenko <olegtaranenko@gmail.com> writes:

> What I suggest change logic of bisecting to something like
>
>       git config bisect.reachable true

Such a configuration should not be needed.

When a history with this shape is given to "git bisect":

    ----o---o---X---Y---B
         \     /
          o---G

and you gave G as good, and B as bad, it is a BUG that needs to be
fixed if bisect strayed outside G, X, Y and B.  Setting your new
configuration to false would mean "please run a buggy version of
bisect", which does not make much sense, I would think.





