Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7291C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F80820BED
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qTUcKq+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgIYVCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 17:02:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62249 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgIYVCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 17:02:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C043F9B88A;
        Fri, 25 Sep 2020 17:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7x+BXQ3d3z8QcW2v7JEFVYd8jZA=; b=qTUcKq
        +DHDoOMsoYixIFHOMvg1WiZcCxfFBXMSjIGrmZ7uHhL+sznwSbcHxoqfYierw1TO
        VuERSeE+FWWQBy4b+N0/EOAYilsPs4jUzm5zxWCrk3RrfySEBpuD/pslurgSQFCl
        7pOjgZYNULuXfCkUEKlQ771rhuQ2dt5uPr7aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PtktIG/a4gUEeVMQIcrj4WpaTAKZiDip
        r+lqN3rlmBcT+QPyAnaGXtAWmC9RUe87Uo+lNCfp+feQ+GNVfnzLSY8GsAoyuB7l
        c/tc4tcg5pMutgeR7ydtQgOvHxoQjpRoo7USMqEh13ZlqsuwfEcbvqHEHXbzZTSs
        qnODw3ZXquY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B69B19B889;
        Fri, 25 Sep 2020 17:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CF0F9B888;
        Fri, 25 Sep 2020 17:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
References: <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
        <xmqq363gs1mt.fsf@gitster.c.googlers.com>
        <20200918104833.GB1874074@generichostname>
        <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
        <20200920110148.GA227771@generichostname>
        <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
        <20200921172740.GA946178@generichostname>
        <xmqqwo0met17.fsf@gitster.c.googlers.com>
        <20200921215409.GA1018675@generichostname>
        <xmqqblhyepup.fsf@gitster.c.googlers.com>
        <20200923094716.GA1309694@generichostname>
Date:   Fri, 25 Sep 2020 14:02:11 -0700
In-Reply-To: <20200923094716.GA1309694@generichostname> (Denton Liu's message
        of "Wed, 23 Sep 2020 02:47:16 -0700")
Message-ID: <xmqqh7rlk1t8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61E65676-FF72-11EA-9A2C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> And worst case scenario, if we receive user reports that they believe
> the feature is inconsistent, it's 100x easier to change it to allow
> ranges than attempting to remove support for ranges in the future.

If we allow ranges from day one, we do not even have to worry about
it, no?
