Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAC7C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 19:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B03207D3
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 19:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bFy+z/Lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgIATO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:14:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54205 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgIATO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 15:14:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 243E775ED9;
        Tue,  1 Sep 2020 15:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yDGXsQMr/XhJerHL4BcgCZt15zc=; b=bFy+z/
        LmzhtbQiXOp0bp8fNMqkcK2WoiLV0L5Gq41cv1t6ERrFoDylU9ayV2SREP2MGeAl
        vyRHzA7T1E/4OlFqX5qAZY707+dQuWENxpt2m/6DO2R8vodg+CoYyfOrpFbEsnue
        tqp/bA3l5A47VU82dkTzHecvsEVlYGjHGOBAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h8pfw/kelDBtpyT6anP58/cPKdS5JPX1
        F4O1XwI3+ALt7rsPUsqBibBjT2idLDXx5heHZHIum/x0gezwkVg8CTijrbf5ojNW
        bGk+EI9Hr9wd+7HVCatG2jWBPXASr8GNA0+JvbJl1o02q9v33YrvrNjXoeVqMDLA
        doPz1QGPhUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A90175ED8;
        Tue,  1 Sep 2020 15:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9ACE875ED7;
        Tue,  1 Sep 2020 15:14:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
References: <20200901074355.GA4498@dcvr>
        <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
        <xmqqblipebto.fsf@gitster.c.googlers.com>
Date:   Tue, 01 Sep 2020 12:14:54 -0700
In-Reply-To: <xmqqblipebto.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 01 Sep 2020 08:49:55 -0700")
Message-ID: <xmqqtuwhcnrl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B7FFCBC-EC87-11EA-9F0B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>>> +		else if (!strcasecmp(value, "false") ||
>>> +			 !strcasecmp(value, "no") ||
>>> +			 !strcasecmp(value, "off"))
>>> +			default_abbrev = the_hash_algo->hexsz;
>>
>> I'm not sure we need three synonyms for "no-abbrev" here.
>
> I do not particularly mind, but if we imitate the variety of various
> boolean false, I'd prefer to see the code to parse them shared to
> avoid them drifting apart over time.

Just a clarification.  

 - I do not particularly mind having multiple synonyms.  

 - I do mind these one-off strcasecmp that will cause them to drift
   away from what we do for the boolean 'false'.

Thanks.
