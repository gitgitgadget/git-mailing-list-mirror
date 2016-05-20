From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Fri, 20 May 2016 09:39:43 -0700
Message-ID: <xmqqbn40fzu8.fsf@gitster.mtv.corp.google.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
	<CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
	<573E30C8.4070600@sapo.pt>
	<CAPig+cRo3tjt9N0YO8sNn90dL3dP0asfmKTr5rerS9YLO6QBtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 20 18:53:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3nVA-00047h-Li
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 18:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbcETQmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 12:42:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755727AbcETQjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 12:39:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 88B44198AF;
	Fri, 20 May 2016 12:39:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OutTvPElgLCO8DjtCHzweEJv3fo=; b=rn53X2
	kAoN7g/9fW3dxVCqap2Yy8wyGQc0q9CUWHOkbPeGyeWGSEOHLI2ovQkwzHCW0HLt
	TbUZqzuFB1kZUZ8zfPGVjgkzqI6WgMjenwlf75YRukW/c3Vvw+SZtdvh0XP/k/HZ
	zkBD2LnftP/DKlWTC/xLKvtMobhtLaPqHvd8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5Q5kfo7xEH+LdJAnseDl4YahxxC7Lrs
	OVTq/MJU99sLxeA7eWRHnRkGqa5LPGqBFkP838ztKWSQQ4An4pyt05vu4ZUs0Gl6
	AV/0tdnr9EyjOG9p7ZIxFZ/4LW7uNhNyw2vS3NWdIe7ZsezG/cd/ohRdc6RYI5g2
	SUCJ6kER8/g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 80093198AC;
	Fri, 20 May 2016 12:39:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE373198AB;
	Fri, 20 May 2016 12:39:44 -0400 (EDT)
In-Reply-To: <CAPig+cRo3tjt9N0YO8sNn90dL3dP0asfmKTr5rerS9YLO6QBtw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 19 May 2016 23:30:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 756ED69A-1EA9-11E6-8EBE-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295184>

Eric Sunshine <sunshine@sunshineco.com> writes:

> [cc:+junio]
>
> Indeed, the sed seems superfluous. The output of the test command is:
>
>     git: 'lfg' is not a git command. See 'git --help'.
>
>     Did you mean this?
>         lgf
>
> And, the grep'd string, "lgf" only appears once, so grep alone should
> be sufficient to verify expected behavior.

We want to see the string appear after "Did you mean this?" and we
do not want to be fooled by a future change in the early part of the
message, which may contain a substring l-g-f that does not have
anything to do with the alias we are looking for.

And the way you express "I do not care anything above this line" is
to say "sed -e '1,/^that line/d'".

Of course, if you use this with POISON, you'd need to consider that
"Did you mean this" would not be a good marker to identify where the
introductory text we want to ignore ends.  You'd need to find a
different mechanism to exclude the introductory text if you want to
retain the future-proofing the existing "sed -e" gave us.

Perhaps discarding up to the first blank line (i.e. assuming that we
would not remove that blank, and also assuming that we will not
rephrase "Did you mean this?") may be a good alternative.

Or assuming that the explanatory text would not begin its lines with
a tab, i.e.

	grep '^	lgf$' actual

(the space between '^' and 'l' above is a TAB) without using
test_i18ngrep?

I think I like that the best among what I can think of offhand.
