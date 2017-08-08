Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF5C20899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbdHHW00 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:26:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53839 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751931AbdHHW0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:26:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A829BA0C58;
        Tue,  8 Aug 2017 18:26:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+GcGYNcRZqtf+26Qh91DR4n3JTA=; b=a1f4wM
        HJi9a18Z2OhblwyS9WGmv7xkDhUpic4Td33kuRrUTB0apibjeW3eejAqs/lb0PQT
        33f92n/GqjZgmGMOscYxvwvDPHbuP4SN3Jx9AzaBzc5+rWDiegpBJtGucOXTIDwj
        KK3lEa4W/pMCwOPvszo5JRDuUoIP+oTWy17EM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bJ97w8Xzeh4dAWW6hHPMOCPkVfQv5n4r
        ofWB50HsjrjQx2fRAPsZjYJ036NwYgEXOG4X8aySswOSHk/lRGO1kheMvNcgpM4R
        XJmCfe+AXR/9fLscRfkUIZ2gLIhtmKRPalupsODfFPQW1kAoXSyJ7W1E0kVLbhI/
        0xSNfI4UcUc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F624A0C57;
        Tue,  8 Aug 2017 18:26:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A6B4A0C54;
        Tue,  8 Aug 2017 18:26:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t4062: stop using repetition in regex
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
        <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
        <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
        <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 08 Aug 2017 15:26:16 -0700
In-Reply-To: <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 08 Aug 2017 15:09:01 -0700")
Message-ID: <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98E46476-7C88-11E7-912A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So I find Dscho's concern quite valid, even though I do believe you
> when you say the code somehow segfaults.  I just can not tell
> how/why it would segfault, though---it is possible that regexec()
> implementation is stupid and does not realize that it can return early
> reporting success without looking at the rest of the buffer, but
> somehow I find it unlikely.
>
> Puzzled.
>
>> You get different results?  How is that possible?  The search string is
>> NUL-terminated in each case, while the point of the test is that the
>> file contents isn't, right?

Intellectual curiosity tells me we may want to find out why it
fails, but in the meantime, I think replacing the test with "0$" to
force the scanner to find either the end of line or the end of the
buffer may be a good workaround.  We do not have to care how many of
random bytes are in front of the last "0" in order to ensure that
the regexec_buf() does not overstep to 4097th byte, while seeing
that regexec() that does not know how long the haystack is has to do
so, no?
