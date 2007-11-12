From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Call refresh_cache() when updating the user index for --only commits.
Date: Mon, 12 Nov 2007 15:01:54 -0800
Message-ID: <7vmytj1319.fsf@gitster.siamese.dyndns.org>
References: <1194900502-8987-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IriIQ-0003HM-0t
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 00:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399AbXKLXCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 18:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758119AbXKLXCF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 18:02:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41449 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399AbXKLXCE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 18:02:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 527032FA;
	Mon, 12 Nov 2007 18:02:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CABB594E7B;
	Mon, 12 Nov 2007 18:02:20 -0500 (EST)
In-Reply-To: <1194900502-8987-1-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Mon, 12 Nov 2007 15:48:22 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64729>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> We're guaranteeing the user that the index will be stat-clean after
> git commit. Thus, we need to call refresh_cache() for the user index =
too,
> in the 'git commit <paths>' case.
>
> Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> ---
>  builtin-commit.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 5011b8b..35205ef 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -109,6 +109,7 @@ static char *prepare_index(const char **files, co=
nst char *prefix)
> =20
>  	/* update the user index file */
>  	add_files_to_cache(verbose, prefix, files);
> +	refresh_cache(REFRESH_QUIET);
>  	if (write_cache(fd, active_cache, active_nr) || close(fd))
>  		die("unable to write new_index file");
> =20

Ah.  This is the real index file that is left for the user after
a partial commit "git-commit <path>" returns.

The other refresh_cache() after this one does not matter if we
did not have hook scripts, but it is not very easy to cheaply
detect if we are not going to run any hooks so let's leave it
there.=20

Thanks.
