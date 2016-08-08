Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA80F2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 22:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbcHHWNn (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 18:13:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750938AbcHHWNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 18:13:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4101D33D8E;
	Mon,  8 Aug 2016 18:13:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tWHMuW3PnQtMgfcPwvdAW/dfjfE=; b=t4tfeH
	Xa7ov6lA84acA80VVv72sZYtnqZYv51YlBH9WwTgjPhY/aXmVfGlnqCtCs58U9qd
	NWArBBYquU6OABpp3kSsiDLfkS6UnmQftrBfVCsprk5F7U/qCc9q12RzUbbnesXj
	ed4yKLZraHLCJm1Jkg7WXco/E5xck49ZUHtoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gWJFmoVopcaXOQ/Ffm+sqHrueukQeN92
	uQ7HD55VT5D2dfOm48g0fil+TU+fuJ2yb7Eq++9DVdoYLMW/yyGzF9T6h7pNnnqo
	T5PLWJ80D41SMcwjWH5b2O9oXsaFpghCV0QCSTIQsCTq+f4BOrZq8GtpQq56LKy1
	2KV5A7Ryomk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 383DF33D8C;
	Mon,  8 Aug 2016 18:13:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE54A33D8B;
	Mon,  8 Aug 2016 18:13:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v10 33/40] environment: add set_index_file()
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
	<20160808210337.5038-34-chriscool@tuxfamily.org>
Date:	Mon, 08 Aug 2016 15:13:38 -0700
In-Reply-To: <20160808210337.5038-34-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 8 Aug 2016 23:03:30 +0200")
Message-ID: <xmqq60raewod.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CC39036-5DB5-11E6-A87D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Now if someone really needs to use this new function, it should be
> used like this:
>
>     /* Save current index file */
>     old_index_file = get_index_file();
>     set_index_file((char *)tmp_index_file);
>
>     /* Do stuff that will use tmp_index_file as the index file */
>     ...
>
>     /* When finished reset the index file */
>     set_index_file(old_index_file);
>
> It is intended to be used by builtins commands, in fact only `git am`,
> to temporarily change the index file used by libified code.
>
> This is useful when libified code uses the global index, but a builtin
> command wants another index file to be used instead.

That is OK, but I do not think NO_THE_INDEX_COMPATIBILITY_MACROS has
much to do with this hack.  Even if you stop using the_index and
have the caller pass its own temporary index_state, that structure
does *not* know which file to read the (temporary) index from, or
which file to write the (temporary) index to.  In fact, apply.c
already does this in build_fake_ancestor():

    static int build_fake_ancestor(struct patch *list, const char *filename)
    {
            ...
            hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
            res = write_locked_index(&result, &lock, COMMIT_LOCK);
            ...
    }

As you can see, this function works with a non-standard/default
index file _without_ having to use non-default index_state.  What
the set_index_file() hack allows you to do is to use interface that
does *NOT* pass "filename" like the caller does to this function.

Isn't the mention on NO_THE_INDEX_COMPATIBILITY_MACROS in the added
comments (there are two) pure red-herring?
