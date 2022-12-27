Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E5C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 02:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiL0CUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Dec 2022 21:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiL0CUb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2022 21:20:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209E3108F
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 18:20:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so3397105pjq.1
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 18:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz8XK1eZdnbvutURpKZEF7ht5BrUc7YavxTMe1ocH7c=;
        b=ARQ4QCMgrXnuoTWhY5cfguCOgw2s+su8OxS8XPuOglDII5mAYjKxcHhDznLHTSrYA2
         m91QQpOfVnzgCNOOgANAQvUTMXnfsqPy9ampS6bKD35nJCDnQImmvtc7MOY/G/LeTCSh
         +H7uBvO0qRQMizj6BhfQ+qTmT/JDuXNjz3QQmQswv8edI5eGLcohh2yQsnFk1Ymwa87c
         eKtXlk2Hupon+YMtQU0iAtKg5gEOUmZ13GUb1IgC5zr4dqI+0hymhEwncLg7GHJVyil4
         9+Ibwqyo/EGP497Bi8UBNMfeHGdUfHXqLpD75HjTD2oqLbEDkrwWjdfMR6JRHJhmcidf
         c6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jz8XK1eZdnbvutURpKZEF7ht5BrUc7YavxTMe1ocH7c=;
        b=4WZjs7afmM6u8dS+RS2m1crq4ywGGSf32mio5VW/jsjRNQymZ7H6iZqWUBM+sYmbAm
         CloC2AvVl36aqyb8HvS+ZCeQ19q3N/8QH/3iqFlHWVmWRRFm98+4Y9PVqZLkXoiJ8MSg
         SKcqQUfUxUgu74Zyeynu6VwFwM75Sdhg+gqOOeVjgRLaxT8wj5Ns/eP/1KReBdi0ew9g
         gqJEImkH+DzQKQsTSNmaRD8InMErbqNISux+Sb9kLmpW85712TRaeVb0l7/qG5SNGCwl
         BfdONVhjwldZJ9Kh032jGDsqNx6FBDRQghFK3H/Nt+BBpTw1Mu2OJ8aRDlt0+mE44Aau
         ZRqA==
X-Gm-Message-State: AFqh2kqebd6S78bWDOJ4841f2yxJsdQfCFiUfhNJAB8BAWcDi1O7hdFi
        6Hh4Pt7vVzjtO+n7ha2V850=
X-Google-Smtp-Source: AMrXdXtRxzVhbYCrYhqlU7KHncLSALX2OFJeNAqvSdmVxHjMfbq8LwdJLW/cJSbG406bgDFlREJbIg==
X-Received: by 2002:a17:90a:6684:b0:225:d290:dcbe with SMTP id m4-20020a17090a668400b00225d290dcbemr11554433pjj.42.1672107629220;
        Mon, 26 Dec 2022 18:20:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a3b0f00b002190eabb890sm2412848pjc.25.2022.12.26.18.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 18:20:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH] ref-filter: add new atom "signature" atom
