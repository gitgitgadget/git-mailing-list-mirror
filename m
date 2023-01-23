Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621D1C38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 08:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjAWIlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 03:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjAWIlo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 03:41:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36221CF40
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 00:41:42 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id az20so28530121ejc.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 00:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7lGQ7lntuUKaDg5RVz/vihI5WKxuS7ji3ND94B15FAY=;
        b=kxB+cCKm/qfDG8XrRFJWRYcjHZ3T6UkpodWssoJ+hlPmhaNDBgUuMU+UXB5WAaKI7W
         W8d2GA0TF0Nn/9WL38f70fcs/VevWxUHNpPhtL8jJ11gWHLWB4J5Bq7izrPaG3dyYX7u
         TjmMzAFF6lyyK+QCOht0fmhiSrpjOXEoTNVID/cUUF0QVjhvH8AiWsnGTfQlxe35d8+M
         b+V7TOIxADiUyUovd3LX3D7549RI1rqwL8PXCqnGA+BVk/TGZuuMfq4jJcjkquF2NSOl
         o9Vv3y81c5y+9/x5fSiFU+JWDPWkloWE7G3LAHOklENr+ulNH3IrKWHmmQh8QxOlCiQR
         1Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lGQ7lntuUKaDg5RVz/vihI5WKxuS7ji3ND94B15FAY=;
        b=WQtE1SC3m0qVM5NrLIPb3s2oMdgecNRLnznK+AVDMr1ejX714+Wr3re2aTw05b1T3z
         gozBClwcgXno57ZBad4WLA+d/A4U0FoXbQ2NqVBDnlgY3m1VcvlvWotLjxkIvcn7cKDr
         Qtq28rhO40bOSNNXZa2cySG7HZx5PupIE6Heu4KHG9H4x1nx9T9GEph1RVbLJRvPTEk/
         0MSAIiKSeJI+aavvjAdVHHwh9H5TkswbnO6tdpoTWHuN1mZ7Blc2cfI8dBrm+GNR6kpp
         WJKUnLjnTEgkpds/42ya0gwevh+EFi9O0IXinOULQGjmPBITfukLC4TV50V1smcbRGJp
         lnww==
X-Gm-Message-State: AFqh2kohAruV1jN+v8J1yuE93W2aL5qWBxSKHqRRq2X6JLUfjc/2rcCd
        sq1PGEMYKC8fEu0j7kJnrUltS3eBR6w=
X-Google-Smtp-Source: AMrXdXu+8etmHqrbHXzdpKYUFIRW86qM5ngy+YohHvjGDsCBhoqObs2dsmzeOlYHmisIpG3dw2orTQ==
X-Received: by 2002:a17:906:94d:b0:871:9b32:71a2 with SMTP id j13-20020a170906094d00b008719b3271a2mr25365122ejd.4.1674463300818;
        Mon, 23 Jan 2023 00:41:40 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b0084c6581c16fsm21784865ejc.64.2023.01.23.00.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 00:41:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pJsOZ-0003eM-2N;
        Mon, 23 Jan 2023 09:41:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] tree-walk: disallow overflowing modes
Date:   Mon, 23 Jan 2023 09:33:57 +0100
References: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
Message-ID: <230123.86a629tzgc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 21 2023, Ren=C3=A9 Scharfe wrote:

> When parsing tree entries, reject mode values that don't fit into an
> unsigned int.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  tree-walk.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index 74f4d710e8..5e7bc38600 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -17,6 +17,8 @@ static const char *get_mode(const char *str, unsigned i=
nt *modep)
>  	while ((c =3D *str++) !=3D ' ') {
>  		if (c < '0' || c > '7')
>  			return NULL;
> +		if ((mode << 3) >> 3 !=3D mode)
> +			return NULL;
>  		mode =3D (mode << 3) + (c - '0');
>  	}
>  	*modep =3D mode;

There was a discussion about this on git-security last August, in a
report that turned out to be uninteresting for the security aspects.

I'll just quote my own reply here out of context
(<220811.86mtcbqd5x.gmgdl@evledraar.gmail.com> for those with access).

For context the other issue in the "two issues" below is the one I'm
working towards fixing in
https://lore.kernel.org/git/cover-0.4-00000000000-20221118T113442Z-avarab@g=
mail.com/,
the other is this file mode overflow.

As noted at the end below I'm conflicted between whether we should "fix"
this in some way, or just intentionally leave it alone, because while
it's entirely accidental, this is the one part of git's object format
I'm aware of that we could sneak in some extension in the future,
without entirely breaking backwards compatibility.

