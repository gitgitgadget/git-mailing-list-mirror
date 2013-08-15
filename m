From: Jeff King <peff@peff.net>
Subject: Re: Bug? ignored files overwritten by checkout
Date: Thu, 15 Aug 2013 08:06:58 -0400
Message-ID: <20130815120658.GA22102@sigill.intra.peff.net>
References: <kuhsn7$84r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Damien Robert <damien.olivier.robert+gmane@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 14:07:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9wKe-0003uM-ES
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 14:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab3HOMHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 08:07:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:46632 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab3HOMHE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 08:07:04 -0400
Received: (qmail 20636 invoked by uid 102); 15 Aug 2013 12:07:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Aug 2013 07:07:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Aug 2013 08:06:58 -0400
Content-Disposition: inline
In-Reply-To: <kuhsn7$84r$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232343>

On Thu, Aug 15, 2013 at 06:33:11AM +0000, Damien Robert wrote:

> git init
> git commit --allow-empty -m "init"
> git checkout -b test
> echo foo > foo
> git add foo
> git commit -am 'add foo'
> git checkout master
> echo 'Important data' > foo #[1]
> echo foo > .gitignore
> git checkout test
> 
> If I tried a `git checkout test` after [1], I would get the error message 
>     error: The following untracked working tree files would be overwritten by checkout: foo
> But after adding foo to .gitignore, I am able to checkout to branch test
> without warning. Of course this overwrites foo to the version in test.

This is by design. Marking a file in .gitignore tells git that the
content is not precious and can be removed if need be. For most ignored
files, this is what you want (e.g., you mark "*.o" as ignored because it
is generated; you do not want to add it, and you can always make it
again).

The less common case is a file that is precious and needs to live inside
your repository directory, but which you do not want to add (e.g., a
config file that affects your project, but should not ever be
committed).  People have occasionally asked for a .gitignore-like
mechanism to mark such files as "precious but do not add".  However,
nobody has actually implemented anything.

-Peff
