From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Sat, 31 Oct 2015 10:37:50 -0700
Message-ID: <xmqqk2q3hrbl.fsf@gitster.mtv.corp.google.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	<xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
	<20151030193151.GB5336@sigill.intra.peff.net>
	<xmqq4mh8kv0e.fsf@gitster.mtv.corp.google.com>
	<CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
	<CAOc6etYCzBYpf+7p8p3=zQun7bYXYVc-codoUf5Abcq+hAz8cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:37:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa6H-0004Xe-EF
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbbJaRhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:37:53 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753716AbbJaRhw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:37:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE42D2594B;
	Sat, 31 Oct 2015 13:37:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gPYASisGozS/jmJ90QJvHVbgN4s=; b=GABXQh
	PQazjwaodQdEhGMQGI1PuzOGJo20w3kVXFUcKpbkPEvPNIW9Jx/hT4mb5v5hEBaD
	PyaIGnjC6LI3mM2sS23sV4Cpc/oYsqTwIDIsubHwRx9AJ2UBTVqi1ZXIwgNWB293
	MIY60GHPY2DjklZwnj6FRDTXemdBS9xGaHQr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H+BN211WATe0XJr5HfzpbzLQxDSN29Em
	wdxkDeJWZGndyqLxp+roNwLW0HtHEYw7bCw2KWA9q4VKLBwtoZuZAFEOyLtYAoRZ
	xBXHBVRra95sYg0Qhj1NAw8tS7B8H94AjtoPPkRi0+mfrb7AuI4xtvzZ6Ona9syz
	SrYtRqbWdpg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5CCD2594A;
	Sat, 31 Oct 2015 13:37:51 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 57BB425948;
	Sat, 31 Oct 2015 13:37:51 -0400 (EDT)
In-Reply-To: <CAOc6etYCzBYpf+7p8p3=zQun7bYXYVc-codoUf5Abcq+hAz8cA@mail.gmail.com>
	(Edmundo Carmona Antoranz's message of "Fri, 30 Oct 2015 20:11:21
	-0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C0973DC-7FF6-11E5-9FB6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280592>

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> +       /*
> +        * Final processing of show_progress
> +        * Any of these 3 conditions will make progress output be skipped:
> +        * - selected --quiet
> +        * - selected --no-progress
> +        * - didn't select --progress and not working on a terminal
> +        */
> +       opts.show_progress = !opts.quiet && opts.show_progress &&
> +                            (opts.show_progress >= 0 || isatty(2));
> +

I do find what Peff showed us a lot easier to follow.

	if (opts.show_progress < 0) {
		if (opts.quiet)
			opts.show_progress = 0;
		else
			opts.show_progress = isatty(2);
	}
