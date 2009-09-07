From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add url.<base>.pushInsteadOf: URL rewriting for push
 only
Date: Mon, 07 Sep 2009 00:53:18 -0700
Message-ID: <7vljkr2ntd.fsf@alter.siamese.dyndns.org>
References: <cover.1252306396.git.josh@joshtriplett.org>
 <0be9995dcd7d48c918fa75f4d9e557a6144a047c.1252306396.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Mon Sep 07 09:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZ2c-00033i-FD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 09:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbZIGHxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 03:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbZIGHxZ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 03:53:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbZIGHxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 03:53:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C919628D48;
	Mon,  7 Sep 2009 03:53:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HK1c1ZNJwfK/qaKRcUP2I+O3LK4=; b=dJJ2xi
	p61cdtLOUSAcsnuEoTQlKRkPZDSeSwntQSrvMowDAS44rTswmOzb8+L4jtVOgaVe
	n4p0NfMun1T7yKb8B7ThLubqwrDH1yMOt7XEqlM//bEAGEeaR8TZS+UkCk4lUjcA
	/msrlILeiY6o3pDno/L+v3XtN7UzozpvvRvf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lFW96KBFhqzplgHz3fxM4oWjxQLMR3jq
	JQEZotE7hg+5p3OQ5i9fW/UvBZW4iYBGZb0fF9W3vboPj4ZVMWQgliAtECWOXjj0
	J7DjrIvw16FBRUOaSji/cWfzI2xx9kBIVk7UpJNQbWzgXyOnMkuovxMhdAAMXZRw
	uERgxo2LuLU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD5D328D47;
	Mon,  7 Sep 2009 03:53:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 069AE28D46; Mon,  7 Sep
 2009 03:53:19 -0400 (EDT)
In-Reply-To: <0be9995dcd7d48c918fa75f4d9e557a6144a047c.1252306396.git.josh@joshtriplett.org> (Josh Triplett's message of "Mon\, 7 Sep 2009 00\:00\:20 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84B00CF6-9B83-11DE-A5AA-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127896>

Josh Triplett <josh@joshtriplett.org> writes:

> This configuration option allows systematically rewriting fetch-only
> URLs to push-capable URLs when used with push.  For instance:
>
> [url "ssh://example.org/"]
>     pushInsteadOf = "git://example.org/"
>
> This will allow clones of "git://example.org/path/to/repo" to
> subsequently push to "ssh://example.org/path/to/repo", without manually
> configuring pushurl for that remote.

Nice.

> @@ -435,12 +449,13 @@ static void alias_all_urls(void)
>  	for (i = 0; i < remotes_nr; i++) {
>  		if (!remotes[i])
>  			continue;
> -		for (j = 0; j < remotes[i]->url_nr; j++) {
> -			remotes[i]->url[j] = alias_url(remotes[i]->url[j], &rewrites);
> -		}
>  		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
>  			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
>  		}
> +		for (j = 0; j < remotes[i]->url_nr; j++) {
> +			remotes[i]->url[j] = alias_url(remotes[i]->url[j], &rewrites);
> +			add_pushurl_alias(remotes[i], remotes[i]->url[j]);
> +		}

Even if you have URL but not pushURL, now you get a corresponding pushURL
for free by just adding pushinsteadof mapping that covers the URL without
having to configue pushURL for each of them.

What happens if you already had a pair of concrete url and pushurl defined
for one of your repositories (say git://git.kernel.org/pub/scm/git/git.git
for fetch, ssh://x.kernel.org/pub/scm/git/git.git for push) at a site, and
then upon seeing this new feature, added a pushinsteadof pattern that also
covers the URL side of that pair (e.g. everything in git://git.kernel.org/
is mapped to x.kernel.org:/ namespsace)?

Do you end up pushing to both (e.g. ssh://x.kernel.org/pub/scm/git/git.git
and x.kernel.org:/pub/scm/git/git.git), or in such a case, the pushURL you
gave explicitly prevents the pushinsteadof to give unexpected duplicates?
