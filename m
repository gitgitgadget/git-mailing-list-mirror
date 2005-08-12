From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fetch-pack: start multi-head pulling.
Date: Fri, 12 Aug 2005 09:12:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508120858420.3295@g5.osdl.org>
References: <7vwtmr4hm5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 18:14:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3c9b-0004W8-Lp
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 18:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVHLQNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 12:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVHLQNE
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 12:13:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751213AbVHLQND (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 12:13:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7CGCwjA019487
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 09:12:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7CGCvaU026895;
	Fri, 12 Aug 2005 09:12:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtmr4hm5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.43__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 12 Aug 2005, Junio C Hamano wrote:
>
> Linus, I need a bit of guidance from you about this one; an
> ancient commit 4f7770c87ce3c302e1639a7737a6d2531fe4b160 removed
> the multi-head support fetch-pack once had, labelling it as "a
> misguided attempt", and I would like to know if I am making the
> same misguided attempt again.  This update actually makes
> clone-pack almost redundant.

I like your version.

My misguided attempt was not the ability to pull multiple heads, but what 
to _do_ with them. I originally envisioned something more "git-push-pack" 
like, where it would pull multiple heads into real references, and _that_ 
was the misguided part. I then ended up just printing it out to stdout, 
and that made it "one ref only".

Your version where you just print out multiple heads with names is, I 
think, the right thing to do.

The shell script looks a bit unreadable to me, personally.

>  	head=$(git-fetch-pack "$merge_repo" "$merge_head")
> +	if h=`expr "$head" : '\([^ ][^ ]*\) '`
> +	then
> +	    head=$h
> +	fi

Back-ticks, and the ":" operator to "expr". You really _are_ old-fashioned 
when it comes to shell ;)

Wouldn't it be simpler/cleaner to just do

	head=($(git-fetch-pack "$merge_repo" "$merge_head"))

which gets you "$head" being the same as ${head[0]}, namely the SHA1 you 
want (and if you ever implement multi-head pulling, you'll have it all in 
${head[..]}..)

			Linus
