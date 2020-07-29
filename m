Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F074C433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4DE2076E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TgZdMKbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgG2AoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:44:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54078 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbgG2AoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 20:44:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E77379A7F;
        Tue, 28 Jul 2020 20:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jA1jn0rYg5C6GaxMDYbrGf+iKpM=; b=TgZdMK
        bkY1TbqNaxEWzriB7i9OA53BvaL4mHptUBYykRMsZvIrc70pxDPbKdmHoy7wk2XJ
        nSDlPQNzybW6pDIhMHrDiV32Lqt9dfXYLrgqBdQKzUwmV+6VRuXJy7F7c0r2TPyv
        LqJjPvq8y4260kWzyQvJobiaL191lg/XknrEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xB619eVhcEsCzlewokZdaNcgKTbf6Xg1
        FH+jbkNSq4mbi+9cpa8XrDlQCq1imwNAROmt7MTS+9sCFeP5u9kfiZFzee7G4bxx
        JAchj1SgeZ2m2wvk/z5lKGzy+Cdoa49eeJOl9CMD2N1Ieu20tFUpRRe9Y/hCX8Hb
        5D4AAxA7iDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 559C879A7E;
        Tue, 28 Jul 2020 20:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4F1979A7C;
        Tue, 28 Jul 2020 20:44:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/11] strvec: drop argv_array compatibility layer
References: <20200728202124.GA1021264@coredump.intra.peff.net>
        <20200728202709.GJ1021513@coredump.intra.peff.net>
        <xmqq5za7cm8e.fsf@gitster.c.googlers.com>
        <20200729000430.GA1623001@coredump.intra.peff.net>
        <20200729003720.GA1653374@coredump.intra.peff.net>
Date:   Tue, 28 Jul 2020 17:44:22 -0700
In-Reply-To: <20200729003720.GA1653374@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jul 2020 20:37:20 -0400")
Message-ID: <xmqqpn8fb15l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A53C21F6-D134-11EA-B453-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Worse than the resolutions are all the new calls which needed to be
> fixed up. I know your scripts keep a fix-up commit for this, but I don't
> think you publish it.

They are found in refs/merge-fix/$topicname, and the broken-out
mirror repository https://github.com/gitster/git/ should have them.
