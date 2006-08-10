From: Jeff King <peff@peff.net>
Subject: Re: diff machinery cleanup
Date: Thu, 10 Aug 2006 06:38:37 -0400
Message-ID: <20060810103836.GA1317@coredump.intra.peff.net>
References: <20060810082455.GA30739@coredump.intra.peff.net> <7vejvpvsni.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 12:39:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB7w4-0001WG-Jr
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 12:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWHJKik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 06:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbWHJKij
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 06:38:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:63888 "HELO
	peff.net") by vger.kernel.org with SMTP id S1161149AbWHJKij (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 06:38:39 -0400
Received: (qmail 10189 invoked from network); 10 Aug 2006 06:38:05 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Aug 2006 06:38:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2006 06:38:37 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejvpvsni.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25179>

On Thu, Aug 10, 2006 at 02:36:49AM -0700, Junio C Hamano wrote:

> In general, run_diff_X are _not_ designed to run twice.

OK, makes sense. As you probably guessed, the reason is for the
run-status in C.

> If you are working in "next" branch where Johannes's merge-recur
> work introduced discard_cache(), you could fake this somehow
> stashing away a copy of the original index, and once you are
> done with run_diff_index(), clean the slate by calling
> discard_cache() once you are done, and swap the original index
> in before running run_diff_files().

OK, doing a discard_cache() between the call to run_diff_index and
run_diff_files seems to clear up the problem. But if I understand
correctly, are you saying that run_diff_index has munged the index on
disk, and I really need to be poking at a temporary copy? If so, why
isn't that a problem when running (e.g.) "git-diff-index; git-ls-files"?

> To solve this cleanly without doing the index munging hack, you
> would (actually, I would) need to have a new path walker that
> walks index, tree and working tree in parallel, which I was
> working on in the git-status/git-commit rewrite I started and
> discarded a few days ago.

That does sound the cleanest, and it would enable a more useful status
message, as you mentioned before. What caused you to stop working on it?
Infeasible, or simply more infeasible than you would like right now?

-Peff
