From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] fetch: refactor ref update status formatting code
Date: Fri, 03 Jun 2016 09:48:26 -0700
Message-ID: <xmqqr3cep6at.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160603110843.15434-1-pclouds@gmail.com>
	<20160603110843.15434-3-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:51:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sGy-0002pS-EN
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 18:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbcFCQsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 12:48:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752939AbcFCQsa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 12:48:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D7B7B1E2DE;
	Fri,  3 Jun 2016 12:48:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sPRCC/aDwlHl
	f3u1fgHapmubUvc=; b=HU/05res+a31T2ZCEDKxeVqON8DPV/h8A1lnyiQzvcV9
	CTLt0RyHxGG7U1qOqgv5Vm1eklfMp+/mKk2B2gBY0pmhuW8DleE1Lnk/BMoXa/eR
	78CWlQy3d/q5cwiIvAl9Nl0XrfNQF6jKASrKXqgRU8PD9YsqbJxL34G6tC5yHqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QTEFk1
	2uAG+OlWpqeYjMNxEUlDDM9YrFWOX7JB4YxoWg1Arg8SiBvC1QZmcoT4qyGR/wM8
	jXfdwdvVwAvcDCCh5KsXHe6jHI4IAT6UdnYdvWlXKedvnI+riu2MC1mqVHXSj3B6
	4UdC9d2pBOvVbjglz5PCPJM3hhgQbdwtoqhF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CED641E2DD;
	Fri,  3 Jun 2016 12:48:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A78D1E2DC;
	Fri,  3 Jun 2016 12:48:28 -0400 (EDT)
In-Reply-To: <20160603110843.15434-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Fri, 3 Jun 2016 18:08:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FF2F0074-29AA-11E6-8B2D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296344>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This makes it easier to change the formatting later. And it makes sur=
e
> translators cannot mess up format specifiers and break Git.
> ...
> +static void format_display(struct strbuf *display, char code,
> +			   const char *summary, const char *error,
> +			   const char *remote, const char *local)
> +{
> +	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
> +	strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
> +	if (error)
> +		strbuf_addf(display, "  (%s)", error);
> +}
> +

Nice reduction of the code repetition below.  Looks very sensible.
