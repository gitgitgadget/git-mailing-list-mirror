From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Fri, 30 Oct 2015 12:37:37 -0700
Message-ID: <xmqq4mh8kv0e.fsf@gitster.mtv.corp.google.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	<xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
	<20151030193151.GB5336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:37:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFUe-0006xu-AK
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759256AbbJ3Thk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:37:40 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752495AbbJ3Thj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:37:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD4E0266B2;
	Fri, 30 Oct 2015 15:37:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w0lzwtCJ1WYObOL8AHe2nUj8fsc=; b=fUw9Ad
	0+ReceojrnMF1tHzMJH+gm5/9PJixYQ9mnAIqBoSqlJ6ODY5fHy+DyNH7l0LwstX
	VoGa0LiFfRwZAbgSvA4zdhoF/fEduh2LjJCRwzhhKrT3D2LMauwxrAXVIFU2SBVc
	fNxQSu4Cv3DBnionqkGuxfWan7pHWI2Ah3Ldc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WTKO1mL99Uo3KHl3bbyt4yIwVN33Lrg1
	6j5L1OK7fl2H28DoBlJhQrMSuAVJNz4OyocfWS3zMUsYF7x92lT0eegz0CqoNuNO
	Si2S0yE/4Z8u7i0ruRmVh1LvX1Kc0uJ3vsKpZvB+yrUDv/M8sI90RQlMaMK5Al74
	eN4TrfAI/rI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D4799266B1;
	Fri, 30 Oct 2015 15:37:38 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5A35A266B0;
	Fri, 30 Oct 2015 15:37:38 -0400 (EDT)
In-Reply-To: <20151030193151.GB5336@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 Oct 2015 15:31:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD6A2E7A-7F3D-11E5-BF81-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280534>

Jeff King <peff@peff.net> writes:

> I sometimes find it confusing when there are two variables with very
> similar meanings (option_progress and show_progress here). I wonder if
> we could use one variable, like:
>
>   static int show_progress = -1;
>   ...
>   OPT_BOOL(0, "progress", &show_progress, ...);
>   ...
>   parse_options(...);
>   if (show_progress < 0) {
> 	if (opts.quiet)
> 		show_progress = 0;
> 	else
> 		show_progress = isatty(2);
>   }
>
> That somehow is much clearer to me, especially around the behavior of
> "-q --progress". Mine does the opposite of what you wrote above, but I
> think it makes more sense.
>
> I can live with it either way, though. :)

Actually, using a single variable is my preference.  In this case I
wanted to illustrate that the value parsed by parse_options() does
not have to be the one that is used in the final location deep in
the callchain for educational purposes, and I found it clearer to
use two separate variables in the illustration.
