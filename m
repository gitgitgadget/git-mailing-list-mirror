From: Jeff King <peff@peff.net>
Subject: Re: Installed git 2.1.3 on sparc 8, but got core dump during 'git
 clone'
Date: Thu, 6 Nov 2014 02:24:03 -0500
Message-ID: <20141106072403.GA24872@peff.net>
References: <1415251144220-7620692.post@n2.nabble.com>
 <1415255667304-7620693.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: victor <liwenxi9999@163.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 08:24:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmHQQ-0004kA-SV
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 08:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbaKFHYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2014 02:24:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:37187 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750901AbaKFHYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 02:24:05 -0500
Received: (qmail 28271 invoked by uid 102); 6 Nov 2014 07:24:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Nov 2014 01:24:04 -0600
Received: (qmail 32719 invoked by uid 107); 6 Nov 2014 07:24:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Nov 2014 02:24:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Nov 2014 02:24:03 -0500
Content-Disposition: inline
In-Reply-To: <1415255667304-7620693.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 05, 2014 at 10:34:27PM -0800, victor wrote:

> Thanks for the input. With below command, I got new error as below:
> 
> ./configure --prefix=/usr/local/git-2.1.3/ --disable-pthreads
> sudo gmake NO_GETTEXT=1 install
> 
> Undefined                       first referenced
>  symbol                             in file
> type_cas_unlock                     builtin/index-pack.o
> type_cas_lock                       builtin/index-pack.o
> ld: fatal: Symbol referencing errors. No output written to git
> 
> How can I overcome this?

The NO_PTHREADS build was broken in v2.1.2 and v2.1.3. The fix, from
commit e0e2128 (index-pack: fix compilation with NO_PTHREADS,
2014-10-11) is in the current "master" branch. If you want to apply it
manually, it is just:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 792c66c..a369f55 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -185,6 +185,9 @@ static void cleanup_thread(void)
 #define deepest_delta_lock()
 #define deepest_delta_unlock()
 
+#define type_cas_lock()
+#define type_cas_unlock()
+
 #endif

-Peff
