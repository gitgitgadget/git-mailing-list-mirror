From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change double quotes to single quotes in message
Date: Sat, 21 Mar 2009 14:07:20 -0700
Message-ID: <7v3ad6egaf.fsf@gitster.siamese.dyndns.org>
References: <877i2j6y6b.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Mar 21 22:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8R7-0006o6-13
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbZCUVH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbZCUVH1
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:07:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbZCUVH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:07:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EF83280DA;
	Sat, 21 Mar 2009 17:07:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40B1C80D8; Sat,
 21 Mar 2009 17:07:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 46E20F98-165C-11DE-A00E-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114057>

Jari Aalto <jari.aalto@cante.net> writes:

> From 6daec692a39a1ecf0452f1ad1eb7ba6fbf5661c9 Mon Sep 17 00:00:00 2001
> From: Jari Aalto <jari.aalto@cante.net>
> Date: Sat, 21 Mar 2009 11:00:54 +0200
> Subject: [PATCH] Change double quotes to single quotes in message
>
> This helps selecting the text inside quotes by using mouse double-click
> action (e.g. in Putty). Functions affected: update_refs_for_switch(),
> update_refs_for_switch() and cmd_checkout().
> ---

The patch is good.

Lacks sign-off, has extra header lines in body, and the justification can
be a lot stronger.  The three you identified are the only ones among 30
hits from:

    $ git grep -n -e "printf(.*\".*['\"]%s" -- '*.c'

that use dq around the path-like things, while all others use sq.  There
also are a few similar constructs using strbuf_addf all of which use sq.
Consistency is good.

>  builtin-checkout.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index 9fdfc58..49daade 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -503,10 +503,10 @@ static void update_refs_for_switch(struct checkout_opts *opts,
>  		create_symref("HEAD", new->path, msg.buf);
>  		if (!opts->quiet) {
>  			if (old->path && !strcmp(new->path, old->path))
> -				fprintf(stderr, "Already on \"%s\"\n",
> +				fprintf(stderr, "Already on '%s'\n",
>  					new->name);
>  			else
> -				fprintf(stderr, "Switched to%s branch \"%s\"\n",
> +				fprintf(stderr, "Switched to%s branch '%s'\n",
>  					opts->new_branch ? " a new" : "",
>  					new->name);
>  		}
> @@ -515,7 +515,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
>  			   REF_NODEREF, DIE_ON_ERR);
>  		if (!opts->quiet) {
>  			if (old->path)
> -				fprintf(stderr, "Note: moving to \"%s\" which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
> +				fprintf(stderr, "Note: moving to '%s' which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
>  			describe_detached_head("HEAD is now at", new->commit);
>  		}
>  	}
> -- 
> 1.6.1.3
