From: Jeff King <peff@peff.net>
Subject: Re: git gc leaved my disk 100% full
Date: Thu, 4 Feb 2016 02:58:24 -0500
Message-ID: <20160204075823.GB21161@sigill.intra.peff.net>
References: <20160119170957.6e69ebb8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 08:58:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aREoE-0001iQ-VS
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 08:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbcBDH63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 02:58:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:37257 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932372AbcBDH61 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 02:58:27 -0500
Received: (qmail 15494 invoked by uid 102); 4 Feb 2016 07:58:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 02:58:26 -0500
Received: (qmail 32611 invoked by uid 107); 4 Feb 2016 07:58:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 02:58:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Feb 2016 02:58:24 -0500
Content-Disposition: inline
In-Reply-To: <20160119170957.6e69ebb8@endymion.delvare>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285407>

On Tue, Jan 19, 2016 at 05:09:57PM +0100, Jean Delvare wrote:

> Earlier today my desktop environment warned me that my /home was almost
> full. I thought that running "git gc" on my git trees would maybe save
> some disk space.
> 
> Unfortunately the opposite happened. "git gc" failed on me with:
> 
> fatal: sha1 file '.git/objects/pack/tmp_idx_XW7opV' write error: No space left on device
> error: failed to run repack
> 
> and at that point the partition was 100% full. My git repository went
> from 2.2 GB to 3.3 GB in the process, this is why.
> 
> While I understand the value of preserving temporary files for
> debugging purpose, I don't think it makes sense in the context of the
> "gc" command which precisely should get rid of such temporary files.
> 
> So please consider fixing "gc" so that it cleans up any temporary file
> in case of failure.

I agree that it would be nice to auto-clean failed object creation. Or
at least make it a configurable option. We have hacky patches at GitHub
to do so unconditionally, as we ran into problems with failed pushes
piling up.

I didn't send it upstream, because it involved building against a
separate and ugly tempfile API. Now that we have tempfile.[ch] upstream,
I think it wouldn't be too hard to do with register_tempfile().

-Peff
