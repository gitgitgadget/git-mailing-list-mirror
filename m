From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/3] revision.c: introduce --min-parents and
 --max-parents
Date: Mon, 21 Mar 2011 10:45:53 -0700
Message-ID: <7v8vw8qsdq.fsf@alter.siamese.dyndns.org>
References: <4D870157.2070309@drmicha.warpmail.net>
 <41d12c53966faa9c9cb5acc7646e9098dcd911ea.1300702130.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 18:46:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jBF-0005oo-MG
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 18:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab1CURqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 13:46:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab1CURqH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 13:46:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA7494186;
	Mon, 21 Mar 2011 13:47:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZsUGlCyU8I+LgzobauAIGgngBco=; b=GkQq9H
	Qv7LB+8kofqkotvZ81DXeTqBmZBIDmfSX4Kh/EPFs34xuJ3WpJAKN41F/LmaEjpZ
	Di4yaSdXmA4ANhFAZQO0qG8HQt4VZQpyqe646MSju/H01uclETgKGGJJUDk359uN
	+gUR3JWEHjphBre17tCURT4whCUJHiErkbdWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GBbeKEnKutgYgP8+jUwneW/XoV0Kqe7B
	EfEx8D9QmckNuT9JHNhD1pohrnOJNXKiZx1gGK2/hc09KlgCPli9CouWwvRa+rbR
	vzgkVk+Zi+oPtdqR72tJuQVtMxUz9Lb/Ga8DTZgstxDqqhNZrziwj7fkm3nHtfbx
	/lzHEF4MJ9Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76EC44182;
	Mon, 21 Mar 2011 13:47:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2AEF24180; Mon, 21 Mar 2011
 13:47:32 -0400 (EDT)
In-Reply-To: <41d12c53966faa9c9cb5acc7646e9098dcd911ea.1300702130.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon, 21 Mar 2011 11:14:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FE307CA-53E3-11E0-B5C2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169618>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Implementation note:
>
> We compute the number of parents only when we limit by that, so there
> is no performance impact when there are no limiters.

Only about 16% of the commits in git.git (and 7% in the kernel) are two
parent merges and the rest are mostly single strand of pearls, so even the
cost of counting all the parents in a loop that does not exit early when
it reaches max-parents limit should be negligible, and checking against
max-parents in each iteration would probably costs even more.

So I think this is a good to go.

Thanks.
