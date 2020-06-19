Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC56FC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582C1208D5
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KEMq/kaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgFSTYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:24:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60039 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388055AbgFSTYe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:24:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9B9370B1D;
        Fri, 19 Jun 2020 15:24:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m/JGmIyi3hltThzg39Ek++NHl90=; b=KEMq/k
        aE/PztodMWkCdxVEXIZ4HW+I97ZbhDYpC1SA+O9na2z1U3ssq2XFNM8sKbGVA5Sb
        nQdp5f+kg+EpMl/JsKk1RWmjABHi9As1TkOMPxXlcPnOA+zMhgh9X3u0E4CpYPGt
        2fPgYSAwXXHscWUjMO4gTc33UXOXe5fQXoWP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uzTWEUgv2ntszDubmalwBkbZ3repl0ti
        61GlPH5pC47m//SymjEX64Pk+bcTcuaDX4+54OwYYpSuJpo+0TZ0rAMSuu5tC8kl
        K++7733PyDrqYNO58qLrWXpPbAEAL1pNI9gNqphyxyBgRDZaNodMIr5d20KKlleX
        znMo861IF04=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1B0770B1C;
        Fri, 19 Jun 2020 15:24:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AFE870B1B;
        Fri, 19 Jun 2020 15:24:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] fast-export: allow dumping the path mapping
References: <20200619132304.GA2540657@coredump.intra.peff.net>
        <20200619132923.GA2540897@coredump.intra.peff.net>
Date:   Fri, 19 Jun 2020 12:24:30 -0700
In-Reply-To: <20200619132923.GA2540897@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 19 Jun 2020 09:29:23 -0400")
Message-ID: <xmqqr1uahn9t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8093DD26-B262-11EA-AE6A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When working with an anonymized repo, it can be useful to be able to
> refer to particular paths. E.g., reproducing a bug with "git rev-list --
> foo.c" in the original repo would need to replace "foo.c" with its
> anonymized counterpart to produce the same effect.

That would not work with "git rev-list -- 'foo*'", where there is no
counterpart, no?

It almost feels as if we want a separate knob to disable
anonymization for paths and perhaps refs while still anonymizing the
blob contents, or something like that.

