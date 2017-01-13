Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DE8720756
	for <e@80x24.org>; Fri, 13 Jan 2017 19:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdAMTvV (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 14:51:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60345 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750965AbdAMTvU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 14:51:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 939405DEFC;
        Fri, 13 Jan 2017 14:51:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aLHZHR2ttbO9
        +VE0hqn8VjXU3ZU=; b=r+5RjCfA0+S2qZ47deRgEcqyhTi+rXgdSJJaGmeKPI+b
        MjwpZUExp/oND9Yc5KTthjWlKEYv7dPCJOTHhpPCs27ipjnGnlad/yLNUMn0BOwA
        plevIzAkzzJIgFqvsikX/lF/Jna/m8njoOpv/aTPMtNR8kFmIuO5HV83ZBQKR/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fWzkId
        qeKqP7vzld7LVJEW0xZfMAng13qjYz13tT4SWzF8EPBvaehbJUZCuIReS2oVQfYc
        JiJLvAaPO3ROXDxxQ7yGq0UHrok6HwivrSbT+msa1G9uCFptuyL/HmULUbvsy7/V
        ShanO7dRGIzg1wCCSxY7p4xcqrCwz0nMsmzn8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 899565DEFB;
        Fri, 13 Jan 2017 14:51:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7ED25DEFA;
        Fri, 13 Jan 2017 14:51:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty lines in context
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
        <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
        <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
Date:   Fri, 13 Jan 2017 11:51:16 -0800
In-Reply-To: <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 13 Jan 2017 19:19:48 +0100")
Message-ID: <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A693ABB6-D9C9-11E6-8B73-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 13.01.2017 um 17:15 schrieb Vegard Nossum:
>> When using -W to include the whole function in the diff context, you
>> are typically doing this to be able to review the change in its entire=
ty
>> within the context of the function. It is therefore almost always
>> desirable to include any comments that immediately precede the functio=
n.
>>
>> This also the fixes the case for C where the declaration is split acro=
ss
>> multiple lines (where the first line of the declaration would not be
>> included in the output), e.g.:
>>
>> 	void
>> 	dummy(void)
>> 	{
>> 		...
>> 	}
>>
>
> That's true, but I'm not sure "non-empty line before function line" is
> good enough a definition for desirable lines.  It wouldn't work for
> people who don't believe in empty lines.  Or for those that put a
> blank line between comment and function.  (I have an opinion on such
> habits, but git diff should probably stay neutral.)  And that's just
> for C code; I have no idea how this heuristic would hold up for other
> file types like HTML.

As you are, I am fairly negative on the heuristic based on the
"non-blank" thing.  We tried once with compaction-heuristics already
and it did not quite perform well.  Let's not hardcode another one.

> We can identify function lines with arbitrary precision (with a
> xfuncname regex, if needed), but there is no accurate way to classify
> lines as comments, or as the end of functions.  Adding optional
> regexes for single- and multi-line comments would help, at least for
> C.

The funcline regexp is used for two related but different purposes.
It identifies a single line to be placed on @@ ... @@ line before a
diff hunk.  This line however does not have to be at the beginning
of a function.  It has to be the line that conveys the most
significant information (e.g. the name of the function).

The way "diff -W" codepath used it as if it were always the very
first line of a function was bound to invite a patch like this, and
if we want to be extra elaborate, I agree that an extra mechanism to
say "the line the funcline regexp matches is not the beginning of a
function, but the beginning is a line that matches this other regexp
before that line" may help.

Do we really want to be that elaborate, though?  I dunno.

I wonder if it would be sufficient to make -W take an optional
number, e.g. "git show -W4", to add extre context lines before the
funcline.
