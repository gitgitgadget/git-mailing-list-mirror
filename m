Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E5C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C352078E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b3NnNpm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgG2Arw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:47:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60247 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbgG2Arw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 20:47:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79A4DEBBD6;
        Tue, 28 Jul 2020 20:47:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WVo9HS4xCl0otX0EfEH82JRK+Q0=; b=b3NnNp
        m8EarX7Ia9tf1JwmwG3+N7jZY/FPSqkk9svvB0/6FsL0cQMi0/FOUgVr7gi0M+E0
        OQPNFU+FwXd0A2cheRdD8p/H+MtdHuzOu1lY4J9Ff7HlvhKWYCkcxoTXBOcDrfp7
        T0hbPHYX4m0WlhQn1F1T96qZsz16BPllk+oaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IQHWxt2XriimrtLy2KIA6Fnn6KGo7wfS
        z0UkPX+UGHhcGwDYT8+iWgRfS7nLdd1hA4dfh8yB1bEEU/yah+xGelpMu1ZvrQuv
        0xALDlRrFd2c/K2NmqeFaBVh1kIC6N4i8uDTw4/M83QqZWmVusQRvrGVlmhlc6fe
        AjxvXlh2ZcU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7283AEBBD5;
        Tue, 28 Jul 2020 20:47:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B243EBBCF;
        Tue, 28 Jul 2020 20:47:46 -0400 (EDT)
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
        <20200729004009.GB1653374@coredump.intra.peff.net>
Date:   Tue, 28 Jul 2020 17:47:45 -0700
In-Reply-To: <20200729004009.GB1653374@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jul 2020 20:40:09 -0400")
Message-ID: <xmqqlfj3b0zy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EAEF874-D135-11EA-8101-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And here's a diff between your current "seen" tip and what I get by
> merging in this updated version and then doing any necessary resolution
> or fixups on top. I'll leave it as an exercise for how you might want to
> pull the content across. :)
>
> I do note that most of the new call-sites are ones that would be better
> off using child_process.args, and reviewers (myself and others) have
> suggested that. So those direct uses of the "argv" member may go away
> anyway.

Yup, I do not think we should spend too much cycles on this at this
point, as Stolee's topic and others that add new callsites are
likely to be rerolled at least one more time.

It is tempting to declare that these 11 patches are now perfect and
we'll stop the world and fast-track it down to 'master', while
discarding any and all topics in flight that changes anything
related to argv-array, and then we ask authors of these discarded
topics to send in a rebase on top of the 'master' with strvec API
already in.  But I somehow think we do not have to take such a
drastic measure to adjust the world around this topic ;-)

