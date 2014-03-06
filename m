From: Jeff King <peff@peff.net>
Subject: Re: Testing for commit reachability through plumbing commands
Date: Thu, 6 Mar 2014 15:23:19 -0500
Message-ID: <20140306202319.GB29659@sigill.intra.peff.net>
References: <CACPiFCJLyE6XC9dY_eawe2y9gS4YsPdTbqkKAd0dcPXd5-eMCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLepC-0003Rz-78
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 21:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbaCFUXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 15:23:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:34314 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752545AbaCFUXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 15:23:21 -0500
Received: (qmail 28870 invoked by uid 102); 6 Mar 2014 20:23:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 14:23:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 15:23:19 -0500
Content-Disposition: inline
In-Reply-To: <CACPiFCJLyE6XC9dY_eawe2y9gS4YsPdTbqkKAd0dcPXd5-eMCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243547>

On Thu, Mar 06, 2014 at 12:17:34PM -0500, Martin Langhoff wrote:

> I have a shell script that trims old history on a cronjob. This is for
> a repo that is used to track reports that have limited "life" (like
> logs). Old history is trimmed with grafts pointing to an empty "root"
> commit.
> 
> Right now, info/graft grows unbound. I am looking for a way to trim
> unreachable grafts, I would like to be able to say something like:
> 
>  git is-reachable treeish

How about:

    git rev-list --objects --all |
    cut -d' ' -f1 |
    grep $(git rev-parse treeish)

Add "--reflog" to the rev-list invocation if you want to catch things
referenced by the reflog, too.

If you're looking for a commit, you can drop the "--objects", and it
will run much faster.

-Peff
