From: Jeff King <peff@peff.net>
Subject: Re: Java Inflater problem decompressing packfile
Date: Sat, 16 Apr 2011 02:37:29 -0400
Message-ID: <20110416063729.GC28853@sigill.intra.peff.net>
References: <1302919505984-6278154.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: madmarcos <fru574@my.utsa.edu>
X-From: git-owner@vger.kernel.org Sat Apr 16 08:37:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAz8S-0001c5-30
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 08:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab1DPGhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 02:37:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58895
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab1DPGhb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 02:37:31 -0400
Received: (qmail 18382 invoked by uid 107); 16 Apr 2011 06:38:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Apr 2011 02:38:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Apr 2011 02:37:29 -0400
Content-Disposition: inline
In-Reply-To: <1302919505984-6278154.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171665>

On Fri, Apr 15, 2011 at 07:05:05PM -0700, madmarcos wrote:

> So, my inflater method decompresses the first 7 objects fine (a commit, a
> couple of trees, and several blobs) and a cursory visual inspection of the
> decompressed data seems fine. The eighth object becomes a problem, though.
> It is a blob with the name build.xml that is 51,060 bytes decompressed
> (looking at the original pre-git-pushed jEdit source). The actual file size
> matches the decompressed data content size in the packfile object header. 
> The inflater procedure outputs the decompressed data to System.out for
> visual inspection. Approximately the first 1/3 looks like the original
> build.xml but after that, the output is garbled. The procedure continues
> decompressing objects after the 8th, but garbled, object but it dies on the
> 9th object with an "unknown compression method" error.

Is it possible that the blob is stored as a delta within the pack? In
that case the pack header will tell you what the eventual size of the
blob will be, but the data will actually be a diff against another pack
object. Does your inflater handle delta-fied objects?

-Peff
