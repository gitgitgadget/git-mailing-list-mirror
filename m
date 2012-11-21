From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 08/15] remote-testgit: cleanup tests
Date: Wed, 21 Nov 2012 10:28:23 -0800
Message-ID: <7vzk2a22g8.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-9-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFlG-0004bT-Ko
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783Ab2KUTOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:14:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779Ab2KUTOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:14:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E2E89659;
	Wed, 21 Nov 2012 14:14:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=b35lbn97Eej/2XEfPTv+inh650o=; b=Fq0VTlTUUtkveuU5o5XA
	A1kOc+qkMCyOSoHvmYE+OlIpL1iPSoCGrSurCo5KJGZbbM37fM2YaNZs0PuBH0dC
	98QLLNbKGk6drAwPjZcbZCuQGBQXVTWFWkQC0oWrV+1cvvSIcjTr/0/jTLzRnzo5
	HySB+nHSYT6PYulTr4+dXvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gM3+8g+7Ga7Ejh5nVHk8/zdmz6WEpJ+B7s7zJZEmDXi61g
	ihgjbqQ8YsVjp5r8ivYbcVJrr2k0lEqraPGeYFkDmV7MkEN2f07+CaRGGwUIui9P
	MO82ejZMnKv1G1T+HSgap6bZA05cEoRnjqHT0xYxy1rQzSOuJdLhMjx6Kt0kI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AEB49658;
	Wed, 21 Nov 2012 14:14:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 604969655; Wed, 21 Nov 2012
 14:14:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE14B042-340F-11E2-9E48-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210159>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We don't need a bare 'server' and an intermediary 'public'. The repos
> can talk to each other directly; that's what we want to exercise.

The previous patch to remove the test (the one that covered a case
where a bug was fixed in an older git-remote-testpy and tried to
catch the bug when it resurfaced) made sense even with its
ultra-short justification "irrelevant".

But I am not sure if this one is so cut-and-dried.  The repos can
talk to each other directly, but at the same time the tests were
exercising interactions between bare and non-bare repositories,
weren't they?  Talking to each other may be one of the things we
want to exercise, but that does not necessarily be the only thing.

If it were explained like this (note that I am *guessing* what you
meant to achieve by this patch, which may be wrong, in which case
the log message needs further clarification):

	Going through an intermediary 'public' may have exercised
	interactions among combinations of bare and non-bare
	repositories a bit more, but that is not an issue specific
	to the remote-helper transfer that we want to be testing in
	this script.  Simplify the tests to let two repositories
	talk directly with each other.

I think the changes themselves make sense.
