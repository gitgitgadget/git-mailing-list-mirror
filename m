Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB383C47254
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC20B207DD
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NGlgGFmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD3UVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:21:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50058 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3UVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 16:21:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B8C4BA8CD;
        Thu, 30 Apr 2020 16:21:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wQshnyUDT6zX
        mCuRZK1oHjtzKWo=; b=NGlgGFmYKYtSIcm5jKiNoz/RtBzTnfiL4sqS03mzqELI
        kCyajfblR2t0y9Aiym+uTBzk/lN0KFWXv8eEEd7tFLROzu6PzOsenENtR+gh0bjC
        3eW3i/FtQuJfym6R1/+TLnyRWJRqpzm0RQ/QESx4IvCL96/XHkXGTQY0mENByq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wHBkBc
        VG+jMUeFPBoSgLxTEcU5J1GaP14d1rtn6xEMaAMK/29srZ+Hdx3BO7exXQE15cJz
        exkSNsXuB2tlftvAwVp3dG1iZatCx6k5LPgqHY4nmcJSJay3ZaiDSmJCy72SDRXq
        0zjuI+c4NFnqhT1iJEIkVR1PQUGqZUyEqdj54=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41C46BA8CC;
        Thu, 30 Apr 2020 16:21:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 809D3BA8C9;
        Thu, 30 Apr 2020 16:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9] credential-store: warn instead of fatal for bogus lines from store
References: <20200430011959.70597-1-carenas@gmail.com>
        <20200430160642.90096-1-carenas@gmail.com>
Date:   Thu, 30 Apr 2020 13:21:06 -0700
In-Reply-To: <20200430160642.90096-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 30 Apr 2020 09:06:42 -0700")
Message-ID: <xmqq1ro4sp1p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 204E4352-8B20-11EA-8A4E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> With the added checks for invalid URLs in credentials, any locally
> modified store files which might have empty lines or even comments
> were reported[1] failing to parse as valid credentials.
>
> Instead of doing a hard check for credentials, do a soft one and
> therefore avoid the reported fatal error.
>
> Warn the user indicating the filename and line number so any invalid
> entries could be corrected but continue parsing until a match is
> found or all valid credentials are processed.
>
> Make sure that the credential that we will use to match is complete by
> confirming it has all fields set as expected by the updated rules.
>
> [1] https://stackoverflow.com/a/61420852/5005936
>
> Reported-by: Dirk <dirk@ed4u.de>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---

Looks good.

> diff --git a/credential-store.c b/credential-store.c
> index c010497cb2..b1f5b2dea6 100644
> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -4,10 +4,20 @@
>  #include "string-list.h"
>  #include "parse-options.h"
> =20
> +#define PARSE_VERBOSE 0x01
> +
>  static struct lock_file credential_lock;
> =20
> +static int valid_credential(struct credential *entry)
> +{
> +	return (entry->username && entry->password &&
> +		entry->protocol && *entry->protocol &&
> +		((entry->host && *entry->host) || entry->path));
> +}

OK.

>  static int parse_credential_file(const char *fn,
>  				  struct credential *c,
> +				  int flags,
>  				  void (*match_cb)(struct credential *),
>  				  void (*other_cb)(struct strbuf *))
>  {
> @@ -15,6 +25,7 @@ static int parse_credential_file(const char *fn,
>  	struct strbuf line =3D STRBUF_INIT;
>  	struct credential entry =3D CREDENTIAL_INIT;
>  	int found_credential =3D 0;
> +	int lineno =3D 0;
> =20
>  	fh =3D fopen(fn, "r");
>  	if (!fh) {
> @@ -23,17 +34,24 @@ static int parse_credential_file(const char *fn,
>  		return found_credential;
>  	}
> =20
> -	while (strbuf_getline_lf(&line, fh) !=3D EOF) {
> -		credential_from_url(&entry, line.buf);
> -		if (entry.username && entry.password &&
> -		    credential_match(c, &entry)) {
> +	while (strbuf_getline(&line, fh) !=3D EOF) {

Hmph, I probably have missed some discussion that happened in the
last few days, but from the use of _lf() in the original, I sense
that it is very much deliberate that the file format is designed to
be LF delimited records, *not* a text file in which each line is
terminated with some end-of-line marker that is platform dependent.
IOW, an explicit use of _lf() shouts, at least to me, that we want a
sequence of LF terminated records even on Windows and Macs.

So, I am not sure why this change is desirable.

> +		lineno++;
> +
> +		if (credential_from_url_gently(&entry, line.buf, 1) ||
> +			!valid_credential(&entry)) {

OK, so we read a line, fed it to the parser, and if we had trouble
parsing or the line did not have enough credential material, we
discard and warn (when told to).

> +			if (flags & PARSE_VERBOSE)
> +				warning(_("%s:%d: ignoring invalid credential"),
> +					fn, lineno);
> +		} else if (credential_match(c, &entry)) {
>  			found_credential =3D 1;
>  			if (match_cb) {
>  				match_cb(&entry);
>  				break;
>  			}
> +			continue;

And if the credential material on a good line matches, we remember
we saw a match.  If there is match callback, we call it and leave
the loop to return from the function.  Otherwise we go to the next
line.
>  		}
> +
> +		if (other_cb)
>  			other_cb(&line);

A malformed/underspecified line and an unmatched line is fed to the
other callback.

>  	}
> =20
> @@ -62,7 +80,7 @@ static void rewrite_credential_file(const char *fn, s=
truct credential *c,
>  		die_errno("unable to get credential storage lock");
>  	if (extra)
>  		print_line(extra);
> -	parse_credential_file(fn, c, NULL, print_line);
> +	parse_credential_file(fn, c, 0, NULL, print_line);

This helper function is called from two places.

 - In store_credential_file, we write the credential we were asked
   to store to a strbuf, and then call this function.  The function
   first writes that new credential and then calls the parse helper
   without PARSE_VERBOSE.  We do not give any match callback, and
   other callback is to just print the line read from the credential
   file.  So, the final output would be the new credential, followed
   by the current contents of the credential file except for the
   records that match the one we are storing.  We do this without
   warning about malformed entries at all.

 - In remove_credential, we go over multiple files and copy the
   lines in each of them, except the ones that match the credential
   we are given.  We also do this without warning about malformed
   entries at all.

>  	if (commit_lock_file(&credential_lock) < 0)
>  		die_errno("unable to write credential store");
>  }
> @@ -139,7 +157,8 @@ static void lookup_credential(const struct string_l=
ist *fns, struct credential *
>  	struct string_list_item *fn;
> =20
>  	for_each_string_list_item(fn, fns)
> -		if (parse_credential_file(fn->string, c, print_entry, NULL))
> +		if (parse_credential_file(fn->string, c, PARSE_VERBOSE,
> +						 print_entry, NULL))
>  			return; /* Found credential */
>  }

This is triggered by the "get" operation.  We read until we hit the
entry we are looking for, at that point the match-callback will
print out "username=3D... / password=3D..." lines and we ignore the
remainder of the file.  While we look for the first matching
credential, we do warn about malformed or underspecified lines that
we are ignoring, but because we leave the loop once a matching line
is found, bad lines that come after it won't be even looked at to be
warned.

Validating and warning about bad entries is *not* the main purpose
of the "credential-store" program, so I fully agree with the design
of the "get" part.  I am not so sure about the other two operations
(i.e. "store" and "erase") that do scan all the entries and has
chance to warn about bad ones, though (note: I am not saying that we
should parse verbosely---it is just that I do not know why you chose
not to and I am not convinced that it is a good idea not to warn).

The tests looked good.

Thanks.

