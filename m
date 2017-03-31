Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3CE1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 16:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbdCaQwV (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 12:52:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55772 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933167AbdCaQwU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 12:52:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 728007B2E6;
        Fri, 31 Mar 2017 12:52:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bOcwbVfhqoX5nxbcRdzjwAYDTlw=; b=iRZyht
        L0LmZ5HmY7Ico01aiv2b4yse/TrPpyy+7pYbMwKbHC/420AuVc0HdxMLRpX6OyPK
        XjtBf1tEZyVD88SJ7le9lWzG+w6cLR1rpY7FkqCnE/MG/P9HTDVCTROCxUINPhSQ
        tQBWcaQwAW2RqVM9JaytH34E/Mc1bPCsKb2Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K4sb7A22tIBgUr8kJYvRJLMccVJCX4nm
        2IBk2cpTvijU4HPWDKrWpKCGmmolJbBGPZtjHf3QmUazD3MHU2arWUtj0KvkHAFR
        kTWw1hX6QYDHhi+rebIZZApxeJhV2RRHjDBuGnUPv7jHFBmHsWCuJB3eOviWHNbl
        JM4mzRsJ88g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B65E7B2E4;
        Fri, 31 Mar 2017 12:52:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0C7B7B2E2;
        Fri, 31 Mar 2017 12:52:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 3/4] name-rev: provide debug output
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
        <cover.1490967948.git.git@grubix.eu>
        <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
Date:   Fri, 31 Mar 2017 09:52:16 -0700
In-Reply-To: <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
        (Michael J. Gruber's message of "Fri, 31 Mar 2017 15:51:23 +0200")
Message-ID: <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 664EA984-1632-11E7-83D0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Currently, `git describe --contains --debug` does not create any debug
> output because it does not pass the flag down to `git name-rev`, which
> does not know that flag.
>
> Teach the latter that flag, so that the former can pass it down (in
> the following commit).
>
> The output is patterned after that of `git describe --debug`, with the
> following differences:
>
> describe loops over all args to describe, then over all possible
> descriptions; name-rev does it the other way round. Therefore, we need
> to amend each possible description by the arg that it is for (and we
> leave out the "searching to describe" header).
>
> The date cut-off for name-rev kicks in way more often than the candidate
> number cut-off of describe, so we do not clutter the output with the
> cut-off.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---

>  static void name_rev(struct commit *commit,
>  		const char *tip_name, unsigned long taggerdate,
>  		int generation, int distance, int from_tag,
> -		int deref)
> +		int deref, struct name_ref_data *data)
>  {
>  	struct rev_name *name = (struct rev_name *)commit->util;
>  	struct commit_list *parents;
> @@ -75,6 +88,7 @@ static void name_rev(struct commit *commit,
>  
>  	if (deref) {
>  		tip_name = xstrfmt("%s^0", tip_name);
> +		from_tag += 1;

Why this change?  I didn't see it explained in the proposed log
message.  "deref" is true only when our immediate caller is the one
that inspected the object at the tip and found it to be a tag object
(i.e. not a lightweight tag or a branch).  from_tag is about "is the
tip within refs/tags/ hierarchy?  Yes/No?" and such a caller will
set it appropriately when calling us.  This function just passes it
down when it recursively calls itself.  

We shouldn't be mucking with that value ourselves here, should we?

The only case that this change may make a difference I can think of
is when you have a tag object pointed at from outside refs/tags
(e.g. refs/heads/foo is a tag object); if you are trying to change
the definition of "from_tag" from the current "Is the tip inside
refs/tags/?" to "Is the tip either inside refs/tags/ or is it a tag
object anywhere?", that may be a good change (I didn't think things
through, though), but that shouldn't be hidden inside a commit that
claims to only add support for debugging.

What problem are you solving?  

> @@ -236,7 +273,6 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>  	}
>  
>  	add_to_tip_table(oid->hash, path, can_abbreviate_output);
> -
>  	while (o && o->type == OBJ_TAG) {
>  		struct tag *t = (struct tag *) o;
>  		if (!t->tagged)

This is a patch noise we can do without.

Thanks.

