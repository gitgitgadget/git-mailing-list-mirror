From: Jeff King <peff@peff.net>
Subject: Re: why is tagger header optional?
Date: Tue, 19 Jan 2010 01:44:54 -0500
Message-ID: <20100119064453.GA3946@coredump.intra.peff.net>
References: <20100119060946.GA23212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 07:48:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX7sh-0006Ac-OD
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 07:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab0ASGo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 01:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271Ab0ASGo7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 01:44:59 -0500
Received: from peff.net ([208.65.91.99]:54618 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932148Ab0ASGo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 01:44:58 -0500
Received: (qmail 17069 invoked by uid 107); 19 Jan 2010 06:49:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 19 Jan 2010 01:49:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2010 01:44:54 -0500
Content-Disposition: inline
In-Reply-To: <20100119060946.GA23212@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137434>

On Mon, Jan 18, 2010 at 10:09:46PM -0800, Shawn O. Pearce wrote:

> So why is it legal to omit the tagger header from a tag?
> 
> E.g. the Linux kernel tag v2.6.12 has no tagger header:

I think you just answered your own question. We must support tagger-less
tags because they exist in important projects like the kernel. :)

> [...]
> Is there a version of Git floating around that doesn't create a
> tagger header when creating a signed tag?  WTF?

Everything prior to c818566 ([PATCH] Update tags to record who made
them, 2005-07-14). So probably nothing that anybody is using now, but
v2.6.12 was one of the first tags made.

> Looking at tag.c's parse_tag_buffer(), the variable sig_line seems
> to be expected to point at the "tagger " header (given its name),
> but its not actually validated as such.

Actually, that variable name predates the patch above, so I suspect
"sig" meant "GPG signature". At any rate, as you can see, git doesn't
verify it, and the code for "git show v2.6.12" in
builtin-log.c:show_object handles the taggerless case as well. I don't
think anything else actually looks at the tagger. verify-tag treats the
signed data as opaque, and just shows the identity of the actual signer.

-Peff
