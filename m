Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8649C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6FB206F0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xv2XRwoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD2VFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:05:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54219 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgD2VFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 17:05:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 650E2570D3;
        Wed, 29 Apr 2020 17:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wlPzBPMAlZjx
        2zJwcYbaWdJRFAA=; b=Xv2XRwoM6bLzcf5Dgpqc6xzv0gfWLf6mxDPzt+yueeJk
        x0As9YfHU1JcbhCEOGJqBDtuhYMQEitV8Fl49s7Qdo9VhIxaXLaQIOSFW/cqoVGQ
        /Fcu5tB3HkdZbZUnWWykdqO9zeWgTqDlw5/xgAVvXC4OZ2aD2VnsnewJ0PIY9QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PSdAAi
        LExXOKX7+EH5deCUekJUOhQFP6fWvyxhtyX38wNjP9Ijjrzi8xD4C03oAsCeQC0U
        wn+yGahcQgAPNt9F+ulr00+jTq58wqpQzpbd1HU688L17xQkfvVi0la5j06hZz2r
        CsTzk5yAJty+xE4r4IGrsFilz/U2Eb26SWwkM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24C73570D1;
        Wed, 29 Apr 2020 17:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 900E6570CE;
        Wed, 29 Apr 2020 17:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [RFC PATCH v6 1/2] credential-store: warn instead of fatal for bogus lines from store
References: <20200429003303.93583-1-carenas@gmail.com>
        <20200429203546.56753-1-carenas@gmail.com>
        <20200429203546.56753-2-carenas@gmail.com>
Date:   Wed, 29 Apr 2020 14:05:02 -0700
In-Reply-To: <20200429203546.56753-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 29 Apr 2020 13:35:45 -0700")
Message-ID: <xmqqo8rauhoh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 188414F8-8A5D-11EA-A30C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> with the added checks for invalid URLs in credentials, any locally
> modified store files which might have empty lines or even comments
> were reported[1] failing to parse as valid credentials.
>
> instead of doing a hard check for credentials, do a soft one and
> warn the user so any invalid entries could be corrected.

Yeah, this version looks be best so far.  No need to worry about
redacting anything; we are dealing with folks who have edited
the file, and they shouldn't have any trouble going to the line with
a problem given an exact line number.

> diff --git a/Documentation/git-credential-store.txt b/Documentation/git=
-credential-store.txt
> index 76b0798856..30d498fe54 100644
> --- a/Documentation/git-credential-store.txt
> +++ b/Documentation/git-credential-store.txt
> @@ -95,8 +95,16 @@ https://user:pass@example.com
>  ------------------------------
> =20
>  No other kinds of lines (e.g. empty lines or comment lines) are
> -allowed in the file, even though some may be silently ignored. Do
> -not view or edit the file with editors.
> +allowed in the file, even though historically the parser was very
> +lenient and some might had been silently ignored.
> +
> +Do not edit the file with editors as it could compromise the validity
> +of your credentials by sometimes subtle formatting issues (like spaces=
)

I do not think dropping "view or" is warranted.  There is no need to
invite the risk of opening with the intention to only view and then
end up saving a modification.  In other words, do not encourage use
of an *editor* in any way.

> +In cases where those formatting issues are detected during parsing a
> +warning indicating the line found will be printed to stderr so it can
> +be corrected at your earliest convenience, but the remaining valid
> +credentials will be used to try to find a match as described below.

I am often just as guilty, but the above four lines in a single
sentence is hard to read, especially without minimum number of
comma.  With a comma after "during parsing", and another after "to
stderr", might make it more readable, but at that point, it would
become far more readable if we split them into two sentences.

Perhaps

	An unparseable line is ignored, and a warning message points
	out the line number the problematic line appears in (you may
	want to delete them with an editor).

>  	while (strbuf_getline_lf(&line, fh) !=3D EOF) {
> +		lineno++;
> +		if (!credential_from_url_gently(&entry, line.buf, 1)) {
> +			if (entry.username && entry.password &&
> +				credential_match(c, &entry)) {
> +				found_credential =3D 1;
> +				if (match_cb) {
> +					match_cb(&entry);
> +					break;
> +				}
>  			}
>  		}
> +		else
> +			warning(_("ignoring invalid credential in %s:%d"),
> +				fn, lineno);
> +		if (!found_credential && other_cb)
>  			other_cb(&line);
>  	}

The above is harder to follow than necessary.

	while (... !=3D EOF) {
		lineno++;
		if (credential is not well formed) {
			warning(_("ignoring..."));
		} else if (the entry matches) {
			found_credential =3D 1;
			if (match_cb) {
				match_cb(&entry);
				break; /* stop at the first match */
			}
			continue;
		}

                if (other_cb)
			other_cb(&line);
	}

may make the intention a bit clearer, with the loud "continue" inside.

 (1) we give warning for malformed one; and
 (2) we do not let other_cb touch a matching entry.

