From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 7fb9de4a830dd8969bc17a219c509a76dd3c9aad
Date: Mon, 6 Jun 2005 09:01:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506060858140.1876@ppc970.osdl.org>
References: <20050606153940.20039.qmail@blackcubes.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 06 17:59:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfJxr-0005SA-Pw
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 17:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFFP7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 11:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVFFP7y
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 11:59:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:27021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261207AbVFFP73 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 11:59:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j56FxIjA016736
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 6 Jun 2005 08:59:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j56FxHQM000796;
	Mon, 6 Jun 2005 08:59:18 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <20050606153940.20039.qmail@blackcubes.dyndns.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 6 Jun 2005 jon@blackcubes.dyndns.org wrote:
>
> [PATCH] Modify git-rev-list to linearise the commit history in merge order.

Much nicer. Will apply after testing, however, not this part:

> @@ -110,6 +145,8 @@ static enum cmit_fmt get_commit_format(c
>  	if (!strcmp(arg, "=short"))
>  		return CMIT_FMT_SHORT;
>  	usage(rev_list_usage);	
> +
> +	return CMIT_FMT_DEFAULT;
>  }			
>  
>  

If you're bothered by a compiler warning (that I don't see, wonder why?),
please mark usage() and die() with "__attribute__ ((__noreturn__))". Make
it depend on GCC, ie

	#ifdef __GCC__
	#define NO_RETURN __attribute__((__noreturn__))
	#else
	#define NO_RETURN
	#endif

and then do

	extern void die(const char *, ...) NO_RETURN;

or something like that.

Anyway, that's indepdendent of this patch, but just fyi.

		Linus
