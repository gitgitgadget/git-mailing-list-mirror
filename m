From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] avoid duplicate .have lines
Date: Thu, 19 May 2011 17:32:32 -0400
Message-ID: <20110519213231.GA29702@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:32:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNApk-0005Ko-Lc
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934799Ab1ESVcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:32:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39437
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932455Ab1ESVce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:32:34 -0400
Received: (qmail 20932 invoked by uid 107); 19 May 2011 21:34:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 17:34:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 17:32:32 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174010>

When receiving a push, we advertise ref tips from any alternate
repositories, in case that helps the client send a smaller pack. Since
these refs don't actually exist in the destination repository, we don't
transmit the real ref names, but instead use the pseudo-ref ".have".

If your alternate has a large number of duplicate refs (for example,
because it is aggregating objects from many related repositories, some
of which will have the same tags and branch tips), then we will send
each ".have $sha1" line multiple times. This is a pointless waste of
bandwidth, as we are simply repeating the same fact to the client over
and over.

This series eliminates duplicate .have lines on push (we don't need to
do so during fetch; see 3/3 for details).

  [1/3]: refactor refs_from_alternate_cb to allow passing extra data
  [2/3]: bisect: refactor sha1_array into a generic sha1 list
  [3/3]: receive-pack: eliminate duplicate .have refs

-Peff
