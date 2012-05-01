From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc --aggressive
Date: Tue, 01 May 2012 11:47:26 -0700
Message-ID: <7vr4v391s1.fsf@alter.siamese.dyndns.org>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
 <20120501162806.GA15614@sigill.intra.peff.net>
 <20120501171640.GA16623@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205011348090.21030@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue May 01 20:47:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPI6o-0006xI-BJ
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172Ab2EASra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 14:47:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab2EASr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 14:47:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EC2C722D;
	Tue,  1 May 2012 14:47:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qDeO7SDEeru6jysTO8s2zpYE8is=; b=glghpD
	HzPrwe9nowm4heiUkuVETSzdrTtkPPjiDm8VbIcXMU5mBFtmT7vIhyyRf/Q+axB3
	Mpu4oDOVRvTkXa3ZDIMZPsd5Z3EEDGpKeEc/OFccDXBL2QD9IRr78bhJDyPotqm0
	gcNNG0vYJ6e/wL/MxO+dcd7/hiyE9KYzgXnUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=css0BxVOf8jy6tL7naYP76aNDE1C+bg/
	4W+F8PeIynm/CFqlvGewccSNz5P2oMM8llq6dyh4eJjKXL5oPumpWni/OZzH1avD
	py6vshoDKjIBasTvFxFGazVBZE9TUOaU7ESf3vr0Wy++vM1/vpU1mRg2Eqe5nPz/
	o7CMoVvw5Pc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 829B2722C;
	Tue,  1 May 2012 14:47:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15332722B; Tue,  1 May 2012
 14:47:27 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.02.1205011348090.21030@xanadu.home> (Nicolas
 Pitre's message of "Tue, 01 May 2012 13:59:08 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19A2B888-93BE-11E1-9B6E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196726>

Nicolas Pitre <nico@fluxnic.net> writes:

> One final quick test if you feel like it: I've never been sure that 
> the last comparison in type_size_sort() is correct.  Maybe it should be 
> the other way around.  Currently it reads:
>
> 	return a < b ? -1 : (a > b);
>
> While keeping the size comparison commented out, you could try to 
> replace this line with:
>
> 	return b < a ? -1 : (b > a);
>
> If this doesn't improve things then it would be clear that this avenue 
> should be abandoned.

Very interesting.  The difference between the two should only matter if
there are many blobs with exactly the same size, and most of them delta
horribly with each other.  Does the problematic repository exhibit such
a characteristic?

The original tie-breaks based on the address (the earlier object we read
in the original input comes earlier in the output) and yours make the
objects later we read (which in turn are from older parts of the history)
come early, but adjacency between two objects of the same type and the
same size would not change (if A and B were next to each other in this
order, your updated sorter will give B and then A still next to each
other), so I suspect not much would change in the candidate selection.
