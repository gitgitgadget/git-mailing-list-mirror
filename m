From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] config: allow http.<url>.* any user matching
Date: Wed, 24 Jul 2013 08:00:21 -0700
Message-ID: <7vfvv46m0q.fsf@alter.siamese.dyndns.org>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
	<7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79>
	<7vehaqcw66.fsf@alter.siamese.dyndns.org>
	<DF5B20F8-33C2-4F72-A78B-97EE1FB4A522@gmail.com>
	<20130724064258.GA30074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 24 17:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V20YQ-0005Le-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 17:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab3GXPA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 11:00:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853Ab3GXPAY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 11:00:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E5B8323E2;
	Wed, 24 Jul 2013 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1SuAJ2b5sQxxPGxwyKthPhlKye0=; b=rYJYvd
	bk6dseHkHqvFMvCwC2c5dLQDXLxN14qfG/lsQbHrZsCDQ8s2QssBba+8n3xxpY37
	dDmnd2jmHiOI5OnzdCaA0JtLFd9mNTwUCjvysPnN5vyllDsYzlQz9BHIHkgIOzEY
	I/24Ra6FVwoYAsy3FigY0zeaG8THp8iFttrZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=utbib3nGqwwbjXw3s+k86K6GSOgJWKfh
	ruisJ6djzdmWp0leHTsVpLDIxo7SYZ+BI7wzOTsqzXjU6Q2ucKq559a9BVhA330g
	dR7DgREyzWsXwQR1ohHGO1a4cpIff1Jwvw2scAjSC3dIFUgncqk7Xf6sRZ27FAGX
	0yJgrlc/XlE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF9A323E1;
	Wed, 24 Jul 2013 15:00:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ACBB323DE;
	Wed, 24 Jul 2013 15:00:22 +0000 (UTC)
In-Reply-To: <20130724064258.GA30074@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 24 Jul 2013 02:42:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3B75260-F471-11E2-A1AB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231101>

Jeff King <peff@peff.net> writes:

>   1. The explanation and special-casing of username is a little
>      complicated to explain.
>
>   2. The behavior for resolving the value when faced with multiple
>      possibilities is completely unlike the rest of the config system
>      (both dropping last-one-wins, and unlike the URL matching for
>      credentials).
>
> I think we can decide that (2) is worth it if your semantics are more
> flexible in practice. It would be nice to see real-world feedback on how
> people use it before setting the behavior in stone, but there's sort of
> a chicken and egg problem there.
>
> For (1), I wonder if the explanation would be simpler if the precedences
> of each sub-part were simply laid out. That is, would it be correct to
> say something like:
>
>   For a config key to match a URL, each element of the config key (if
>   present) is compared to that of the URL, in the following order:
>
>     1. Protocol (e.g., `https` in `https://example.com/`). This field
>        must match exactly between the config key and the URL.
>
>     2. Host/domain name (e.g., `example.com` in `https://example.com/`).
>        This field must match exactly between the config key and the URL.
>
>     3. Path (e.g., `repo.git` in `https://example.com/repo.git`). This
>        field is prefix-matched by slash-delimited path elements, so that
>        config key `foo/` matches URL `foo/bar`. Longer matches take
>        precedence (so `foo/bar`, if it exists, is a better match than
>        just `foo/`).
>
>     4. Username (e.g., `user` in `https://user@example.com/repo.git`).
>
>   The list above is ordered by decreasing precedence; a URL that matches
>   a config key's path is preferred to one that matches its username.
>
> I don't know if that is more or less clear of an explanation. It makes
> more sense to me, but that is probably because I wrote it. 

The above reads very clearly to me, too.  We may want to add that
the Username, if exists on the configuration key name, must match
exactly to the one in the URL the variable is queried for
(i.e. anonymous requests never match configuration for a specific
user).
