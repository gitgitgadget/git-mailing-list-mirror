From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Wed, 30 Apr 2014 08:38:57 -0700
Message-ID: <xmqqbnvihlny.fsf@gitster.dls.corp.google.com>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
	<1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>, d9ba@mailtor.net,
	jrnieder@gmail.com, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 30 17:39:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfWbE-0006Yf-TT
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 17:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933732AbaD3PjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 11:39:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933648AbaD3PjC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 11:39:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AB597FCA9;
	Wed, 30 Apr 2014 11:39:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y/iArj3kZjaTeCOpchSAPJW3DGc=; b=a5CCjR
	5BDJ/ROKgnoBTzwl5xdDTDi7a8/ycu9UaIDFK5bRjYQt7jzkPgtCmSrYUvclWFhC
	LSOKtpe8X7/NDpfgHgrBnPYwqR+KZvkd51TrXRxTqdHxP+96JLg+Gd1iUCHCla5q
	0KEckppjaDtCYumwsePQEvq32RI7p9+qYZpb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U4BTn/nm1NiiesIcjumPVOJzLcjBJVXs
	7fcMNvE05Z/d0mZVynhsUoVHG6x6aVKcgi1WlXXL9FQTZ8hzu1DcqZ9j0qwiDZ4f
	e6/FWSsHa4vKoU5k6gf5T710kSGGRnB3sgP8Z/MgXUXpGq/rOPHr5udNF0kOEBFb
	N5CdqY0cO0U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 803357FCA8;
	Wed, 30 Apr 2014 11:39:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 518737FCA3;
	Wed, 30 Apr 2014 11:38:59 -0400 (EDT)
In-Reply-To: <1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 30 Apr 2014 09:35:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C41E44C-D07D-11E3-913C-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247722>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> By default, Git used to set $LESS to -FRSX if $LESS was not set by the
> user. The FRX flags actually make sense for Git (F and X because Git
> sometimes pipes short output to less, and R because Git pipes colored
> output). The S flag (chop long lines), on the other hand, is not related
> to Git and is a matter of user preference. Git should not decide for the
> user to change LESS's default.

Git always pipes its output to less, not just "sometimes pipes short
ones" ;-)  "because the output may be short" would be more accurate
and would convey the same thing.

But that is just nitpicking.  The patch looks totally agreeable.

I am inclined to suggest queuing it for the first batch after 2.0
instead of directly applying to 'master', as we have past the point
we can expect to see reports of unexpected fallouts and fix the
issues in time for the final.

Thanks.

> More specifically, the S flag harms users who review untrusted code
> within a pager, since a patch looking like:
>
> -old code;
> +new good code; [... lots of tabs ...] malicious code;
>
> would appear identical to:
>
> -old code;
> +new good code;
>
> Users who prefer the old behavior can still set the $LESS environment
> variable to -FRSX explicitly, or set core.pager to 'less -S'.
>
> The documentation in config.txt is made a bit longer to keep both an
> example setting the 'S' flag (needed to recover the old behavior) and an
> example showing how to unset a flag set by Git.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This is just a rewrite of PATCH v1 on top of master instead of pu.
>
>  Documentation/config.txt | 13 ++++++++-----
>  git-sh-setup.sh          |  2 +-
>  pager.c                  |  2 +-
>  perl/Git/SVN/Log.pm      |  2 +-
>  4 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 73c8973..5484d9d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -553,14 +553,17 @@ core.pager::
>  	configuration, then `$PAGER`, and then the default chosen at
>  	compile time (usually 'less').
>  +
> -When the `LESS` environment variable is unset, Git sets it to `FRSX`
> +When the `LESS` environment variable is unset, Git sets it to `FRX`
>  (if `LESS` environment variable is set, Git does not change it at
>  all).  If you want to selectively override Git's default setting
> -for `LESS`, you can set `core.pager` to e.g. `less -+S`.  This will
> +for `LESS`, you can set `core.pager` to e.g. `less -S`.  This will
>  be passed to the shell by Git, which will translate the final
> -command to `LESS=FRSX less -+S`. The environment tells the command
> -to set the `S` option to chop long lines but the command line
> -resets it to the default to fold long lines.
> +command to `LESS=FRX less -S`. The environment does not set the
> +`S` option but the command line does, instructing less to truncate
> +long lines. Similarly, setting `core.pager` to `less -+F` will
> +deactivate the `F` option specified by the environment from the
> +command-line, deactivating the "quit if one screen" behavior of
> +`less`.
>  +
>  Likewise, when the `LV` environment variable is unset, Git sets it
>  to `-c`.  You can override this setting by exporting `LV` with
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 5f28b32..9447980 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -160,7 +160,7 @@ git_pager() {
>  	else
>  		GIT_PAGER=cat
>  	fi
> -	: ${LESS=-FRSX}
> +	: ${LESS=-FRX}
>  	: ${LV=-c}
>  	export LESS LV
>  
> diff --git a/pager.c b/pager.c
> index 0cc75a8..f75e8ae 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -85,7 +85,7 @@ void setup_pager(void)
>  		int i = 0;
>  
>  		if (!getenv("LESS"))
> -			env[i++] = "LESS=FRSX";
> +			env[i++] = "LESS=FRX";
>  		if (!getenv("LV"))
>  			env[i++] = "LV=-c";
>  		env[i] = NULL;
> diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
> index 34f2869..6641053 100644
> --- a/perl/Git/SVN/Log.pm
> +++ b/perl/Git/SVN/Log.pm
> @@ -116,7 +116,7 @@ sub run_pager {
>  		return;
>  	}
>  	open STDIN, '<&', $rfd or fatal "Can't redirect stdin: $!";
> -	$ENV{LESS} ||= 'FRSX';
> +	$ENV{LESS} ||= 'FRX';
>  	$ENV{LV} ||= '-c';
>  	exec $pager or fatal "Can't run pager: $! ($pager)";
>  }