BEGIN QUOTE

There's really two issues being raised here, how we validate the "mode"
in tree entries, and how we sometimes misreport object type X as type Y.

I replied on-list just now noting that the "mode" thing is something I
was working towards fixing a while ago, but am happy to see a more
isolated fix for:
https://lore.kernel.org/git/220811.86r11nqfi2.gmgdl@evledraar.gmail.com/

I have local patches for the misreporting of object types, it's not
*that* hard to get right. Basically we just need to be more careful
about how we populate the "struct object". The most common case is when
we parse tags that say on their envelope that we refer to a type X, but
it's really a type Y.

In that case we haven't .parsed=3D1 the object, but we note the wrong type
down. My local patches are basically just deferring that, so we don't
trust such type claims, and take our *actual* parsing of the object over
a previous reference in the object store.

I don't think that leaves any difficult edge cases related to tree
parsing, as Xavier notes we'd have modes claiming that an X is Y, but we
can resolve it using the same principle.

But regarding the "mode parsing" I think
https://lore.kernel.org/git/YvQdR3sDqDMCIjIE@coredump.intra.peff.net/ is
taking us in the wrong direction, but wasn't comfortable saying so on
list, because this is "exploitable" in the following way:

	$ perl -wE 'say unpack "B*", "hello world"'
	01101000011001010110110001101100011011110010000001110111011011110111001001=
10110001100100

Which, combined with Jeff's series on-list you can try e.g.:
=09
	diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-stric=
t.sh
	index ac4099ca893..d435dfd64c5 100755
	--- a/t/t5504-fetch-receive-strict.sh
	+++ b/t/t5504-fetch-receive-strict.sh
	@@ -357,16 +357,16 @@ test_expect_success 'badFilemode is not a strict err=
or' '
	 	tree=3D$(
	 		cd badmode.git &&
	 		blob=3D$(echo blob | git hash-object -w --stdin | hex2oct) &&
	-		printf "123456 foo\0${blob}" |
	+		printf "106640110100001100101011011000110110001101111001000000111011101=
101111011100100110110001100100664 foo\0${blob}" |
	 		git hash-object -t tree --stdin -w --literally
	 	) &&
=09=20
	 	rm -rf dst.git &&
	 	git init --bare dst.git &&
	 	git -C dst.git config transfer.fsckObjects true &&
	-
	-	git -C badmode.git push ../dst.git $tree:refs/tags/tree 2>err &&
	-	grep "$tree: badFilemode" err
	+	git -C badmode.git push ../dst.git $tree:refs/tags/tree &&
	+	git -C badmode.git fsck &&
	+	git -C dst.git fsck
	 '
=09=20
	 test_done
	diff --git a/tree-walk.c b/tree-walk.c
	index 74f4d710e8f..2fb9f2e6cbe 100644
	--- a/tree-walk.c
	+++ b/tree-walk.c
	@@ -15,6 +15,7 @@ static const char *get_mode(const char *str, unsigned in=
t *modep)
	 		return NULL;
=09=20
	 	while ((c =3D *str++) !=3D ' ') {
	+		fprintf(stderr, "%c\n", c);
	 		if (c < '0' || c > '7')
	 			return NULL;
	 		mode =3D (mode << 3) + (c - '0');

Which gets you all tests passing, i.e. the particulars of the mode check
are such that we'll accept a very long mode (but if you play with it
you'll find it's not infinite, we'll run into other buffers elsewhere
pretty soon).

This is all assuming you're on a system whose "unsigned int" is 64 bit.

This part of it is also something I discovered in the beginning of 2021
(and there's some old off-list thread between myself & Elijah on the
topic I could dig up), but didn't report here at the time.

So, we could just "fix" it, and re the "wrong direction" above
downgrading the "bad mode" check to a mere warning is going a bit too
far given the above. We have some odd modes in the wild, but we don't
have such "overflowing modes".

On the other hand this edge case is also a golden opportunity we're not
likely to ever have again. We can't really change the git object format
at this point without *major* headaches, but in this case we have the
ability to encode arbitrary data into tree entries (e.g file metadata)
as long as the writer makes sure they overflow back to the valid
filemode :)

As hacky as that is I think it would be regrettable to forever close the
door on that to fix a hypothetical security bug, hypothetical because no
version of git.git has an issue with it. But it is a *potential* edge
case in overflowing any other tree parsing code out there in the wild
(which might be otherwise guarded by a stricter fsck check of ours).

END QUOTE
