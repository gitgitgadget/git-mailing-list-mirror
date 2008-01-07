From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: RFC/RFH submodule handling in big setups
Date: Mon, 7 Jan 2008 21:49:22 +0100
Message-ID: <20080107204922.GA19728@pvv.org>
References: <20080107102327.GA12427@pvv.org> <7vr6gtzaeq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 21:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JByuv-00038O-Sn
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 21:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774AbYAGUt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 15:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756715AbYAGUt0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 15:49:26 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:52529 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298AbYAGUtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 15:49:25 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1JByuQ-0008FX-Oa; Mon, 07 Jan 2008 21:49:22 +0100
Content-Disposition: inline
In-Reply-To: <7vr6gtzaeq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69804>

On Mon, Jan 07, 2008 at 11:46:21AM -0800, Junio C Hamano wrote:
> Finn Arne Gangstad <finnag@pvv.org> writes:
> 
> > We're trying to get git to work well with our vision of submodules,
> > and have to figure out how to make submodule fetching and pushing work
> > in a smooth way.
> >
> > This is our situation (simplified):
> >
> >           [product1]          [product2]  ...         (supermodules)
> >            /      \             /     \
> >     ... [foo]  [os-abstraction-lib] [log-merger] ...  (submodules)
> >
> > [...]
> 
> The phrase "without interfering with anyone else" feels somewhat
> wrong and I sense there is something missing in the description
> of the workflow.  When a developer pushes a change to somewhere
> else, it must be because the change needs to be shared with
> _somebody else_ (but not necessarily with _everybody_).
> 
> Without knowing exactly what the desired workflow is, I'd hazard
> a guess and would recommend something else, which is  hopefully
> a more useful way.

I'll try to explain a bit better, in different ways:

Way 1: Think of product2 as a big repository

I want to use git as if product2 was a single repository containing
all its submodules as directories.

I want to be able to send email patches agains product2 that affect
any number of the submodules. I want to apply these in any order, and
to let them live as topic branches in product2.

Way 2: Changes to several submodules must be "globally atomic"

If I change submodule 1 and submodule 2, I want to be able to commit
both those changes as one atomic change in the supermodule - in a
topic branch. When merging that topic branch in the supermodule, both
changes in the submodules are merged. But NOT BEFORE. The submodules
cannot be pre-merged (hence the need to push them "somewhere")

Way 3: The submodules are not released on their own

Only the products are released, each product has different release
criteria, code freezes, whatever. Syncing of submodules between
products happens rarely (a few times a year maybe). Modifications to
submodules must fit each product's release criteria.

There is usually no one who is responsible for each submodule, they
live their life as part of the supermodule. Anyone can modify a
submodule, but each product has a maintainer who decides what
modifications to the submodules are allowed in that product.


Does this make things clearer in any way?

- Finn Arne
