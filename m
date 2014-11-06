From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] imap-send: Use parse options API to determine verbosity
Date: Wed, 05 Nov 2014 16:01:11 -0800
Message-ID: <xmqqbnoli4e0.fsf@gitster.dls.corp.google.com>
References: <545AAA60.3040207@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Thu Nov 06 01:01:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmAVx-00040e-7L
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 01:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbaKFABQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 19:01:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbaKFABQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 19:01:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D10371BCF3;
	Wed,  5 Nov 2014 19:01:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t8SVfOaqK7O1oK+5QO+LYLip7pA=; b=Lvuoe5
	cCJxvGTtIi2Ik2LyM6FIaD9ADZN/QJzr3emxFgHSqN2NhRrdX3FcG1PT3stSOBBA
	MFaCiLEezC9EEl2YzZ5w5F6Vl64oa7qQO2phXKJCXZTqa5wTjPYy4IzHvZCU0sNF
	o53luZ2aRgtrJaNlJ6tQuhVmZVu4gBznyz42Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1p/qL/7mo2Jm2YcdSkoShjW9yjB5P3o
	+3PZB+9oKBTBfN5FE8SCkPmEvpQGY4aqwE8iQXsLxrv11ztv4QON7RI0+g7fuWN/
	9HZopUCGltAAFjHkKpesDXPEFpl/99fbAR9lwDwNm0Ua2Df2dOJ/n20p3ilyQhdI
	sLmqV+Cjqv8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C844A1BCF2;
	Wed,  5 Nov 2014 19:01:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D3591BCF1;
	Wed,  5 Nov 2014 19:01:13 -0500 (EST)
In-Reply-To: <545AAA60.3040207@raz.or.at> (Bernhard Reiter's message of "Wed,
	05 Nov 2014 23:53:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 057AF5B0-6548-11E4-916A-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bernhard Reiter <ockham@raz.or.at> writes:

> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
> ---
> In reply to <xmqqk339ibal.fsf@gitster.dls.corp.google.com>.
>
> Thanks for bearing with me. I should've given the corresponding verbosity
> values more thought myself in the first place.

The original defined and even used these two variables, but as far
as I can tell they were always set to 0 and nobody modified them.
Hence, we would be OK as long as the end result will behave the same
as before without any -v/-q from the command line ;-)

Thanks.  This version looks more sensible.

> -	if (argc != 1)
> -		usage(imap_send_usage);
> -
>  	setup_git_directory_gently(&nongit_ok);
>  	git_imap_config();
>  
> +	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
> +

... except we might want to check argc here and say something about
missing or excess parameters, which was lost in the change in this
hunk.  I think (without giving it a real thought, though ;-) you
would expect that nothing remains on the command line after
parse_options() has done its thing, no?


>  	if (!server.port)
>  		server.port = server.use_ssl ? 993 : 143;
