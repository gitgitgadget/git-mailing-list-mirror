From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-checkout: fix argument parsing to detect ambiguous
 arguments.
Date: Wed, 23 Jul 2008 02:17:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230215480.8986@racer>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 03:18:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLT0F-0004Ja-UO
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbYGWBRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYGWBRw
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:17:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:53295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718AbYGWBRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:17:52 -0400
Received: (qmail invoked by alias); 23 Jul 2008 01:17:50 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp011) with SMTP; 23 Jul 2008 03:17:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aT5E0NfTag7PUV/ecQzYPd8gy7LBcthgpZCm55E
	1ZMo5LfmlHp9YX
X-X-Sender: gene099@racer
In-Reply-To: <1216774940-4955-1-git-send-email-madcoder@debian.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89590>

Hi,

On Wed, 23 Jul 2008, Pierre Habouzit wrote:

> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index fbd5105..1490e8e 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -438,9 +438,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  
>  	opts.track = git_branch_track;
>  
> -	argc = parse_options(argc, argv, options, checkout_usage, 0);
> -	if (argc) {
> +	argc = parse_options(argc, argv, options, checkout_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (argc && strcmp(argv[0], "--")) {
>  		arg = argv[0];
> +
> +		if (argc == 1 || strcmp(argv[1], "--"))
> +			verify_non_filename(NULL, arg);

Why "argc == 1"?  Should "git checkout <path>" really fail?  That would be 
a change in behavior that _would_ hit me.

However, you may want to verify_non_filename() when argc == 1 _and_ 
get_sha1() succeeded.  Because then, <path> is ambiguous.

Ciao,
Dscho
