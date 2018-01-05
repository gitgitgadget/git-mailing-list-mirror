Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74CB1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 22:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeAEW2Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 17:28:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54500 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeAEW2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 17:28:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77696CB2A1;
        Fri,  5 Jan 2018 17:28:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UwOtn6nHl11v
        cUVkJWTwY5QRb1U=; b=amrSxrJrdnFLST8+UbYDxYPkeJJDOE0GMIpWqOx97tLa
        Sh75AeiUMcrosIBHVDdnF0fpU2Xrs+irZDP9mlx7vtUgxuX3idO2RgIiNHnCboqV
        eA2+klIi21sc2DOzCsNWyvmcv2ZZxAGFp9CA2KPjTcTnnNxzi7Plg4xM20ru87c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MY23/W
        WLxkId2Yc4WrABHIUC8AM6F4I4pfUgGjl9EJhBW4xlC00h5V+YYiaGLch7LVHiPn
        bNWLsafKYzLq5EL9y1Q6Wv8byul1ij7dsdMWOJYsjapXAC3RFC2wj8Qx9s9HaEf8
        /ja+6lvnMef/tQ4Qqu8HhcAhxSLkoVcqzXDZc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7058DCB2A0;
        Fri,  5 Jan 2018 17:28:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDCD1CB29D;
        Fri,  5 Jan 2018 17:28:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] perf: amend the grep tests to test grep.threads
References: <20171229225903.19688-1-avarab@gmail.com>
        <xmqqinchfowj.fsf@gitster.mtv.corp.google.com>
        <87o9m8asys.fsf@evledraar.gmail.com>
Date:   Fri, 05 Jan 2018 14:28:13 -0800
In-Reply-To: <87o9m8asys.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 05 Jan 2018 22:36:27 +0100")
Message-ID: <xmqqa7xsaqki.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B86EE8AC-F267-11E7-B495-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Judging by the way the other side uses "test_perf $prereq ..."
>> without quotes around it, I suspect you do expect it to be empty in
>> some cases.  It means you expect test_have_prereq is prepared to
>> skip an empty prerequisite in a prereq list, but I do not recall
>> writing that helper in such a way, so...
>>
>> 	PTHREADS${prereq:+,}$prereq
>>
>> or something along that line, perhaps?
>
> It's not, but a trailing comma at the end of the prereq list works sinc=
e
> test_have_prereq() relies on setting the IFS to ",", so as long as this
> is portable:
> ...
> We could use the ${...} pattern above if you prefer, but since it
> doesn't appear to be needed...

I view that reasoning as depending more on how the helper happens to
be implemented right now than working by design, though.