References: <pull.1452.git.1672102523902.gitgitgadget@gmail.com>
Date:   Tue, 27 Dec 2022 11:20:28 +0900
In-Reply-To: <pull.1452.git.1672102523902.gitgitgadget@gmail.com> (nsengaw4c
        via GitGitGadget's message of "Tue, 27 Dec 2022 00:55:23 +0000")
Message-ID: <xmqqo7rpvb83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
>
> This only works for commits. Add "signature" atom with `grade`,
> `signer`, `key`, `fingerprint`, `primarykeyfingerprint`, `trustlevel`
> as arguments. This code and it's documentation are inspired by
> how the %GG, %G?, %GS, %GK, %GF, %GP, and %GT pretty formats were
> implemented.

Lacking motivation.  Without explaining why somebody may want to
have the feature and what it would be used for, "only works for
commits" would invite a "so what?  does it even have to work?"  as a
response, so start with a brief descrioption "with the current set
of atoms, $this_useful_thing cannot easily be achieved" before
describing its limitation.

Having said that, wouldn't it be natural to expect that the same
code can deal with signed tags?  After all we use the same signature
verification machinery at the lowest level in the callchain.

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 6da899c6296..9a0be85368b 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -212,6 +212,33 @@ symref::
>  	`:lstrip` and `:rstrip` options in the same way as `refname`
>  	above.
>  
> +signature::
> +...
> +signature:trustlevel::
> +	The Trust level of the GPG signature of a commit. Possible
> +	outputs are `ultimate`, `fully`, `marginal`, `never` and `undefined`.

A good list.  How do these work for signature made with a tool other
than GPG (in other words, when "gpg.format" is set to something
other than "openpgp")?

> @@ -378,6 +383,30 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
>  	return 0;
>  }
>  
> +static int signature_atom_parser(struct ref_format *format, struct used_atom *atom,
> +			       const char *arg, struct strbuf *err)
> +{
> +	if (arg) {
> +		if (!strcmp(arg, "signer"))
> +			atom->u.signature.option = S_SIGNER;
> +		else if (!strcmp(arg, "grade"))
> +			atom->u.signature.option = S_GRADE;
> +		else if (!strcmp(arg, "key"))
> +			atom->u.signature.option = S_KEY;
> +		else if (!strcmp(arg, "fingerprint"))
> +			atom->u.signature.option = S_FINGERPRINT;
> +		else if (!strcmp(arg, "primarykeyfingerprint"))
> +			atom->u.signature.option = S_PRI_KEY_FP;
> +		else if (!strcmp(arg, "trustlevel"))
> +			atom->u.signature.option = S_TRUST_LEVEL;
> +		else
> +			return strbuf_addf_ret(err, -1, _("unknown %%(signature) argument: %s"), arg);
> +	}
> +	else
> +		atom->u.signature.option = S_BARE;
> +	return 0;
> +}

Handing the !arg case first will make the if/else if/... cascade
easier to follow, no?  Also the body of the function may want to
become a separate function that returns one of these S_FOO constants.

	static enum signatore_option signature_atom_parser(...)
	{
                enum signature_option opt = parse_signature_option(arg);
                if (opt < 0)
                        return strbuf_addf_ret(err, opt, _("unknown ..."), arg);
                return opt;
	}

where parse_signature_option() would look like

	static enum signature_option parse_signature_option(const char *arg)
	{
		if (!arg)
			return S_BARE;
		else if (!strcmp(arg, "signer"))
			return S_SIGNER;
		...
		else
			return -1;
	}

or something like that?

> @@ -1344,6 +1374,69 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
>  	}
>  }
>  
> +static void grab_signature(struct atom_value *val, int deref, struct object *obj)

To be considerate for future developers, perhaps rename this to
grab_commit_signature(), so that they can add grab_tag_signature()
when they lift the limitation of this implementaiton?

> +{
> +	int i;
> +	struct commit *commit = (struct commit *) obj;

Style?  No SP between cast and value?

> +
> +	for (i = 0; i < used_atom_cnt; i++) {
> +		struct used_atom *atom = &used_atom[i];
> +		const char *name = atom->name;
> +		struct atom_value *v = &val[i];
> +		struct signature_check sigc = { 0 };
> +
> +		if (!!deref != (*name == '*'))
> +			continue;
> +		if (deref)
> +			name++;
> +		if (strcmp(name, "signature") &&
> +			strcmp(name, "signature:signer") &&
> +			strcmp(name, "signature:grade") &&
> +			strcmp(name, "signature:key") &&
> +			strcmp(name, "signature:fingerprint") &&
> +			strcmp(name, "signature:primarykeyfingerprint") &&
> +			strcmp(name, "signature:trustlevel"))
> +			continue;

And with the helper above, we can avoid the repetition here that can
go out of sync with the parser function.

> +		check_commit_signature(commit, &sigc);

If a format asks for signature:signer and signature:key, we
shouldn't be running GPG twice.  First check used_atom[] to see if
we even need to do _any_ signature processing (and leave if there is
not), populate the sigc just once and then enter the loop, perhaps?

In adddition, a call to check_commit_signature() should have a
matching call to signature_check_clear(); otherwise all the
resources held by sigc would leak, wouldn't it?
