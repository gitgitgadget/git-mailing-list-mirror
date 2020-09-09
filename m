Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2331DC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C444C20708
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O7tzwPj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgIJB7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 21:59:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64362 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbgIJBmw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 21:42:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E6248C8F0;
        Wed,  9 Sep 2020 19:06:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZedA3ynbgGmxZPH3hYar6YvnO6o=; b=O7tzwP
        j5ff2+yQhZtMLyWRoQ7XguvzK7Nu/j/Hei2dmg5MYLtmwSjNt7TeVL4g4EbhdI8t
        jvgLmmrHtjPUkYEg8hkB3cOkELCXKvX6KnF9A/tK9sqgT4QHzQlQ2N0unUGCIWkW
        k2+FRQTpNltClPEeJdo2grdA1VUv//NfCGfUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vl+qepVxgt+DQDL8eKocj8rezFFdbyYk
        4ZHZkLyaVs8UA5V6MqY0nHrrWFvagLWrlKh/TpugwjKcWAc4UA8TH8YqdhSjCRkA
        +6rcc3e9IeANqVsMok7r5Q/oFC4ZYujbSMSC6o/pVQipwRlzq8PzPX0LSLNleJF3
        SDi9LM87QV0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 568FD8C8EF;
        Wed,  9 Sep 2020 19:06:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3A408C8EE;
        Wed,  9 Sep 2020 19:06:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     emilyshaffer@google.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
References: <xmqq365zro2u.fsf@gitster.c.googlers.com>
        <20200909223631.864145-1-jonathantanmy@google.com>
Date:   Wed, 09 Sep 2020 16:06:42 -0700
In-Reply-To: <20200909223631.864145-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 9 Sep 2020 15:36:31 -0700")
Message-ID: <xmqqzh5ysg71.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20296968-F2F1-11EA-B522-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I also saw some strbuf manipulation to generate the title, but I also
> don't think that takes significant cycles compared to the task that
> requires the progress display.

I do not think we care so much about cycles.  What I find a lot more
disturbing was that this loses conceptual clarity (e.g. "why are we
generating the title unconditionally when we know we are not going
to use it?"), and that is why in the message you are responding to I
wondered if this was a price we should accept to pay, as decided to
tie the progress and tracing closely earlier.

