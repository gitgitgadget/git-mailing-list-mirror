From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] commit.c: add clear_commit_marks_many()
Date: Wed, 06 Mar 2013 07:30:08 -0800
Message-ID: <7vd2vcsfzz.fsf@alter.siamese.dyndns.org>
References: <1362523639-30566-1-git-send-email-gitster@pobox.com>
 <1362523639-30566-2-git-send-email-gitster@pobox.com>
 <20130306083037.GA2018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 16:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDGIh-0006W8-E6
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 16:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757940Ab3CFPaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 10:30:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757359Ab3CFPaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 10:30:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42301A524;
	Wed,  6 Mar 2013 10:30:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ee7Z0W9EXFejxP8hQG4ZfOlA4WI=; b=Qv/G2P
	pjBsWqAO5VharoQKcQLmCdj1C/EhS9NUPHj98Au4S2uVUJWfWf26hfIwSEBnwS1v
	1Zpy1mjJ3XyIutHRKmwXrs8p/FuIDnc+l0U0lgj3m6d3iKLdZXjUdnslqahpSSxX
	HzmlGjj+5WiTP09Z23K/uZ9a3TDJfZwKtyPus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ouPREg6DhfgSWCBN+IaibVwtxCCzoeLQ
	SN5HC4M8FYSBZroK/UP3KrlylJBH7RNY+spIolPa+cwLCbV0Drk8lt6+m7gKKtmH
	7CHovtwdfkAyWQvHJRiqnYxbhgYsFNDUIPuf/AEHJAR3r5qw3zgLRj3AV2H1KVEJ
	XVCZjkWPTvY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37A40A523;
	Wed,  6 Mar 2013 10:30:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADBEDA521; Wed,  6 Mar 2013
 10:30:09 -0500 (EST)
In-Reply-To: <20130306083037.GA2018@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Mar 2013 03:30:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB0E31D2-8672-11E2-A53B-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217530>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 05, 2013 at 02:47:16PM -0800, Junio C Hamano wrote:
>
>> clear_commit_marks(struct commit *, unsigned) only can clear flag
>> bits starting from a single commit; introduce an API to allow
>> feeding an array of commits, so that flag bits can be cleared from
>> commits reachable from any of them with a single traversal.
>
> Out of curiosity, is that actually measurably more efficient?
>
> Since we stop traversing a commit's parents when we see it does not have
> any of the flags we are clearing, we should visit most commits once. The
> exception is ones that we hit by multiple paths. But that should
> be the same whether it is done as part of a single traversal or
> multiple; in each case, we hit the commit and say "Oh, already cleared;
> do not add it to the parents list".
>
> So I would expect it to have little to no impact on performance.  I
> still think it is a sane interface change; I was just curious from the
> commit message whether there could be a performance impact.

I agree that the log message should end with "with a single API
call." to clarify that this is more about eliminating the code
overhead (the caller having to loop over an array of things) than
about runtime overhead.
