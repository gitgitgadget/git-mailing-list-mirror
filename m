From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cloning speed comparison, round II
Date: Sat, 12 Nov 2005 11:40:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511121134170.3263@g5.osdl.org>
References: <20051112155302.GD30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 20:41:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb1Ee-0003H3-Gj
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 20:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVKLTkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 14:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVKLTkV
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 14:40:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41637 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932477AbVKLTkU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 14:40:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jACJeCnO008855
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 12 Nov 2005 11:40:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jACJeBPB008823;
	Sat, 12 Nov 2005 11:40:11 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051112155302.GD30496@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11699>



On Sat, 12 Nov 2005, Petr Baudis wrote:
>
>              rsync   git+ssh(*)   git(**)   http
> 
> git.git      0m45s   0m34s        5m30s     4m01s (++)
> 
> cogito.git   2m09s   1m54s (+)    4m30s     15m11s (only single run)
> 
> 
> (*) git+ssh was to master.kernel.org, which was under significant load
>     from some seemingly runaway gzip process, so that slowed things
>     down.
> 
> (**) The unpacking was slooooooooow yet the load was quite low. This
>      should be investigated, the native git fetching is much slower
>      than even HTTP.

git:// and git+ssh:// should be the exact same protocol, the main 
difference in this case being the server they go to.

In the case of (**), the unpacking itself is fast, but it's done as the 
stream of data comes in, so it will appear slow if the server at the other 
end is slow (or the network to that server is slow).

So I think the difference between your git+ssh and git tests are purely 
due to the fact that master.kernel.org sees a lot less load (both in CPU 
and in networking) than the public sites, and the time differences have 
nothing to do with the protocol per se.

I suspect master.kernel.org also has a beefier machine with more memory 
(but even if that's not the case, it's simply true that the public 
machines obviously do mirroring to a lot of other machines, and run things 
like webgit and just basic serving too).

If anything, git:// as a protocol is theoretically a bit faster, since the 
login procedure is faster and there's no encryption overhead.

			Linus
