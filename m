From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Fri, 27 Nov 2009 21:52:16 -0800
Message-ID: <7vhbsfi4bz.fsf@alter.siamese.dyndns.org>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 06:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEGEc-0000e8-7U
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 06:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbZK1FwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 00:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbZK1FwV
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 00:52:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbZK1FwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 00:52:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B710A256D;
	Sat, 28 Nov 2009 00:52:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LrwEnc47NkbOLDYCEP72VIIMrio=; b=nRoQIh
	3LEh3hG4oIS0mIBkxeYFmp6DBeE4zdz3XByD2w3yaolFB/RY/801IyrYBcsXs7oi
	ANHcqiq74sppYJAHN/WcydfMBUVj2pYil+S14f9ypUaUZwGu3Jq+LLVjiDcS9zJA
	pPqW1N3QEEuhq0/xLvaUyvijxBvTtXOwzo7s4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PfdBiQPjPTTihmnCxUNjnSlYt16g6Nuh
	BtpZoMtZYSQXgAhyf19TcBBLwyOO+dSwS8GoBpqg/S0WTUaTmWIUreo9pzpzVu4x
	Sl/nYv2HcMqgta3rvIMRxWr1pbYAy9L3Ja5TumWcM3DyEcLMSbUg9/yADk6tx0zS
	uHUQPdSIc44=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B7F6A256C;
	Sat, 28 Nov 2009 00:52:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC81BA256B; Sat, 28 Nov 2009
 00:52:18 -0500 (EST)
In-Reply-To: <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Fri\, 27 Nov 2009 07\:55\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32E5BEDA-DBE2-11DE-B5A1-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133946>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>  diff.c                   |   64 +++++++++++++++++++++++++++++++++++++++++++--
> ...
> @@ -344,6 +347,63 @@ static void emit_add_line(const char *reset,
>  	}
>  }
>  
> +static void emit_hunk_line(struct emit_callback *ecbdata,
> +			   const char *line, int len)
> +{
> +	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
> +	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
> +	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
> +	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
> +	const char *orig_line = line;
> +	int orig_len = len;
> +	const char *frag_start;
> +	int frag_len;
> +	const char *part_end = NULL;
> +	int part_len = 0;
> +
> +	/* determine length of @ */
> +	while (part_len < len && line[part_len] == '@')
> +		part_len++;
> +
> +	/* find end of frag, (Ie. find second @@) */
> +	part_end = memmem(line + part_len, len - part_len,
> +			  line, part_len);

This is not incorrect per-se, but probably is overkill; this codepath only
deals with two-way diff and we know we are looking at "@@ -..., +... @@"
at this point.

	part_end = memmem(line + 2, len - 2, "@@", 2);

would be sufficient.

> +	if (!part_end)
> +		return emit_line(ecbdata->file, frag, reset, line, len);
> +	/* calculate total length of frag */
> +	part_len = (part_end + part_len) - line;
> +
> +	/* remember frag part, we emit only if we find a space separator */
> +	frag_start = line;
> +	frag_len = part_len;
> +
> +	/* consume hunk header */
> +	len -= part_len;
> +	line += part_len;
> +
> +	/*
> +	 * for empty reminder or empty space sequence (exclusive any newlines
> +	 * or carriage returns) emit complete original line as FRAGINFO
> +	 */
> +	if (!len || !(part_len = strspn(line, " \t")))

Slightly worrisome is what guarantees this strspn() won't step outside
len.

I would probably write the function like this instead.

-- >8 --

static void emit_hunk_header(struct emit_callback *ecbdata,
			     const char *line, int len)
{
	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
	const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
	const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
	static const char atat[2] = { '@', '@' };
	const char *cp, *ep;

	/*
	 * As a hunk header must begin with "@@ -<old>, +<new> @@",
	 * it always is at least 10 bytes long.
	 */
	if (len < 10 ||
	    memcmp(line, atat, 2) ||
	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
		emit_line(ecbdata->file, plain, reset, line, len);
		return;
	}
	ep += 2; /* skip over the second @@ */

	/* The hunk header in fraginfo color */
	emit_line(ecbdata->file, frag, reset, line, ep - line);

	/* blank before the func header */
	for (cp = ep; ep - line < len; ep++)
		if (*ep != ' ' && *ep != 't')
			break;
	if (ep != cp)
		emit_line(ecbdata->file, plain, reset, cp, ep - cp);

	if (ep < line + len)
		emit_line(ecbdata->file, func, reset, ep, line + len - ep);
}
