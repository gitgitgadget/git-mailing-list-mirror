Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F385EC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B2220DD4
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DxStDLe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIRSQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 14:16:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56577 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRSQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 14:16:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C2008FFEA;
        Fri, 18 Sep 2020 14:16:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=REkfQwOl1/dQasyvrSe9kul4EEs=; b=DxStDL
        e4vBTSa8RwdUAypUX1tWGUXNEGinqdZQTK4uOaG3ZnLrp7lTbn4jY0EvVdG3bGV6
        zn6JfZMqS25Om7CuYYWm1F6AgHyLeAbT/AwLVVPKBo6z5VDdhFQDfB7aZLWu6acm
        mO+QfjOt24r1EELJPG4Pnl2q+HFuWcrUkVK1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q4OqADpymtAQjcPfxqI+aZK2oNIsOmax
        TqfTFLaeMWMMV56uxU34ajRunuWqx7l1mVYIZF0IcKAOAIUnNsdNFgnbCcDwdXId
        v6cqSJIzpzo1IDzngaz8tK8symcvKPPGGb+ELXOzZoeGQUTRpwH5BJ3w0OSS+o0V
        3yPlm1PRHCs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F004D8FFE9;
        Fri, 18 Sep 2020 14:16:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47E1F8FFE8;
        Fri, 18 Sep 2020 14:16:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/4] builtin/rev-parse: learn --null-oid
References: <cover.1600427894.git.liu.denton@gmail.com>
        <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
        <20200918141125.GB1602321@nand.local>
        <20200918141614.GC1602321@nand.local>
Date:   Fri, 18 Sep 2020 11:16:54 -0700
In-Reply-To: <20200918141614.GC1602321@nand.local> (Taylor Blau's message of
        "Fri, 18 Sep 2020 10:16:14 -0400")
Message-ID: <xmqqy2l7kl0p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 221493C4-F9DB-11EA-9E58-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In either case, I think '--zero-oid' makes more sense than '--null-oid'
> (and it matches the tests that are already written). The pair
> '--zero-oid' and '--empty-oid=<type>' make sense to me.

I am not sure rev-parse should even know about "empty-oid".  An end
user or a script who wants to learn what name an empty blob has can
and should ask "git hash-object -t blob --stdin </dev/null".

I can buy --zero-oid might be handy, but don't see a pressing need
if it is merely to support our test suite and sample hooks.
Instead, something like

  ZERO_OID=$(git hash-object --stdin </dev/null | tr '[0-9a-f]' '0')

should suffice, no?

Take this as a mild indifference, not as a strong rejection.

