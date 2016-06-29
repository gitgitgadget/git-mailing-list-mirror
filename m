Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B25B1FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 17:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbcF2RSu (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 13:18:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751449AbcF2RSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 13:18:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 66E1927D45;
	Wed, 29 Jun 2016 13:18:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vx7L43APUo5A8x+oZw0sZRoF8t8=; b=oKVunU
	XXMNNau6TieACCrEdZDgsleGtptd9AaM57Tie4JbiNKAbZyXck3L0cJSvg9hJ3lW
	G1e1qHTXXkRUPxUcpGQyr2ZWOYAe3OM7pYRHGwSGy0EqFJhOSy/rOCWEl/Ew1Ai3
	tlkc2JT1zLdmSAUzgspUXPCOKy1g7a/mIcrmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tYLIQjuwmG6Lv3kvmDAkb5YbwCPkHtVn
	wN/F8rgXgAYWuuUlNn3XVA/jUwRSby6LtgnDd+87ycBZq6uGNy8ibVPVeQXNEKIa
	tXtTQnlCuTYBdkXlkpWpkfDdpy/2iYKQzH+FSG9xz+SfZWJkO1XmmuW8IPAwNz4l
	73hR9zWU9Yg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FB7327D44;
	Wed, 29 Jun 2016 13:18:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C64F527D43;
	Wed, 29 Jun 2016 13:18:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: add a rule to re-run previously-failed tests
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 10:18:26 -0700
In-Reply-To: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 09:02:37 +0200
	(CEST)")
Message-ID: <xmqqy45n52xp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F11B4CC-3E1D-11E6-8E6A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> While developing patch series, it is a good practice to run the test
> suite from time to time, just to make sure that obvious bugs are caught
> early. With complex patch series, it is common to run `make -j15 -k
> test`, i.e. run the tests in parallel and not stop at the first failing
> test but continue.

Hmmm, my tests run in parallel and do not stop at the first one
without '-k'.  What are we doing differently?

> It is the most convenient way to determine which tests failed after
> running the entire test suite, in parallel, to look for left-over "trash
> directory.t*" subdirectories in the t/ subdirectory.

Good idea, but I'd drop "in the t/ subdirectory" from the
description.

> +failed: $(patsubst trash,,$(patsubst directory.%,%.sh,$(wildcard trash\ directory.t[0-9]*)))
> +

This would not work if you use --root=<there> in GIT_TEST_OPTS, I am
afraid.
