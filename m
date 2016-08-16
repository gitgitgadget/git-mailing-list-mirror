Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6ABF1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 21:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbcHPVbV (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 17:31:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752041AbcHPVbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 17:31:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEA1136DDE;
	Tue, 16 Aug 2016 17:31:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=njsYt1dZEMupchlF3NzZ3zXpsU0=; b=w1PI2p
	yGdASXoX/4nWWbnu7qpBvg6oaSUv91iXSrF6N7hEnIe9wttrmQUKu3yBE4mUsfJF
	mefGMdfY8Ql980tObbgM8kLslK3QGvb2D+nNBWwPsJ4fZtwnj6Y0A7LQy0eZC7eH
	xTz6Aq4BdDyuyISlrAe5Xjlu5zLFv0KE1sNj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qk0QpxDXZF8fBwKTK3PgO7lnOnKTwzD1
	gvaaShrf2NVO9zJeAFNM1KPvY1zf2+MRWJAa6Gu73GMoJSMHmN6eMuNJbMVTtW4g
	2sdxC8DVdXhguI2dL9MoxBgETicg07ABmRBeVQEdQ815THWm6Vwb7QCTaqtMmMjy
	rNI6mW5knmM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5EC736DDD;
	Tue, 16 Aug 2016 17:31:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BCB636DDC;
	Tue, 16 Aug 2016 17:31:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 3/3] diff: add SUBMODULE_DIFF format to display submodule diff
References: <20160815230702.30817-1-jacob.e.keller@intel.com>
	<20160815230702.30817-4-jacob.e.keller@intel.com>
	<xmqqh9akczyp.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xqc_WwzjUnF5P4arBhBqgRbtXyKC9QWtRJ3+fmx0Q2+oA@mail.gmail.com>
	<xmqqvaz0bemk.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xrnUAN8M4UX0hZN213yUKndb_4d+AjohWV45KvCdJm9PQ@mail.gmail.com>
Date:	Tue, 16 Aug 2016 14:31:17 -0700
In-Reply-To: <CA+P7+xrnUAN8M4UX0hZN213yUKndb_4d+AjohWV45KvCdJm9PQ@mail.gmail.com>
	(Jacob Keller's message of "Tue, 16 Aug 2016 14:20:30 -0700")
Message-ID: <xmqqmvkcbdui.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C54CB7B0-63F8-11E6-B2F0-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Thoughts on that? Or should we just limit ourselves to only some
> options get propagated to the submodule?

I think you have to be selective either way.  You do not want
pathspecs used to limit the top-level paths propagated down when you
run a diff or a log in the submodule, for example, and that does not
change even if you start using the code in diff-lib.c (after adding
the submodule odb as an alternate).

