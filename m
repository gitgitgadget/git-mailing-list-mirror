From: Jeff King <peff@peff.net>
Subject: Re: HTTP tests fail on OS X
Date: Fri, 21 Jun 2013 00:30:52 -0400
Message-ID: <20130621043052.GA5318@sigill.intra.peff.net>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 06:31:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upt08-00037w-LB
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 06:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446Ab3FUEa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 00:30:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:34695 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247Ab3FUEa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 00:30:56 -0400
Received: (qmail 3365 invoked by uid 102); 21 Jun 2013 04:31:56 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 23:31:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 00:30:52 -0400
Content-Disposition: inline
In-Reply-To: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228568>

On Fri, Jun 21, 2013 at 12:27:02AM -0400, Brian Gernhardt wrote:

> I've bisected it to this commit:
> 
> > commit 0442743810c6f6c14386a5a9d6bf8e4d69adbc51
> > Author: Jeff King <peff@peff.net>
> > Date:   Sun Jun 9 04:07:59 2013 -0400
> > 
> >     t/lib-httpd/apache.conf: do not use LockFile in apache >= 2.4
> 
> OS X 10.8.4, apache 2.2.22

Hrm. That's quite odd. The patch in its entirety looks like this:

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 542241b..891edd7 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -1,5 +1,7 @@ LockFile accept.lock
 ServerName dummy
+<IfVersion < 2.4>
 LockFile accept.lock
+</IfVersion>
 PidFile httpd.pid
 DocumentRoot www

So it should not be having any effect at all on apache 2.2, unless it
somehow does not like the <IfVersion> tags.

Puzzled...

-Peff
