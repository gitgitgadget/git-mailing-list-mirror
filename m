Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E797D1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 19:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbcHLTYb (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 15:24:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751088AbcHLTYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 15:24:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7795C3452E;
	Fri, 12 Aug 2016 15:24:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JxfwRnyhKQJdU/4BEenELz4z6QI=; b=Pxvilo
	dGhpgXs0asR7IY/Yt22KcPqk/aZe7RVFvFVszmUiTBAIwC5ZqtpcIKy+rYfIOpdP
	PeXo9MV3A1p/PlTgeTgOhb8zJEcnov/u63ZXcy4ig/4vfIIG01HdHV0qsDo+VXEy
	vDxk+jOpINMWzNz1SJVNRrWQaeoUbXZFA14wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o6kjFTjUOj8xfNLGg/h5Fjxv7mPapDL9
	GZx5fHRkCDK6zaQ/YMBzSQRSTp/eNLR+wKA8UI/ukmHhgAa2eWc6kXLm4uWWmTVn
	pE7HsYFZyO7a3k109mZU2I4kc5ajB9Hb39dk+Qjn6FjWwWEOijqqq7fCJFUtdIUD
	VjMtHPJrBlM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70E0B3452D;
	Fri, 12 Aug 2016 15:24:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEF883452C;
	Fri, 12 Aug 2016 15:24:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v12 04/13] bisect--helper: `bisect_clean_state` shell function in C
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
	<010201567675ae50-4349bd9e-54a4-44e5-aabb-1d928126b237-000000@eu-west-1.amazonses.com>
Date:	Fri, 12 Aug 2016 12:24:26 -0700
In-Reply-To: <010201567675ae50-4349bd9e-54a4-44e5-aabb-1d928126b237-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Wed, 10 Aug 2016 21:57:19 +0000")
Message-ID: <xmqqlh01x02d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63749938-60C2-11E6-9C24-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int bisect_clean_state(void)
> +{
> +	int result = 0;
> +
> +	/* There may be some refs packed during bisection */
> +	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
> +	for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
> +	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
> +	result = delete_refs(&refs_for_removal);

I think this function has changed its signature recently.  I am
planning to tag 2.10-rc0 this weekend, and it may be a good time to
rebase the series on to an updated codebase.
