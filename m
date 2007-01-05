From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 05 Jan 2007 14:48:36 -0800
Message-ID: <7vac0xdr97.fsf@assigned-by-dhcp.cox.net>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	<Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	<7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
	<7v1wmalez6.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
	<7vbqldfg56.fsf@assigned-by-dhcp.cox.net>
	<204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
	<20070105193958.GE8753@spearce.org>
	<7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701051354590.3661@woody.osdl.org>
	<Pine.LNX.4.64.0701051439060.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Chris Lee <chris133@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 05 23:48:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2xre-0005bz-Ls
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 23:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbXAEWsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 17:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXAEWsi
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 17:48:38 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43647 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbXAEWsh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 17:48:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105224837.RSXI16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 17:48:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7ano1W0041kojtg0000000; Fri, 05 Jan 2007 17:47:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701051439060.3661@woody.osdl.org> (Linus
	Torvalds's message of "Fri, 5 Jan 2007 14:39:54 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36036>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 5 Jan 2007, Linus Torvalds wrote:
>> 
>> Heh. Maybe we should just make the default the other way? It's probably 
>> pretty easy to find any users that suddenly start segfaulting ;)
>
> This seems to pass all the tests, at least.
>
> (But I didn't test the SVN stuff, since I don't have perl::SVN installed)

I do not think we have too many branch refs (builtin-branch and
builtin-show-branch) for this patch to make any practical
difference, but I wonder why this is needed...

> diff --git a/merge-recursive.c b/merge-recursive.c
> index bac16f5..b98ed1a 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1286,6 +1286,7 @@ int main(int argc, char *argv[])
>  	const char *branch1, *branch2;
>  	struct commit *result, *h1, *h2;
>  
> +	save_commit_buffer = 1;
>  	git_config(git_default_config); /* core.filemode */
>  	original_index_file = getenv(INDEX_ENVIRONMENT);

Ah, there are those annoying "using this as the merge base whose
commit log is..." business.  I wonder if anybody is actually
reading them (I once considered squelching that output).
