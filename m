From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: move thread autodetection closer to
 relevant code
Date: Thu, 05 Nov 2009 23:20:39 -0800
Message-ID: <7v7hu43yrc.fsf@alter.siamese.dyndns.org>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
 <alpine.LFD.2.00.0911041623570.10340@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 08:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6J7y-0001kM-32
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 08:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbZKFHUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 02:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbZKFHUr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 02:20:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbZKFHUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 02:20:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FFCF75ED4;
	Fri,  6 Nov 2009 02:20:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVB4PpfcczAYxVkHabmwJ4gj8EQ=; b=J5qXmB
	rerYmN03f6Lbfl3t1Zfpx1mP1U/8Cebq6ED2uKrUaZ8ppwFUBQeGs7dUf2b/RoTm
	qIbhIfAxy13zLIvEmVEodLZsYDz2l2AmpzZZOLDObB3em97KXACyIuBHbsFyrfkI
	xybAij/EwSWa+qoat81BL6PPY4vqwHK/lKjF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S/dcFyN6Y+9uHmhdO349l+17XyC5guc/
	WVnST9VYvaJrGGMPm4bPhRtmt98gYZ2tm0tdlA+IMMMjuVYGbDn5Ywzbxt1tDmFA
	ZKL2wmd23EYPn9cWukkhZscc4Exr3EsY33hdhXtIfl006k2/vNOjDvGnQ0em20kX
	KsF6Ki1+2B0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D1975ED3;
	Fri,  6 Nov 2009 02:20:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2191275ED1; Fri,  6 Nov
 2009 02:20:40 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0911041623570.10340@xanadu.home> (Nicolas
 Pitre's message of "Wed\, 04 Nov 2009 16\:32\:46 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E73A1BF0-CAA4-11DE-A25A-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132277>

Nicolas Pitre <nico@fluxnic.net> writes:

> Let's keep thread stuff close together if possible.  And in this case,
> this even reduces the #ifdef noise, and allows for skipping the
> autodetection altogether if delta search is not needed (like with a pure
> clone).

Nice.  The ll_find_delta() function itself will disappear and becomes the
single-threaded find_deltas() when THREADED_DELTA_SEARCH is not defined,
and the variable in question is used only inside the function anyway, so
this works beautifully.

Very nice.
