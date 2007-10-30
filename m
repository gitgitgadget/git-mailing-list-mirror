From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Correct handling of upload-pack in builtin-fetch-pack
Date: Mon, 29 Oct 2007 22:41:23 -0400
Message-ID: <20071030024123.GW14735@spearce.org>
References: <Pine.LNX.4.64.0710292232330.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 03:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imh30-00047H-Ih
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 03:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbXJ3Cl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 22:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbXJ3Cl2
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 22:41:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54880 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbXJ3Cl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 22:41:28 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Imh2X-0002xr-3D; Mon, 29 Oct 2007 22:41:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 82E3B20FBAE; Mon, 29 Oct 2007 22:41:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710292232330.7357@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62650>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> The field in the args was being ignored in favor of a static constant
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> Found this while trying to figure out how builtin-fetch-pack was 
> initializing the string in the args struct, and why it generally worked 
> even though it wasn't.

Gahhh.  Yes, obviously correct fix.  Thanks!  :-)
 
> -static struct fetch_pack_args args;
> +static struct fetch_pack_args args = {
> +	/* .uploadpack = */ "git-upload-pack",
> +};
>  
>  static const char fetch_pack_usage[] =
>  "git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
> -static const char *uploadpack = "git-upload-pack";
>  
>  #define COMPLETE	(1U << 0)
>  #define COMMON		(1U << 1)
> @@ -773,7 +774,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
>  			st.st_mtime = 0;
>  	}
>  
> -	pid = git_connect(fd, (char *)dest, uploadpack,
> +	pid = git_connect(fd, (char *)dest, args.uploadpack,
>                            args.verbose ? CONNECT_VERBOSE : 0);
>  	if (pid < 0)
>  		return NULL;

-- 
Shawn.
