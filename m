From: "Steven E. Harris" <seh@panix.com>
Subject: Re: How does git follow branch history across a merge commit?
Date: Fri, 28 Aug 2009 19:50:44 -0400
Organization: SEH Labs
Message-ID: <831vmv5wh7.fsf@torus.sehlabs.com>
References: <8363c75zug.fsf@torus.sehlabs.com>
	<7vskfbcy9n.fsf@alter.siamese.dyndns.org>
	<7vmy5jbjkr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 01:51:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhBDv-0000S0-Hr
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 01:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbZH1XvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 19:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbZH1XvF
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 19:51:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:45804 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbZH1XvE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 19:51:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MhBDl-0000PP-OF
	for git@vger.kernel.org; Sat, 29 Aug 2009 01:51:05 +0200
Received: from pool-68-162-167-240.pitt.east.verizon.net ([68.162.167.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Aug 2009 01:51:05 +0200
Received: from seh by pool-68-162-167-240.pitt.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Aug 2009 01:51:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-68-162-167-240.pitt.east.verizon.net
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (windows-nt)
Cancel-Lock: sha1:vxXdKhF/29IGyARAxbi3km75opA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127364>

Junio C Hamano <gitster@pobox.com> writes:

> If you merge competition into your master, the resulting commit will
> have your master as its first parent.  If check out competition and
> merge master in your example, the resulting merge will have
> compatition as the first parent.

I see, having run a few more experiments to confirm this.

I missed the point that merge commits are not "predecessor neutral";
they apparently have a bias indicating "/this branch/ received content
from /that branch/ (or /those branches/)".

To try to recreate my confusing scenario, I tried this:

,----
| git checkout competition
| git merge master
| # This fast-forwarded "competition" be equivalent to "master".
| git checkout 'HEAD^'
| # This wound up again at "master"'s predecessor, not "competition"'s.
`----

It seems that since fast-forward merges don't produce a commit, the
merge record remains in place recording that branch "competition" came
into branch "master". Even though we're checked out to branch
"competition" here, following its history back in time requires some
manual intervention. Do you concur, or is my example perhaps flawed?

-- 
Steven E. Harris
