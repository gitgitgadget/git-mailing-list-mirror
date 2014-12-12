From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] strbuf: migrate api-strbuf.txt documentation to strbuf.h
Date: Fri, 12 Dec 2014 14:16:32 -0800
Message-ID: <xmqqoar8ecov.fsf@gitster.dls.corp.google.com>
References: <20141212212726.GA26284@peff.net>
	<20141212212800.GA27451@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:16:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzYVs-00087E-Kz
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 23:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbaLLWQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 17:16:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752913AbaLLWQf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 17:16:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33CB024D21;
	Fri, 12 Dec 2014 17:16:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o7wSc/4rjuMbpH1J3hjdNaLe504=; b=WTQlM8
	X6+hht9JdnUj/0y7dAMaTsoRoz5wayKyAzdboKqnzIlUtF2dYU3NZTuQZL96/22g
	5Aji60cbitmX0yr4VObXKxJ1pYsfCImt6WIH2DmJdgUyq1RP5DJuuRMRNfsmLLDt
	ZKWXtTZYSuRR+c0DIBVlEo0o+dJYXJ5gasqBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=capNtdzLGkSLCr4I+htJEsoF263o2fCv
	HhJ5Ly6r2mVgKlAn8mZl77NoLf4FnrRU1CbSXuN7AmzE6Gn+lupI6giv7YOwRz/t
	dk1DZd2k5TH3JWakB+Pdeq84BRispE1SHJ5Y0kGho89N2blpTRZPUwfxlrPzypAe
	489Rp+0UI3g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2853824D20;
	Fri, 12 Dec 2014 17:16:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE18524D1F;
	Fri, 12 Dec 2014 17:16:33 -0500 (EST)
In-Reply-To: <20141212212800.GA27451@peff.net> (Jeff King's message of "Fri,
	12 Dec 2014 16:28:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 880A8F9C-824C-11E4-B368-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261383>

Jeff King <peff@peff.net> writes:

> +/**
> + * * Related to the contents of the buffer
> + */
> +
> +/**
> + * Strip whitespace from the beginning and end of a string.
> + * Equivalent to performing `strbuf_rtrim()` followed by `strbuf_ltrim()`.
> + */
>  extern void strbuf_trim(struct strbuf *);
> +
> +/**
> + * Strip whitespace from the end of a string.
> + */
>  extern void strbuf_rtrim(struct strbuf *);
> +
> +/**
> + * Strip whitespace from the beginning of a string.
> + */
>  extern void strbuf_ltrim(struct strbuf *);

This part reminds me why I often find the current "out of header"
documentation when writing code _without_ the need for _learning_
the API.  The corresponding part in the original is merely these:

    /*----- content related -----*/
    extern void strbuf_trim(struct strbuf *);
    extern void strbuf_rtrim(struct strbuf *);
    extern void strbuf_ltrim(struct strbuf *);
    extern int strbuf_reencode(struct strbuf *sb, const char *from, const char *to);
    ...

It is a lot quicker, scanning this with eyeball, to notice that
there are three related "trim" functions and how they are spelled.
If I wanted to "trim from both ends", knew there were some ways to
"trim" but didn't remember if we had r/ltrim without trim, and/or
was not sure if the "both" version was was _trim or _btrim, scanning
a bland list tends to be much more pleasant.

When you are _learning_ the API, the format that spreads each
individual function into its own section with explanation would be
easier to read through.

Not a strong objection to the overall direction, but I think that we
need to be aware that we are making things harder for some use
cases.
