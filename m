Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6296C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABA02078E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n2cEYjeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgHJQEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:04:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59784 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgHJQEG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 12:04:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6D40856AB;
        Mon, 10 Aug 2020 12:04:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PBqiRLhv3sF6CFGd7a1OIQpaxxw=; b=n2cEYj
        eFvfG1MZybJC4po2mqWl7MwwbDPekXL7XgsSwx36nIp6seD3Kieg718pBesrkeFj
        TGTV5m78Ehb+zah+zgd+l7ZtfLIpi3pNtNoGV5QsPhTrYs0W7Jf02JpuSmKGx3ve
        FkGoDFWbKR+pzrEXVnCWhEJXh20A1EIINNydw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v/caf7byeyBVDsT0JiEDPwpW6QolCFh6
        LmumVLEEpXYKrlxTAWF+NeJ95hco1Lm+9k1loL6+z+tx1SpH13T521NFucIoD+UE
        eh8rMNoRPzvkM1kg7kGa1NwQppUjIuq+WdC5o15D+Zrk9BZY0BfDZ5P/IxfWkUMU
        mfEo2tQ7aUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBFF9856AA;
        Mon, 10 Aug 2020 12:04:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5616C856A9;
        Mon, 10 Aug 2020 12:04:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
        <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
        <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
        <xmqqpn8hgca7.fsf@gitster.c.googlers.com>
        <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
        <xmqqh7tjv6hb.fsf@gitster.c.googlers.com>
        <xmqq1rklrhle.fsf@gitster.c.googlers.com>
        <CAFQ2z_NU4=WcUDvVY9PNs+p-WU4u5=QY+=DHonGyK29numhWoQ@mail.gmail.com>
        <xmqqk0ydozqe.fsf@gitster.c.googlers.com>
        <CAFQ2z_OgNQKZ23gNB9=LqPn2M=WKL2vPQQpxm3drRWeN1sxH_A@mail.gmail.com>
Date:   Mon, 10 Aug 2020 09:04:02 -0700
In-Reply-To: <CAFQ2z_OgNQKZ23gNB9=LqPn2M=WKL2vPQQpxm3drRWeN1sxH_A@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 10 Aug 2020 16:27:08 +0200")
Message-ID: <xmqqk0y6cwst.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C52059C-DB23-11EA-B608-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Dealing with FETCH_HEAD generically isn't possible unless we extend
> the API of the ref backend: the generic ref_store instance doesn't
> offer a way to get at the path that corresponds to FETCH_HEAD, so we
> can't handle it in refs_read_raw_ref(). In the current reftable
> series, FETCH_HEAD is dealt with in the backends separately.

I am not sure what the best way would be, but I do not think any
existing code writes into it using the refs API at all, even though
it may be read only for the first object name using the refs API.

And I am not sure if we want to extend the write side API so that
the callers can express the full flexibility of that single file.

So perhaps the best way forward would be to ensure that anybody who
tries to read from FETCH_HEAD using the ref API reads the first
object name in it from $GIT_DIR/FETCH_HEAD file as we've always done
since the beginning of time, regardless of what ref backend is used,
that anybody who tries to write FETCH_HEAD using the ref API gets an
error, and letting the writers write into it directly?



