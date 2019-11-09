Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75E91F454
	for <e@80x24.org>; Sat,  9 Nov 2019 04:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfKIE1W (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 23:27:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61536 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfKIE1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 23:27:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FBFEA174D;
        Fri,  8 Nov 2019 23:27:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MacqZVixtbIa2Z3PwA3leqkgqlI=; b=B+oqGF
        Hdbtf7awlmXCsNpAVi6SZYkZSOO0Zls9ncXTLstrCL5DZBl6zPifJivGI9FUrN+O
        htYBPSIU7a3vBQ8CNHMJlchobgBIBjTQfKMjEnOrpRI+8z6hcG1G2G63qc0R5Q6L
        qQkqV/jaIiALl/NVy2TLx/zWRI7kBGIwFQjeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UlzOkCBsp2TxiCmn+SX8ZwjhS+2Jwizm
        qZtJDST+PM2WBkfQSDRzj7w4t0KsJ7JCirKB/S010QatDhpyp03XeUNSN//MWKiw
        Eln/1JD9l05i369f067YzoSjk2g4HWT6Y1uLC8AlWNahmdYt5ebg0EI9oZWPf6nS
        WA0xk46OPoE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07BACA174C;
        Fri,  8 Nov 2019 23:27:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3753EA174A;
        Fri,  8 Nov 2019 23:27:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Change behavior of git add --patch on newly added file?
References: <20191108225035.GA60198@google.com>
Date:   Sat, 09 Nov 2019 13:27:16 +0900
In-Reply-To: <20191108225035.GA60198@google.com> (Emily Shaffer's message of
        "Fri, 8 Nov 2019 14:50:35 -0800")
Message-ID: <xmqq5zjtn07v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36EC8B00-02A9-11EA-9966-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Should 'git add -p <newly-added-file>' do the same thing as 'git add -N
> <newly-added-file && git add -p <newly-added-file>'?

Probably.  

I originally wrote "git add -i" with the intention that the
interactive mode is _the_ primary interface to the machinery, so the
expected way to work with a new file was "git add -i", tell the
command to add that <newly-added-file>, and do the "patch" thing
using the interactive subcommand to do so within the "git add -i"
session.

Later people liked (only) the patch part, and "git add -p" (and
various "--patch" options that invoke "add -p" internally from other
commands like "checkout", "reset" were added) was born.  I think
nobody thought things through when they did so.

If I were designing "git add -p" from scratch and explicitly asked
not to do the other parts of the "--interactive" feature, I would
imagine "add -N && add -p" combination is what I would make it
mimic.

Patches welcome, but you may want to check with Dscho as there is an
effort going on to reimplement the entire "add -i" machinery in C.

Thanks.
