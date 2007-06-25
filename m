From: Junio C Hamano <gitster@pobox.com>
Subject: Re: DWIM ref names for push/fetch
Date: Sun, 24 Jun 2007 23:10:56 -0700
Message-ID: <7vodj4o973.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706241808550.4740@iabervon.org>
	<7v3b0gq4id.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0706242234250.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 08:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2hmw-0007gb-1F
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 08:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbXFYGK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 02:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbXFYGK6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 02:10:58 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38248 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbXFYGK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 02:10:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625061057.TDTL3339.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 02:10:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FiAw1X0051kojtg0000000; Mon, 25 Jun 2007 02:10:57 -0400
In-Reply-To: <Pine.LNX.4.64.0706242234250.4740@iabervon.org> (Daniel
	Barkalow's message of "Sun, 24 Jun 2007 23:12:38 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50861>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I was actually thinking exclusively of the matching of strings like "HEAD" 
> or "origin/next" or "master" to refs from the list of available refs. It 
> seems to me like the push code does a better job of handling the same 
> sorts of things that get_sha1() handles.
>
> In particular, the handling of "refs/my/funny/thing" is really wrong: it 
> gets treated as refs/heads/refs/my/funny/thing.

git-parse-remote.sh::canon_refs_list_for_fetch() seems to say
otherwise, though.

 - When unspecified, or explicitly spelled HEAD, take HEAD;
 - Anything that begins with refs/, use it as is;
 - Anything that begins with heads/, tags/, remotes/, assume
   it is a branch, a tag, or a tracking branch;
 - Otherwise assume a branch;

So I suspect refs/my/funny/thing is covered by the second rule.

But I do agree "otherwise assume a branch" part has huge room
for improvement.  Especially...

> I think that "origin/next" 
> should also be assumed to be refs/remotes/origin/next instead of 
> refs/heads/origin/next, at least if you have refs/remotes/origin/ and not 
> refs/heads/origin/.

... I think that makes perfect sense -- the code should
interpret your example as a request to start using a new
tracking branch refs/remotes/origin/next.
