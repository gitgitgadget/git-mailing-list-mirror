Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B941F406
	for <e@80x24.org>; Fri, 22 Dec 2017 20:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756783AbdLVULK (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 15:11:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59161 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756764AbdLVULJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 15:11:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CB33BE438;
        Fri, 22 Dec 2017 15:11:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j55OwnexRb/PtwDhqR3F2qlylz8=; b=B9/Dax
        oBeg7LBXVuVdIS8Az2oeGqTtUa2Jy3u7IG53q+O88uCP4DENmuYLKsni6BfxQ3vj
        y017bT1dcD5z7Rtxu8ppk5DpuD77f0xAka8c7ErGU6Nlh8wREay/WMJPjjB8i3kK
        KT4vBCt+RQ9cRXZNYEfS/bI6K0Ym8jHDNFXrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c+N2IeDKcd4W6R8v5cj9M0RJA+56jXFe
        4qIvoB1MFeWhRPTi7IgkyPsrcArfgvvuqY0F4RU9wvoitY5mNucvL6wLqiHfoJSN
        EJ5k310Arven8OJLklye1qLNSeDjR9J7miu7J8/Tk+5jzkfkSL2R7ZWc3RW/UyVo
        sE359RfGZ6U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24A39BE437;
        Fri, 22 Dec 2017 15:11:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92673BE436;
        Fri, 22 Dec 2017 15:11:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] send-pack: use internal argv_array of struct child_process
References: <d532a23f-cf73-615c-976d-f4fe83309feb@web.de>
        <CAGZ79kb43_nSm-tjv3zOw7OFzByM3WocYboB6QRr=Z7bRue_hA@mail.gmail.com>
Date:   Fri, 22 Dec 2017 12:11:07 -0800
In-Reply-To: <CAGZ79kb43_nSm-tjv3zOw7OFzByM3WocYboB6QRr=Z7bRue_hA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 22 Dec 2017 10:09:37 -0800")
Message-ID: <xmqqpo76r09w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F77BC44-E754-11E7-BAAB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> +       argv_array_push(&po.args, "pack-objects");
>> +       argv_array_push(&po.args, "--all-progress-implied");
>> +       argv_array_push(&po.args, "--revs");
>> +       argv_array_push(&po.args, "--stdout");
>
> (useless nit of the day, no need to resend:)
> These four statements could be done as pushl(a,b,c, NULL);
> but it would not differ in readability, so I guess either is fine.

Yup.  Shorter is not necessarily better.  If we anticipate that we
will need to update the set of options later (and I suspect we may
be doing so soon, given what JeffH and JTan are working on
recently), one option (or option-argument pair) per line is a more
preferrable form from the maintenance point of view.
