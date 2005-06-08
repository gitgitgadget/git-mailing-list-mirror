From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 8 Jun 2005 16:35:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
 <7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 01:31:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg9zu-0005D0-JZ
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 01:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFHXeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 19:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVFHXeG
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 19:34:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:11906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261393AbVFHXeC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 19:34:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j58NXhjA003214
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 16:33:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j58NXgnS024811;
	Wed, 8 Jun 2005 16:33:43 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 8 Jun 2005, Junio C Hamano wrote:
>  # Deleted in both.
> 
> Making sure that the path does not exist in the work tree with
> test -f "$4" would be more sensible, before running --remove.

Yeah, my (broken) thinking was that since it wasn't in both, it wasn't in 
the working directory either, but you're right, that's just crazy talk. 
There could be a stale file there.

Made it do a

	rm -f -- "$4" || exit 1

instead (and changed the other one to do the "|| exit 1" too, since you're 
also obviously right on the directory issue).

>  # Modified in both, but differently.
> +	merge -p "$src1" "$orig" "$src2" > "$4"
> 
> Again, make sure "$4" is not a directory before redirecting into
> it from merge, so that you can tell merge failures from it?

Hmm.. What's the cleanest way to check for redirection errors, but still
be able to distinguish those cleanly from "merge" itself returning an
error?

			Linus
