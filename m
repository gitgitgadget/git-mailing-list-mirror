From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 08/19] rebase -i: root commits are replayed with an
 unnecessary option
Date: Fri, 1 Aug 2014 20:13:22 -0400
Message-ID: <20140802001322.GC20040@peff.net>
References: <53A258D2.7080806@gmail.com>
 <cover.1406589435.git.bafain@gmail.com>
 <7ed1b44ae05860a556d86c8b90ac6fff0906128d.1406589435.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 02:16:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDMzM-0007hs-8i
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 02:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbaHBANa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 20:13:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:44557 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751008AbaHBANa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 20:13:30 -0400
Received: (qmail 19041 invoked by uid 102); 2 Aug 2014 00:13:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Aug 2014 19:13:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Aug 2014 20:13:22 -0400
Content-Disposition: inline
In-Reply-To: <7ed1b44ae05860a556d86c8b90ac6fff0906128d.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254687>

On Tue, Jul 29, 2014 at 01:18:08AM +0200, Fabian Ruch wrote:

> The command line used to recreate root commits specifies the
> effectless option `-C`. It makes git-commit reuse commit message and
> authorship of the named commit. However, the commit being amended
> here, which is the sentinel commit, already carries the authorship
> and log message of the commit being replayed. Remove the option.
> 
> Since `-C` (in contrast to `-c`) does not invoke the editor and the
> `--amend` option invokes it by default, disable editor invocation
> again by specifying `--no-edit`.

I found this description a little backwards. The "-C" does have an
effect, as you noticed in the second paragraph.

I think the reasoning is more like:

  The command line used to recreate root commits uses "-C" to
  suppress the commit editor. This is unnecessarily confusing,
  though, because that suppression is a secondary effect of the
  option. The main purpose of "-C" is to pull the metadata from
  another commit, but here we know that this is a noop, since we
  are amending a commit just created from the same data.

  At the time, commit did not yet know "--no-edit", and this was a
  reasonable way to get the desired behavior. We can switch it to
  use "--no-edit" to make the intended effect more obvious.

-Peff
