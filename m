From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Fix memory leaks in read_tree_recursive()
Date: Thu, 5 May 2005 02:08:15 +0200
Message-ID: <20050505000815.GA25992@diku.dk>
References: <20050504231959.GA25475@diku.dk> <7vpsw6muay.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 02:26:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTUBe-0003dJ-8y
	for gcvg-git@gmane.org; Thu, 05 May 2005 02:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVEEAcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 20:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVEEAcV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 20:32:21 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:32200 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261976AbVEEAcP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 20:32:15 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id ECA7D6E1993; Thu,  5 May 2005 02:07:10 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 6EAB16E2F0F; Thu,  5 May 2005 02:07:10 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 824B661FDE; Thu,  5 May 2005 02:08:15 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vpsw6muay.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote Wed, May 04, 2005:
> >>>>> "JF" == Jonas Fonseca <fonseca@diku.dk> writes:
> 
> JF> This patch fixes memory leaks in the error path of
> JF> read_tree_recursive().
> 
> The leak seems to be real but what is "mem_free"?

That mem_free() was a bad habbit from the project I usually work on.

> Has it been compile tested?

No, but the second patch has.

BTW, when compiling git on a FreeBSD box I get these warnings:

date.c: In function `parse_date':
date.c:414: warning: long unsigned int format, time_t arg (arg 4)
date.c:414: warning: long unsigned int format, time_t arg (arg 4)
date.c: In function `datestamp':
date.c:427: warning: long unsigned int format, time_t arg (arg 4)
date.c:427: warning: long unsigned int format, time_t arg (arg 4)
tar-tree.c: In function `write_header':
tar-tree.c:249: warning: long unsigned int format, time_t arg (arg 3)
local-pull.c: In function `fetch':
local-pull.c:73: warning: long int format, different type arg (arg 4)

because time_t is defined as int32_t.  Don't know if they are worth
fixing at this point.

> JF> @@ -39,14 +39,18 @@
> JF>  		if (S_ISDIR(mode)) {
> JF>  			int retval;
>  
> JF> ...
> JF> -			if (!eltbuf || strcmp(elttype, "tree"))
> JF> +			if (!eltbuf || strcmp(elttype, "tree")) {
> JF> +				if (eltbuf) mem_free(eltbuf);
> JF>  				return -1;
> 
> Btw, who is putting this header in your mail?  It does not make
> sense to me unless Jonas is pseudonym for Linus...
> 
>   Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org 

Maybe because Mutt knows I am subscribe to this mailing list and assumes
I don't want to have mail addressed directly to my email address?

I just hit 'g'.

-- 
Jonas Fonseca
