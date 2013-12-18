From: Jeff King <peff@peff.net>
Subject: Re: "git fsck" fails on malloc of 80 G
Date: Wed, 18 Dec 2013 17:09:23 -0500
Message-ID: <20131218220922.GA16347@sigill.intra.peff.net>
References: <201312161605.rBGG5Wm5027739@hobgoblin.ariadne.com>
 <20131216191500.GD29324@sigill.intra.peff.net>
 <201312182108.rBIL8lAo015570@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 18 23:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtPJG-0003Qd-As
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 23:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab3LRWJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 17:09:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:46955 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753068Ab3LRWJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 17:09:26 -0500
Received: (qmail 10749 invoked by uid 102); 18 Dec 2013 22:09:26 -0000
Received: from va-71-48-137-223.dhcp.embarqhsd.net (HELO sigill.intra.peff.net) (71.48.137.223)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 16:09:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 17:09:23 -0500
Content-Disposition: inline
In-Reply-To: <201312182108.rBIL8lAo015570@hobgoblin.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239495>

On Wed, Dec 18, 2013 at 04:08:47PM -0500, Dale R. Worley wrote:

> > From: Jeff King <peff@peff.net>
> 
> > One of the problems I ran into recently is that
> > corrupt data can cause it to make a large allocation
> 
> One thing I notice is that in unpack_compressed_entry() in
> sha1_file.c, there is a mallocz of "size" bytes.  It appears that
> "size" is the size of the object that is being unpacked.  If so, this
> code cannot be correct, because it assumes that any file that is
> stored in the repository can be put into a buffer allocated in RAM.

For some definition of correct. Git does load whole-blobs into memory in
several places. Some code paths _can_ stream, but they do not stream
deltas, and the diff engine definitely wants the whole thing in-core.

So you are reading it right. If you want to work on changing it, be my
guest, but it's a non-trivial fix. ;)

-Peff
