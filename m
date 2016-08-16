Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB941F859
	for <e@80x24.org>; Tue, 16 Aug 2016 21:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbcHPVPn (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 17:15:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753387AbcHPVPk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 17:15:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AB7136BF7;
	Tue, 16 Aug 2016 17:14:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cWyZjhUY8l7O97opPCxavEnt9rU=; b=eBbals
	cYDKqMKHLNJbrPAU+b+CwJ9PoqDuKYKPnb4oq8eDyqVkwNxTaWnhT9ljWSExtywz
	g9BT0fZCiHU5PUmU2hfkFm0uafr+ZajOKxRTQy678cYa96jYC595IogaqeriZ9OX
	HqejMvsik8Cgibe75+OvAsjbIMcIejaKoy9uE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sOjiPAsbFgbL2X7noGfNZaFlD7652ZP5
	Gs0EQYdu3tn2GBrQaKMAo2hX2eCBe8vF5hGo0B5/ObudBeqdQuhQroL0SpfGCb4Q
	h09q95Wtd8nCLIKhRwBKqM44l5ZbtfABpiuj1jTJGZHf1ksEPS3V+HkmJEekEKsS
	pk7dOFwQx4I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7322836BF6;
	Tue, 16 Aug 2016 17:14:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA3BF36BF5;
	Tue, 16 Aug 2016 17:14:28 -0400 (EDT)
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
Date:	Tue, 16 Aug 2016 14:14:27 -0700
In-Reply-To: <CA+P7+xqc_WwzjUnF5P4arBhBqgRbtXyKC9QWtRJ3+fmx0Q2+oA@mail.gmail.com>
	(Jacob Keller's message of "Tue, 16 Aug 2016 13:25:46 -0700")
Message-ID: <xmqqvaz0bemk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B0A7F6E-63F6-11E6-8E47-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>>> +
>>> +     if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
>>> +             /*
>>> +              * If the submodule has modified contents we want to diff
>>> +              * against the work tree, so don't add a second parameter.
>>> +              * This is essentially equivalent of using diff-index instead.
>>> +              * Note that we can't (easily) show the diff of any untracked
>>> +              * files.
>>> +              */
>> ...
>> I am debating myself if this is a good thing to do, though.  The
>> submodule is a separate project for a reason, and there is a reason
>> why the changes haven't been committed.  When asking "what's different
>> between these two superproject states?", should the user really see
>> these uncommitted changes?
>
> Well, the previous submodule code for "log" prints out "submodule has
> untracked content" and "submodule has modified content" so I figured
> the diff might want to show that as a diff too? Or maybe we just stick
> with the messages and only show the difference of what's actually been
> committed.. I think that's probably ok too.

I do not have a strong opinion.  We only see DIRTY when we are
looking at the working tree at the top-level diff (i.e. "git diff
HEAD~ HEAD" at the top-level, or "git diff --cached" will not show
DIRTY_SUBMODULE_MODIFIED when a submodule has local modifications in
its working tree), so in that sense, it probably makes sense to show
the more detailed picture of the working tree like your patch does.
After all, choosing to use --submodule=diff is a strong sign that
the user who says top-level "git diff [<tree>]" wants to see the
details of her work-in-progress.

Do you need to handle "git diff -R [<tree>]" at the top-level a bit
differently, by the way?  If this function gets the full diff_options
that is driving the top-level diff, the DIFF_OPT_REVERSE_DIFF bit
would tell you that.

