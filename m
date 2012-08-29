From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Funny 'git describe --contains' output
Date: Tue, 28 Aug 2012 22:57:23 -0700
Message-ID: <7vr4qqxmt8.fsf@alter.siamese.dyndns.org>
References: <20120829044840.GA25869@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 07:57:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6bHY-0000mV-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 07:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab2H2F5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 01:57:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942Ab2H2F50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 01:57:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D0626D7B;
	Wed, 29 Aug 2012 01:57:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i//gQgL9R1feh4cH0pBrUmuj78E=; b=u/34vC
	L2UFbFIrG4ZIcOJMB3x4VtAuuoZqmizaXF3WIu6nxLc9R1p4wuNPn7nLLlq2gBHD
	Kn/Tpip3TiAgatkKGDeKVvbTOW4kKiO9Km+ar79+trH/AyH2WxAMT6HeEvZOKki0
	GQ7LHc3Pc0UzDkUulUFunMLg2e2Bt1lNNQSqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UBYTlPqnQOWioG9w3morJTrks44a1sYx
	em//m+tr3qjlWzylVYwkZ5o+7aCRYmMmtwWUMsnDgb73aC1Nox+zuPW9vTjGe1x6
	CJTcJyYrHyN4JGhXLgIUyKJeo00wbtMsh4X46GGtv63r7j86chdVmHqvEah28/GT
	gpI916nZBTo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AF986D7A;
	Wed, 29 Aug 2012 01:57:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DB886D79; Wed, 29 Aug 2012
 01:57:25 -0400 (EDT)
In-Reply-To: <20120829044840.GA25869@kroah.com> (Greg KH's message of "Tue,
 28 Aug 2012 21:48:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 685D071A-F19E-11E1-B0D4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204462>

Greg KH <gregkh@linuxfoundation.org> writes:

> In the Linux kernel tree, commit 0136db586c028f71e7cc21cc183064ff0d5919
> is a bit "odd".
>
> If I go to look to see what release it was in, I normally do:
> 	$ git describe --contains 0136db586c028f71e7cc21cc183064ff0d5919
> 	v3.6-rc1~59^2~56^2~76
> ...
> Any ideas?

That is 59 + 1 + 56 + 1 + 76 = 193 steps away from the tag v3.6-rc1.

$ git name-rev --refs=refs/tags/v3.5-rc1 0136db58
0136db58 tags/v3.5-rc1~83^2~81^2~76

which is 83 + 1 + 81 + 1 + 76 = 242 steps away from that tag.

So it _is_ odd that the newly tagged tip merged a branch that had
smaller development since it merged the commit, but name-rev seems
to be measuring the steps it takes from the tags to reach the commit
and giving us the one that gives the shortest path correctly.

Obviously, that is not the same as "which tag is the oldest one
among the ones that can reach this commit?"
