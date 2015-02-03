From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Mon, 2 Feb 2015 19:50:05 -0500
Message-ID: <20150203005005.GB31946@peff.net>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1422919650-13346-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 01:50:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIRh6-0004V1-IF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 01:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721AbbBCAuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 19:50:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:44332 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933698AbbBCAuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 19:50:07 -0500
Received: (qmail 28654 invoked by uid 102); 3 Feb 2015 00:50:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 18:50:07 -0600
Received: (qmail 4587 invoked by uid 107); 3 Feb 2015 00:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 19:50:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 19:50:05 -0500
Content-Disposition: inline
In-Reply-To: <1422919650-13346-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263298>

On Mon, Feb 02, 2015 at 03:27:27PM -0800, Junio C Hamano wrote:

> +test_expect_failure 'symlink escape via ..' '
> +	{
> +		mkpatch_symlink tmp .. &&
> +		mkpatch_add tmp/foo ../foo
> +	} >patch &&
> +	test_must_fail git apply patch &&
> +	test_path_is_missing ../foo
> +'

By the way, does this patch (and the other symlink-escape ones) need to
be marked with the SYMLINKS prereq? For a pure-index application, it
should work anywhere, but I have a feeling that this "git apply patch"
may try to write the symlink to the filesystem, fail, and report failure
for the wrong reason.  I don't have a SYMLINK-challenged filesystem to
test on, though.

-Peff
