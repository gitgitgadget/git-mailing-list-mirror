From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge commits are non-deterministic? what changed?
Date: Tue, 20 Nov 2012 12:39:13 -0800
Message-ID: <7v4nkkroum.fsf@alter.siamese.dyndns.org>
References: <20121109133132.GK69724@acme.spoerlein.net>
 <m2y5iarf5s.fsf@igel.home> <20121109154245.GP69724@acme.spoerlein.net>
 <vpq390idb8v.fsf@grenoble-inp.fr>
 <20121109161647.GB19725@sigill.intra.peff.net>
 <20121109182753.GQ69724@acme.spoerlein.net>
 <50A0DD23.4040800@drmicha.warpmail.net>
 <20121120162226.GK69724@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Ulrich =?utf-8?Q?Sp=C3=B6rlein?= <uqs@spoerlein.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 21:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaubT-0003KT-FE
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 21:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab2KTUjR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 15:39:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab2KTUjQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 15:39:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18820923D;
	Tue, 20 Nov 2012 15:39:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gcpJUeVI47Nu
	sPuBWowQ27XXh7E=; b=Elc6dMIKyDRTAppAdXpT9ohyGGYKmTtG4ZoPzKohpc16
	T2bA8bfyk9rbjZQ3gquj4NL4hf44M0Oh2PbuqCK1ArsWb0HuugW726ewYRbdPAJe
	BMnJqg9lSNawdOWPz/bHAd7lGxajzvo2QldoLoeDdW6BYB+TW5Z5LJfOKkEClPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uapFHH
	IusGm5V2jsqizIngAW/EdF1vDDF5QHGcBSYCZtL2lbNZPRw3TGoeY+JgCTssYudg
	XcLrkmrgc2ccjEGzLgmq+waSxenm6yU2AoER6R4/TUYPRu60brHgbZEevHsExW1Y
	0mn9uaO/YNI/wOrKnbW3dn6qB5CrzakC9oLoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF79B923C;
	Tue, 20 Nov 2012 15:39:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29134923B; Tue, 20 Nov 2012
 15:39:15 -0500 (EST)
In-Reply-To: <20121120162226.GK69724@acme.spoerlein.net> ("Ulrich
 =?utf-8?Q?Sp=C3=B6rlein=22's?= message of "Tue, 20 Nov 2012 17:22:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59390D74-3352-11E2-BBC2-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210111>

Ulrich Sp=C3=B6rlein <uqs@spoerlein.net> writes:

> But this will never be changed, it would break the fundamental git
> storage model as it is in place now.

It doesn't just break "storage model", but more importantly, it
breaks the semantics.

Imagine that things started breaking after merging your topic branch
'foo' to the integration branch 'master', and how people would
perceive the situation.  Everybody would say your topic 'foo' broke
the build.  Nobody except you would say, even if the tip of your
topic 'foo' alone works perfectly, merging the 'master' to your
topic 'foo' broke that topic.  The topic should have been adjusted
to the updated baseline, that is the 'master' branch before this
merge since your topic 'foo' forked off of it, before or during the
merge.

To express what was merged into what, the order of parents in the
commit is fundamentally a part of what a commit is.
