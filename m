From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] grep: let grep_buffer callers specify a binary flag
Date: Wed, 01 Feb 2012 16:47:38 -0800
Message-ID: <7vhaza12ol.fsf@alter.siamese.dyndns.org>
References: <20120201221437.GA19044@sigill.intra.peff.net>
 <20120201232109.GA2652@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 02 01:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rskq2-0003J1-LL
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 01:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab2BBArm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 19:47:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122Ab2BBArl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 19:47:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6A577E69;
	Wed,  1 Feb 2012 19:47:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iBP4s+5Y/kB8BBcO9A8CWSBjACA=; b=KkJapC
	xqq9iB6J0mYV7HcrnwTZqIV+rNrxaF8d9c/Nd44oL9/mFAPnRFGup+ABjLu4oxep
	vwZ6KTOt7n+4YRHFbAaLW82O6I5n35dHQ6XiPxvOsCh80K9pH6HC5hSDyu76/Sto
	OKDNZzw7Xc4xyIzBzHBZQmPqAkzdfxPB/jM8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qcyxn8ek5lPjWE/P7nRTQn0B4Sle/4Te
	/1OF6ZVvQLeM8qN6/GL9LYDy1LHqur58hXUz+zNbeFDCprSiCLH6k/jQ7UvuMsf6
	Qt4gDriL/BmqXq62dAK9654dw09r0/oIzgpjYcaw3GUsvQMwYf6iheJeqTpuwPHS
	GmndPUiIL2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E1CE7E68;
	Wed,  1 Feb 2012 19:47:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32F047E67; Wed,  1 Feb 2012
 19:47:40 -0500 (EST)
In-Reply-To: <20120201232109.GA2652@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 1 Feb 2012 18:21:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82494992-4D37-11E1-ADD6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189564>

Jeff King <peff@peff.net> writes:

> The caller of grep_buffer may have extra information about
> whether a buffer is binary or not (e.g., from configuration).
> Let's give them a chance to pass along that information and
> override our binary auto-detection.

Hrm, I would have expected a patch that turns "const char *name" into a
structure that has name and drv as its members, so that later we can tell
the function more about the nature of the contents. Or a separate pointer
to drv in place of your "binary" flag word.

I am not saying that your patch is wrong. It was just somewhat unexpected
that "binary" is the only additional thing we want to tell the function.
