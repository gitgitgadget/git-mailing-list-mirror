From: "Bernhard R. Link" <brlink@debian.org>
Subject: Re: [PATCH] Let format-patch and rebase ignore trivial merges.
Date: Fri, 18 Dec 2009 14:06:03 +0100
Message-ID: <20091218130603.GA6193@pcpool00.mathematik.uni-freiburg.de>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de> <4B29106C.1040501@viscovery.net> <7vaaxhfcfe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 14:07:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLcXx-00074d-NR
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 14:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbZLRNGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 08:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbZLRNGK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 08:06:10 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:60609
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753163AbZLRNGH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 08:06:07 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLcWx-0007oV-K3; Fri, 18 Dec 2009 14:06:03 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NLcWx-0001gF-Hm; Fri, 18 Dec 2009 14:06:03 +0100
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <7vaaxhfcfe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135409>

* Junio C Hamano <gitster@pobox.com> [091217 23:44]:
[order of replies changed for the sake of answers]
> On the other hand, a branch that will be rebased to keep up with others is
> by definition private, and I don't see a reason to mark with "-s ours" to
> cauterize history of an unrelated side branch that tried to do something
> similar to what the branch is trying to achieve in that setting.  You can
> instead ignore such a side branch and not merge with it.  So I don't know
> how a sane history you are going to rebase ends up containing a "-s ours"
> merge to begin with.

Think of a team working to prepare a complicated change that is to be
presented as multiple easily reviewable patches.

If you do something like that alone on a single computer, you will
usually have a branch, collect some commits and merge fixes for previous
commits together with rebase -i. If it takes a longer time you also
rebase to upstream from time to time, fixing all the conflicts and so
on. (You can also just collect and hope to still separate them into
different patches at the end, but that usually gets messy in my
experience).
Those rebases will make you lose some history, which you can work around
by having some extra branches with older states. If you work on
different computers, pulling and pushing the current state of the branch
around needs special care as the non-fast-forward needed all the time
might also easily overwrite and newer with an older state (and keeping
track of the older branches is a big mess unless you have one central
repository).
If there are multiple people working on this, things will not get
easier. In this case having the new clean branch containing a trivial merge
with second parent the old history will both allow easy push and pull
and keep the history so one can look at older states.
(see http://marc.info/?l=git&m=125959221911443&w=2)

A special case for this are modifications in Debian packages. The
patches have to be rebased to every new upstream, while at the same
time should always be in a state so they can be sent upstream and
upstream can pick some of them. (And ideally the debian source package
does include the patches as nice topic separated patch files, so other
distributions/users can easily pick those independent of what vcs they
use).

> A branch that merges with "-s ours" is typically done so that others can
> pull and build against (and "-s ours" is used to cauterize the history of
> a bad side branch), and good bits merged into it would also have come from
> a different clean branch that is merged into that branch.  It might make
> more sense to format-patch that clean branch when preparing for upstream
> submission, than the "aggregated mesh of commits" branch with "-s ours"
> fix-ups.

format-patch has to choose a parent. Choosing the first one make the
most sense for me (as the first is the only real 'special' one).
In the workflows I envision the first parent would also be the one with
the clean history.

Hochachtungsvoll,
	Bernhard R. Link
-- 
"Never contain programs so few bugs, as when no debugging tools are available!"
	Niklaus Wirth
