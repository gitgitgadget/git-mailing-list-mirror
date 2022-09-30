Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36497C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 17:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiI3RXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiI3RXR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 13:23:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A302037D
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:23:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dv25so10375708ejb.12
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=Mp6A0sfmGDI9Bv876qG+10W/oX/wLSlqnvRJ38S+lsQ=;
        b=i2BB9DY5FV8+x0+bbWani/ISdNfu9WQkWo1gOybNDMQ7JyZveFnr5jxmuAGevGum44
         HytcB44cdwNKy5TL6QX/o9sR2IVXnDxI+ojuK5dBJoUkLS4V+9YhfeSDEiOPSlO/T08F
         MUyRda4FJVEXHXMJ14LrSW8oKu6x3xel8Kwjs/0EARfAF84L7dhs+D+FNoGyzId2jK8R
         VynYEFokbRV/E+E5ZL/5V8IdHKe3wqjkSVxEUSyedTryOSy8oLQRhLkwhIYsCJL1Faox
         kafku/znlxDEE6ZOjzR/7uHLNya9Z0H1JYPdsZm/WB5Iy66P58bKtwBG/b0umg4iQ8Ys
         vKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Mp6A0sfmGDI9Bv876qG+10W/oX/wLSlqnvRJ38S+lsQ=;
        b=74yoSEn9SZhaWoFt7DE2FzX7iRvcuVL1oq6vOXVorMcuWwq2WIXY4I3gOglMaChRu9
         sl08HhdWIMR/JWPnrADSCWXhA/L+ccBPt8Ez3y6wGaJFnOZNOPpdy4153DqPaDYCIXBb
         gBB5ryJcBCr4Zi/nt0kJc7onin0+mPqWP6ZdMdhciyAm9eLGbWLlto/iddBLog6E4hHv
         5w7yH4+OPn86Zvq4LpvlEM3V/BB8wr6NxuCPCnDF7aZT7wl6oE923MEw3bQn5YyXmcnB
         SkDn94Wisv7JFkJif/1qUmzW4ciG0VPKLWPTyNXIwIRZADeNieTYO3iG/4+AOmzTYfIF
         G0Jw==
X-Gm-Message-State: ACrzQf3Fh28hxGXVuEv2Y8dnwAjV+c8D1he1CKoeqf1qWgNWH7xbrrsX
        O+ZMH7ok6rL14hTYeK1cJfw=
X-Google-Smtp-Source: AMsMyM5uw9W3/745+D/pJ/YJuzI+y0wKFYyxgJ5Gq4m3gUdQcpFv3e7vAsoRpdYierwm9Yve7FPdKA==
X-Received: by 2002:a17:907:2bd8:b0:770:77f2:b7af with SMTP id gv24-20020a1709072bd800b0077077f2b7afmr7097298ejc.545.1664558595005;
        Fri, 30 Sep 2022 10:23:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ek12-20020a056402370c00b004587f9d3ce8sm1553309edb.56.2022.09.30.10.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:23:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oeJjF-001mhi-0p;
        Fri, 30 Sep 2022 19:23:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] sequencer: fail early if invalid ref is given to
 'update-ref' instruction
Date:   Fri, 30 Sep 2022 19:09:04 +0200
References: <20220930140948.80367-1-szeder.dev@gmail.com>
 <20220930140948.80367-7-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20220930140948.80367-7-szeder.dev@gmail.com>
Message-ID: <220930.86a66gvkse.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 30 2022, SZEDER G=C3=A1bor wrote:

> +	if (item->command =3D=3D TODO_UPDATE_REF) {
> +		struct strbuf ref =3D STRBUF_INIT;
> +		int ret =3D 0;
> +
> +		item->commit =3D NULL;
> +		item->arg_offset =3D bol - buf;
> +		item->arg_len =3D (int)(eol - bol);
> +
> +		strbuf_add(&ref, bol, item->arg_len);

Just a nit and maybe not worth it, but we've done this allocation dance
just because..

> +		if (!starts_with(ref.buf, "refs/") ||
> +		    check_refname_format(ref.buf, 0))

...there isn't such a thing as checkn_refname_format() taking a "size_t
len" or whatever.

So maybe not worth it, but if we do the equivalent of:
=09
	static checkn_refname_format(const char *refname, size_t len, unsigned int=
 flags)
	{
	        struct strbuf ref =3D STRBUF_INIT;
	        int ret;
=09
		strbuf_add(&ref, refname, len);
	        ret =3D check_refname_format(ref,buf, flags);
	        strbuf_release(&ref);
=09
		return ret;
	}

This caller could just (untested):

	if (!starts_with(bol, "refs/") ||
	    checkn_refname_format(bol, eol - bol, 0))
		return error(_("...%.*s", item->arg_len, bol));

Which saves us the copy in case the "starts_with" test is all we need.

Even without such a helper, maybe:

	int bad;

        [...]
	bad =3D (!starts_with(ref.buf, "refs/") ||
               check_refname_format(ref.buf, 0));
        strbuf_release(&buf);
        if (bad)
		return error(_("...%.*s", item->arg_len, bol));
	return 0;

Would make it clearer that the strbuf is just for the use of
check_refname_format().

What you have already is also fine, this just sent me down a rabbit hole
of re-learning that most of the string duplication we do for
check_refname_format() could be avoided if it was slightly less stupid,
i.e. accepted a "len" and "prefix" (i.e. "pretend your refname argument
started with 'refs/heads/'", or whatever).

> +			ret =3D error(_("invalid ref for update-ref instruction: %s"), ref.bu=
f);
> +
> +		strbuf_release(&ref);
> +		return ret;
> +	}
> +
>  	end_of_object_name =3D (char *) bol + strcspn(bol, " \t\n");
>  	saved =3D *end_of_object_name;
>  	*end_of_object_name =3D '\0';
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 2e081b3914..b97f1e8b31 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1964,6 +1964,34 @@ test_expect_success 'respect user edits to update-=
ref steps' '
>  	test_cmp_rev HEAD refs/heads/no-conflict-branch
>  '
>=20=20
> +test_expect_success 'update-refs with invalid refs' '
> +	cat >fake-todo-4 <<-EOF &&
> +	update-ref refs/heads/foo..bar
> +	update-ref refs/heads/foo.lock
> +	update-ref foo
> +	update-ref foo/bar
> +	pick $(git rev-parse HEAD)

Another potentially hidden segfault/exit code for "git"
