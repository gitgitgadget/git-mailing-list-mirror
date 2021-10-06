Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACD8C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35CA61154
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbhJFQqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:46:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62470 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbhJFQqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 12:46:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A74CDC29C;
        Wed,  6 Oct 2021 12:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cl57B3splDhC
        N+gP/Bmh31ikWrXWMTfuVCokiZOPfc0=; b=jor+gQvxnoZt0kpxSIZ3i3x98q47
        YDXK48zqS6NHceKQdi2YNBB6cjLFk/hBoSnhWh/FQG0ig2jlqMwkseke4NbZTxsN
        5hfvdTIIGXiXD0CLlq7vDAUQhUpeBAZhul3YzULMksxaB6iMwD58DJTdVzAMWwPG
        vP6aYf4+a2sSngE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31A42DC29A;
        Wed,  6 Oct 2021 12:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75433DC299;
        Wed,  6 Oct 2021 12:44:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/parse-options-cleanup & ab/align-parse-options-help &
 ab/help-config-vars
References: <xmqqo884tkxd.fsf@gitster.g> <87ilyaihdd.fsf@evledraar.gmail.com>
Date:   Wed, 06 Oct 2021 09:44:05 -0700
In-Reply-To: <87ilyaihdd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 06 Oct 2021 12:17:29 +0200")
Message-ID: <xmqqzgrmrtm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F049868-26C4-11EC-B7FE-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Oct 04 2021, Junio C Hamano wrote:
>
>> * ab/parse-options-cleanup (2021-10-01) 11 commits
>>  - parse-options: change OPT_{SHORT,UNSET} to an enum
>>  - parse-options tests: test optname() output
>>  - parse-options.[ch]: make opt{bug,name}() "static"
>>  - commit-graph: stop using optname()
>>  - parse-options.c: move optname() earlier in the file
>>  - parse-options.h: make the "flags" in "struct option" an enum
>>  - parse-options.c: use exhaustive "case" arms for "enum parse_opt_typ=
e"
>>  - parse-options.c: use exhaustive "case" arms for "enum parse_opt_res=
ult"
>>  - parse-options.[ch]: consistently use "enum parse_opt_result"
>>  - parse-options.[ch]: consistently use "enum parse_opt_flags"
>>  - parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
>>
>>  Random changes to parse-options implementation.
>>
>>  Will merge to 'next'?

As I already said, I am not convinced by the "exhaustive case"
thing.  Other than that, I think this is OK.

>> * ab/align-parse-options-help (2021-09-22) 4 commits
>>  - parse-options: properly align continued usage output
>>  - git rev-parse --parseopt tests: add more usagestr tests
>>  - send-pack: properly use parse_options() API for usage string
>>  - parse-options API users: align usage output in C-strings
>>
>>  When "git cmd -h" shows more than one line of usage text (e.g.
>>  the cmd subcommand may take sub-sub-command), parse-options API
>>  learned to align these lines, even across i18n/l10n.
>>
>>  Will merge to 'next'?

This was more or less "Meh" for me.

>> * ab/help-config-vars (2021-09-23) 9 commits
>>  - help: move column config discovery to help.c library
>>  - help / completion: make "git help" do the hard work
>>  - help tests: test --config-for-completion option & output
>>  - help: simplify by moving to OPT_CMDMODE()
>>  - help: correct logic error in combining --all and --guides
>>  - help: correct logic error in combining --all and --config
>>  - help tests: add test for --config output
>>  - help: correct usage & behavior of "git help --guides"
>>  - help: correct the usage string in -h and documentation
>>
>>  Teach "git help -c" into helping the command line completion of
>>  configuration variables.
>>
>>  Will merge to 'next'?

This is probably a good thing to do.  I do not remember what
implementation nits were still there offhand.

