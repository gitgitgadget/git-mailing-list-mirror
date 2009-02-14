From: "Jan =?iso-8859-1?Q?Kr=FCger?=" <jk@jk.gs>
Subject: Re: [PATCH] gc: make --prune useful again by accepting an optional 
     parameter
Date: Sat, 14 Feb 2009 22:33:12 +0100 (CET)
Message-ID: <3651.78.34.159.109.1234647192.squirrel@heapsort.de>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch>
    <20090214025115.615119bf@perceptron>
    <alpine.DEB.1.00.0902140642520.10279@pacific.mpi-cbg.de>
    <20090214074954.7e423dd2@perceptron>
    <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Rast" <trast@student.ethz.ch>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:34:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYSA2-0000mo-9W
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbZBNVdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbZBNVdP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:33:15 -0500
Received: from zoidberg.org ([88.198.6.61]:60741 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510AbZBNVdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:33:14 -0500
Received: from localhost (localhost [127.0.0.1])
  (uid 33)
  by cthulhu.zoidberg.org with local; Sat, 14 Feb 2009 22:33:12 +0100
  id 004244EB.49973898.0000666B
Received: from 78.34.159.109
        (SquirrelMail authenticated user jast)
        by heapsort.de with HTTP;
        Sat, 14 Feb 2009 22:33:12 +0100 (CET)
In-Reply-To: <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109936>

Hi,

> With this patch, "git gc --no-prune" will not prune any loose (and
> dangling) object, and "git gc --prune=5.minutes.ago" will prune
> all loose objects older than 5 minutes.

I like it, so disregard my patch.

> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 7086eea..fcef5fb 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local
> repository
>
>  SYNOPSIS
>  --------
> -'git gc' [--aggressive] [--auto] [--quiet]
> +'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date>]

Maybe add --no-prune too.

>
>  DESCRIPTION
>  -----------
> @@ -59,6 +59,13 @@ are consolidated into a single pack by using the `-A`
> option of
>  'git-repack'. Setting `gc.autopacklimit` to 0 disables
>  automatic consolidation of packs.
>
> +--prune=<date>::
> +	Prune loose objects older than date (default is 2 weeks ago).
> +	This option is on by default.

Maybe refer to the config option at least briefly.

> +
> +--no-prune::
> +	Do not prune any loose objects.
> +
>  --quiet::
>  	Suppress all progress reports.
>
> diff --git a/builtin-gc.c b/builtin-gc.c
> index a201438..a962f38 100644
> --- a/builtin-gc.c
> +++ b/builtin-gc.c
> [snip]
> @@ -173,14 +174,15 @@ static int need_to_gc(void)
>
>  int cmd_gc(int argc, const char **argv, const char *prefix)
>  {
> -	int prune = 0;
>  	int aggressive = 0;
>  	int auto_gc = 0;
>  	int quiet = 0;
>  	char buf[80];
>
>  	struct option builtin_gc_options[] = {
> -		OPT_BOOLEAN(0, "prune", &prune, "prune unreferenced objects
> (deprecated)"),
> +		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
> +			"prune unreferenced objects (deprecated)",

If you actually make it useful again shouldn't we stop marking it as
deprecated?

-Jan
