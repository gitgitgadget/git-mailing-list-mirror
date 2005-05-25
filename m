From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Tue, 24 May 2005 18:00:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 02:57:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DakD1-0006CF-FE
	for gcvg-git@gmane.org; Wed, 25 May 2005 02:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVEYA66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 20:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVEYA66
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 20:58:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:11703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261210AbVEYA6z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 20:58:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4P0wojA007556
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 17:58:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4P0wnTx028392;
	Tue, 24 May 2005 17:58:50 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Junio C Hamano wrote:
>
> It advertises the path restriction in documentation and usage
> string, but the argument parsing code was not updated and was
> causing it to refuse to run.  One liner fix is here.

No, it's more broken than that. Look at how it uses "argv[1]" for the tree
SHA1, then does "argv++" and then uses "argv[1]" (which is a totally
different argument entirely) for error reporting when the tree SHA1 is bad

> -	while (argc > 2) {
> +	while (1 < argc && argv[1][0] == '-') {

Btw, that "1 < argc" order is very unintuitive to most humans. Like it or 
not, people get used to things one way, and have a hard time seeing what 
it means when it's the other way around.

And when people have a hard time seeing what it means, you get more bugs.

This is why it is _not_ better to do 

	if (1 == a)

like some people teach, even if that protects against the "single equal
sign" bug. There are better ways to protect against that one bug (like
having compiler warnings enabled) that don't make the code less obvious.

		Linus
