From: Jeff King <peff@peff.net>
Subject: Re: No progress from push when using bitmaps
Date: Thu, 13 Mar 2014 17:26:26 -0400
Message-ID: <20140313212626.GA23618@sigill.intra.peff.net>
References: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 22:26:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOD97-0005zT-I8
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 22:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbaCMV03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 17:26:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:39041 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752392AbaCMV02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 17:26:28 -0400
Received: (qmail 13049 invoked by uid 102); 13 Mar 2014 21:26:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 16:26:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2014 17:26:26 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244052>

On Wed, Mar 12, 2014 at 05:21:21PM -0700, Shawn Pearce wrote:

> Today I tried pushing a copy of linux.git from a client that had
> bitmaps into a JGit server. The client stalled for a long time with no
> progress, because it reused the existing pack. No progress appeared
> while it was sending the existing file on the wire:
> 
>   $ git push git://localhost/linux.git master
>   Reusing existing pack: 2938117, done.
>   Total 2938117 (delta 0), reused 0 (delta 0)
>   remote: Resolving deltas:  66% (1637269/2455727)
> 
> This is not the best user experience. :-(

Yeah, I agree that sucks. I hadn't noticed it, as I don't typically have
my client repos bitmapped (and on fetch, the interesting progress is
coming from the local index-pack).

It would definitely be good to have throughput measurements while
writing out the pack. However, I'm not sure we have anything useful to
count. We know the total number of objects we're reusing, but we're not
actually parsing the data; we're just blitting it out as a stream. I
think the progress code will need some refactoring to handle a
throughput-only case.

-Peff
