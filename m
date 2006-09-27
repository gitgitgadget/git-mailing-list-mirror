From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 11:11:02 -0400
Message-ID: <20060927151102.GC20705@spearce.org>
References: <20060926233321.GA17084@coredump.intra.peff.net> <20060927002745.15344.qmail@web51005.mail.yahoo.com> <20060927033459.GA27622@coredump.intra.peff.net> <20060926234309.b16aa44e.seanlkml@sympatico.ca> <20060927042850.GB9460@spearce.org> <7vfyedd3bw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 17:12:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSb4i-0002Yy-Qw
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 17:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWI0PLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 11:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWI0PLI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 11:11:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:21733 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964901AbWI0PLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 11:11:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSb3q-0003wt-Jl; Wed, 27 Sep 2006 11:10:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 251DC20FB28; Wed, 27 Sep 2006 11:11:02 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyedd3bw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27907>

Junio C Hamano <junkio@cox.net> wrote:
> One thing that makes "the common library code" less useful is
> that lock_ref_sha1() and its cousin lock_any_ref_for_update() do
> not let the caller to tell why a ref could not be locked ("did
> it not exist?  did the old_sha1 not match?"  and in
> lock_ref_sha1()'s case "did the ref have funny characters?").

Yes.  But I thought that in all such cases we use error or die so
the message is sent to STDERR before the process either terminates
or the function returns NULL.  So although the caller doesn't know
why the lock failed the end user does.

Git hasn't exactly structured its error messages in the past.
If we are talking about going down the path of having functions
return why they failed to the caller so the caller can react to
the failure as they see fit then we've got some work to do.  :)

> diff --git a/receive-pack.c b/receive-pack.c
> @@ -318,9 +258,11 @@ int main(int argc, char **argv)
>  	if (!dir)
>  		usage(receive_pack_usage);
>  
> -	if(!enter_repo(dir, 0))
> +	if (!enter_repo(dir, 0))
>  		die("'%s': unable to chdir or not a git archive", dir);
>  

You are missing:
+	setup_ident();

Without that reflog can't get the proper committer data from the
host's gecos information.  This is probably what is desired for
most pushes over SSH.

> +	git_config(git_default_config);
> +
>  	write_head_info();

-- 
Shawn.
