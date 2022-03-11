Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F41C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 02:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiCKCSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239274AbiCKCSx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 21:18:53 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75CA5133E
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 18:17:50 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qa43so16030417ejc.12
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 18:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AL1/RuYE7MUcb9gQhsYazRXr73aE0tB5TyFwFyqNK4Q=;
        b=LYjJ9lfCU4FLZaWQYHj6qAun2+dsxQ3cvMc1rYgjuGofgzoSa+XozzeDlyiospCrx1
         j/rx1PK6RBW+B9pFXEiavDRQUT01dKDX8mkb8pT+hviFBRtTZvn8fByn2iFdqrqCUV7q
         GtfQWhYpbTbskSyxI7Xe7LzLH4kFzUKdqCwyr1brp7NunIdSOC6d7uMIU/VkFws1KOfq
         bqYT98v+YkQRpk5Szt27bPtPoQ0IdjNAsDUDxtR8MPpPzvLDbcxw5UexMMnY/TGWShYw
         RwJAqf/SP3LeUGt0hTB4cvt1N197DmovejgsAR6pscJMRw06JwzjCp52vISSj/28J9U4
         7xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AL1/RuYE7MUcb9gQhsYazRXr73aE0tB5TyFwFyqNK4Q=;
        b=Q+3P+jEvAufiFnwj05rgkAVFabgkiItx8vojGp+egmJMNuDCKWfK/pJMKN4sKlObsc
         AVth5SHLOiQrICS8Wt+2gTGXBkBQj1BqCSY3+TRHsjn6zDChpA0idwciyXiCbo+3OrJr
         +TDSRA8pSQDgWNMBogLXmnepRvha6kFf8R1zuDkgA0qPuYFbzvityOamCTx/4fuuDL5o
         vm0brjOR0BtE8VcUq6OcrHmTUsQvO6CBGImveOeso5DDYk7F5oR5K9uU2axpgVkyZ043
         c5vTOcxysV80ssPXYXyRnjcnNMLsKkPyeAm8IoI7LpMmHO2OtROpK0o6H60QXJy8oS40
         SyZg==
X-Gm-Message-State: AOAM530rtyW8bjOprvCYI1pxSA4SDk6VtXxatvaAoAD7NqyQG69J16V/
        4CX5x2HsZjq8ZQxRrDcfi1c=
X-Google-Smtp-Source: ABdhPJwXTPd1x02Zo3nBwD4SCjb6RQ+KLpZoKKc9A4lG2sKCgz3zFm2B7iZMcJub9zRqqJHcZh7FRA==
X-Received: by 2002:a17:906:30d1:b0:6cf:d160:d8e4 with SMTP id b17-20020a17090630d100b006cfd160d8e4mr6766560ejb.265.1646965069103;
        Thu, 10 Mar 2022 18:17:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090664d700b006db59e6a243sm2425669ejn.53.2022.03.10.18.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 18:17:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSUqi-000rq3-72;
        Fri, 11 Mar 2022 03:17:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 4/6] builtin/stash: provide a way to export stashes to a
 ref
Date:   Fri, 11 Mar 2022 03:08:04 +0100
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220310173236.4165310-5-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220310173236.4165310-5-sandals@crustytoothpaste.net>
Message-ID: <220311.86bkydi65v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 10 2022, brian m. carlson wrote:

> +	size_t author_len, committer_len;
> +	struct commit *this = NULL;
> +	const char *orig_author = NULL, *orig_committer = NULL;
> +	char *author = NULL, *committer = NULL;
> +	const char *buffer = NULL;
> +	unsigned long bufsize;
> +	const char *p;
> +	char *msg = NULL;

These shouldn't be initialized unless they really need to..

> +	this = lookup_commit_reference(the_repository, &info->w_commit);

..and some are clobbered right away here, so all of these should not be initializzed.

> +	buffer = get_commit_buffer(this, &bufsize);
> +	orig_author = find_commit_header(buffer, "author", &author_len);
> +	orig_committer = find_commit_header(buffer, "committer", &committer_len);
> +	p = memmem(buffer, bufsize, "\n\n", 2);

...since by doing so we hide genuine "uninitialized"
warnings. E.g. "author_len" here isn't initialized, but is set by
find_commit_header(), but if that line was removed we'd warn below, but
not if it's initialized when the variables are declared..

> +		for (size_t i = 0;; i++, nitems++) {
> +			char buf[32];
> +			int ret;
> +
> +			if (nalloc <= i) {
> +				size_t new = nalloc * 3 / 2 + 5;
> +				items = xrealloc(items, new * sizeof(*items));
> +				nalloc = new;

Can't we just use the usual ALLOC_GROW() pattern here?

> +			}
> +			snprintf(buf, sizeof(buf), "%zu", i);

Aren't the %z formats unportable (even with our newly found reliance on
more C99)? I vaguely recall trying them recently and the windows CI jobs
erroring...

> +	for (ssize_t i = nitems - 1; i >= 0; i--) {

The ssize_t type can be really small (it's not a signed size_t), so this
is unportable, but in practice maybe it's OK...

In this case if you're just wanting to count down in a list maybe you
can use the pattern I used in 99d60545f87 (string-list API: change "nr"
and "alloc" to "size_t", 2022-03-07)?

> +	if (ref) {
> +		update_ref(NULL, ref, &prev->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
> +	} else {
> +		puts(oid_to_hex(&prev->object.oid));
> +	}

Nit: braces can be gone.

> +out:
> +	for (size_t i = 0; i < nitems; i++) {
> +		free_stash_info(&items[i]);
> +	}

Ditto.

> +static int export_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int ret = 0;
> +	int print = 0;
> +	const char *ref = NULL;
> +	struct option options[] = {
> +		OPT_BOOL(0, "print", &print,
> +			 N_("print the object ID instead of writing it to a ref")),
> +		OPT_STRING(0, "to-ref", &ref, "refname",

Needs _("refname")

> +			   N_("save the data to the given ref")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_export_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (!(!!ref ^ print))
> +		return error("exactly one of --print or --to-ref is required");

Cute, but maybe we can just use OPT_CMDMODE(), and if it's "to-ref"
shift one off argv afterwards (which'll be your &ref).

I.e. it'll give you the option incompatibility check, and without a new
translaed string.

Which, if we're keeping this version should use _().

