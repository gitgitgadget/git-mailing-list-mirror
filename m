Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05E01F4DD
	for <e@80x24.org>; Tue,  5 Sep 2017 10:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdIEKDX (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 06:03:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62588 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751099AbdIEKDS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 06:03:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D586A322A;
        Tue,  5 Sep 2017 06:03:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=SIDLo+/zlBe/1HXU9XjHwqF+PT0=; b=HgBVJRKfqQmhGq5RUt0g
        Dnaec5F0mA4LipFhDPROH/sVUzCvwwPHxd0M2pUx5IfhXQGIhSP5adqYO65GdQBM
        gCkOmJFD3gm4xnnV4li27A2FnY7ETVLncRQR8l/YmwtFPEjlfx0Nq6T/CLvHThIz
        Y0GM8tkNWeYK11HMNZJOuVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=c4TIMSQ/kXm6HMGoq1UDxWTRe8i7FRmGzz/lV1M4fTj771
        sSsdgePz5KRYhgbkilb1Wqk9SrXzkkL66aLFCRs6GYCroDWyILFxDvRB7ay4vllf
        P4e0N8DfXbyJI9mrVQHTQ2IYJ0+ttJsYTUVVtksKVQsUUaSCWTsQbhVZqVyNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85817A3229;
        Tue,  5 Sep 2017 06:03:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4DFAA3225;
        Tue,  5 Sep 2017 06:03:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
References: <20170827073732.546-1-martin.agren@gmail.com>
        <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
        <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
        <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
        <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
        <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
        <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
        <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
        <CAN0heSomjqiSStq3eqGgCe21b0Pr0gbAQLL-2EEB6Zfnjj+Mjg@mail.gmail.com>
        <20170829214809.xxpsp76eqhd4hupo@sigill.intra.peff.net>
        <20170830053108.g2xsn43rwulnwn3p@sigill.intra.peff.net>
Date:   Tue, 05 Sep 2017 19:03:15 +0900
Message-ID: <xmqqr2vlbgyk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 700BE98A-9221-11E7-9417-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Overall I suspect that running our cmd_*() functions multiple times in a
> single process is already going to cause chaos, because they often are
> touching static globals, etc. So it's probably not that big a deal in
> practice to add one more variable to the list, and declare that calling
> cmd_ls_files() anywhere except as the main function of ls-files is
> forbidden.

IIRC there were a few existing violators of this rule around "merge"
implementation.  It may be a reasonably low hanging fruit to find
and fix them.

#leftoverbits
