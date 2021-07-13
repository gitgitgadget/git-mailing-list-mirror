Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8C3C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14B160720
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbhGMWcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 18:32:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63806 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbhGMWcP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 18:32:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 615C0C7943;
        Tue, 13 Jul 2021 18:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+eb5gNfpejju
        4EVlzDF82aQOkYg61TlCDpSBpc/uiPk=; b=TfA9LqTHTSZC3rmBUldlYeSos9B7
        WmE6LdteU/2GMXjbQC+V3Q6NMixEJHfvDA25ta1S5UUW0zx4QAl2aY1g2uOBxiyn
        Oefba4rUIAOrOs8MJjPHXQSH/rA5/016ZHn0FPD/ywEAcoryMImLe6SeU5TtyqrI
        H+pUL+l1R8CC43M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59D39C7942;
        Tue, 13 Jul 2021 18:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6A4BC7941;
        Tue, 13 Jul 2021 18:29:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] add missing __attribute__((format))
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
        <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
Date:   Tue, 13 Jul 2021 15:29:23 -0700
In-Reply-To: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 13 Jul
 2021 10:05:15 +0200")
Message-ID: <xmqqfswh26gs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C66FC518-E429-11EB-B93D-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> v2: Let's drop the whole bending over backwards to do mostly/entirely
> useless strftime() checking. That's gone, I added a patch at the end
> with a comment for strbuf_addftime() to say why it's not there, and
> also split up the advise_if_enabled() change into its own commit.

OK.

> I also removed the other cases of adding attribute checking to
> compat/*. I can't easily test those, and I don't know if there's
> potential bad interactions with git-compat-util.h.

Sensible.

> 3:  bc3fee3b7a ! 3:  e2e039f481 *.c static functions: add missing __att=
ribute__((format))
>     @@ commit-graph.c: int write_commit_graph(struct object_directory *=
odb,
>       {
>       	va_list ap;
>     =20
>     - ## compat/mingw.c ##
>     -@@ compat/mingw.c: static int read_yes_no_answer(void)
>     - 	return -1;
>     - }
>     -=20
>     -+__attribute__((format (printf, 1, 2)))
>     - static int ask_yes_no_if_possible(const char *format, ...)
>     - {
>     - 	char question[4096];
>     -
>     - ## compat/winansi.c ##
>     -@@ compat/winansi.c: static void winansi_exit(void)
>     - 	CloseHandle(hthread);
>     - }
>     -=20
>     -+__attribute__((format (printf, 1, 2)))
>     - static void die_lasterr(const char *fmt, ...)
>     - {
>     - 	va_list params;
>     -
>       ## contrib/credential/osxkeychain/git-credential-osxkeychain.c ##

These refrain from touching some compat stuff, OK.

> 4:  3bf8637c16 ! 4:  fd70d512b4 *.h: add a few missing  __attribute__((=
format))
>     @@ Metadata
>       ## Commit message ##
>          *.h: add a few missing  __attribute__((format))
>     =20
>     -    Add missing format attributes to those function that were miss=
ing
>     -    them.
>     -
>     -    In the case of advice_enabled() this revealed a trivial issue
>     -    introduced in b3b18d16213 (advice: revamp advise API, 2020-03-=
02). We
>     -    treated the argv[1] as a format string, but did not intend to =
do
>     -    so. Let's use "%s" and pass argv[1] as an argument instead.
>     -
>     -    For strbuf_addftime() let's add a strftime() format checker. O=
ur
>     -    function understands the non-portable %z and %Z, see
>     -    c3fbf81a853 (strbuf: let strbuf_addftime handle %z and %Z itse=
lf,
>     -    2017-06-15).
>     -
>     -    That might be an issue in theory, but in practice we have exis=
ting
>     -    codepath that supplies a fixed string to strbuf_addftime(). We=
're
>     -    unlikely to run into the "%z" and "%Z" case at all, since it's=
 used by
>     -    date.c and passed via e.g. "git log --date=3D<format>".
>     -
>     -    In fact, we had no in-tree user of strbuf_addftime() with an i=
nline
>     -    fixed format string at all. A subsequent commit will tweak an =
existing
>     -    one to use the format checking.
>     +    Add missing format attributes to API functions that take print=
f
>     +    arguments.
>     =20
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>

OK.  strftime() is gone.

>     - ## advice.h ##
>     -@@ advice.h: int advice_enabled(enum advice_type type);
>     - /**
>     -  * Checks the visibility of the advice before printing.
>     -  */
>     -+__attribute__((format (printf, 2, 3)))
>     - void advise_if_enabled(enum advice_type type, const char *advice,=
 ...);

This has become a separate one, because...?

OK, the addition to advise_if_enabled() reveals an existing iffy
caller, so you chose to fix it and to annotate the function at the
same time in a single commit at step [5/6].  Makes sense.
