From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/12] ref-filter: bump 'used_atom' and related code to the top
Date: Mon, 01 Feb 2016 14:22:37 -0800
Message-ID: <xmqqvb68t6j6.fsf@gitster.mtv.corp.google.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 23:22:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQMrs-0001tS-Km
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 23:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbcBAWWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 17:22:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753470AbcBAWWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 17:22:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D980B41238;
	Mon,  1 Feb 2016 17:22:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ux791JNyFUb5bQKLacp1Cm2y414=; b=hEmSre
	7fNbqDSl5EyJStnOc9LngSesG0Rw39eczhlyCVJTbZALMM3MGV2ct7oANynKri2w
	S3WQ4WVY2/a1eucoZibvYBFcBiU97ndGOlsPvSOb0tl8drjnsDOZEKu96HbUBGmU
	g2i2qL4OYLJ/C0/trKjv1YhoAfjQ/ukEfcqR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eppEOXz7Ze8fAfEx6ilgzyGTOtehpdUl
	b05RUGudbrrLAeWiTqEWMK7ypuYu/2zSf8+YmYp5SQwrNW/5P3Edtp7aE7heuWKf
	DOdu+mwrGxIfkS0FyQn09tJXRTwLhVV/DqWjJEYOky8u255q1Lbitp3NE61SH3Z5
	N+eceR1CMmY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D19D641237;
	Mon,  1 Feb 2016 17:22:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4F41D41236;
	Mon,  1 Feb 2016 17:22:38 -0500 (EST)
In-Reply-To: <1454262176-6594-4-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 31 Jan 2016 23:12:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4D14CC9E-C932-11E5-9252-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285221>

Karthik Nayak <karthik.188@gmail.com> writes:

> Bump code to the top for usage in further patches.
> ---

Sign-off?

>  ref-filter.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 38f38d4..c3a8372 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -16,6 +16,21 @@
>  
>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>  
> +/*
> + * An atom is a valid field atom listed below, possibly prefixed with
> + * a "*" to denote deref_tag().
> + *
> + * We parse given format string and sort specifiers, and make a list
> + * of properties that we need to extract out of objects.  ref_array_item
> + * structure will hold an array of values extracted that can be
> + * indexed with the "atom number", which is an index into this
> + * array.
> + */
> +static const char **used_atom;
> +static cmp_type *used_atom_type;
> +static int used_atom_cnt, need_tagged, need_symref;
> +static int need_color_reset_at_eol;
> +
>  static struct {
>  	const char *name;
>  	cmp_type cmp_type;
> @@ -92,21 +107,6 @@ struct atom_value {
>  };
>  
>  /*
> - * An atom is a valid field atom listed above, possibly prefixed with
> - * a "*" to denote deref_tag().
> - *
> - * We parse given format string and sort specifiers, and make a list
> - * of properties that we need to extract out of objects.  ref_array_item
> - * structure will hold an array of values extracted that can be
> - * indexed with the "atom number", which is an index into this
> - * array.
> - */
> -static const char **used_atom;
> -static cmp_type *used_atom_type;
> -static int used_atom_cnt, need_tagged, need_symref;
> -static int need_color_reset_at_eol;
> -
> -/*
>   * Used to parse format string and sort specifiers
>   */
>  int parse_ref_filter_atom(const char *atom, const char *ep)
