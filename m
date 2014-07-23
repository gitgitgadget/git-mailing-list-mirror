From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.c: change the function signature of `git_config_string()`
Date: Wed, 23 Jul 2014 10:25:51 -0700
Message-ID: <xmqqr41cdm1s.fsf@gitster.dls.corp.google.com>
References: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>
	<20140722110720.GA386@peff.net>
	<xmqqk375gx1n.fsf@gitster.dls.corp.google.com>
	<vpqegxccvq9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Tanay Abhra <tanayabh@gmail.com>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:26:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA0Iu-00084B-M7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbaGWR0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:26:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56762 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756793AbaGWR0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:26:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B94828D28;
	Wed, 23 Jul 2014 13:26:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I+aiGpVZw2x/SFqp+04Px8lFfZE=; b=A6wJ7t
	ABP1AUocTDxymlF42TB+0TOKrnppUiPMnXhLfbEEdMuMxsuu187vHkrTiCIUG/Pu
	EP643dojwUOrOlXJ3eLPKumTowuSno0N7J2kXbvaTV4RipL+Y5Kq5bc9UwEz12oJ
	nb+i1+RDpr8XFVibMcG65nLQaKXfZyiOstbPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rm9yUstjo0dQrnJHW5FU6DP7eY6MhF6B
	G+pV4h9gu7WMyhy/biLBoTwfUjpEtWDvL9wsyouKTf1eosbSme+yOgb+TLHWGU1E
	XAZMQbckcDmtPdWRdaNLGwlrYV5oPls/ODTZKftRspCirocvSYFwWMMimumCFMJD
	uCxI4zmiyrg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FE1B28D27;
	Wed, 23 Jul 2014 13:26:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5543728D0F;
	Wed, 23 Jul 2014 13:25:53 -0400 (EDT)
In-Reply-To: <vpqegxccvq9.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	23 Jul 2014 10:42:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65FBBEF4-128E-11E4-9354-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254095>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> *1* We have safe_create_leading_directories_const() that works
>> around this for input parameter around its _const less counterpart,
>> which is ugly but livable solution.
>
> I think it would actually be a reasonable solution to avoid casting here
> and there on the caller side.

"Ugly" primarily refers to the fact that we are forced to do this in
the first place by the language.  I agree with you, especially if we
have very many call sites, and I suspect config-get-string actually
would.

> Another option would be to _return_ a non-const char * instead of
> outputing it as a by-address parameter.

Here, too, I agree that it is the most C-ish interface.
