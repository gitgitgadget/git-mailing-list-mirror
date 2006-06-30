From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Creating diff from 2.6.16 from cryptodev-2.6 git tree
Date: Fri, 30 Jun 2006 11:36:27 +1000
Message-ID: <20060630013627.GA27527@gondor.apana.org.au>
References: <44A47BE0.9060504@logix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-crypto@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 03:37:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw7wW-0007mE-FB
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 03:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWF3BhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 21:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWF3BhH
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 21:37:07 -0400
Received: from [64.62.148.172] ([64.62.148.172]:12037 "EHLO arnor.apana.org.au")
	by vger.kernel.org with ESMTP id S1751402AbWF3BhF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 21:37:05 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1Fw7vp-0008D4-1H; Fri, 30 Jun 2006 11:36:29 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1Fw7vo-0007CB-00; Fri, 30 Jun 2006 11:36:28 +1000
To: Michal Ludvig <michal@logix.cz>
Content-Disposition: inline
In-Reply-To: <44A47BE0.9060504@logix.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22943>

On Fri, Jun 30, 2006 at 01:18:24PM +1200, Michal Ludvig wrote:
> 
> just a quick question: how can I create a patch with all changes in
> cryptodev-2.6 tree against tag v2.6.16 in Linus tree? I've got
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> cloned here and want to extract all your commits in this tree since
> 2.6.16. Is there a way to do it in Git/Cogito?

OK, it's easier if you break this into three problems.

You start by getting all the changes merged right after 2.6.16.  This
can be done by locating the merge changeset in Linus's tree.  It looks
like this:

commit ec1248e70edc5cf7b485efcc7b41e44e10f422e5
Merge: 3d1f337b3e7378923c89f37afb573a918ef40be5 55e9dce37ddf3ab358ba1d1e9eef4ee4bd8174a6
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Tue Mar 21 09:33:19 2006 -0800

    Merge master.kernel.org:/pub/scm/linux/kernel/git/herbert/crypto-2.6

    * master.kernel.org:/pub/scm/linux/kernel/git/herbert/crypto-2.6:
      [CRYPTO] aes: Fixed array boundary violation
      [CRYPTO] tcrypt: Fix key alignment
      [CRYPTO] all: Add missing cra_alignmask
      [CRYPTO] all: Use kzalloc where possible
      [CRYPTO] api: Align tfm context as wide as possible
      [CRYPTO] twofish: Use rol32/ror32 where appropriate

You can get the diff for this merge by doing

$ git-diff-tree -p 3d1f337b3e7378923c89f37afb573a918ef40be5 ec1248e70edc5cf7b485efcc7b41e44e10f422e5

You then repeat this for 2.6.17 where the merge changeset is:

commit 972d19e837833b93466c6f6a8ef2a7d653000aa3
Merge: cdf4f383a4b0ffbf458f65380ecffbeee1f79841 b9d0a25a484a90c1d60b974d115eff2fe580ce16
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Mon Jun 26 11:03:29 2006 -0700

Finally you get the changes since that merge by find the common changeset
between cryptodev-2.6 and Linus's tree and getting all the changes after
that.

This method works because all crypto changes since 2.6.16 were merged
from my tree.  If this wasn't the case, then you'd have to search
through the history since 2.6.16 to identify the crypto patches that
were merged from other sources.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
