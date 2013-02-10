From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/15] user-manual: Use request-pull to generate
 "please pull" text
Date: Sun, 10 Feb 2013 14:23:48 -0800
Message-ID: <7vehgnst8r.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <3d860e7c19b33ebc2725eb86ec481f966e3007de.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:24:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fKA-0004EV-FI
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab3BJWYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:24:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607Ab3BJWYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:24:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15233B67D;
	Sun, 10 Feb 2013 17:24:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qshJZU2ChT3s0/66+NT1Lp7orts=; b=S8cuJi
	LZLolXhGA3c2agCBo4Veo+QyOZMn1+XB5mzsJAEWDnY7vVxorNY3UQZevpWguqbO
	cCNEbqyRyN0++ZjftNs2Ov5+U/3K/zqCwCwleCyD5P0Iu5j+nNM7IZyDZmSdc9PQ
	fDgPgvaIeAZgF49rt4k1fjJUODf5Z7ZKbVSu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XjUdEGmK9YkaBwJuH/80ak+E8qEkLSve
	I+jdjoAERSeLKcnTxbI5KCGzR0MIl7ONw/Y0oxh1coHDW3wnoUQBQjHMW3BM9974
	IOqjCraSa6YMHKEohpGm7JOCrLEtyjAKLRV+B06KnFp3XTA661enK2NUtzU0NiHC
	/CAZeZhbvJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B99F4B646;
	Sun, 10 Feb 2013 17:23:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69910B5F4; Sun, 10 Feb 2013
 17:23:50 -0500 (EST)
In-Reply-To: <3d860e7c19b33ebc2725eb86ec481f966e3007de.1360508415.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 10 Feb 2013 10:10:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ED5BF90-73D0-11E2-98F0-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215952>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> Less work and more error checking (e.g. does a merge base exist?).
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 31054a2..6446791 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2298,17 +2298,14 @@ these changes, just apply directly to the `release` branch, and then
>  merge that into the `test` branch.
>  
>  To create diffstat and shortlog summaries of changes to include in a "please
> -pull" request to Linus you can use:
> +pull" request to Linus you can use linkgit:git-request-pull[1]:
>  
>  -------------------------------------------------
> -$ git diff --stat origin..release
> +$ git request-pull origin git://example.com/proj.git release
>  -------------------------------------------------
>  
> -and
> -
> --------------------------------------------------
> -$ git log -p origin..release | git shortlog
> --------------------------------------------------
> +where the `git://` URL points to your <<public-repositories,public
> +repository>>.
>  
>  Here are some of the scripts that simplify all this even further.

The request-pull checks a lot more than "does a merge base exist?",
no?  Does the examples in this flow push out what you want to be
pulled _before_ running this step?
