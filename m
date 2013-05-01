From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Wed, 01 May 2013 14:57:03 -0700
Message-ID: <7vwqri4b4g.fsf@alter.siamese.dyndns.org>
References: <20130501203449.GA12535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 01 23:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXf1V-0005jv-6S
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 23:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758892Ab3EAV5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 17:57:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63722 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758767Ab3EAV5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 17:57:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91B1C1BEA3;
	Wed,  1 May 2013 21:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zfgHGaZJPntRwEV4zIEiTPHuiAc=; b=pB4RaY
	hLmU2FS7f3sPhXVp7Unxy+BCS8GdocSvCIDEsUXwwiTTVV+NyQizXncLxO8Bl7Ov
	HYLBbYfEel2CvcrMhGNOls54SfgTEhGdMX0tUDX1+/pvZuu6rf4pWi0ftJNSy+lS
	d6ZCYN31aLjme6VELA7MEtm+cHrRcjdRBF3YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jbvIAeEAcY6JIJiLtQNDzXTU23MvShd4
	x0cBZDfOnJdgVN2NctaqC5BpyF1qB7HJ6jpOA9qisiZdQBT8wUO1xcyjoSfIDabm
	nSfa6KOFJnKgqYCYAygFS3W/tqVCL0hiuiq+B0P9cudKcKBTbvJJpKHJKT/4HFHp
	fZzwF/INaFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88D601BEA2;
	Wed,  1 May 2013 21:57:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C45A1BEA1;
	Wed,  1 May 2013 21:57:04 +0000 (UTC)
In-Reply-To: <20130501203449.GA12535@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 1 May 2013 16:34:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F9C1EB8-B2AA-11E2-9DF3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223150>

Jeff King <peff@peff.net> writes:

> We could instead bump X into the `i` slot, and then shift
> the whole contiguous chain down by one, resulting in:
>
> index       | i-1 |  i  | i+1 | i+2 |
>        -----------------------------------
> entry   ... |  A  |  X  |  B  |  C  | ...
>        -----------------------------------
>
> That puts our chain in true most-recently-used order.
> However, experiments show that it is not any faster (and in
> fact, is slightly slower due to the extra manipulation).

Makes quite a lot of sense to me.  Very simple, clean and nice.
