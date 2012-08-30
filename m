From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] name-rev: --weight option (WIP)
Date: Wed, 29 Aug 2012 21:09:27 -0700
Message-ID: <7vd329uiko.fsf@alter.siamese.dyndns.org>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <1346275044-10171-4-git-send-email-gitster@pobox.com>
 <20120830035127.GB32268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 06:10:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6w5C-00068T-9w
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 06:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728Ab2H3EJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 00:09:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab2H3EJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 00:09:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 266BB8E26;
	Thu, 30 Aug 2012 00:09:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+MM9nirTSTxFg/P1B0EOhetiFdQ=; b=VmfHzR
	Ea6zLf6hokHDwk7dh6w7rvcrSf7RRXgzeqxlsHOtEpvENZGP3vEnHg3c1iGwrFJV
	Rz6oCMib89gjdM5dx8/BFrX/guo/pLIyUqV+H3ytRFiWEx6I4lMrKyGT997yjrms
	Xt1SoRkM26EhKHYkGHkv/8mzAfYYNeieV+Ylc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SewzE+Kw4otqof778yxZ3rpYPCR2luHj
	GiaAW4HRjYqmwOzboR8WN5BfIC40MTNFrFDh6nJbJBhOeVrkjV/5/TySfT6rHoWt
	C9LxPhVbyESvqpLBeiFYLhmnWJyqOVTasxH5tl37WPFV1XeR//e4rhe/jibwqSuh
	P82R9d5vsiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B778E25;
	Thu, 30 Aug 2012 00:09:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81A208E22; Thu, 30 Aug 2012
 00:09:28 -0400 (EDT)
In-Reply-To: <20120830035127.GB32268@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 29 Aug 2012 23:51:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E27C6BA-F258-11E1-8740-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204519>

Jeff King <peff@peff.net> writes:

> When you wrote "oldest" here, I thought that meant you would do a
> comparison on the taggerdate. But reading the implementation, you really
> mean "topologically oldest".
>
> I wonder, though, if the former would be sufficient for most people.

Even without clock skew, timestamps are inappropriate measure for
the purpose of measuring "this dates back to...", unless you are
limiting yourself to very linear history.  Even in our own history,
v1.7.6.6 is 4 months newer than v1.7.7, for example.  The same holds
true between v1.7.6.6^0 and v1.7.7^0, so the story does not change
whether you use tagger date or committer date.

Basing this based on tag names is an attractive idea, but we would
need to devise a way for people to pass project specific tagname
comparison function from outside.  v3.2 is newer than v3.2-rc1 but
v3.2-bis may probably be newer than v3.2 and I do not think we want
to collect the rules and cast the logic in our code in stone.
