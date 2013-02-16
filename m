From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] make smart-http more robust against bogus server input
Date: Sat, 16 Feb 2013 01:44:55 -0500
Message-ID: <20130216064455.GA27063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 07:45:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6bWU-0003bJ-7Z
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 07:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab3BPGo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 01:44:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49771 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030Ab3BPGo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 01:44:58 -0500
Received: (qmail 2816 invoked by uid 107); 16 Feb 2013 06:46:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Feb 2013 01:46:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2013 01:44:55 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216377>

For the most part, smart-http just passes data to fetch-pack and
send-pack, which take care of the heavy lifting. However, I did find a
few corner cases around truncated data from the server, one of which can
actually cause a deadlock.

I found these because I was trying to figure out what was going on with
some hung git processes which were in a deadlock like the one described
in patch 3. But having experimented and read the code, I don't think
that it is triggerable from a normal clone, but rather only when you
poke git-remote-curl in the right way. So it may or may not be my
culprit, but these patches do make remote-curl more robust, which is a
good thing.

  [1/3]: pkt-line: teach packet_get_line a no-op mode
  [2/3]: remote-curl: verify smart-http metadata lines
  [3/3]: remote-curl: sanity check ref advertisement from server

-Peff
