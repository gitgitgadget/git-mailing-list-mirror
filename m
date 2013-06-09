From: Jeff King <peff@peff.net>
Subject: [RFH/PATCH 0/4] git http tests with apache 2.4
Date: Sun, 9 Jun 2013 04:07:22 -0400
Message-ID: <20130609080722.GA31699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 10:07:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulaf4-00031N-4n
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 10:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab3FIIHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 04:07:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:33122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab3FIIHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 04:07:25 -0400
Received: (qmail 21438 invoked by uid 102); 9 Jun 2013 08:08:14 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 03:08:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 04:07:22 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226943>

Apache 2.4 recently shipped in Debian unstable, and I noticed that all
of the git httpd tests stopped working. It turns out that some
configuration directives have changed between 2.2 and 2.4, and the httpd
server would not start at all.

With this series, the tests run again (for me, at least). The
"<IfVersion>" checks hopefully mean that there are no regressions for
people running 2.2 and lower.

However, the final patch is very unsatisfactory. We have to pick an MPM
module to mention in the config, but we don't have any idea what's
available. I suspect what I have provided will work on most Unix-ish
systems. Under Windows, there is a totally different MPM. But I am not
sure that our http tests run at all on Windows, as we seem to check in
lib-httpd.sh for a Unix-ish apache module path.

As far as I know, Apache does not have a "try to load this module and
fallback" directive. We could perhaps look in the module directory and
try to do something clever in the shell before starting Apache. Advice
from Apache gurus is welcome.

  [1/4]: t/lib-httpd/apache.conf: do not use LockFile in apache >= 2.4
  [2/4]: t/lib-httpd/apache.conf: load extra auth modules in apache 2.4
  [3/4]: t/lib-httpd/apache.conf: load compat access module in apache 2.4
  [4/4]: t/lib-httpd/apache.conf: configure an MPM module for apache 2.4

-Peff
