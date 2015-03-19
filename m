From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a corrupted repository
Date: Thu, 19 Mar 2015 14:23:25 -0700
Message-ID: <xmqqvbhwheb6.fsf@gitster.dls.corp.google.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072844.GA25191@peff.net>
	<xmqqfv90iwjj.fsf@gitster.dls.corp.google.com>
	<20150319205147.GA7775@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:23:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhuh-00036u-5l
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbbCSVXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:23:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750799AbbCSVXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:23:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7497341A60;
	Thu, 19 Mar 2015 17:23:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LmTvGjp2kp8ZuUgOkQIVmqexSAM=; b=wwKQPH
	lq5dvoOW/hZO72e6hJDBLXATc2zQJZEgDe4oG5sA+jYtdzIa+JTASHEXYt6JIdgX
	25xexwz0gpXKyCh3n0tIg2QFoVzk/RCWt7fiOCUIllm0c2icnBfcODMt5MJAukmo
	BuAwBk0r7KKAMHeN4jTcQeVNjyCrOQl8Hx7o8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kzDRALIvhK0dTSfOukH6d1FImx99X/bs
	Ji6x0lMcQv21I/w9FB3wMnoFVhJT/zEzxkYqMl8l5mpcNFo6XMWzdtR1VkZwONPV
	fxkEEe59ygpA2h9sG8pceWvm/346+4zDzB02goTT376Mb+IQV1KTlsib/112WuIh
	MXQZRokIzJw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C0FF41A5F;
	Thu, 19 Mar 2015 17:23:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A114041A5C;
	Thu, 19 Mar 2015 17:23:26 -0400 (EDT)
In-Reply-To: <20150319205147.GA7775@peff.net> (Jeff King's message of "Thu, 19
	Mar 2015 16:51:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E5910E4-CE7E-11E4-BE95-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265836>

Jeff King <peff@peff.net> writes:

>> A safer check may be to pack and then make it missing, I guess, but
>> I do not know if the difference matters.
>
> Yeah, I considered that. The trouble is that we are relying on the
> earlier setup that made the object go missing. We cannot pack the refs
> in the setup step, because the earlier tests are checking the loose-ref
> behavior. So we would have to actually restore the object, pack, and
> then re-delete it.

Yes, "restore pack redelete" was what I had in mind when I wondered
such a sequence of extra steps is worth and the difference between
such an approach and an approach to use a hand-crafted packed-refs
file matters.
