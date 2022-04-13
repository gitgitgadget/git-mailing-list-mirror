Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9875C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 15:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiDMPvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbiDMPvg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 11:51:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946EE66226
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:49:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bh17so4809988ejb.8
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xBN2K0E57a6wuEOwzPacY8TQdJucenoGPX/2dhQvQrc=;
        b=fsGiaXn2pbNTzHCHH7VWm0bF/C9+BBcfs5ZgKEeOSHHb/sQDsYRCSaebkUZ/uCg5xP
         F3ff6GSci7fPtnkMWh4mueNuDNF4NbNZkwWjb4c44DhTyISXiGLuGuSaKEHINvGJky8y
         F7uYWMzjSITaJZW7kl+4KmcVL2aZSHvbwm+QG+0AbfH5hZIy4CYPGLknrJmVc8WYm9dP
         j7sZMTD47PjPYY7T6umURH4HIpv4w80vMUI8hqiaHDEXXmftqg5OksQhJmxndpZXScr/
         ZvPPtkjcdE0gYYohR/xSQiRzXzQnhPzxt+ME2CwXq7uSROz9dTxrUqrYAYFPkh7aWJaE
         AxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xBN2K0E57a6wuEOwzPacY8TQdJucenoGPX/2dhQvQrc=;
        b=iuxnH8JJNWx7bass2ZxFZlzP5HZaZZJXQ9/4FO4oyZ0eOYi2Q1he3wgOM1+/Rzj+sM
         u9IE0coSuoUj35PmlncBDXS3GDYprlBZ/A8q9IAJP+noW9JgTjSsm7EfBIG3I2G7GcuS
         M/2d/bukEwEyMBVwqqeEloPyKc0oyeE5VasHCcObARzPd1u8xTeqz19eVHTNqBXfngpi
         jP5EY9ulESxneP8OorAg8A4PXz52svycZjmJP5bXY0wqexoF2tnD/q0JIavozoh+S5l0
         R2l9TLo+EV/giZvAP0GLNXvMN8mmqFR/ufXlXMboNAzPpOoEKqMWPADMIkMG13oFrSeV
         yHhQ==
X-Gm-Message-State: AOAM530UhCqO/CMcSk/dmIRquGET+kuhIL97E9UUfqXuOHtOFMLhBbD2
        2Gnsg4QBkOdDIljVosD/WTlt1yVihl0=
X-Google-Smtp-Source: ABdhPJyajLB5qopLuSLhHVrkbtUi+GnE9E/FqifLcLHqhi4v2Ao3BFBmMKXzlnfuNckN/w/36SV44w==
X-Received: by 2002:a17:906:6a0f:b0:6e8:b593:4845 with SMTP id qw15-20020a1709066a0f00b006e8b5934845mr6988743ejc.527.1649864952920;
        Wed, 13 Apr 2022 08:49:12 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm104466ejc.197.2022.04.13.08.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:49:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nefF0-0057wt-TD;
        Wed, 13 Apr 2022 17:49:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 3/4] builtin/stash: provide a way to export stashes
 to a ref
Date:   Wed, 13 Apr 2022 17:36:05 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-4-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220407215352.3491567-4-sandals@crustytoothpaste.net>
Message-ID: <220413.86ee21f0g9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 07 2022, brian m. carlson wrote:

> +static int write_commit_with_parents(struct object_id *out, const struct object_id *oid, struct commit_list *parents)
> +{
> +	size_t author_len, committer_len;
> +	struct commit *this;
> +	const char *orig_author, *orig_committer;
> +	char *author = NULL, *committer = NULL;
> +	const char *buffer;
> +	unsigned long bufsize;
> +	const char *p;
> +	struct strbuf msg = STRBUF_INIT;
> +	int ret = 0;
> +
> +	this = lookup_commit_reference(the_repository, oid);
> +	buffer = get_commit_buffer(this, &bufsize);
> +	orig_author = find_commit_header(buffer, "author", &author_len);
> +	orig_committer = find_commit_header(buffer, "committer", &committer_len);

In builtin/am.c we also start with this, but follow it with passing the
data through split_ident_line(), any reason we're not doing the same
thing here, and are there cases wehre that would result in propagating
not-sanity-checked-enough data?


> +	p = memmem(buffer, bufsize, "\n\n", 2);
> +
> +	if (!orig_author || !orig_committer || !p) {
> +		ret = error(_("cannot parse commit %s"), oid_to_hex(oid));
> +		goto out;
> +	}
> +	/* Jump to message. */
> +	p += 2;
> +	strbuf_addstr(&msg, "git stash: ");
> +	strbuf_add(&msg, p, bufsize - (p - buffer));

And more on those behavior differences, the am.c version seems to not
care that we *might* have a \0 in a commit buffer and just uses
xstrdup(msg + 2).

But this one looks like it will faithfully carry that \0-containing
message forward.

Probably OK, just checking...
