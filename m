From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/11] "git prune" is safe
Date: Tue, 27 Aug 2013 12:17:46 -0700
Message-ID: <xmqqy57naqp1.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<860155028.34610.1377626750550.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:18:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEOm2-00083Y-9O
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab3H0TRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:17:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858Ab3H0TRt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:17:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 519E13C288;
	Tue, 27 Aug 2013 19:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NJpJW3yc0dlQRWN5BkfpuI4T9aQ=; b=RZXgBh
	ESpdoBNX947g2IN1NJHaFAS+ePtCzbXPGGMfb69ILDKzH8mQ+OH0jcBR4/HfpV8I
	j50uNs6vpeQUQfm4uYy6HaY1+EiRGvanbRtGvz/oRbdhvp9Ym33yo5lTeHJmng8k
	/cl54C4rSNnzcVqrT+X4wGziK4MLAcm+c7JFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D5dQkbpWJQEbsL9/dJXcagchItSLDkX5
	AtxUcUYDvyTTnYroICpUD3HcSn00Zmc3wKvj4nC7nR8rYYY61tCoQEbRRdXolds5
	rYnfBQtC888RlrXLh4LD80vrrfH0hYOipX1UBWr9i2jIQMzTTCffl4UvvehPInhn
	CmlNM9RkVzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 455383C287;
	Tue, 27 Aug 2013 19:17:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9449C3C286;
	Tue, 27 Aug 2013 19:17:48 +0000 (UTC)
In-Reply-To: <860155028.34610.1377626750550.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 20:05:50 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5C453B32-0F4D-11E3-8E6F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233143>

Thomas Ackermann <th.acker@arcor.de> writes:

> "git prune" is safe in case of concurrent accesses to a repository
> but using it in such a case is not recommended.
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 9149846..ea843e6 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3299,17 +3299,11 @@ state, you can just prune all unreachable objects:
>  $ git prune
>  ------------------------------------------------
>  
> -and they'll be gone. But you should only run `git prune` on a quiescent
> +and they'll be gone. (You should only run `git prune` on a quiescent
>  repository--it's kind of like doing a filesystem fsck recovery: you
>  don't want to do that while the filesystem is mounted.
> -
> -(The same is true of `git fsck` itself, btw, but since
> -`git fsck` never actually *changes* the repository, it just reports
> -on what it found, `git fsck` itself is never 'dangerous' to run.
> -Running it while somebody is actually changing the repository can cause
> -confusing and scary messages, but it won't actually do anything bad. In
> -contrast, running `git prune` while somebody is actively changing the
> -repository is a *BAD* idea).
> +`git prune` is designed not to cause any harm in such cases of concurrent
> +accesses to a repository but you might receive confusing or scary messages.)

These new two lines are good, but did we lose the mention of "fsck"
that will report what is not dangling as dangling and such when run
concurrently with other operations?  Is that intended?

>  
>  [[recovering-from-repository-corruption]]
>  Recovering from repository corruption
