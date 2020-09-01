Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AE7C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3069208CA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="paLIE1sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgIAPvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:51:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60436 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbgIAPuD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 11:50:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFB4CEF7AD;
        Tue,  1 Sep 2020 11:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BdO0lSz/x0J2xaY7YKc1Tq08i4I=; b=paLIE1
        sY43eyr1pxEqQWVFG2zNZ+wtezNyUixImhy++Ua8zArw8yIf797RDGlLzsQsMsLO
        vpDS57rJnE6U5KREQkufggCHeix6sNWc8/yz4CwOMlkmQPR+vQl4Wt147lVaoohA
        Lzz2XGGAtLvSmpkSEZjaORsFXLO9q/33Xd3Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=teqm/IC/NpS/yM4P+1B+tgBrkKBbUytU
        Xy0PKUm6XH1JaZSZHmtCbctLOrZ/09qGmuB9f/nEup2VthAskwyFgwcdJAqmcQ36
        4m3Gz7nnIbAXxRfbZVZZW4Xpb1f/vEgcD97okFC0+SwWTfTzKgtGut9ddGj2XBF2
        2pX0uWV1WCw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AAA1EF7AC;
        Tue,  1 Sep 2020 11:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C305CEF7AB;
        Tue,  1 Sep 2020 11:49:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
References: <20200901074355.GA4498@dcvr>
        <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
Date:   Tue, 01 Sep 2020 08:49:55 -0700
In-Reply-To: <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com> (Derrick
        Stolee's message of "Tue, 1 Sep 2020 08:14:32 -0400")
Message-ID: <xmqqblipebto.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C96B0C1C-EC6A-11EA-B88C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +		else if (!strcasecmp(value, "false") ||
>> +			 !strcasecmp(value, "no") ||
>> +			 !strcasecmp(value, "off"))
>> +			default_abbrev = the_hash_algo->hexsz;
>
> I'm not sure we need three synonyms for "no-abbrev" here.

I do not particularly mind, but if we imitate the variety of various
boolean false, I'd prefer to see the code to parse them shared to
avoid them drifting apart over time.

> "false" would be natural, except I think in a few places
> the config value "0" is also interpreted as "false", but
> as seen below a value of "0" snaps up to the minimum
> allowed abbreviation.

I was in the vicinity of this code recently for reviewing another
topic, but IIRC, 0 came from the UI level does get rounded up to the
minimum accepted and never reach "default_abbrev", but if you manage
to place 0 or -1 in default_abbrev here (e.g. with additional code,
like the above part with the right hand side of the assignment
updated), I think the value will propagate throughout the codepath
and causes the downstream code to do the right thing.  0 will give
you no-abbreviation (i.e. full length depending on the length of the
hash) and -1 will give you the "scale as appropriate for the size of
the object store".

I have mild preference for using 0 over hardcoded single "full
length" here.  Even though we currently do not plan to allow
multiple hashes in use simultaneously in a single invocation of Git,
if that ever happens, we will regret hardcoding the_hash_algo->hexsz
on the right hand side of the assignment here, like this patch does.

Telling the downstream code in the control flow that we want no
truncation by using 0 would keep both 40-hexdigit and 64-hexdigit
hashes to their original length (as opposed to telling it to
truncate at 40 or 64 by using the_hash_algo->hexsz).

Thanks.



