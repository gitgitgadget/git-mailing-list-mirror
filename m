From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] t5510: prepare test refs more straightforwardly
Date: Wed, 23 Oct 2013 11:36:21 -0700
Message-ID: <xmqq61snrg0q.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 23 20:36:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ3ID-0001Co-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 20:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab3JWSgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 14:36:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab3JWSgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 14:36:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B4314D555;
	Wed, 23 Oct 2013 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aNCaUhvi/DGPg6e1War7/JOsYpc=; b=idGJuO
	tkH+l3pceFvzSeo3XPiozJm5KBiBbKb/ftLLHTM2VCqA1YhI+e4I4GguGz2N7gjM
	IoUgqQP0XoW8HtSuhk03h7gKEN99roeGqcr/vjnH7w52DwKcu7cHRxaKRxjqnCI0
	/5ZCeXrv2Gp5rH9TOAaM8n1pMxXbedMqUuTBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x/y/PzVMy4IPi/1Vxd+Jbca3bbcCfDoe
	0h4B/ON2M5xM7Gq5i8wRuKET7JQEbplo5InPe7YrE9rZHFdNc8pPgB7GBed03tcp
	9qYksVf0WB1vk6T8cD49AiuiMLxhAnkJ9JL3vwJ40Zvou/6a+oTxQ9rcCk0PQZ05
	yXn3pVZTJso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED0664D554;
	Wed, 23 Oct 2013 18:36:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 248144D54F;
	Wed, 23 Oct 2013 18:36:23 +0000 (UTC)
In-Reply-To: <1382543448-2586-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 23 Oct 2013 17:50:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 046A4B36-3C12-11E3-87FD-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236544>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> "git fetch" was being used with contrived refspecs to create tags and
> remote-tracking branches in test repositories in preparation for the
> actual tests.  This is obscure and also makes one wonder whether this
> is indeed just preparation or whether some side-effect of "git fetch"
> is being tested.
>
> So use the more straightforward commands "git tag" / "git update-ref"
> when preparing branches in test repositories.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t5510-fetch.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index c5e5dfc..08d8dbb 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -88,7 +88,7 @@ test_expect_success 'fetch --prune on its own works as expected' '
>  	cd "$D" &&
>  	git clone . prune &&
>  	cd prune &&
> -	git fetch origin refs/heads/master:refs/remotes/origin/extrabranch &&
> +	git update-ref refs/remotes/origin/extrabranch master &&

As long as you have checked that our local 'master' should be at the
same commit as the origin's 'master' at this point, I think this
change is OK.

I wouldn't call the use of "very explicit, without any room for
mistake" refspecs "contrived", though.
