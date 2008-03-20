From: Jeff King <peff@peff.net>
Subject: Re: Two bugs with renaming
Date: Wed, 19 Mar 2008 22:06:21 -0400
Message-ID: <20080320020621.GA24678@coredump.intra.peff.net>
References: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org> <7vwsnyz07y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 03:07:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcABS-0005sP-A6
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 03:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbYCTCG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 22:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbYCTCGZ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 22:06:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4701 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbYCTCGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 22:06:25 -0400
Received: (qmail 13080 invoked by uid 111); 20 Mar 2008 02:06:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 19 Mar 2008 22:06:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Mar 2008 22:06:21 -0400
Content-Disposition: inline
In-Reply-To: <7vwsnyz07y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77612>

On Wed, Mar 19, 2008 at 05:51:45PM -0700, Junio C Hamano wrote:

> > # Set up bug #2
> 
> This hasn't been addressed, I think.

Hmm. It looks like threeway_merge is getting bogus input. In a regular
merge (e.g., branch changes file "file", master adds new file "other",
branch merges master), threeway merge sees:

  - call 1: index=file, head=file, remote=file
  - call 2: index=NULL, head=NULL, remote=other

But if the change to file is a D/F conflict (as in the scenario John
described), we get:

  - call 1: index=files, head=files, remote=""
  - call 2: index=files.upstream/delete.me, head=NULL, remote=NULL

and it barfs because index != head in the second call. But the "" entry
in the first call makes me wonder if this is the same "lists getting out
of sync" problem as before.

This is as far as I got.  I don't have any more time to look at it
tonight, unfortunately.

-Peff
