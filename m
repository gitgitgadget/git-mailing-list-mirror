From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 23:33:26 -0700
Message-ID: <7vy6p8pfm1.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home>
 <alpine.LFD.2.00.0908232320410.6044@xanadu.home>
 <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908240144530.28290@iabervon.org>
 <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk>
 <alpine.LFD.2.00.0908242001250.6044@xanadu.home>
 <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org>
 <20090825061248.GG1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 08:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfpcE-0002wR-LO
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 08:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbZHYGdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 02:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbZHYGdq
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 02:33:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbZHYGdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 02:33:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D21F81871D;
	Tue, 25 Aug 2009 02:33:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ucR2ucpUykmlcgsbWcCC/MmVDnU=; b=EngoRC
	1uA/eJWyqcJxyCxIG2jyaxkJUI2dH2knhzeWwuzQe9L2vC+eIW8IYuOWiupwtxOS
	qZnMbJTqn1cUD8oYyDDbSexLinLMyJlEnJ+xGuL0kM6WG8ON4nvNjv1Vj2XmiiYT
	qGmxi0OhpJopW8cCinXEumWE2kP6plQYIh5lM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MpH3IAS2F49Rg/zpzqOmKXULoG3Upkcu
	FXExAhdp3NklO95VpKkf6dYyNYT37WWjEInSuAYv8W2Yo40d4qxnmQqIKGbUO5F2
	xTw5XRAOme4ETGr19o4iMduCYSBedep1WCJE45lg43rZocU9SFaNee6Vo+kL2xyo
	mv2h9e0nAA4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72ED01871C;
	Tue, 25 Aug 2009 02:33:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 426C318713; Tue, 25 Aug
 2009 02:33:28 -0400 (EDT)
In-Reply-To: <20090825061248.GG1033@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 24 Aug 2009 23\:12\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3917A322-9141-11DE-8A86-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127010>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The client knows the *name* of the ref, but not the SHA-1 the ref is
> currently valued at.  Thus when the client knows it wants a certain
> ref by name, it needs to send a "want " line to the server that would
> give it whatever that ref currently points at.  Unfortunately since we
> have not obtained that value yet, we are stuck.

That could be something you can fix in the out-of-band procedure Gerrit
uses (you let the client learn both name and value offline, and then the
client uses that value on "want" line).

However, even if we limit the discussion to Gerrit, you would need an
updated client that can be called with the out-of-band information
(i.e. "we know that changes/88/4488/2 points at X, so use X when
requesting") when talking with such an updated server.

So I think that expand-refs is a much nicer general solution than just
"server side is configured to hide but still allow certain refs", and
client updates cannot be avoided.

And again, 

> The problem with this is servers which are sending this expand-refs
> tag have hidden certain namespaces from older clients.  Those names
> can't be seen by older git clients, unless the user does an upgrade.

I do not think "generally hidden, but if you need to know you are allowed
to peek" is much of a problem.  You do not do that for regular refs, only
for "on-demand-as-needed" type things.  If we are going to make extensive
use of notes on commits to give richer annotations, I suspect notes
hierarchy could be hidden by default in a similar way.
