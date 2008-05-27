From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 3/5] Make verbosity configurable in reset_index_file()
Date: Tue, 27 May 2008 10:08:01 -0400
Message-ID: <1211897281.13838.1.camel@gaara.bos.redhat.com>
References: <cover.1211586801.git.vmiklos@frugalware.org>
	 <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org>
	 <28874c24faf45e6e4499c9692cc1de1e93cd4dcf.1211586801.git.vmiklos@frugalware.org>
	 <dace39a3a72957bec9a7f4b8528b08fc7fbe3341.1211586801.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue May 27 16:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0zrW-0005h2-NH
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 16:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129AbYE0OIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 10:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbYE0OIX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 10:08:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50154 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755996AbYE0OIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 10:08:22 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4RE8AkH005746;
	Tue, 27 May 2008 10:08:10 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4RE89id012802;
	Tue, 27 May 2008 10:08:09 -0400
Received: from [10.16.3.198] (dhcp-100-3-198.bos.redhat.com [10.16.3.198])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4RE897W016240;
	Tue, 27 May 2008 10:08:09 -0400
In-Reply-To: <dace39a3a72957bec9a7f4b8528b08fc7fbe3341.1211586801.git.vmiklos@frugalware.org>
X-Mailer: Evolution 2.22.0 (2.22.0-4.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83017>

On Sat, 2008-05-24 at 02:01 +0200, Miklos Vajna wrote:
> Till now reset_index_file() was always verbose. Add a new argument to be
> able to disable this behaviour.
> 
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  builtin-reset.c |    2 +-
>  reset.c         |    5 +++--
>  reset.h         |    2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin-reset.c b/builtin-reset.c
> index 6e6e168..179c59c 100644
> --- a/builtin-reset.c
> +++ b/builtin-reset.c
> @@ -216,7 +216,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  		if (is_merge() || read_cache() < 0 || unmerged_cache())
>  			die("Cannot do a soft reset in the middle of a merge.");
>  	}
> -	else if (reset_index_file(sha1, (reset_type == HARD)))
> +	else if (reset_index_file(sha1, (reset_type == HARD), 1))
>  		die("Could not reset index file to revision '%s'.", rev);
>  
>  	/* Any resets update HEAD to the head being switched to,
> diff --git a/reset.c b/reset.c
> index a75fec6..baae947 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -11,13 +11,14 @@
>  #include "cache.h"
>  #include "run-command.h"
>  
> -int reset_index_file(const unsigned char *sha1, int is_hard_reset)
> +int reset_index_file(const unsigned char *sha1, int is_hard_reset, int verbose)

I would suggest using flags here instead of a bunch of boolean args.
Consider the readability of

    reset_index_file(sha1, 1, 1);

vs

    reset_index_file(sha1, RESET_HARD | RESET_VERBOSE);

cheers,
Kristian
