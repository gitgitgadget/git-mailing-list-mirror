From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Mon, 4 Feb 2013 03:37:01 -0500
Message-ID: <20130204083701.GA30835@sigill.intra.peff.net>
References: <12070540.431901359961105650.JavaMail.weblogic@epml10>
 <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jongman.heo@samsung.com, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 09:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2HYk-00053D-B5
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 09:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711Ab3BDIhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 03:37:24 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59927 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753691Ab3BDIhE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 03:37:04 -0500
Received: (qmail 16839 invoked by uid 107); 4 Feb 2013 08:38:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Feb 2013 03:38:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2013 03:37:01 -0500
Content-Disposition: inline
In-Reply-To: <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215367>

On Sun, Feb 03, 2013 at 11:13:00PM -0800, Junio C Hamano wrote:

> Yeah, that result is understandable, as .depend/*.o.d files will not
> be rebuilt when the rules to build them changes in the Makefile.
> Applying the patch to the Makefile in the pristine old tree, run the
> build (which will generate .depend/*.o.d files with the corrected
> rules), then checking out the new tree and running the build again
> without "make clean", with or with the patch applied, would validate
> that the patch fixes the issue for old ccache.
> 
> Thanks Jonathan for diagnosing, fixing, and thanks Jongman for
> testing.

Do we want to do anything with the other dependency hole I found here:

  http://article.gmane.org/gmane.comp.version-control.git/215211

It's definitely a potential problem, but I don't think we have any
reports of it happening in practice, so it might not be worth worrying
about. Doing a clean version of the fix here:

  http://article.gmane.org/gmane.comp.version-control.git/215212

would probably involve reorganizing our .depend directory structure,
unless somebody can cook up some clever use of make's patsubst.

-Peff
