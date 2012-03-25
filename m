From: Jeff King <peff@peff.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sat, 24 Mar 2012 22:32:15 -0400
Message-ID: <20120325023215.GA13958@sigill.intra.peff.net>
References: <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net>
 <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net>
 <4F6A33C5.2080909@gmx.net>
 <20120321201722.GA15021@sigill.intra.peff.net>
 <4F6E3373.7090500@gmx.net>
 <20120325010609.GB27651@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 04:32:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBdGG-0008A4-HW
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 04:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab2CYCcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 22:32:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58824
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021Ab2CYCcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 22:32:17 -0400
Received: (qmail 31131 invoked by uid 107); 25 Mar 2012 02:32:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Mar 2012 22:32:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Mar 2012 22:32:15 -0400
Content-Disposition: inline
In-Reply-To: <20120325010609.GB27651@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193857>

On Sat, Mar 24, 2012 at 09:06:09PM -0400, Jeff King wrote:

> That's weird. 405 is "Method Not Allowed". Clone shouldn't be doing
> anything more exotic than GET and POST. And the prior tests pass, so it
> means that it's working in general. The only thing different about this
> test is that apache is configured to use mod_rewrite to issue a
> redirect.
> 
> Does your machine have mod_rewrite installed and enabled? I would think
> apache would complain at startup if it wasn't.  I wonder if there's
> something non-portable in the minimal apache config we ship.
> 
> Does httpd/error.log in the trash directory say anything interesting?

Also, does it work any better with this patch?

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 3c12b05..714760d 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -61,9 +61,8 @@ ScriptAlias /smart_noexport/ ${GIT_EXEC_PATH}/git-http-backend/
 	Options ExecCGI
 </Files>
 
-RewriteEngine on
-RewriteRule ^/smart-redir-perm/(.*)$ /smart/$1 [R=301]
-RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
+RedirectMatch 301 ^/smart-redir-perm/(.*)$ /smart/$1
+RedirectMatch 302 ^/smart-redir-temp/(.*)$ /smart/$1
 
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
