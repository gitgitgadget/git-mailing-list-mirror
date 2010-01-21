From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http/remote-curl: coddle picky servers
Date: Thu, 21 Jan 2010 17:07:07 +0100
Message-ID: <20100121160707.GA31276@glandium.org>
References: <20100121004756.GA18213@onerussian.com>
 <20100121050850.GA18896@Knoppix>
 <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
 <20100121155136.17b59e8f.rctay89@gmail.com>
 <20100121140054.GH18213@onerussian.com>
 <20100121224100.624c9c9d.rctay89@gmail.com>
 <20100121155637.GA19078@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 17:09:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXzZ6-0004gi-LZ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab0AUQHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241Ab0AUQHT
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:07:19 -0500
Received: from vuizook.err.no ([85.19.221.46]:45151 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab0AUQHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:07:18 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NXzYq-00022y-9b; Thu, 21 Jan 2010 17:07:10 +0100
Received: from mh by jigen with local (Exim 4.71)
	(envelope-from <mh@jigen>)
	id 1NXzYp-0008B2-CR; Thu, 21 Jan 2010 17:07:07 +0100
Content-Disposition: inline
In-Reply-To: <20100121155637.GA19078@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137661>

On Thu, Jan 21, 2010 at 07:56:37AM -0800, Shawn O. Pearce wrote:
> Tay Ray Chuan <rctay89@gmail.com> wrote:
> > When "info/refs" is a static file and not behind a CGI handler, some
> > servers may not handle a GET request for it with a query string
> > appended (eg. "?foo=bar") properly.
> > 
> > If such a request fails, retry it sans the query string. In addition,
> > ensure that the "smart" http protocol is not used (a service has to be
> > specified with "?service=<service name>" to be conformant).
> > 
> > Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> > Reported-and-tested-by: Yaroslav Halchenko <debian@onerussian.com>
> 
> *grumble* stupid Apache *grumble*

stupid Apache... configuration.

Check the error message you get on
http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack:

The requested URL /gitweb.cgigit/pkg-exppsy/pymvpa.git/info/refs was not
found on this server.

Look closely at the start of the requested URL: /gitweb.cgi...
It comes from this rule:

RewriteCond %{QUERY_STRING} ^(.+)$
RewriteRule ^/(.*)$ /gitweb.cgi$1 [L,PT]

which is global to the virtual host.

Anyways, while git.debian.org can certainly be fixed for that, other
servers may want to do some different things with urls with parameters.

Mike
