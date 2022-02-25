Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127CFC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 18:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiBYSY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiBYSY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 13:24:56 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2721D8AB2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:24:18 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B50E217E65C;
        Fri, 25 Feb 2022 13:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JrO3E6+PZExc22eaUVXoylQxBz84+FFBdjZRX6
        o+XYs=; b=xJ/We6w70bgYRtUAx/o5hXNPiIzCHm/1bqLxrC9yEHMHTd78BKxaoE
        dRzLHjFdkHtyp75Gz6yMe/WBEpKnWMCKhmsZrUZRnVAIP/adujtRcm60v4Vk+bKM
        1BS8iNfLglU33hMdYXU3Q6wqOMjSXDF6EWQSNfoZngI3euc7MIi4w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADB6E17E65B;
        Fri, 25 Feb 2022 13:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2489717E65A;
        Fri, 25 Feb 2022 13:24:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Edward Thomson <ethomson@edwardthomson.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 1/1] xdiff: provide indirection to git functions
References: <20220217225218.GA7@edef91d97c94>
        <20220217225408.GB7@edef91d97c94>
        <e73c6746-9f8d-7e23-3764-18d01307278b@gmail.com>
        <nycvar.QRO.7.76.6.2202251639590.11118@tvgsbejvaqbjf.bet>
Date:   Fri, 25 Feb 2022 10:24:14 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2202251639590.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 25 Feb 2022 16:41:57 +0100
        (CET)")
Message-ID: <xmqqo82udctt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 231EACFC-9668-11EC-A2FF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 22 Feb 2022, Phillip Wood wrote:
>
>> On 17/02/2022 22:54, Edward Thomson wrote:
>> > Provide an indirection layer into the git-specific functionality and
>> > utilities in `git-xdiff.h`, prefixing those types and functions with
>> > `xdl_` (and `XDL_` for macros).  This allows other projects that use
>> > git's xdiff implementation to keep up-to-date; they can now take all the
>> > files _except_ `git-xdiff.h`, which they have customized for their own
>> > environment.
>>
>> The changes since V1 look good,
>
> Indeed. This is the range-diff:
>
> -- snip --
> 1:  52c8f141cbe1 ! 1:  e05e9b5e2f27 xdiff: provide indirection to git functions
>     @@ xdiff/git-xdiff.h (new)
>      +#ifndef GIT_XDIFF_H
>      +#define GIT_XDIFF_H
>      +
>     ++#include "git-compat-util.h"
>     ++
>      +#define xdl_malloc(x) xmalloc(x)
>      +#define xdl_free(ptr) free(ptr)
>      +#define xdl_realloc(ptr,x) xrealloc(ptr,x)
>     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t
>
>       ## xdiff/xinclude.h ##
>      @@
>     + #if !defined(XINCLUDE_H)
>       #define XINCLUDE_H
>
>     - #include "git-compat-util.h"
>     +-#include "git-compat-util.h"
>      +#include "git-xdiff.h"
>       #include "xmacros.h"
>       #include "xdiff.h"
>       #include "xtypes.h"
>     -@@
>     - #include "xdiffi.h"
>     - #include "xemit.h"
>     +
>     + ## xdiff/xmerge.c ##
>     +@@ xdiff/xmerge.c: static int xdl_cleanup_merge(xdmerge_t *c)
>     + 		if (c->mode == 0)
>     + 			count++;
>     + 		next_c = c->next;
>     +-		free(c);
>     ++		xdl_free(c);
>     + 	}
>     + 	return count;
>     + }
>     +@@ xdiff/xmerge.c: static void xdl_merge_two_conflicts(xdmerge_t *m)
>     + 	m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
>     + 	m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
>     + 	m->next = next_m->next;
>     +-	free(next_m);
>     ++	xdl_free(next_m);
>     + }
>
>     --
>     - #endif /* #if !defined(XINCLUDE_H) */
>     + /*
> -- snap --
>
> My ACK from
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202171644090.348@tvgsbejvaqbjf.bet/
> still holds. Junio could you please add it before merging it down to
> `next`?

Not so fast.  I still do not see a strong reason to support
xdl_malloc() and other wrappers.

Is the expectation for other projects when using the unified code,
they do not use xdiff/git-xdiff.h and instead add
xdiff/frotz-xdiff.h that defines xdl_malloc() and friends with the
infrastructure they provide as part of the Frotz project (and the
Xyzzy project would do the same with xdiff/xyzzy-xdiff.h header for
them), making "git" the first among equal other consumers?

If that is the direction this indirection is aiming for, stating it
clearly may be a start of a not-so-bad justification, but then the
hardcoded inclusion of "git-xdiff.h" in xdiff/xinclude.h still
contradicts with it, which may want to be fixed.


