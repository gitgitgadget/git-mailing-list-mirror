From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Tue, 04 Jun 2013 14:24:20 -0700
Message-ID: <7vk3m9603f.fsf@alter.siamese.dyndns.org>
References: <20130604141314.GD22308@pomac.netswarm.net>
	<20130604160815.GB15953@sigill.intra.peff.net>
	<51AE3A88.2080203@kdbg.org> <20130604191025.GG28153@google.com>
	<20130604210600.GA3271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Ian Kumlien <pomac@vapor.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyiR-0004FR-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab3FDVYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:24:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab3FDVYX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:24:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC54C250D4;
	Tue,  4 Jun 2013 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I2r3z19X6FyOGjb9DLG0iGkSgf8=; b=sVI1+E
	4athgH1BGG0KJZak1A7W+gjuS9aKYtuEzfguoc/A1nEjN0l3vtNuK3VJqnI0Nm3f
	ISrBi5BvstADS9g6dH6g91GCpxBL1Wyo7na/UB51sfIuvc08W9ZxdnvvNeKgQSMO
	gPu+/P9chh45lGXAKjEGq/LQUmCLbXklkk9Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ClSOWhMDVPEZJ7NRBEpLKdOLnvJXiTDO
	3NjpD/qUYIruCHylvsqE3bnHSpFrt7KvUGqqSbqFVWHrtOaMwF8ugs/mK5pSS7Eg
	vH8Q/4NJPnuaAPBA6Sesvw0PM8yeo5qBYMiktU3zwSfEBCPY0DnS8qZZl08gZjHs
	RY57+4JBdnU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1EBC250D3;
	Tue,  4 Jun 2013 21:24:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B7B7250D2;
	Tue,  4 Jun 2013 21:24:22 +0000 (UTC)
In-Reply-To: <20130604210600.GA3271@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Jun 2013 17:06:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FA70926-CD5D-11E2-A62F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226411>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 04, 2013 at 12:10:25PM -0700, Jonathan Nieder wrote:
>
>> >> However, since changing user id and leaving $HOME is so common, there is
>> >> a patch under consideration to loosen the check only for the case of
>> >> EACCES on files in $HOME. That commit is 4698c8f (config: allow
>> >> inaccessible configuration under $HOME, 2013-04-12); it's not yet in any
>> >> released version of git, though.
>> [...]
>> > I've a PHP script in ~/public_html that runs git. Without the mentioned
>> > patch, the script bails out due to this error. This time it's Apache
>> > that gets me into trouble because at the time the PHP script and git
>> > run, $HOME is still /root, but the user identity is not root anymore.
>> > The patch is direly needed; without it, I need to use 'env
>> > HOME=/home/j6t /usr/local/bin/git' in my script.
>> 
>> I could be remembering wrong, but I thought it was not so much "under
>> consideration" as "accepted for 1.8.4".  I haven't heard any
>> compelling reasons not to apply it.
>> 
>> Would it would make sense against earlier releases as well?
>
> Yeah, I think it would. I only said "under consideration" because I saw
> that it was in "next" and not elsewhere, and did not hunt down the exact
> status in "What's Cooking".

Sorry about that; it is in 'master' but "What's cooking" for that
pushout hasn't been published yet (the description of what I did
yesterday will be rolled into today's issue together with the
description of what I did today at the end of day).
