Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C4CC4742C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F4D2225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KBlQZNqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKBSeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:34:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61364 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBSeF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:34:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A579A05A0;
        Mon,  2 Nov 2020 13:34:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=IV6fD7WsWJct5naTA/IdDknf3lQ=; b=KBlQZNqOZbAsj1CX4w+6
        aQYkheHgizzYuuwOLIOPmZAyUY7hJBCRo7GvzO2Aul7bQuR/xVoVtqEK98K0iB11
        uyWJtjdmHK6sH9pOL04DdSFAl1ZqPGsXI1vZ0oW6wSTpBqyTPbccZXib7OOLyZ3O
        SXRxfS5uH8GRLCSp2IBJMcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=IUTIHwtrgmW4Yf+OjB+GB3WiuyzYGy5CA93BaVieh3Lwrj
        afe6zMBNwIuWtRO+KM7pPhNjxHQAVU8rnulwu9z1lyinwgqyrWRQLf16p7TJIt7f
        zoTziNQvEvKmTsTFcozjPGPr+SixWjOVmULcpnEWPmfVcbPFLbDBGBEF1bVMA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 801ECA059F;
        Mon,  2 Nov 2020 13:34:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9051A059D;
        Mon,  2 Nov 2020 13:34:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: jc/sequencer-stopped-sha-simplify, was Re: What's cooking in
 git.git (Oct 2020, #04; Tue, 27)
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011020237070.18437@tvgsbejvaqbjf.bet>
Date:   Mon, 02 Nov 2020 10:34:00 -0800
Message-ID: <xmqqsg9rvc9z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA90EB0E-1D39-11EB-88A4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 27 Oct 2020, Junio C Hamano wrote:
>
>> * jc/sequencer-stopped-sha-simplify (2020-10-21) 1 commit
>>  - sequencer: tolerate abbreviated stopped-sha file
>>
>>  Recently the format of an internal state file "rebase -i" uses has
>>  been tightened up for consistency, which would hurt those who start
>>  "rebase -i" with old git and then continue with new git.  Loosen
>>  the reader side a bit (which we may want to tighten again in a year
>>  or so).
>>
>>  Is this a real issue, or just a theoretical one?
>>  cf. <xmqqd01b429a.fsf@gitster.c.googlers.com>
>
> We had a similar situation when we decided to fix the incorrect quoting in
> the `author-script` file, and we decided that we have to be careful:
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.1807271415410.10478@tvgsbejvaqbjf.bet/
>
> In light of that, I think we should go with Jonathan's patch for a couple
> of versions before tightening the reader side again.

I do not mind taking the approach as a prudent and careful thing,
but I want the question answered regardless, as I know Jonathan is
in a good position to tell if this is just a theoretical issue than
I am, and depending on the answer, we may rethink the approach of
trying to be overly careful.

Thanks.
