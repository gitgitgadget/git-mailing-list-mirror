From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 1 Jun 2016 20:16:21 +0100
Message-ID: <20160601191621.GO1355@john.keeping.me.uk>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
 <xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
 <xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
 <20160601163747.GA10721@sigill.intra.peff.net>
 <20160601183100.GN1355@john.keeping.me.uk>
 <20160601190759.GB12496@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:16:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8BdA-0006Br-Le
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 21:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbcFATQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 15:16:29 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:59656 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750765AbcFATQ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 15:16:29 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 1F688BF226;
	Wed,  1 Jun 2016 20:16:27 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 1A81320B6E;
	Wed,  1 Jun 2016 20:16:27 +0100 (BST)
X-Quarantine-ID: <O7Dtn2si1eXw>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: 0.55
X-Spam-Level: 
X-Spam-Status: No, score=0.55 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, KAM_INFOUSMEBIZ=0.75]
	autolearn=no autolearn_force=no
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id O7Dtn2si1eXw; Wed,  1 Jun 2016 20:16:25 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.10])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 0CD6961FA7;
	Wed,  1 Jun 2016 20:16:22 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20160601190759.GB12496@sigill.intra.peff.net>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296151>

On Wed, Jun 01, 2016 at 03:07:59PM -0400, Jeff King wrote:
> On Wed, Jun 01, 2016 at 07:31:00PM +0100, John Keeping wrote:
> 
> > > >  reset_submodule_urls () {
> > > > -	local root
> > > > -	root=$(pwd) &&
> > > >  	(
> > > > +		root=$(pwd) &&
> > > >  		cd super-clone/submodule &&
> > > >  		git config remote.origin.url "$root/submodule"
> > > >  	) &&
> > > >  	(
> > > > +		root=$(pwd) &&
> > > >  		cd super-clone/submodule/sub-submodule &&
> > > >  		git config remote.origin.url "$root/submodule"
> > [...]
> > I wonder if it's relevant that the "local root" line isn't &&-chained?
> > Is it possible that on some shells we ignore an error but everything
> > still works?
> 
> I don't think so. We're inside a function, so we wouldn't affect any
> outer &&-chaining in the function (and there isn't any in the caller
> anyway). I think it's a reasonable custom not to bother &&-chaining
> "local" lines, as they come at the top of a function and can't fail.

Can't fail if the shell supports "local", but if we're in a shell that
doesn't support it, then the lack of "&&" may allow us to just carry on.
