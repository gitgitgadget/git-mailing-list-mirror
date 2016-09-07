Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCE31F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbcIGSwX (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:52:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752001AbcIGSwW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:52:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9971380E8;
        Wed,  7 Sep 2016 14:52:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lV53KORdJ+wZKgeFL1D2BR108sU=; b=dJmQSl
        opOz7zw/X/YUz+m9fG8woj2sLe26Hhasp017JkdpfPX7byxlHW3+CIDm5GzcWaNb
        SFUkg1OhxhbtJbt1CwkvbLbO3mKuISIQ1rIfkp6ZqvQC9669x3INK/kvXSQGArkW
        vCl4YigldkcX977iMCRFDfBOYPGc5VhGAVLAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p95NasmxrMYqBQmB0BJdKQUmF3WdeS6e
        +t1SDwpsYzbLxj2jORqEMRN71AOo7o9jzCLKofmz5+efYtZDL86zzJbjracnDhET
        GP/ePt+42jcqTUurce+HO2idWZSudiS312lqQtLlQuVKhNlqKzn1nESjvxZTbGwG
        V05hV9mil1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1787380E6;
        Wed,  7 Sep 2016 14:52:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 234A7380E5;
        Wed,  7 Sep 2016 14:52:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>, git@vger.kernel.org,
        jnareb@gmail.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4] diff.c: emit moved lines with a different color
References: <20160906070151.15163-1-stefanbeller@gmail.com>
        <87a1ddbf-2499-d5b4-55c4-aeed2b72acce@ramsayjones.plus.com>
Date:   Wed, 07 Sep 2016 11:52:19 -0700
In-Reply-To: <87a1ddbf-2499-d5b4-55c4-aeed2b72acce@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 6 Sep 2016 14:37:41 +0100")
Message-ID: <xmqqvay7lezg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35286004-752C-11E6-982F-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> +static int diff_line_moved_entry_cmp(const struct diff_line_moved_entry *a,
>> +				     const struct diff_line_moved_entry *b,
>> +				     const void *unused)
>> +{
>> +	return strcmp(a->line, b->line) &&
>> +	       a->hash_prev_line == b->hash_prev_line;
>
> I doubt it would make much difference, but my knee-jerk reaction to
> this was to suggest swapping the order of the expression, thus:
>
> 	return a->hash_prev_line == b->hash_prev_line &&
> 		strcmp(a->line, b->line);
>
> ... but perhaps it doesn't read quite so well, and probably wouldn't affect
> performance much (except in strange edge cases), so it may not be worth it.

It would make very much sense to do so, as the final version will be
a lot more involved than a mere strcmp() to make "git diff -w" to
also work as expected with this new feature.

