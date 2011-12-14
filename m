From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Do not create commits whose message contains NUL
Date: Wed, 14 Dec 2011 13:29:53 -0500
Message-ID: <20111214182953.GA6469@sigill.intra.peff.net>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-4-git-send-email-pclouds@gmail.com>
 <7vzkevow2j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Miles Bader <miles@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 19:30:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rataa-0005mi-O2
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 19:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab1LNS34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 13:29:56 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50175
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732Ab1LNS3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 13:29:55 -0500
Received: (qmail 888 invoked by uid 107); 14 Dec 2011 18:36:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 13:36:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 13:29:53 -0500
Content-Disposition: inline
In-Reply-To: <7vzkevow2j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187163>

On Wed, Dec 14, 2011 at 10:19:16AM -0800, Junio C Hamano wrote:

> Limiting the Porcelain layer to deal only with reasonable text encodings
> (yes, I am declaring that utf16 is not among them) is perfectly fine, but
> I was somehow hoping that you would allow the option for the low-level
> function commit_tree() to create a commit object with binary blob in the
> body part, especially after seeing the patch 1/3 to do so.
> 
> Certainly that kind of usage would not give the binary blob literally in
> "git log" output, but it is with or without the issue around NUL byte. A
> custom program linked with commit.c to call commit_tree() may not be using
> the data structure to store anything that is meant to be read by "git log"
> to begin with.

I'm happy to ignore custom programs linking against internal git code,
but what should "git commit-tree" do?

My gut feeling is that it should store the literal binary contents.
However, I don't think this has ever been the case. Even in the initial
version of commit-tree.c, we read the input line-by-line and sprintf it
into place.

-Peff
