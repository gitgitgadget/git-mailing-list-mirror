Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDAB620959
	for <e@80x24.org>; Thu, 16 Mar 2017 22:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbdCPWnR (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:43:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51985 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751389AbdCPWnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:43:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B0CE695BF;
        Thu, 16 Mar 2017 18:43:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8tU1riYpD4/KdCEasAyNBp2YTCc=; b=HUClJc
        ExPRfsT8YJBB0hu/1ZrCFu/2O7Wj2xzd7tRK90jgLKT4LhMOwOSZ4acDXoiDdPWM
        cTPwtgGoCx9XpBc26T33G/y2qSJ1Gou0PLXILCpkyOQlNqAVCioaCsHdjpKD7KaY
        u8IXl/zZk9r5LgxhKoTwlKTZuKcmZr1DOQ3CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C8Ak3OfcQpT+KBR8kxanIQd2rOptgnXw
        oyuC/o5jhvAqq+d3qn2F3Xq7kkRprRuedqHQbgQRCZFK/j0YjL+J83QdFTjtLi4f
        10COUv+6UrGLsZn7aRtBTGkh+A2b9dHsuUP/g5rPNdjHpadQT2QoQUvj/H0JDgGD
        ulczqoxbaWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03A2C695BD;
        Thu, 16 Mar 2017 18:43:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6821F695BC;
        Thu, 16 Mar 2017 18:43:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] Makefile: add USE_SHA1DC knob
References: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
        <20170316220911.43zernzq643m5mmk@sigill.intra.peff.net>
Date:   Thu, 16 Mar 2017 15:43:13 -0700
In-Reply-To: <20170316220911.43zernzq643m5mmk@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 16 Mar 2017 18:09:12 -0400")
Message-ID: <xmqqtw6salmm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0CDC06C-0A99-11E7-B95A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +ifdef USE_SHA1DC
> +	LIB_OBJS += sha1dc/sha1.o
> +	LIB_OBJS += sha1dc/ubc_check.o
> +	BASIC_CFLAGS += -DSHA1_SHA1DC

The name of this CPP symbol is one difference between this and
Linus's version.  Wouldn't "-DSHA1_DC" make more sense?

Another difference is that your version adds USE_SHA1DC to
GIT-BUILD-OPTIONS in patch 5/5; I thought GIT-CFLAGS forces
rebuilding and that was sufficient, but GIT-BUILD-OPTIONS is
available to tests for introspection, so adding it is needed
for that reason.


