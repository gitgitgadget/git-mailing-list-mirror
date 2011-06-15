From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 15 Jun 2011 16:53:55 -0700
Message-ID: <7vips6ircc.fsf@alter.siamese.dyndns.org>
References: <20110608093648.GA19038@elte.hu>
 <201106141156.56320.johan@herland.net>
 <20110614171204.GC26764@sigill.intra.peff.net>
 <201106150145.12912.johan@herland.net>
 <20110615230033.GB19803@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 01:54:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWzuN-0000hM-GA
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 01:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab1FOXx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 19:53:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab1FOXx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 19:53:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 08FE4652E;
	Wed, 15 Jun 2011 19:56:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kr+CWtZFXACtsr6sPQHcwwMXbiM=; b=UF92dz
	a6trp9m/fwgh33vnuWe74hhFIsS6MvtmnDeWYpeUM5niM/r/EGcNGnaeTzrHQ08J
	ypBV0PIlc1arRidk517k4wveJCbUTdAW2NU/Dk28AcnMkiN9tRtMpt/71rKLlbtb
	MRiB4OoRLGwKzyTHtBkMG1PAChE90upSEqaAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sdmoz+GfwYseZZhEVgM253B2BQtr/TT9
	K9MozrOiZORY/XYfYx1j32s4eUxh6cvqHdvhHf0g7sxGDXm4Mk+13gNYS/48aoAS
	ei6s8I2PRwtjaCTXI4THpt369wbVGmjEDNAwSNn8Kf9TAkSm4XIkpWJ3yLg1UzFG
	a23BRBRLnkY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 00305652D;
	Wed, 15 Jun 2011 19:56:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 40279652C; Wed, 15 Jun 2011
 19:56:07 -0400 (EDT)
In-Reply-To: <20110615230033.GB19803@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 15 Jun 2011 19:00:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 095721CC-97AB-11E0-90F9-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175872>

Jeff King <peff@github.com> writes:

> Given 1/2/3, you would look for tags in:
>
>   refs/remotes/1/tags/2/3
>   refs/remotes/1/2/tags/3
>
> and then similarly heads in:
>
>   refs/remotes/1/heads/2/3
>   refs/remotes/1/2/heads/3

> And then complain of ambiguity if they both match (which will almost
> _never_ happen, unless you have a totally insane repo setup. So this is
> really just about having well-defined rules just in case, and probably
> won't affect most people in practice. In most cases, it will just DWYM).
>
> The "HEAD" thing remains simple. You check for:
>
>   refs/remotes/1/2/3/HEAD
>
> since HEAD is going to be at the top-level anyway.

Gaah, why is this even a good thing?

Yes, you demonstrated that it is _possible_ to define disambiguation
rules, but do we currently allow (or horrors encourage) hierarchical
remote nicknames, and do people rely on being able to do so?  What
workflows benefit from such a confusing layout?

I am not fundamentally opposed to it, but just trying to tell between "we
do so because we can" and "because we need to for such and such reasons".
