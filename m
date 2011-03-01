From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/3] t6022: New test checking for unnecessary updates
 of renamed+modified files
Date: Tue, 1 Mar 2011 14:38:52 -0500
Message-ID: <20110301193852.GC10082@sigill.intra.peff.net>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
 <1298941732-19763-2-git-send-email-newren@gmail.com>
 <4D6CA13C.1000006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:39:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVQ5-0001L3-5Q
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249Ab1CATip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 14:38:45 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45374 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757242Ab1CATin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 14:38:43 -0500
Received: (qmail 9545 invoked by uid 111); 1 Mar 2011 19:38:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 19:38:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 14:38:52 -0500
Content-Disposition: inline
In-Reply-To: <4D6CA13C.1000006@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168244>

On Tue, Mar 01, 2011 at 08:33:16AM +0100, Johannes Sixt wrote:

> > +	orig=$(stat --format="%Y" rename) &&
> 
> 	orig=$(test-chmtime -v +0 rename) &&
> 
> > +	git merge merge-branch-1 &&
> > +	new=$(stat --format="%Y" rename) &&
> 
> 	new=$(test-chmtime -v +0 rename) &&
> 
> > +	echo "Checking whether stat times are same: $orig vs $new" &&
> 
> 	echo "Checking whether stat times are same: ${orig%%	*} vs ${new%%	*}" &&
> 
> (that's TAB after the %%)
> 
> > +	test "$orig" == "$new" &&
> 
> 	test "${orig%%	*}" = "${new%%	*}" &&

Maybe this would be simpler as:

  test-chmtime -v +0 rename >orig &&
  ... do the merge ...
  test-chmtime -v +0 rename >new &&
  test_cmp orig new

And then you don't have to care about the format that test-chmtime
outputs at all, and test_cmp's diff output is usually self-explanatory
when there is a mismatch (it's even better if you name the files
"expect" and "actual").

-Peff
