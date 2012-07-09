From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Restore umasks influence on the permissions of work tree
 created by clone
Date: Mon, 09 Jul 2012 16:18:13 -0700
Message-ID: <7vwr2cikwa.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
 <20120707215029.GA26819@blimp.dmz> <7vobnpn224.fsf@alter.siamese.dyndns.org>
 <20120709225829.GA8397@sigill.intra.peff.net>
 <7v1ukkjzyz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 01:18:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoNDi-0007qT-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 01:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab2GIXSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 19:18:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64011 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab2GIXSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 19:18:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7800E9039;
	Mon,  9 Jul 2012 19:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kj9Xmn/Ooz6GSYl3uYigwBjkCmY=; b=cU0xDA
	Zw9w+WNbNGYcJlWicK8kqEXXbkP14S2dTy8PsAV+z4XPp8yBgEpAnaejDQI40mi5
	B1qvhjxd3UK3Oo/2HhcrFwCqNAgeeO25dp2V9aI5QSyBjO99pnEX9ivEan+eqzyn
	k9iSoa+pVQNCc5zdTZckJr7noGFeHA9qQWidU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BtXK9cMxtG2TD1Sx/54ktxnSR39xP/C/
	XWD6yrO4pfkJLqs/+3O7I86Gj/WtIJjzjrZwZN1569u7tU5iFqi2A1OeF6k7/zlM
	oJWh/xmjnbE28qy9jGbNqEeJdKT7Prshea7LnQxhtFjDTI41VK2tVHyWY8W7D8ck
	KkLPi7i+mE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FBBC9038;
	Mon,  9 Jul 2012 19:18:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 075A89035; Mon,  9 Jul 2012
 19:18:14 -0400 (EDT)
In-Reply-To: <7v1ukkjzyz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 09 Jul 2012 16:07:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C1228F4-CA1C-11E1-8CE3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201233>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Does the mkdir of "rr-cache/*" in rerere.c make the same mistake? The
>> rr-cache root is made with 0777, and the files inside each subdirectory
>> are created with 0666.  So it is the only thing preventing users of
>> shared repos from using rerere.
>
> Quite possibly yes.  I do not recall tightening permissions on
> purpose, and it was a long time ago ;-)

Yup, that's the last remaining "mkdir(.*, 755)" in the codebase, and
it should be trivial to replace it with mkdir_in_gitdir() or
something.
