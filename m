Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947311F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 01:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfJ2Byx (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 21:54:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63914 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfJ2Byx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 21:54:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EC5533E82;
        Mon, 28 Oct 2019 21:54:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n573QlTkZgAkfT1/Sct534xcTHE=; b=pRIRt6
        tW/jxC5VTJYZ5CYY4jSwoofeAZDXt1pK4fbIKbCMDb3vmaeVvIKoavuzQF0iShXE
        WG12AWt9RV0ctzpVj3Ny21SzpsRvjZIyjCgn+cL0xiFMwByXWSEVut9soMXGiGXm
        0VuzbLdssrxojFNjSe5G5Ldg2lnULtaGc9uCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tAsy/Cf/uzQzIbjCGM75RO5kQlnwSljU
        +2Q2UAQCOQgSqHa5OpE0CUDPBR9v9NXdofWAv4yDc9FxPYDSYIasjGOwUui5vQ3L
        u1tA7JppjKdfMjQQBFqlu+DgQh13BO/9OjP0A/6kjjUnUWGr1A7pLcMYJU72AZsY
        cEQO3RRUdF0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05C8033E81;
        Mon, 28 Oct 2019 21:54:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6395633E80;
        Mon, 28 Oct 2019 21:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/9] add git-bugreport tool
References: <20191025025129.250049-1-emilyshaffer@google.com>
Date:   Tue, 29 Oct 2019 10:54:49 +0900
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 24 Oct 2019 19:51:20 -0700")
Message-ID: <xmqqd0eg8geu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17DB0E7A-F9EF-11E9-BB2C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Thanks for the patience with the long wait, all. Here's an attempt at
> the rewrite in C; I think it does verbatim what the sh version did
> except that this doesn't print the reflog - Jonathan Nieder was good
> enough to point out to me that folks probably don't want to share their
> commit subjects all willy-nilly if they're working on something
> secretive.

Is the goal to give a tool the end users can type "git
bugreport<RET>" and automatically send the result to this mailing
list (or some bug tracker)?  Or is this only about producing a
pre-filled bug report template to be slurped into their MUA and then
further manually edited before sending it out?

It probably is controversial if we exposed contents of hooks scripts
(I can imagine some people may trigger external process by pinging a
URL that includes credential material out of laziness), so the
presence test you have is probably a good stopping point.  I do not
know how much it helps to know which hooks exist in order to
diagnose an anomaly without knowing what their contents are, but it
is a start.

By the way, I doubt that it is the best use of developer time to
write these in C---taking various pieces of information from
different places to prepare a text file sounds more suited to
scripting languages, especially while we are still learning what
kind of information we want to collect and how we want to present
the final result (iow, for the first handful of years after
deploying this command).

Thanks.
