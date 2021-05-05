Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D86C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 03:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B7D613CB
	for <git@archiver.kernel.org>; Wed,  5 May 2021 03:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhEEDmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 23:42:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50994 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhEEDmw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 23:42:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C376D11B272;
        Tue,  4 May 2021 23:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cK2d429YMP+I
        wlyTmlSpb2FE7OZUuJyO5aOQuRpb/oE=; b=Y7/D1t3VUN8TEE0PN+S0OKIvtEtR
        R+8c2VNC3NboKxEK7vFjnjcRQpc+YMwK4TvL3m1KHyqIM/9XZzXSDW/DNd4SdXjm
        iIeSquHd1At59XLbVA7O7uxz2zMIrurI5nIx/RHsvJRn9faVDJ9yIA8HfV34wAvr
        3S1Murft0JQcQ28=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC66E11B271;
        Tue,  4 May 2021 23:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F286B11B26B;
        Tue,  4 May 2021 23:41:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/5] mailinfo: warn if CR found in
 base64/quoted-printable email
References: <20210421013404.17383-1-congdanhqx@gmail.com>
        <cover.1620148732.git.congdanhqx@gmail.com>
        <45d2c4ab58c4b0c6f0c7790890bbf75eb373f999.1620148732.git.congdanhqx@gmail.com>
Date:   Wed, 05 May 2021 12:41:51 +0900
In-Reply-To: <45d2c4ab58c4b0c6f0c7790890bbf75eb373f999.1620148732.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 5 May
 2021 00:19:59 +0700")
Message-ID: <xmqqr1il4zk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D5755E2C-AD53-11EB-95E5-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> When an SMTP server receives an 8-bit email message, possibly with only
> LF as line ending, some of those servers decide to change said LF to
> CRLF.

s/an SMTP server receives/SMTP servers receive/
s/those servers/them/

> Some mailing list softwares, when receives an 8-bit email message,
> decide to encoding such message in base64 or quoted-printable.

s/encoding/encode/

So the issue is not about CRLF terminating the lines of base64 or QP
(we should treat CRLF and LF terminated lines when unwrapping base64
or QP the same way).  It is about seeing CRLF in the payload after
unwrapping base64 or QP.  It was unclear which one was at issue from
the subject alone.

> If an email is transfered through above mail servers, then distributed
> by such mailing list softwares, the recipients will receive an email
> contains a patch mungled with CRLF encoded inside another encoding.
> Thus, such CR couldn't be dropped by mailsplit. Hence, the mailed patch
> couldn't be applied cleanly. Such accidents have been observed in the w=
ild [1].
>
> Let's give our users some warnings if such CR is found.

Hmph.  It is unclear which one of the following we want our endgame
to be:

 (1) strip silently and apply
 (2) warn but strip and apply
 (3) warn but do not strip, letting the application fail

but let's keep reading.  I suspect (1) and (2) might be error prone,
as the mailpath that may have caused this kind of breakage may not
be under end-user's control.

> +static void summarize_quoted_cr(struct mailinfo *mi, int have_quoted_c=
r)
> +{
> +	if (have_quoted_cr)
> +		warning("quoted CR detected");
> +}

At this step, it is unclear if it is easier to read to make it the
responsibility of the caller to check for have_quoted_cr, but it
will become clear as we add more condition for the warning in later
steps to let callers unconditionally call this helper and decide
when we want to be silent inside this function.

Have you considered adding a new have_quoted_cr member to "struct
mailinfo"?  After all, the mailinfo struct is not only about end
user preference but contains all information we gleaned out of the
incoming message.

>  static void handle_body(struct mailinfo *mi, struct strbuf *line)
>  {
>  	struct strbuf prev =3D STRBUF_INIT;
> +	int have_quoted_cr =3D 0;
> =20
>  	/* Skip up to the first boundary */
>  	if (*(mi->content_top)) {
> @@ -1051,6 +1063,8 @@ static void handle_body(struct mailinfo *mi, stru=
ct strbuf *line)
>  				handle_filter(mi, &prev);
>  				strbuf_reset(&prev);
>  			}
> +			summarize_quoted_cr(mi, have_quoted_cr);
> +			have_quoted_cr =3D 0;
>  			if (!handle_boundary(mi, line))
>  				goto handle_body_out;
>  		}
> @@ -1081,7 +1095,7 @@ static void handle_body(struct mailinfo *mi, stru=
ct strbuf *line)
>  						strbuf_addbuf(&prev, sb);
>  						break;
>  					}
> -				handle_filter_flowed(mi, sb, &prev);
> +				handle_filter_flowed(mi, sb, &prev, &have_quoted_cr);
>  			}
>  			/*
>  			 * The partial chunk is saved in "prev" and will be
> @@ -1091,7 +1105,7 @@ static void handle_body(struct mailinfo *mi, stru=
ct strbuf *line)
>  			break;
>  		}
>  		default:
> -			handle_filter_flowed(mi, line, &prev);
> +			handle_filter_flowed(mi, line, &prev, &have_quoted_cr);
>  		}
> =20
>  		if (mi->input_error)
> @@ -1100,6 +1114,7 @@ static void handle_body(struct mailinfo *mi, stru=
ct strbuf *line)
> =20
>  	if (prev.len)
>  		handle_filter(mi, &prev);
> +	summarize_quoted_cr(mi, have_quoted_cr);
> =20
>  	flush_inbody_header_accum(mi);
> =20
> diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
> index 147e616533..d8fdda6bea 100755
> --- a/t/t5100-mailinfo.sh
> +++ b/t/t5100-mailinfo.sh
> @@ -228,4 +228,19 @@ test_expect_success 'mailinfo handles unusual head=
er whitespace' '
>  	test_cmp expect actual
>  '
> =20
> +check_quoted_cr_mail() {

SP on both sides of (), i.e.

	check_quoted_cr_mail () {

> +	git mailinfo -u "$@" quoted-cr-msg quoted-cr-patch \
> +		<"$DATA/quoted-cr.mbox" >quoted-cr-info 2>quoted-cr-err &&
> +	test_cmp "expect-cr-msg" quoted-cr-msg &&
> +	test_cmp "expect-cr-patch" quoted-cr-patch &&
> +	test_cmp "$DATA/quoted-cr-info" quoted-cr-info
> +}
> +
> +test_expect_success 'mailinfo warn CR in base64 encoded email' '
> +	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-msg" >expect-cr-msg &&
> +	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-patch" >expect-cr-patch =
&&
> +	check_quoted_cr_mail &&
> +	grep "quoted CR detected" quoted-cr-err
> +'
> +
>  test_done
