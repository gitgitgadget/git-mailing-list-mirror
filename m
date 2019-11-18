Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29EF41F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 01:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfKRBnF (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 20:43:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59055 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRBnF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 20:43:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD15333F2C;
        Sun, 17 Nov 2019 20:42:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yo74NHxjnaWhjfClzFuPfPn+Ggc=; b=RrHeqQ
        Yd76cEimuqEMNMJwV/ABqxEp0xf1+Fu+wLldqhmXx3khA/eGl0u3bCi/IsvMcVtJ
        zwPOINdItYRAZrqr+V+vRqQzAvvnJeeJsGXpUiBKTQTQog6oBLWSv4Ao67HOaiLn
        S9CsMTzNa5PkKMsGm3oDiVTcSfILqiA0plqMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iRhyCK9dY9WsULIMyvqhToApXnhieQmF
        EDpcs8xjAPvHZHwhAYJNDJkXAoQuTQXqpl9SL0a1QAch6C5S7Gq3CTElHaQh6Mgz
        6wXpw/dfFj8nTdlFMLK9jXNCjYWd1HgXqHYG6wQ3MxfGs0/qH0gmXu733PvPMcI0
        542P0bCfNzU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D434D33F2B;
        Sun, 17 Nov 2019 20:42:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A51F33F2A;
        Sun, 17 Nov 2019 20:42:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 09/10] pretty: implement 'reference' format
References: <cover.1573241590.git.liu.denton@gmail.com>
        <cover.1573764280.git.liu.denton@gmail.com>
        <470a2b0f4fd450af1d9c9d27ec0f0c91ea59117f.1573764280.git.liu.denton@gmail.com>
        <xmqqbltd7juo.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 18 Nov 2019 10:42:58 +0900
In-Reply-To: <xmqqbltd7juo.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 15 Nov 2019 15:07:59 +0900")
Message-ID: <xmqqa78u3qot.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C04412CC-09A4-11EA-BA04-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Denton Liu <liu.denton@gmail.com> writes:
>
>> +* 'reference'
>> +
>> +	  <abbrev hash> (<title line>, <short author date>)
>
> s/title line/title/ as you definitely do *not* want a line with a
> title on it (and nothing else) in this context.
>
>> +This format is useful for referring to other commits when writing a new
>> +commit message. It uses the following canned user format:
>> +`%C(auto)%h (%s, %as)`. This means it will not respect options that
>> +change the output format such as `--date` `--no-abbrev-commit`, and
>> +`--walk-reflogs`.
>
> Ignoring of the '--date' may want to be eventually fixed, but for an
> initial cut, using %as in the canned format is a good approach for
> expediency.
> ...
> ...  I do not think I understand what you wanted to do by
> using `--walk-reflogs` with the format at all, either.

OK, I re-read the patch text and I understand what you wanted to
say.  The mention of --walk-reflogs in the new description is
grossly misleading.

   $ git log --pretty=ref --walk-reflogs @{now}

would work perfectly fine.  It is an instruction that tells "git
log" not to follow the commit ancestry from the commit that sits at
the current branch right now, but instead follow the history of what
commits used to sit at the tip of the current branch.

"--pretty=format:<anything>" overrides only the side effect of
"--walk-reflogs" that modifies traditional built-in formats.  But
the above makes it sound as if use of "--pretty=ref" somehow makes
our commands to ignore the entire effect of any option that has side
effect of changing the output format, which is not true.

The `--date` and `--decorate` options would be a good example of
options "that change the output format".  If you want to mention the
effect of this option on the `--walk-reflogs` option correctly, the
explanation must make sure that only the output aspect is affected.

Perhaps like this

	This format is used to refer another commit in a commit
	message as "<short hash> (<title>, <author date>)" and is
	the same as `--pretty=format:%C(auto)%h (%s, %as)`.  As with
	any `format:` with format placeholders, its output is not
	affected by other options like `--decorate` and
	`--walk-reflogs`.

I guess?

We would want to fix it in such a way that it uses %ad instead of
%as, but internally tweak the default date format to short unless
the --date option is given.

Thanks.
