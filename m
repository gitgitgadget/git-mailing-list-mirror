From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Fix termination issues for remote svn connections
Date: Thu, 05 Sep 2013 11:48:54 -0700
Message-ID: <xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: "Uli Heller" <uli.heller@daemons-point.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 20:49:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHec5-0007Qn-GA
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 20:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab3IEStA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 14:49:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354Ab3IESs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 14:48:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 053B33FA7C;
	Thu,  5 Sep 2013 18:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rplDnIv4ROe2itlw9JS/k0M0dZ0=; b=tpVHx4
	Nz8Oep37FSevw47gPq6dVgY8iNB9bQA6zuYOiaO8dXrB8kU2zH5+U2yKFCn35VjC
	VDT9a7sgg8ReZ5cKT1YynRTeQUt0dXyQUCQShze1YjtOaF4Aq0FH+OeeJNzXfBaC
	PRMpFfOjUULRw+Mu/TvEyfaK4uGOnqBX6aGjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TeNmuY1G998IZkadKO4TgWW/EMrPY+pN
	9G8+siKfBwA1Vb+lc4iCvHuLNJ7Bh57VIs4Sznn0KJFflYmuPJuB1wLkqIcYUd31
	OmyC4Z3hhm5lGkadMGZhmWX68VDMjwVE1Gj5g71W2PJk69x2qtoClmNUeSaP7icq
	qxbAJ+9/TMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA5403FA7B;
	Thu,  5 Sep 2013 18:48:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F34B3FA71;
	Thu,  5 Sep 2013 18:48:56 +0000 (UTC)
In-Reply-To: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106> (Uli
	Heller's message of "Tue, 3 Sep 2013 09:35:29 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1EF2D92-165B-11E3-89A7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233979>

"Uli Heller" <uli.heller@daemons-point.com> writes:

> When using git-svn in combination with serf-1.2.1 core dumps are
> created on termination. This is caused by a bug in serf, a fix for
> the bug exists (see https://code.google.com/p/serf/source/detail?r=2146).
> Nevertheless, I think it makes sense to fix the issue within the
> git perl module Ra.pm, too. The change frees the private copy of
> the remote access object on termination which prevents the error
> from happening.
>
> Note: Since subversion-1.8.0 and later do require serf-1.2.1 or later,
> the core dumps typically do show up when upgrading to a recent version
> of subversion.
>
> Credits: Jonathan Lambrechts for proposing a fix to Ra.pm.
> Evgeny Kotkov and Ivan Zhakov for fixing the issue in serf and
> pointing me to that fix.
> ---

Thanks.  Please sign-off your patch.

I am Cc'ing Kyle McKay who apparently had some experience working
with git-svn with newer svn that can only use serf, hoping that we
can get an independent opinion/test just to be sure.  Also Cc'ed is
Eric Wong who has been the official git-svn area expert, but I
understand that Eric hasn't needed to use git-svn for quite a while,
so it is perfectly fine if he does not have any comment on this one.

We may want to find a volunteer to move "git svn" forward as a new
area expert (aka subsystem maintainer), by the way.



>  perl/Git/SVN/Ra.pm | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index 75ecc42..78dd346 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -32,6 +32,11 @@ BEGIN {
>  	}
>  }
>
> +END {
> +	$RA = undef;
> +	$ra_invalid = 1;
> +}
> +
>  sub _auth_providers () {
>  	my @rv = (
>  	  SVN::Client::get_simple_provider(),
