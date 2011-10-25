From: Jeff King <peff@peff.net>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 08:37:20 -0700
Message-ID: <20111025153720.GA6640@sigill.intra.peff.net>
References: <20111024201153.GA1647@x4.trippels.de>
 <20111024214949.GA5237@amd.home.annexia.org>
 <201110251550.22248.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	meyering@redhat.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 25 17:37:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIj4F-0001rm-KV
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 17:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624Ab1JYPh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 11:37:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55957
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752Ab1JYPh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 11:37:26 -0400
Received: (qmail 15485 invoked by uid 107); 25 Oct 2011 15:43:12 -0000
Received: from 75-147-138-244-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (75.147.138.244)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 25 Oct 2011 11:43:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Oct 2011 08:37:20 -0700
Content-Disposition: inline
In-Reply-To: <201110251550.22248.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184212>

On Tue, Oct 25, 2011 at 03:50:21PM +0200, Thomas Rast wrote:

> That being said, I'm not entirely convinced that the code in
> builtin/grep.c works in the face of memory pressure.  It guards
> against concurrent access to read_sha1_file() with the
> read_sha1_mutex, but any call to xmalloc() outside of that mutex can
> still potentially invoke the try_to_free_routine.  Maybe one of the
> pack experts can say whether this is safe.  (However, I implemented
> locking around try_to_free_routine as a quick hack and it did not fix
> the issue discussed in the bug report.)

Yes, I think it needs to set try_to_free_routine. See this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/180446

which discusses a possible subtlety with doing so.

-Peff
