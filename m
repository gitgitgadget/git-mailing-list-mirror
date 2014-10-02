From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Thu, 02 Oct 2014 13:09:37 -0700
Message-ID: <xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<1412256292-4286-6-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 22:09:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZmh6-000495-ST
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 22:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbaJBUJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 16:09:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50208 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaJBUJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 16:09:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B84140A0B;
	Thu,  2 Oct 2014 16:09:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ilF0Pl+Laa4Aq3lQLmKAiQNcEDA=; b=huVsOu
	8xK0aeOCNvuGH54Y9E9Gos+Zn5aIPZiInnkFNBo12kqXK8K7RYQoz8G+x3DLocuH
	GuVSWiBoAovAsOE9eO5gFyVgoe1e1Srji2GkLpOBUb2DbKw4IAi65bYa3pgpMp0V
	qUrVmyXXiBfRT9UoGZeL9xskpj8eueJ9hg4WE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gcNFlmbYsTmG2jrLzAOoGjO/unq72I/A
	Z+JQvDUfI7gdp0auVef8Q2yPLx94QZqig38hgK/U+KanJfEWAIRenZUCUfiDjS1Z
	l2EO0GhKlNFfV/j82WFGyYJmyfP9+T/IBVlQD0NQtaCDveRv4h3IDGXvdUS7Zv5b
	9CnnhCyAOx8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71EE640A0A;
	Thu,  2 Oct 2014 16:09:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EC1B240A08;
	Thu,  2 Oct 2014 16:09:38 -0400 (EDT)
In-Reply-To: <1412256292-4286-6-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 2 Oct 2014 06:24:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09D6175E-4A70-11E4-A07F-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257821>

Tanay Abhra <tanayabh@gmail.com> writes:

> +test_expect_success 'document how unset.variable will behave in shell scripts' '
> +	rm -f .git/config &&
> +	cat >expect <<-\EOF &&
> +	EOF
> +	git config foo.bar boz1 &&
> +	git config --add foo.bar boz2 &&
> +	git config unset.variable foo.bar &&
> +	git config --add foo.bar boz3 &&
> +	test_must_fail git config --get-all foo.bar >actual &&

You make foo.bar a multi-valued one, then you unset it, so I would
imagine that the value given after that, 'boz3', would be the only
value foo.bar has.  Why should --get-all fail?

I am having a hard time imagining how this behaviour can make any
sense.
