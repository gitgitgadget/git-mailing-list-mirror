From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] mv: honor --verbose flag
Date: Mon, 12 Dec 2011 11:53:28 -0800
Message-ID: <7vwra136tj.fsf@alter.siamese.dyndns.org>
References: <20111212074503.GB16511@sigill.intra.peff.net>
 <20111212075124.GB17532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:53:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaBwN-00036Q-Ch
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab1LLTxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:53:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918Ab1LLTxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:53:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0C9D5FF6;
	Mon, 12 Dec 2011 14:53:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6N4DFWcOKMJwg2Oo6IemMa4xkpY=; b=PAkK/Q
	biAmn5i4svbyZ0ie+4ugoRRjhvOVXegoG+Ih8/FGjABqNR/ognjoEUUtZmLrXA4v
	zQ/H0brY6KyEwLscfnSxVkuCy3UXCTo1GpsC2XYBGE2qfu/VDErizeGD1/sDry/J
	rhQvFCc24t8uGFMeFBRJ9xF+KVlZ8PnNoxwDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kGXsbWLfCMadhUviAH28BcEzh19z3QLI
	xiihTwb3tvuIac2+fBociQDeLCkwi+IKSB64vZfWDlxJ5lcNyrgzYrMm9Vaoz3DV
	us3h78qOt5QXNNq5enDqO7dEYA0K1vF6/dPfnEUWhPmAE8DNtGprFq0KSlRvI3vs
	jz4D15ojpmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D87A55FF5;
	Mon, 12 Dec 2011 14:53:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BCA05FED; Mon, 12 Dec 2011
 14:53:29 -0500 (EST)
In-Reply-To: <20111212075124.GB17532@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Dec 2011 02:51:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F68B65D4-24FA-11E1-AACE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186940>

Jeff King <peff@peff.net> writes:

> The code for a verbose flag has been here since "git mv" was
> converted to C many years ago, but actually getting the "-v"
> flag from the command line was accidentally lost in the
> transition.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This has been broken since 2006, so I guess nobody really cares. But
> it's simple to fix.

Heh. It means nobody exercised the codepaths that are inside "if (verbose)",
so it may uncover old bugs, no?

>  Documentation/git-mv.txt |    8 ++++++--
>  builtin/mv.c             |    1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
> index 4be7a71..e3c8448 100644
> --- a/Documentation/git-mv.txt
> +++ b/Documentation/git-mv.txt
> @@ -15,8 +15,8 @@ DESCRIPTION
>  -----------
>  This script is used to move or rename a file, directory or symlink.
>  
> - git mv [-f] [-n] [-k] <source> <destination>
> - git mv [-f] [-n] [-k] <source> ... <destination directory>
> + git mv [-v] [-f] [-n] [-k] <source> <destination>
> + git mv [-v] [-f] [-n] [-k] <source> ... <destination directory>
>  
>  In the first form, it renames <source>, which must exist and be either
>  a file, symlink or directory, to <destination>.
> @@ -40,6 +40,10 @@ OPTIONS
>  --dry-run::
>  	Do nothing; only show what would happen
>  
> +-v::
> +--verbose::
> +	Report the names of files as they are moved.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 5efe6c5..11abaf5 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -59,6 +59,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	int i, newfd;
>  	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
>  	struct option builtin_mv_options[] = {
> +		OPT__VERBOSE(&verbose, "be verbose"),
>  		OPT__DRY_RUN(&show_only, "dry run"),
>  		OPT__FORCE(&force, "force move/rename even if target exists"),
>  		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
