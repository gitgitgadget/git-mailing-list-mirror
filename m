From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Mon, 26 Nov 2012 09:56:24 -0800
Message-ID: <7vd2z0tfhz.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
 <7vd2z7rj3y.fsf@alter.siamese.dyndns.org> <20121121041735.GE4634@elie.Belkin>
 <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
 <20121121194810.GE16280@sigill.intra.peff.net>
 <CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com>
 <7v7gp9udsl.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1211261726260.7256@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 18:56:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td2vD-0002rS-Nq
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 18:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919Ab2KZR4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 12:56:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755453Ab2KZR40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 12:56:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 419F89DFC;
	Mon, 26 Nov 2012 12:56:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WCK49/Bblnu5RgjdrNPFpeY7ZWU=; b=hr17zg
	RwMI5jR/92+bZl7R+I4EUsl2p/GbvdJQJaZhQB/EJOumOaVX6UUb58COnCa2Oa43
	zL60VfurwkuLArM0OzMHEBpY2cRdx4YoGWR9em9F8aI07FJhOHMOkRs9H2Ukb6Ct
	Cm8qCHpJzxYLvodNPbLOICF4Qn8rIEJl5bNc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MjXAj/I3CZEMwmbGxJ/oGlKXq4ELvd6m
	UAqgWzglZBN5plh1nJWoqqIFKTS1n2b0rp20NrdAR7z5o+yezq+GbGE2c6snkFbv
	+fGrCkt45oi/5pupll/LHZy3ROaDv2xpzcfFwgcvxM30Wu4C1fiIX1UXYFWEcr47
	Gz3p7UXtFGo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C9789DFA;
	Mon, 26 Nov 2012 12:56:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A077B9DF9; Mon, 26 Nov 2012
 12:56:25 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1211261726260.7256@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Mon, 26 Nov 2012 17:28:20 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98A0BB8E-37F2-11E2-8074-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210460>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you changed your stance on the patch Sverre and I sent to fix this, we
> could get a non-partial fix for this.

This is long time ago so I may be misremembering the details, but I
thought the original patch was (ab)using object flags to mark "this
was explicitly asked for, even though some other range operation may
have marked it uninteresting".  Because it predated the introduction
of the rev_cmdline_info mechanism to record what was mentioned on
the command line separately from what objects are uninteresting
(i.e. object flags), it may have been one convenient way to record
this information, but it still looked unnecessarily ugly hack to me,
in that it allocated scarce object flag bits to represent a narrow
special case (iirc, only a freestanding "A" on the command line but
not "A" spelled in "B..A", or something), making it more expensive
to record other kinds of command line information in a way
consistent with the approach chosen (we do not want to waste object
flag bits in order to record "this was right hand side tip of the
symmetric difference range" and such).

If you are calling "do not waste object flags to represent one
special case among endless number of possibilities, as it will make
it impossible to extend it" my stance, that hasn't changed.

We added rev_cmdline_info since then so that we can tell what refs
were given from the command line in what way, and I thought that we
applied a patch from Sverre that uses it instead of the object
flags.  Am I misremembering things?
