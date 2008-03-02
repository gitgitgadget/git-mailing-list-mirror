From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Re* [PATCH] git-submodule: Don't blame when git-describe fails
Date: Sun, 2 Mar 2008 17:41:52 -0500
Message-ID: <20080302224152.GC8410@spearce.org>
References: <1204469152-24227-1-git-send-email-pkufranky@gmail.com> <7vy791oyqa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 23:42:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVwt9-0005Rv-4w
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 23:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbYCBWl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 17:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbYCBWl6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 17:41:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58003 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbYCBWl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 17:41:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVwsK-0005X8-E5; Sun, 02 Mar 2008 17:41:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 753BC20FBAE; Sun,  2 Mar 2008 17:41:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vy791oyqa.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75852>

Junio C Hamano <gitster@pobox.com> wrote:
> -- >8 --
> describe --always: fall back to showing an abbreviated object name
...
> diff --git a/builtin-describe.c b/builtin-describe.c
> index 05e309f..c1182a3 100644
> --- a/builtin-describe.c
> +++ b/builtin-describe.c
> @@ -146,6 +147,17 @@ static unsigned long finish_depth_computation(
>  	return seen_commits;
>  }
>  
> +static void cannot_describe(const unsigned char *sha1) NORETURN;
> +
> +static void cannot_describe(const unsigned char *sha1)
> +{
> +	if (always) {
> +		printf("%s\n", find_unique_abbrev(sha1, DEFAULT_ABBREV));

This should be "abbrev" not "DEFAULT_ABBREV" as then we honor the
command line "describe --always --abbrev=16" (for example).

> @@ -278,6 +290,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  			    "consider <n> most recent tags (default: 10)"),
>  		OPT_STRING(0, "match",       &pattern, "pattern",
>  			   "only consider tags matching <pattern>"),
> +		OPT_BOOLEAN(0, "always",     &always,
> +			   "show abbreviated commit object as fallback"),
>  		OPT_END(),
>  	};
  
Sadly I cannot come up with a better name for this option.  :-(

-- 
Shawn.
