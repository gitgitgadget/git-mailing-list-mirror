Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE1920A21
	for <e@80x24.org>; Wed, 13 Sep 2017 21:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdIMVd1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:33:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58760 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751125AbdIMVd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:33:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B127ADB45;
        Wed, 13 Sep 2017 17:33:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WoSaLzxJjG+ymKEFi/S8rAlMN8c=; b=dnqdYb
        kyhfThe2czmxBFy9jliIhFFsno8XQA8NtAp1TP5m0R7tK8i4ZPT0JcLNmQL+xMLt
        DLTgb/n4FT4i1E4QLPbqZd/l27WNAwpnLPwDtcISyg6cz3cyTdOSQlKRWGSedWK5
        xOBP2z2YouyZdWdtYC9LfamUZW6jpm0SJOsd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XYvHjvNSxsqb1o2BBIF9cU4qKbY/xXlK
        wz1hWs7TP28+kFZWPJWDU+oui9mVT+U9/0wugImBLhHlMymfOhApegSvVoOZtSMu
        nkixwp6RkUfNaq1UeEtwHF1PNgkqi6Sw7uPiQOq/MXRgCTtwa3Foh8WFJRwLqCKp
        UFXTJ8QL2Ag=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 107AAADB44;
        Wed, 13 Sep 2017 17:33:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6609CADB43;
        Wed, 13 Sep 2017 17:33:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>,
        Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] config: avoid "write_in_full(fd, buf, len) < len" pattern
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
        <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
        <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
        <20170913182431.GE27425@aiede.mtv.corp.google.com>
Date:   Thu, 14 Sep 2017 06:33:23 +0900
In-Reply-To: <20170913182431.GE27425@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 13 Sep 2017 11:24:31 -0700")
Message-ID: <xmqqfubq1dy4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CBAEFB8-98CB-11E7-BECD-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> What I missed is that copy_begin and copy_end here are actually size_t
>> variables, not the pointers. Sorry for the confusion, and here's an
>> updated version of the patch with this paragraph amended (the patch
>> itself is identical):
>
> Subtle.  The world makes more sense now.  Thanks for figuring it out.
> ...
> For what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, both. It seems that I missed all the fun ;-)
