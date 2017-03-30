Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905A420966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934061AbdC3SSj (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:18:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51628 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933378AbdC3SSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:18:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 841FB6D381;
        Thu, 30 Mar 2017 14:18:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i7t5LfRaLe6JWLAGVrmu7secbbQ=; b=pfKwcs
        lpl0wJVkugOJ3VOHkLH1NyaZbK4mgsFmoeQ9DN8GlKwNS7uiHFZl7r+3KuiouGdr
        ELmLc7eVgfu5qcFim8B2l5B1cBagPnTW81+lWWhRrPOzqrEV6FNKv7UEj0UrXcmq
        PyFL720CFWuBmAP3sZgsrMihuJ/LG7Gqbycwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JnqNzFQJWIJ02jJJMBmOYIvcEL528Wb9
        bqWO3nchQuV7VAFs1hTS5TU21jyKuMuliz/TlwvzymnY1nS+rjCKbwTgO7x2Wc9O
        iwfFgJw4AVHeaATjudSEkBZ/dZVVZz+v8zhDMHSmwyfrYjnlWggwiBRgOLP1Ddhd
        0lxGBxXX/lo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C59B6D380;
        Thu, 30 Mar 2017 14:18:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE1DB6D37D;
        Thu, 30 Mar 2017 14:18:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] submodule.c: correctly handle nested submodules in is_submodule_modified
References: <20170324182902.19280-1-sbeller@google.com>
        <20170325003610.15282-1-sbeller@google.com>
        <20170325003610.15282-8-sbeller@google.com>
        <xmqqpoh2z93q.fsf@gitster.mtv.corp.google.com>
        <20170328010533.GQ31294@aiede.mtv.corp.google.com>
Date:   Thu, 30 Mar 2017 11:18:34 -0700
In-Reply-To: <20170328010533.GQ31294@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 27 Mar 2017 18:05:33 -0700")
Message-ID: <xmqqr31e4ohx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A235C0E-1575-11E7-87B0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Shouldn't this done as part of 4/7 where is_submodule_modified()
>> starts reading from the porcelain v2 output?  4/7 does adjust for
>> the change from double question mark (porcelain v1) to a single one
>> for untracked, but at the same time it needs to prepare for these
>> 'u' (unmerged), '1' (normal modification) and '2' (mods with rename)
>> to appear in the output, no?
>>
>> IOW, with 4/7 and 7/7 done as separate steps, isn't the system
>> broken between these steps?
>
> No.  Both before and after patch 4, this code has to determine two
> details from a submodule:
> ...
> Question (3) didn't come up before because when there are no nested
> submodules, the diff machinery answers it (saving us from getting the
> answer from the status --porcelain we recurse to).

Thanks.
