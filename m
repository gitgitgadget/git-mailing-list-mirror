From: Jeff King <peff@peff.net>
Subject: Re: Git clone behave strange after active branch change in bare repo
Date: Mon, 12 Mar 2012 07:12:42 -0400
Message-ID: <20120312111242.GA12921@sigill.intra.peff.net>
References: <CA+OUE95+Ux_+hSRJw6MH-kh54JewXx-fbWqBoh-Eh_P1tNwAFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Zdenek Crha <zdenek.crha@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 12:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S73BR-0007BE-1q
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 12:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab2CLLMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 07:12:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47603
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027Ab2CLLMp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 07:12:45 -0400
Received: (qmail 14887 invoked by uid 107); 12 Mar 2012 11:12:55 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Mar 2012 07:12:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2012 07:12:42 -0400
Content-Disposition: inline
In-Reply-To: <CA+OUE95+Ux_+hSRJw6MH-kh54JewXx-fbWqBoh-Eh_P1tNwAFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192852>

On Mon, Mar 12, 2012 at 11:10:03AM +0100, Zdenek Crha wrote:

> When I run git clone while 'master' and 'a_branch' point to same
> commit, I will get clone with default branch 'master' where I would
> expect default branch 'a_branch'.

Yes, this is a known issue. The git protocol does not transfer the
contents of the symref; the client must guess the branch name from the
set of refs that are advertised. This has been discussed before, and
there were even some patches proposed, but I think nobody cared enough
to push it through, as it requires an extension to the protocol.

You can search the list archives for past discussions.

> I did few more checks and it seems to me that:
> 
> * when active branch is 'master' then default branch in clone is
> always master as expected
> * when active branch is different from 'master', then the default
> branch in clone is a first branch in alfabetically sorted list of
> branches that point to same commit as active branch

Exactly. The relevant code is in remote.c:guess_remote_head.

-Peff
