From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Mon, 29 Jul 2013 08:48:10 -0700
Message-ID: <7vli4p1i6d.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
	<20130726212438.GA1388@sigill.intra.peff.net>
	<20130726213705.GJ14690@google.com>
	<20130726214036.GB1388@sigill.intra.peff.net>
	<20130726224359.GA3928@sigill.intra.peff.net>
	<20130726230527.GA12968@sigill.intra.peff.net>
	<20130726230857.GK14690@google.com>
	<20130726231902.GA1674@sigill.intra.peff.net>
	<20130726233928.GD12968@sigill.intra.peff.net>
	<7vtxjd1jje.fsf@alter.siamese.dyndns.org>
	<20130729152345.GA10393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 29 17:48:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3pgL-0004zd-4U
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 17:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847Ab3G2PsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 11:48:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756835Ab3G2PsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 11:48:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2887A340C5;
	Mon, 29 Jul 2013 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fBLOhmt/K3nD+ysfREIMIYpQrGU=; b=ZDqe0N
	wKnR2vLTVkZd3ex1oOVkYY1Oq0kbitIAkVxZbsb7aq3IYKJT4O/CP2wwGcT2kzEA
	3TQ+BECNtylK8ooI0uwOmz/vhblGn4VclUkpSFIWX+lmZVLdsNXrzG4uCrpJbyhP
	F8Us30+tgwKtmcuGqY128XQmH6+atKVGRqmrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F2HkefjRLct/k4dV+skCZfkGn+OFVRtL
	ddzWXWIDC6ODhICC/tD81nd2+4wPJFx9LDIteN32wG2owCDG8cWY+imnuWUUYezB
	bsBESQkvk4sWA/LHuuJDXYdO94Xp82aIFNwE0jQuGQNw+Vx2W7KYmqF8YKWhtjCx
	eIJ8vmHfKps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 064EF340C3;
	Mon, 29 Jul 2013 15:48:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7EB4340C1;
	Mon, 29 Jul 2013 15:48:11 +0000 (UTC)
In-Reply-To: <20130729152345.GA10393@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 29 Jul 2013 08:23:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45F96FF4-F866-11E2-87A4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231294>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 29, 2013 at 08:18:45AM -0700, Junio C Hamano wrote:
>
>> >  	if (file_exists(git_path("MERGE_HEAD")))
>> >  		whence = FROM_MERGE;
>> > -	else if (file_exists(git_path("CHERRY_PICK_HEAD")))
>> > +	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
>> >  		whence = FROM_CHERRY_PICK;
>> > +		if (file_exists(git_path("sequencer")))
>> > +			sequencer_in_use = 1;
>> 
>> Should this be
>> 
>> 	sequencer_in_use = file_exists(...)
>> 
>> so readers do not have to wonder what the variable is initialized
>> to?
>
> Yeah, I think that is a readability improvement. I suppose the use-site
> could also just run "file_exists" itself, but I wanted to keep the
> filesystem-reading "magic name" bits together.

I take that one back.  The use-site is sufficiently far from this
assignment that is protected with a cascading if that the reader
needs to be aware that sequencer_in_use is initialized to zero
anyway.  The code you posted is just as readable, if not more.

> I had also originally considered adding new states to "whence" to cover
> these cases (i.e., FROM_CHERRY_PICK_MULTI), but there are fallouts all
> over the place for call sites that do not care whether we are in the
> single- or multi-commit mode.

;-)
