Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76CE202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 01:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdJXBLV (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 21:11:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52783 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751216AbdJXBLU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 21:11:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49D099557E;
        Mon, 23 Oct 2017 21:11:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AR3PKQrykZFLkr4EeGDxWVOjB80=; b=r71zOZ
        n+slpq2hknM8+NWi/o9aJbzQ87f448IIYC7EtacPwoB4cwUBV+p0R9nrWqNKxvuL
        69D6qgskNdcB+CIabZ0A6jdLX9fJzAZDxhvlMmqgc6HA5bEXw+6HNSEeeoiF5Tip
        fICZ2ExZTcvlYcCaELpI/xrg6nh/SUSljfyiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KsMeMZ+3HHODxnMnyCdA022lXUbD39UI
        /rihCpd8SetkGdEZYIWs6JTwxc1XG36yayzSxCaKqMt5Ex2QRkv5/HS+z+ookH/D
        AY5MosA5duVLYuhGTRDudMxZobgugew9d/2tFRco3955+fXlrh9R9jkXKyphf5lE
        MOpaBr+iAXQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 426829557D;
        Mon, 23 Oct 2017 21:11:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A519F95579;
        Mon, 23 Oct 2017 21:11:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Rafael =?utf-8?Q?As?= =?utf-8?Q?cens=C3=A3o?= 
        <rafa.almas@gmail.com>,
        Martin =?utf-8?Q?=C3=85g?= =?utf-8?Q?ren?= 
        <martin.agren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v2] column: show auto columns when pager is active
References: <20171011172310.2932-1-me@ikke.info>
        <20171016183511.12528-1-me@ikke.info>
        <20171023215246.r3xevx5jey5pyuuz@aiede.mtv.corp.google.com>
Date:   Tue, 24 Oct 2017 10:11:18 +0900
In-Reply-To: <20171023215246.r3xevx5jey5pyuuz@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 23 Oct 2017 14:52:46 -0700")
Message-ID: <xmqqy3o19wp5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E284758-B858-11E7-B75C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Kevin Daudt wrote:
>
>> --- a/column.c
>> +++ b/column.c
>> @@ -5,6 +5,7 @@
>>  #include "parse-options.h"
>>  #include "run-command.h"
>>  #include "utf8.h"
>> +#include "pager.c"
>
> Should this be pager.h?

Ouch.  And I was not paying enough attention.

Thanks, I'll queue this on top.

-- >8 --
Subject: column: do not include pager.c

Everything this file needs from the pager API (e.g. term_columns(),
pager_in_use()) is already declared in the header file it includes.

Noticed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 column.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/column.c b/column.c
index ded50337f7..49ab85b769 100644
--- a/column.c
+++ b/column.c
@@ -5,7 +5,6 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "utf8.h"
-#include "pager.c"
 
 #define XY2LINEAR(d, x, y) (COL_LAYOUT((d)->colopts) == COL_COLUMN ? \
 			    (x) * (d)->rows + (y) : \
