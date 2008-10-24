From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] refactor userdiff textconv code
Date: Fri, 24 Oct 2008 08:40:44 -0400
Message-ID: <20081024124043.GA4806@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net> <20081024025330.GC2831@coredump.intra.peff.net> <4901762A.3090003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 14:42:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtLzL-0001fM-6H
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 14:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbYJXMkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 08:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYJXMkr
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 08:40:47 -0400
Received: from peff.net ([208.65.91.99]:1192 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbYJXMkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 08:40:46 -0400
Received: (qmail 17014 invoked by uid 111); 24 Oct 2008 12:40:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 08:40:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 08:40:44 -0400
Content-Disposition: inline
In-Reply-To: <4901762A.3090003@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99031>

On Fri, Oct 24, 2008 at 09:15:54AM +0200, Johannes Sixt wrote:

> What do we do when symlinks are involved? Pilot error? Or should we
> exclude them from textconv (and diff.*.command, for that matter)
> at all times? See a test case below.

Hrm, I hadn't really considered that. I would guess they should not be
excluded from diff.*.command; the external driver gets the mode, so it
is free to represent symlinks in whatever way it wants.

But clearly they are going to always be text, so there is no point in
textconv'ing them.

> +cat >expect.typechange <<'EOF'
> +Binary files a/file and /dev/null differ
> +diff --git a/file b/file
> +new file mode 120000
> +index ad8b3d2..67be421
> +--- /dev/null
> ++++ b/file
> +@@ -0,0 +1 @@
> ++frotz
> +\ No newline at end of file
> +EOF
> +

I find this output a bit confusing, since it actually breaks it into a
deletion and an addition. But I guess that is orthogonal to the textconv
issue, and intended. I don't think I've ever actually needed to diff a
symlink before.

-Peff
