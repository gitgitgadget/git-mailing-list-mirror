From: Jeff King <peff@peff.net>
Subject: [PATCH 0/14] resumable network bundles
Date: Thu, 10 Nov 2011 02:43:31 -0500
Message-ID: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:43:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPIk-0000V5-51
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab1KJHnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:43:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38903
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab1KJHnx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:43:53 -0500
Received: (qmail 22041 invoked by uid 107); 10 Nov 2011 07:43:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:43:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:43:31 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185196>

One possible option for resumable clones that has been discussed is
letting the server point the client by http to a static bundle
containing most of history, followed by a fetch from the actual git repo
(which should be much cheaper now that we have all of the bundled
history).  This series implements "step 0" of this plan: just letting
bundles be fetched across the network in the first place.

Shawn raised some issues about using bundles for this (as opposed to
accessing the packfiles themselves); specifically, this raises the I/O
footprint of a repository that has to serve both the bundled version of
the pack and the regular packfile.

So it may be that we don't follow this plan all the way through.
However, even if we don't, fetching bundles over http is still a useful
thing to be able to do. Which makes this first step worth doing either
way.

  [01/14]: t/lib-httpd: check for NO_CURL
  [02/14]: http: turn off curl signals
  [03/14]: http: refactor http_request function
  [04/14]: http: add a public function for arbitrary-callback request
  [05/14]: remote-curl: use http callback for requesting refs
  [06/14]: transport: factor out bundle to ref list conversion
  [07/14]: bundle: add is_bundle_buf helper
  [08/14]: remote-curl: free "discovery" object
  [09/14]: remote-curl: auto-detect bundles when fetching refs
  [10/14]: remote-curl: try base $URL after $URL/info/refs
  [11/14]: progress: allow pure-throughput progress meters
  [12/14]: remote-curl: show progress for bundle downloads
  [13/14]: remote-curl: resume interrupted bundle transfers
  [14/14]: clone: give advice on how to resume a failed clone

-Peff
