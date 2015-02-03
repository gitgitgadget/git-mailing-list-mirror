From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Tue, 3 Feb 2015 16:01:40 -0500
Message-ID: <20150203210140.GA20594@peff.net>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1422919650-13346-2-git-send-email-gitster@pobox.com>
 <20150203005005.GB31946@peff.net>
 <xmqqpp9qrbgf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:01:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIkbT-0000wB-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 22:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbbBCVBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 16:01:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:44790 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756171AbbBCVBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 16:01:43 -0500
Received: (qmail 14955 invoked by uid 102); 3 Feb 2015 21:01:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 15:01:42 -0600
Received: (qmail 14217 invoked by uid 107); 3 Feb 2015 21:01:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 16:01:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2015 16:01:40 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpp9qrbgf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263333>

On Tue, Feb 03, 2015 at 12:23:28PM -0800, Junio C Hamano wrote:

> > By the way, does this patch (and the other symlink-escape ones) need to
> > be marked with the SYMLINKS prereq? For a pure-index application, it
> > should work anywhere, but I have a feeling that this "git apply patch"
> > may try to write the symlink to the filesystem, fail, and report failure
> > for the wrong reason.  I don't have a SYMLINK-challenged filesystem to
> > test on, though.
> 
> We check the links to be created by the patch itself in-core before
> going to the filesystem, and the symbolic links you are creating
> using mkpatch_symlink should be caught before we invoke symlink(2),
> I think.
> 
> In other words, this series attempts to stick to the "verify
> everything in-core before deciding that it is OK to touch the
> working tree or the index".

Right, I do not think these tests will _fail_ when the filesystem does
not support symlinks. But nor are they actually testing anything
interesting. They would pass on such a system even without your patch,
as we would fail to apply even the symlink creation part of the patch.

I can live with leaving them unmarked, though. It gets the code
exercised on more systems, which gives a slightly higher chance of
catching some other unexpected breakage.

-Peff
