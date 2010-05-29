From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 3/4] revert: allow cherry-picking a range of
 commits
Date: Sat, 29 May 2010 17:47:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1005291743300.1638@bonsai2>
References: <20100529043738.569.85482.chriscool@tuxfamily.org> <20100529044044.569.7874.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 29 17:47:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIOFr-0000H0-JL
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 17:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361Ab0E2PrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 11:47:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:38060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757191Ab0E2PrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 11:47:13 -0400
Received: (qmail invoked by alias); 29 May 2010 15:47:11 -0000
Received: from wrzb-5f758afe.pool.mediaWays.net (EHLO noname) [95.117.138.254]
  by mail.gmx.net (mp058) with SMTP; 29 May 2010 17:47:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GPgs4Kk7GogP6UwMJmdh0B3pY2dbQKhto0X55YJ
	x0ffYqwepuszbQ
X-X-Sender: gene099@bonsai2
In-Reply-To: <20100529044044.569.7874.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147971>

Hi,

On Sat, 29 May 2010, Christian Couder wrote:

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 70372dc..c281a80 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -545,6 +542,40 @@ static int revert_or_cherry_pick(int argc, const char **argv)
>  	if (read_cache() < 0)
>  		die("git %s: failed to read the index", me);
>  
> +	dotdot = strstr(commit_name, "..");
> +	if (dotdot) {
> +		struct rev_info revs;
> +		const char *argv[4];
> +		int argc = 0;
> +
> +		argv[argc++] = NULL;
> +		if (action != REVERT)
> +			argv[argc++] = "--reverse";
> +		argv[argc++] = commit_name;
> +		argv[argc++] = NULL;

Maybe "--no-merges"?

> +		init_revisions(&revs, NULL);
> +		setup_revisions(argc - 1, argv, &revs, NULL);
> +		if (prepare_revision_walk(&revs))
> +			die("revision walk setup failed");
> +
> +		if (!revs.commits)
> +			die("empty range passed");
> +
> +		while ( (commit = get_revision(&revs)) ) {

The style more in linet with the rest of the source code would be:

		while ((commit = get_revision(&revs))) {

The rest of the patch series looks very, very good to me. I totally agree 
that we do not have to implement the --abort and --continue for now, as 
well as the HEAD-detaching business we're used to from rebase and am.

Thanks,
Dscho
