Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28010C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 04:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43FC20936
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 04:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i+r8tsW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIPExR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 00:53:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61673 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgIPExR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 00:53:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1FEF780D7;
        Wed, 16 Sep 2020 00:53:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=slGzXIVxunSWa7Z1dkrUSaGO9B4=; b=i+r8ts
        W0tCMChto931SJ4DR6FSRHBwLyTAwyXEDIm5jIlSSsf7NfeBEFovgSo7SVX5AsLx
        YO6bsdTZezHfVJGBKandtYK2J3hg4oIrqNK19a+Qjd0AT9c6X709qC64eo27TbI6
        Y50VJC65PMINKKuAslxxoqiXfsQos0e3ukswQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VEG68YVDRAiE695hFncBO+2sKwPNMZGF
        lGrNw7mn0DyPSCi+fKe5owO3CGX55T1BjIkCnKA2FjrUIQhV3+tq1Ms+foNAF+pd
        7KP1Ba0lGREDBfGRZwPOnLdFnUMKJ7x1N7ZHplcEq9Ucp0/D6fxh0wnKnl3+22tG
        lFFQcA1TPsQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA83D780D6;
        Wed, 16 Sep 2020 00:53:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 702A0780D5;
        Wed, 16 Sep 2020 00:53:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/3] git branch: allow combining merged and no-merged
 filters
References: <20200913193140.66906-1-alipman88@gmail.com>
        <20200916020840.84892-1-alipman88@gmail.com>
Date:   Tue, 15 Sep 2020 21:53:13 -0700
In-Reply-To: <20200916020840.84892-1-alipman88@gmail.com> (Aaron Lipman's
        message of "Tue, 15 Sep 2020 22:08:37 -0400")
Message-ID: <xmqq8sdaxqyu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8764E4EA-F7D8-11EA-883D-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

>> I do not mind making the 0/1 a symbolic constant between
>> do_merge_filter() and filter_refs() for enhanced readability,
>> though.
>
> If I understand the convention, the constant names should be prefixed
> with DO_MERGE_FILTER. I suggest DO_MERGE_FILTER_REACHABLE and
> DO_MERGE_FILTER_UNREACHABLE. Happy to re-roll if others have a
> different preference - or feel free to edit.)

Even though I said "I do not mind", using DO_MERGE_FILTER prefix is
way too much noise.  The common prefix is appropriate for external
API, but this is merely an internal contract between a private
helper do_merge_filter() and its only caller.

If I were redesigning the code around this area, I probably would
rename do_merge_filter() to something more descriptive, and tweak
its parameters a bit more focused, e.g.

    #define EXCLUDE_REACHED 0
    #define INCLUDE_REACHED 1
    static void reach_filter(struct ref_array *array, 
			     struct commit_list *check_reachable,
			     int include_reached) {
		...
		for (i = 0; i < old_nr; i++) {
			struct commit *c = array->items[i];
			int is_reached = !!(c->object.flags & UNINTERESTING);

			if (is_reached == include_reached)
				array->items[array->nr++] = array->items[i];
			else
				free_array_item(array->items[i]);
		}
		...
    }

    /* the caller */
    ...
    reach_filter(array, filter->reachable_from, INCLUDE_REACHED);
    reach_filter(array, filter->unreachable_from, EXCLUDE_REACHED);

to make it clear which part of the callback struct is really passed
between the caller and the helper.  Even if we are not renaming
things that much, a locally defined preprocessor macro with shorter
names, defined just before the callee, would be more appropriate for
a case like this, with a single callee called by only one caller.

Thanks.
