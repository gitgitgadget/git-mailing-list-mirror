Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF21C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 04:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593B82076D
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 04:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fQbE6I/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIJEva (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:51:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60760 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgIJEvC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 00:51:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E5078E873;
        Thu, 10 Sep 2020 00:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Esw92ZyWmy4gINS8N8BvC6oykSM=; b=fQbE6I
        /x6mRLbkAeq0El40r4rsCqJ6Syg5NXB8J5DpbeHI7oqxXim0X7XDhllEAE9P7DLT
        rw+8bWOIQzIgO0UPNaA8/ZT1DfnY2k4HuAFmMCVml4b7Xx9OsGo0Q3K+QSBALTsH
        RzcpdebTEfVcSrokaqRVFQhrmBRuU6uK6+icI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dux2aPMCqILqjNavW7neUHTXOL1FhdPo
        sSoFsUxtKap5ecMSE6naqTsR+4x6VqNefrbbwIQ5h4H8lGXidZN9HOzKbx6O7PLK
        9prZtuhd1hRRDxO+WIvBNeWy1FFxKDx0wDN6gGfI2PDRcUSE9H/bIfZ6WSt+zDI3
        kdJdSGw2kUI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95EAC8E872;
        Thu, 10 Sep 2020 00:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AD468E871;
        Thu, 10 Sep 2020 00:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] ls-files: respect 'submodule.recurse' config
References: <pull.732.git.1599707259907.gitgitgadget@gmail.com>
        <xmqqv9gms1fp.fsf@gitster.c.googlers.com>
Date:   Wed, 09 Sep 2020 21:50:52 -0700
In-Reply-To: <xmqqv9gms1fp.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 09 Sep 2020 21:25:30 -0700")
Message-ID: <xmqqmu1ys09f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34B44EC2-F321-11EA-99FF-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So, no.  I am not enthused to see this change.

A more relevant question to ask you is what the motivation behind
this change is.  

If it is an apparent "inconsistency" that the plumbing command in
question takes an explicit command line option but ignores user
configuration, then we can stop there---I think we would want to
keep it that way.

But if it is because "I use this command interactively quite often,
and I find it inconvenient because I need to type the long command
line option", we may want to step back and understand why you need
to run the low level plumbing command in your interactive use case.
Perhaps most, but not quite all, of your need, whatever it is, is
already satisfied by higher level commands (like "status"?) and what
we need is to enrich these end-user facing higher level commands to
fill the "gap" to satisfy the need in your use case.

