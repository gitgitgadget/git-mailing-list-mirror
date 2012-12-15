From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Allow git log to use mailmap file
Date: Sat, 15 Dec 2012 12:18:38 -0800
Message-ID: <7vd2ybrrvl.fsf@alter.siamese.dyndns.org>
References: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 21:19:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjyCM-0006x4-FX
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 21:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab2LOUSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 15:18:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab2LOUSl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 15:18:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A88EA08C;
	Sat, 15 Dec 2012 15:18:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BVFzuD5lswjXj4ZVvbuR+yfvMWU=; b=oPoF9m
	AQt2wxm0G+ICo4dajJIRfqh+jzBDtIpgjBicx6jLfCiIuvgDxbGiMWdfdBasJpR6
	1UGW+L6LwXHl4SGMznVXgWMxSurN8UVm+4qxo+Uckzzjfmx7igWc3XEksmRY+gIC
	YzZ2LeJY3YBQv2M7DQdr2okJ37HxM59kLBIYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eg/cpBG3Ff2+Rhqfvoun0UDzGD4Urql0
	WDMiv/93rmFtJVAjAhcpYoj7Npp7VkH4any1jX13v0B5Q0Zy+tZONY9IAtZQ39fa
	b0Xg1Ak+lDSW2p6hFJQfLdHoBjap8uatN9d/FTYM4kcPEf00IHIwnRp7gAWVjgQw
	2gFUnRf6Sro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87E92A08A;
	Sat, 15 Dec 2012 15:18:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3027A088; Sat, 15 Dec 2012
 15:18:39 -0500 (EST)
In-Reply-To: <1355594754-27589-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sat, 15 Dec 2012 19:05:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D49E460-46F4-11E2-9030-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211570>

Antoine Pelisse <apelisse@gmail.com> writes:

> Implement the feature suggested by Rich Mindwinter and Junio C Hamano
> (and following his advices)
>
>
>
> Allows git show/log commands to map author and committer
> names and emails using the mailmap file.
>
> Updates related to this second series:
>   - All tests are successful after each patch
>   - Use split_ident_line in shortlog.c
>   - Documentation has been added to git-log.txt
>   - Test has been added to check that we use the file
>   - Lots of improvements in the way strbufs are used
>   - New interface to map_user()
>   - Bunch of other fixes

The updated map_user() and its users look much nicer now.  Applying
your patches with "git am --whitespace=error" spots a few style
violations, though.

> git glog --committer/--author is still not looking for mailmap user
> names.

I think we should stop using the header grep mechanism for these and
instead keep two separate grep expressions in struct rev_info and
use them in revision.c::commit_match().  The unification of header
filter and message grep filter done in 2d10c55 (git log: Unify
header_filter and message_filter into one., 2006-09-20) may not have
been a good idea.

Thanks.
