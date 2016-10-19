Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7517E20986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbcJSWkF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:40:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64921 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754593AbcJSWkE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:40:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7099C478B0;
        Wed, 19 Oct 2016 18:40:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3BDreyT9Zxt/N1QMCz/ls1ePEW4=; b=PviMQo
        lPTOngQ9l/iF/vUu/pzCXoAeWx7Hhf2Yjf34FsDGwXTH47gIwqY8CladRx0FSBNg
        +WNm+MfXacv+6v7e9+yd8EWK4f3bWYgjUBIscA+dxnZcXaefBhuZwwk8s0nUrSM3
        Y7zWFMrhKlXEP5IKa6r5ZkB99IAa/orI5vMxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OylK9pYxUH3xNTv1iD5hnEQgNCLb6TFp
        i0wa0layQTZ2E8kRhBDPDhpcqQK6aCA1fJ6UDjxaHotjWOFVxz9ht1M4lTXC6M86
        H5ZZaJ/mNz4ZgfVlBBj7UBSq/JKl7NH7YFc6iB9k8ap/i5rAjnY8Ilugm6knMMlX
        vWzLRlCvwKY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BAB9478AF;
        Wed, 19 Oct 2016 18:40:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4C97478AC;
        Wed, 19 Oct 2016 18:40:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rev-list: restore the NUL commit separator in --header mode
References: <1476908699.26043.9.camel@kaarsemaker.net>
        <20161019210448.aupphybw5qar6mqe@hurricane>
        <CA+P7+xogHOCbPV+rx7yrur85m=HX5ms9kGQYvTpQ7n2i7Hzuvw@mail.gmail.com>
Date:   Wed, 19 Oct 2016 15:39:59 -0700
In-Reply-To: <CA+P7+xogHOCbPV+rx7yrur85m=HX5ms9kGQYvTpQ7n2i7Hzuvw@mail.gmail.com>
        (Jacob Keller's message of "Wed, 19 Oct 2016 15:15:36 -0700")
Message-ID: <xmqq8ttkj740.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8D1C720-964C-11E6-B335-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Hi,
>
> On Wed, Oct 19, 2016 at 2:04 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
>> Commit 660e113 (graph: add support for --line-prefix on all graph-aware
>> output) changed the way commits were shown. Unfortunately this dropped
>> the NUL between commits in --header mode. Restore the NUL and add a test
>> for this feature.
>>
>
> Oops! Thanks for the bug fix.
>
>> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
>> ---
>>  builtin/rev-list.c       | 4 ++++
>>  t/t6000-rev-list-misc.sh | 7 +++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
>> index 8479f6e..cfa6a7d 100644
>> --- a/builtin/rev-list.c
>> +++ b/builtin/rev-list.c
>> @@ -157,6 +157,10 @@ static void show_commit(struct commit *commit, void *data)
>>                         if (revs->commit_format == CMIT_FMT_ONELINE)
>>                                 putchar('\n');
>>                 }
>> +               if (revs->commit_format == CMIT_FMT_RAW) {
>> +                       putchar(info->hdr_termination);
>> +               }
>> +
>
> This seems right to me. My one concern is that we make sure we restore
> it for every case (in case it needs to be there for other formats?)
> I'm not entirely sure about whether other non-raw modes need this or
> not?

Right.  The original didn't do anything special for CMIT_FMT_RAW,
and 660e113 did not remove anything special for CMIT_FMT_RAW, so it
isn't immediately obvious why this patch is sufficient.  

Dennis, care to elaborate?
