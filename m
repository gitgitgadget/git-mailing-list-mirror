From: Jeff King <peff@peff.net>
Subject: Re: Cannot clone redirecting stdout
Date: Fri, 11 Sep 2009 06:23:29 -0400
Message-ID: <20090911102329.GA13044@sigill.intra.peff.net>
References: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Aloisio <aloisiojr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 12:23:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm3I5-0004fj-7S
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 12:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbZIKKX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 06:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbZIKKX3
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 06:23:29 -0400
Received: from peff.net ([208.65.91.99]:44488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbZIKKX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 06:23:28 -0400
Received: (qmail 6283 invoked by uid 107); 11 Sep 2009 10:23:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 11 Sep 2009 06:23:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 06:23:29 -0400
Content-Disposition: inline
In-Reply-To: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128185>

On Thu, Sep 10, 2009 at 07:33:21PM -0300, Aloisio wrote:

> I faced a problem when trying to clone git://gitorious.org/qt/qt.git
> 
> this works:
> git clone -n git://gitorious.org/qt/qt.git repo
> 
> this doesn't:
> git clone -n git://gitorious.org/qt/qt.git repo >log
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed

I can reproduce the problem here. But after staring at the strace for a
long time, I don't think the problem is on the client side. The remote
end _does_ hang up unexpectedly.

Looking at what we send, the only difference between the redirected and
unredirected case I could find is that we send the "no-progress" flag to
the server, which then hangs up on us instead of sending us the pack.
Which makes no sense.

Confused,
-Peff
