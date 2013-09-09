From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: Fix termination issues for remote svn   connections
Date: Mon, 09 Sep 2013 08:42:10 -0700
Message-ID: <xmqqfvtd1u7n.fsf@gitster.dls.corp.google.com>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106>
	<xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
	<A46AD76E-56FA-4555-8811-6141284300DD@gmail.com>
	<07b9b270090d6b42515c5dc3dfb8ab4f.squirrel@83.236.132.106>
	<9D2EC674-887A-479B-B8FB-3EFEAC391435@gmail.com>
	<f2fe486a6ca0bf40be4489bfe888d517.squirrel@83.236.132.106>
	<xmqqa9jpzyvo.fsf@gitster.dls.corp.google.com>
	<522D643E.2000901@daemons-point.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Uli Heller <uli.heller@daemons-point.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:55:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAMg-0004va-19
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039Ab3IIWzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:55:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028Ab3IIWzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:55:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03E2540337;
	Mon,  9 Sep 2013 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=X/Ajja71Ok6J+L10xL5C75aCoU4=; b=uaHYl992aLFgMojDZNfH
	iXOvEhTAzU/Z2PS750O/xum+0WO1GDlX7z8FATCrzE/18sFqtWzCIVXCQ9EuOWm7
	+bbwG745z0+mcoJejqyMT1c1C8N2qBLxgGA1udxBvzB7Soe9LZP1hheM7CBey2lm
	j5ZbIagRvwA+5qBWzKqUXoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DpqXK2TcrV4fkNrKBcKr48/ayqlQ4ymqzQKAO2GWHgBuM1
	20Ddt79FzMNC+kOmALz2yaRIyPamS6/jdNbuYH6uQ+Qu5yyNhN1nl2LnhmxWa/vS
	jdkB7Y/NydGgONjWrgbRanZYKHHS6tr/Exq7L+EhMLz+ccJ/EZvjitpdEc/JQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D01B240335;
	Mon,  9 Sep 2013 22:55:12 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7411840328;
	Mon,  9 Sep 2013 22:55:10 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E148B9E4-19A2-11E3-8AED-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234396>

Uli Heller <uli.heller@daemons-point.com> writes:

> From a763550fc59b756580f9b162839d2737c27f2fe3 Mon Sep 17 00:00:00 2001
> From: Uli Heller <uli.heller@daemons-point.com>
> Date: Tue, 3 Sep 2013 09:14:03 +0200
> Subject: [PATCH] git-svn: Fix termination issues for remote svn connections

None of the above need to be in the e-mail body (the first one must
not be in the e-mail body, and the other three are redundant).

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
> Junio C Hamano for proposing a great code comment.
> Kyle J. McKay for testing against latest serf (1.3.1).
> ... and various others - thanks!
> ---

Hmph, the only change I see relative to the version in the message
you are responding to is reversion of the proposed commit log
message rewrite I did, and missing sign-off from you, and the latter
of which matters most.

I'd keep the one queued on 'pu' 73ffac3b (git-svn: fix termination
issues for remote svn connections, 2013-09-03) for now.

Thanks.

>  perl/Git/SVN/Ra.pm | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index 75ecc42..a7b0119 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -32,6 +32,14 @@ BEGIN {
>         }
>  }
>
> +# serf has a bug that leads to a coredump upon termination if the
> +# remote access object is left around (not fixed yet in serf 1.3.1).
> +# Explicitly free it to work around the issue.
> +END {
> +       $RA = undef;
> +       $ra_invalid = 1;
> +}
> +
>  sub _auth_providers () {
>         my @rv = (
>           SVN::Client::get_simple_provider(),
