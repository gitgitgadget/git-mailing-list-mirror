From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] t1050-large: generate large files without dd
Date: Wed, 14 Jan 2015 16:00:16 -0500
Message-ID: <20150114210016.GC1155@peff.net>
References: <54B5579B.4080607@kdbg.org>
 <20150113214733.GA16582@peff.net>
 <54B59D24.7030508@kdbg.org>
 <20150113223849.GA3144@peff.net>
 <xmqq4mruckrp.fsf@gitster.dls.corp.google.com>
 <20150114112659.GA23474@peff.net>
 <54B6D188.7010500@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBV3D-0007KH-IA
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbbANVAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:00:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:34579 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753833AbbANVAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:00:19 -0500
Received: (qmail 14406 invoked by uid 102); 14 Jan 2015 21:00:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 15:00:18 -0600
Received: (qmail 6496 invoked by uid 107); 14 Jan 2015 21:00:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 16:00:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 16:00:16 -0500
Content-Disposition: inline
In-Reply-To: <54B6D188.7010500@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262425>

On Wed, Jan 14, 2015 at 09:28:56PM +0100, Johannes Sixt wrote:

> For some unknown reason, the dd on my Windows box segfaults randomly,
> but since recently, it does so much more often than it used to, which
> makes running the test suite burdensome.
> 
> Use printf to write large files instead of dd. To emphasize that three
> of the large blobs are exact copies, use cp to allocate them.
> 
> The new code makes the files a bit smaller, and they are not sparse
> anymore, but the tests do not depend on these properties. We do not want
> to use test-genrandom here (which is used to generate large files
> elsewhere in t1050), so that the files can be compressed well (which
> keeps the run-time short).

Thanks, this version looks good to me.

> The files are now large text files, not binary files. But since they
> are larger than core.bigfilethreshold they are diagnosed as binary
> by Git. For this reason, the 'git diff' tests that check the output
> for "Binary files differ" still pass.

I was less concerned with tests not passing, as much as tests ending up
testing nothing (which is very hard to test automatically, as you would
have to recreate the original bug!). But I think it is fine, as text is
more likely to get malloc'd than a binary (and these tests are really
about making sure we avoid huge mallocs).

> @@ -162,7 +162,7 @@ test_expect_success 'pack-objects with large loose
> object' '

Funny wrapping here. I imagine Junio can manage to apply it anyway, but
you may want to check your MUA settings.

-Peff
