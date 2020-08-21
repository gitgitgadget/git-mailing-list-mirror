Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91C7C433E4
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E9E214F1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xhRPoveQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHUTzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:55:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55270 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgHUTyw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 15:54:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D9BF7BAB1;
        Fri, 21 Aug 2020 15:54:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PA21XC685WOhRQpUCvNjCrdi5qE=; b=xhRPov
        eQiJrdv983YJ+Q4xXX8lnb6N154JpKXBmufzelC8N2yaNHJXD5FLPt7ltL+rtZy7
        or2/BoeoAmtOtR5NwAocvPHtczsL1pI0oQ4jHRizkuIzfwQSMN8uZ/f+bm2X+Bc/
        46Ox7NJt9TsTu1pfPMPbIgOOCM7cWjwI9MtgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mMrj5hU3T544CebtuhzZsNrum+oUA698
        jVhjJd+VWFFE+222ysSbB1VD/2TPpdvXCZSzuSN0RXi9RwT9LOF/8xZ8lPgFa/mw
        4JRZBdR3AxKYPDm9ADfT1mc4qsF4eNR337CY9YH62uDw4ZzyAboE1MSEtK/X95B+
        uUEN+glfE8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83AC57BAB0;
        Fri, 21 Aug 2020 15:54:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 006C77BAAF;
        Fri, 21 Aug 2020 15:54:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        liu.denton@gmail.com, pc44800@gmail.com, stefanbeller@gmail.com
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary' from shell to C
References: <20200821171705.GA16484@konoha>
        <xmqq5z9ban27.fsf@gitster.c.googlers.com>
        <377b1a2ad60c5ca30864f48c5921ff89b5aca65b.camel@gmail.com>
Date:   Fri, 21 Aug 2020 12:54:46 -0700
In-Reply-To: <377b1a2ad60c5ca30864f48c5921ff89b5aca65b.camel@gmail.com>
        (Kaartic Sivaraam's message of "Sat, 22 Aug 2020 00:24:01 +0530")
Message-ID: <xmqqa6yn93ll.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A52D216-E3E8-11EA-B477-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Here's the error message with context of the trash directory of that
> test:
>
> -- 8< --
> $ cd t
> $ ./t7421-submodule-summary-add.sh  -d
> $ cd trash\ directory.t7421-submodule-summary-add/
>
> $ git submodule summary HEAD^^
> fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
> * my-subm 35b40f1...0000000:
>
> * subm 0000000...dbd5fc8 (2):
>   > add file2
>
> -- >8 --
>
> That 'fatal' is a consequence of spawning a process in
> `verify_submodule_committish` of `builtin/submodule--helper.c` even for
> non-existent submodules.

Oh, so doing something that would cause the error message to be
emitted itself is a bug.

> I don't think that 'fatal: ' message is giving
> any useful information here. The fact that submodule 'my-subm' doesn't
> exist can easily be inferred just by looking at the destination mode
> (0000000). If anything that 'fatal' message is just confusing and
> unnecessary, IMO.

Yes, I 100% agree.

> So, we could easily suppress it by doing something like this (while
> also fixing the test):

Yup.  That is a very good idea.  

Or the caller of verify_submodule_committish() should refrain from
calling it for the path?  After all, it is checking sm_path is a
path to where a submodule should be before calling the function
(instead of calling it for every random path), iow its criteria to
make the call currently may be "the path in the index says it is a
submodule", but it should easily be updated to "the path in the
index says it is a submodule, and the submodule actually is
populated", right?

> @@ -972,7 +972,7 @@ static char* verify_submodule_committish(const char *sm_path,
>         strvec_pushf(&cp_rev_parse.args, "%s^0", committish);
> ...
> BTW, I noted that `print_submodule_summary` has the following
> definition:
>
>    static void print_submodule_summary(struct summary_cb *info, char* errmsg
>    				    ...
>
> Note how '*' is placed near 'char' for 'errmsg' with an incorrect style. Ditto
> for the return type of `verify_submodule_committish`. This might make
> for a nice cleanup patch.

Yup.  It would have been nicer to catch these before the topic hit
'next'.

Thanks.
