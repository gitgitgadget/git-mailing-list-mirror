From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/16] add: avoid yoda conditions
Date: Thu, 31 Oct 2013 13:31:58 -0700
Message-ID: <xmqqmwlp41xd.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-17-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6i5z8Z9HPzsUWTh8U2HXc9p6MPgQjJ7K6KSDw8FXtFyww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 21:32:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbyub-0006kD-EQ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 21:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab3JaUcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 16:32:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305Ab3JaUcH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 16:32:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DFA04D0B9;
	Thu, 31 Oct 2013 16:32:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C/YoDQ+F846NRWjG/+ffJgTbXh0=; b=x/tTyz
	GCFsaS5zmE1B3gJF7O1v2nmwiUWNrpmZfs3iqPABHjx6j4sPSeoktBaVnQJQd9iz
	APPGVf0I+KHS9wNSPCHim5JS0W3vxsB+HiC679XL57CsIVKZACwiHMp6uHAcVuQZ
	bZKwqMd+uzrEAcLi0k7D+BP7cz/mKFAsu8TSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9s2zj7B/K624m/6hHHu33ltxJjYCk8v
	xuyYRH5ZjLzK9aNkOMpaPB3OQnhgmiIGmiPVItTt+NkFhwtvshyU5Pb7nHU7cgp8
	1cUz4SX0TjnMBH17g3RLQNdfsd8DB7PrLSJ9urUCMHD1s6oixgHcRXU2J8g+fETK
	ykgoaOIDuz8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D7D94D0B7;
	Thu, 31 Oct 2013 16:32:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E8254D0B4;
	Thu, 31 Oct 2013 16:32:00 -0400 (EDT)
In-Reply-To: <CANiSa6i5z8Z9HPzsUWTh8U2HXc9p6MPgQjJ7K6KSDw8FXtFyww@mail.gmail.com>
	(Martin von Zweigbergk's message of "Thu, 31 Oct 2013 12:48:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E96ABAC-426B-11E3-AD28-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237178>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> I was recently confused by the yoda condition in this block of code from [1]
>
> + for (i = 0; i < revs.nr; i++)
> + if (&bases->item->object == &revs.commit[i]->object)
> + break; /* found */
> + if (revs.nr <= i)
>
> I think I was particularly surprised because it came so soon after the
> "i < revs.nr". I didn't bother commenting because it seemed too
> subjective and the code base has tons of these.

That follows "visual/textual order should follow the actual
ordering" principle.  Think of a number-line you learn in elementary
school arithmetic class, and try to place revs.nr and i on it.

I agree that there is no justification to write "if 0 == something",
when "if something == 0" suffices.  The latter reads better and that
is why the phrase "yoda condition" was invented.

But the situation is different when both sides are not constants,
and especially when "<" and "<=" are involved..
