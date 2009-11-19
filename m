From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v4] git remote: Separate usage strings for subcommands
Date: Thu, 19 Nov 2009 12:40:40 +0900
Message-ID: <20091119124040.6117@nanako3.lavabit.com>
References: <4B04B4A2.8090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, jrnieder@gmail.com,
	git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 04:40:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAxtA-0000mE-QY
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 04:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbZKSDkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 22:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbZKSDkn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 22:40:43 -0500
Received: from karen.lavabit.com ([72.249.41.33]:59814 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932334AbZKSDkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 22:40:42 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 2203F11B85F;
	Wed, 18 Nov 2009 21:40:49 -0600 (CST)
Received: from 3765.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 0SRLUZK1K85I; Wed, 18 Nov 2009 21:40:49 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=AWFyD8OJ3cnmvQ2XIzLgzJWyeZTIBkr8L26gbKyLtyvHfpR0A5l9uG2KzKb5kpAu1hBqUrO0A3JPck7IGGm5CGvCrWh1MiGvkazqZyzFKtTglZ69pFX1jiyFknz1Jnsgr459zPsdx7Z9qW22OrNQOUDPwkwFuvT50yp87uO17hs=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4B04B4A2.8090001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133210>

Quoting Tim Henigan <tim.henigan@gmail.com>

> When the usage string for a subcommand must be printed,
> only print the information relevant to that command.

I think this is a huge improvement.

> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 82a3d29..ee3dc80 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -9,14 +9,14 @@ git-remote - manage set of tracked repositories
>  SYNOPSIS
>  --------
>  [verse]
> -'git remote' [-v | --verbose]
> -'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
> +'git remote' [<options>]
> +'git remote add' [<options>] <name> <url>
>  'git remote rename' <old> <new>
>  'git remote rm' <name>
> -'git remote set-head' <name> [-a | -d | <branch>]
> -'git remote show' [-n] <name>
> -'git remote prune' [-n | --dry-run] <name>
> -'git remote update' [-p | --prune] [group | remote]...
> +'git remote set-head' <name> [<options>] [-a | -d | <branch>]
> +'git remote show' [<options>] <name>
> +'git remote prune' [<options>] <name>
> +'git remote update' [<options>] [<group> | <remote>]...

Often people look at this part of the manual page to quickly remind 
themselves what options are available, and it is better to keep the 
current text. Some manual pages have to use [options...] when there 
are too many to list, but each subcommand of git-remote doesn't have 
that many options.

> diff --git a/builtin-remote.c b/builtin-remote.c
> index 0777dd7..24a3ec0 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -7,18 +7,35 @@
>  #include "run-command.h"
>  #include "refs.h"
>  
> +#define REMOTE_BARE_USAGE "git remote [<options>]"
> +#define REMOTE_ADD_USAGE "git remote add [<options>] <name> <url>"
> +#define REMOTE_RENAME_USAGE "git remote rename <old> <new>"
> +#define REMOTE_RM_USAGE "git remote rm <name>"
> +#define REMOTE_SETHEAD_USAGE "git remote set-head <name> [-a | -d | <branch>]"
> +#define REMOTE_SHOW_USAGE "git remote show [<options>] <name>"
> +#define REMOTE_PRUNE_USAGE "git remote prune [<options>] <name>"
> +#define REMOTE_UPDATE_USAGE "git remote update [<options>] [<group> | <remote>]..."
> +
>  static const char * const builtin_remote_usage[] = {
> -	"git remote [-v | --verbose]",
> -	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
> -	"git remote rename <old> <new>",
> -	"git remote rm <name>",
> -	"git remote set-head <name> [-a | -d | <branch>]",
> -	"git remote show [-n] <name>",
> -	"git remote prune [-n | --dry-run] <name>",
> -	"git remote [-v | --verbose] update [-p | --prune] [group]",
> +	REMOTE_BARE_USAGE,
> +	REMOTE_ADD_USAGE,
> +	REMOTE_RENAME_USAGE,
> +	REMOTE_RM_USAGE,
> +	REMOTE_SETHEAD_USAGE,
> +	REMOTE_SHOW_USAGE,
> +	REMOTE_PRUNE_USAGE,
> +	REMOTE_UPDATE_USAGE,
>  	NULL
>  };

For the same reason, I don't think this is a good change, if these
lines are used to show the first lines of 'git-remote -h' output.
