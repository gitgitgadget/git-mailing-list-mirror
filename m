From: Jeff King <peff@peff.net>
Subject: Re: Bug report: Git 1.8 on Ubuntu 13.10 refs not valid
Date: Mon, 31 Mar 2014 14:01:18 -0400
Message-ID: <20140331180118.GA31023@sigill.intra.peff.net>
References: <5334398E.8090402@gmail.com>
 <20140327184916.GA28668@sigill.intra.peff.net>
 <5339A38D.1080504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Siggi <siggin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:01:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUgWV-0003xa-NA
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbaCaSBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:01:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:51106 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753419AbaCaSBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:01:21 -0400
Received: (qmail 554 invoked by uid 102); 31 Mar 2014 18:01:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 31 Mar 2014 13:01:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Mar 2014 14:01:18 -0400
Content-Disposition: inline
In-Reply-To: <5339A38D.1080504@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245501>

On Mon, Mar 31, 2014 at 07:19:09PM +0200, Siggi wrote:

> here are the two outputs you wanted to see.

The interesting bit is at the end...

> < HTTP/1.1 200 OK
> < Date: Mon, 31 Mar 2014 17:04:57 GMT
> * Server Apache/2.2.22 (Ubuntu) is not blacklisted
> < Server: Apache/2.2.22 (Ubuntu)
> < X-Powered-By: Phusion Passenger (mod_rails/mod_rack) 3.0.19
> < ETag: "2ab570112563de50022189f0a2ffcdd4"
> < Pragma: no-cache
> < Expires: Fri, 01 Jan 1980 00:00:00 GMT
> < X-Runtime: 72
> < Cache-Control: no-cache, max-age=0, must-revalidate
> < Content-Length: 1047
> < Status: 200
> < Content-Type: application/x-git-upload-pack-advertisement; charset=utf-8

This content-type is the problem. There should not be a charset
parameter (it is meaningless, and it throws off git's content-type
check). So your web server configuration (or the redmine git plugin)
should be fixed, but you'll have to talk to redmine folks to figure that
part out.

That being said, git _could_ be more liberal in accepting a content-type
with parameters (even though it does not know about any parameters, and
charset here is completely meaningless). I have mixed feelings on that.

-Peff
