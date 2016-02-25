From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] t/lib-http/apache.conf: load mod_unixd module in apache 2.4
Date: Thu, 25 Feb 2016 15:16:55 -0800
Message-ID: <xmqqbn74mlco.fsf@gitster.mtv.corp.google.com>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
	<20160225220045.GA10267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:17:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ59x-000521-LA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbcBYXRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:17:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752492AbcBYXQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:16:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2B89474C6;
	Thu, 25 Feb 2016 18:16:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ip8xOExazh8eZ6EgNbAxn1EWNTI=; b=EP/gUk
	uw13sRFz9AxzxWj1dSazXJnnbKSUlkaj+eY83q/eoMaaDACh+nhYRFsWTNDknfC/
	AOJUfS74XE6JrQMC0BQICbzwf7Aa0E4iZ3rxFInclUhx5CmCCQyslYGYkzG4KQZg
	CIIyUIM1/tR6rcrOQZ/353cvxv5dmHfSfcrCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nqd2NUlf37yOOhxplp2Fz+lSDegTAuEm
	pxDvmnKA3AmnmCHrGqFiVQKf9nL9YqYMylTSgWjkalhuhmt/oLRqEy5QqfRAKhjk
	tCLjwZU3mXfez8sLvt7RKFjxiRUSa5+jqsYBNDz4oA2uB+QyCatK/5Ey5z827qo7
	k6Q1e9DabvE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A36D474C5;
	Thu, 25 Feb 2016 18:16:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01152474C4;
	Thu, 25 Feb 2016 18:16:57 -0500 (EST)
In-Reply-To: <20160225220045.GA10267@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 25 Feb 2016 17:00:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD5C3FF8-DC15-11E5-AE8C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287487>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 25, 2016 at 10:57:11AM -0800, Jacob Keller wrote:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>> 
>> Since 2.4, apache will fail to load unless mod_unixd is loaded in order
>> to drop privileges.
>> 
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> 
>> I am not sure why this wasn't there already, but I am unable to run
>> httpd 2.4.18 without it, on Fedora 23.
>> 
>>  t/lib-httpd/apache.conf | 3 +++
>>  1 file changed, 3 insertions(+)
>
> Michael (cc'd) posted an identical patch with some more discussion back
> in May:
>
>   http://article.gmane.org/gmane.comp.version-control.git/268770
>
> The series languished because none of the reviewers had systems that
> reproduced the problem, and I think there's some additional work needed
> to get all of the svn-over-http tests running[1].
>
> I think this bit should be OK to take without the rest (though I like
> the extra discussion in the original).

I can resurrect 745a5487 (t/lib-httpd: load mod_unixd, 2015-04-08),
which is still on 'pu', and apply 2/2 from Jacov on top of it.

Thanks.

>
> -Peff
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/284349
