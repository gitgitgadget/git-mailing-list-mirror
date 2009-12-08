From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Mon, 07 Dec 2009 19:28:21 -0800
Message-ID: <7vtyw2p2ju.fsf@alter.siamese.dyndns.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr>
 <7vws12r5v2.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
 <20091205062708.6117@nanako3.lavabit.com>
 <7vd42t6f9i.fsf@alter.siamese.dyndns.org>
 <20091208121314.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 04:28:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHqkn-0002Yg-Lj
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 04:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935821AbZLHD2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 22:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935819AbZLHD2b
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 22:28:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935817AbZLHD2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 22:28:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4344B86CF7;
	Mon,  7 Dec 2009 22:28:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HcgKj9xXj1nJemdR/eWR/SdTh2w=; b=XtFR37
	uDa00MeG0/gWf13HXMB6OfVaFPDeGOhTtaLMHTHHx5CoPW3qsYu59HIWhnn3q23R
	NInMxWqm6erlDNATPGm/AG84QxTt3DwMDRvSWwQjcyw1eVldvdRLWP6W/7AwvxHx
	j8mn3KQl6xbpgTauwFDSVVuYlRYSBqFOZebpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iPggq8hoIPDFmFMzA35h3Sl7GdnqJXlp
	zpiCH8uTozr/WseGgfZeLrIovfLW1x5MN1zOEZKK3np4unrr02RNKOtz1tILwkYc
	TaAR+nAy9sLnOR5lKPt9w0lgvZrmzl0yG82Nkczimf3RhgTtEOR02QLJ6likKl1g
	dOlV/rCRFoQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD76986CF3;
	Mon,  7 Dec 2009 22:28:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D10186CF2; Mon,  7 Dec
 2009 22:28:23 -0500 (EST)
In-Reply-To: <20091208121314.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Tue\, 08 Dec 2009 12\:13\:14 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C1CC8E02-E3A9-11DE-900E-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134812>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Teach a new option, --autosquash, to the interactive rebase.
> When the commit log message begins with "!fixup ...", and there
> is a commit whose title begins with the same ..., automatically
> modify the todo list of rebase -i so that the commit marked for
> squashing come right after the commit to be modified, and change
> the action of the moved commit from pick to squash.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>

Hmph, did you forget to retitle the message, or keep in-body "Subject:"?
