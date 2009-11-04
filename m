From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] use '--bisect-refs' as bisect rev machinery
 option
Date: Wed, 04 Nov 2009 11:22:04 -0800
Message-ID: <7veioegko3.fsf@alter.siamese.dyndns.org>
References: <20091104034312.4545.2176.chriscool@tuxfamily.org>
 <7vljimgnaz.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0911041030080.31845@localhost.localdomain>
 <alpine.LFD.2.01.0911041033530.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:22:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lRB-00036Y-GU
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbZKDTWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756008AbZKDTWK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:22:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbZKDTWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:22:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2718F73B6D;
	Wed,  4 Nov 2009 14:22:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wxc4weGRT8aVczRApcPWNX366dE=; b=CSevRW
	T4pb1MZSZOVOedfBZRQtNjZW3jAvmHnGdkLiEWTyiZ7V0TIImmYta430VG87WINO
	mdb76i9033l8Yffid8+wTSyZo6H1Eik3tFWhj/227AYCVqFj3dOFHs6gCcELs6Vl
	dJJFreiOudtu86jDPyXVM2NwNT0PgjPiucT1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R62XxEcRuo6Ka8UJbqpkvq9SMbMC1xEt
	rsDz89B77nrq4OMsFoECXMzVcMQEScJFLrkzmkSyNWAiqM/Hb9eUUqnKL2Wpnk1d
	R3m1Cwm3d8jEaYNjKXjRroBrHcs0KS12eN69qVJe37knLIePOR8iVLmJzi7Zv3SA
	B5ke0PF/Uno=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDFF273B6C;
	Wed,  4 Nov 2009 14:22:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F65273B6A; Wed,  4 Nov
 2009 14:22:06 -0500 (EST)
In-Reply-To: <alpine.LFD.2.01.0911041033530.31845@localhost.localdomain>
 (Linus Torvalds's message of "Wed\, 4 Nov 2009 10\:35\:47 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5904D34E-C977-11DE-BE56-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132117>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 4 Nov 2009, Linus Torvalds wrote:
>> 
>> Yes, it is a behavioral change, but is it a bad one?
>
> .. and perhaps we could introduce --bisect-refs as the "old behavior" of 
> '--bisect' to git rev-list?
>
> I kind of suspect that it is unlikely that people are using 'git rev-list 
> --bisect' while _inside_ a bisection, but then wanting to bisect someting 
> that is outside the set of commits we're currently actively bisecting.
>
> But maybe I'm wrong.

Maybe I'm wrong too, but I do not think that is plausible that people are
doing nested bisection that way.  It is probably a useful thing to do, but
if somebody has thought of doing so we would have at least seen a request
to add a way to tell "git-bisect" what names to use to record the good/bad
set of commits under to make their implementation easier.  I haven't, and
I take it an indication that it is very implausible that such scripts by
people exist to be broken by this change.

I was more worried about people who reinvented the wheel and are using
their own git-bisect.sh derivative.  It probably was forked from the
version that still used 'git rev-list --bisect", manually feeding good and
bad set of commits to it from the command line.  But then what they are
feeding would be the same as the new --bisect option implicitly gives them
anyway, so there won't be a regression either.
