From: Jeff King <peff@peff.net>
Subject: Re: git cloning paths
Date: Fri, 13 Jul 2012 04:07:31 -0400
Message-ID: <20120713080731.GA32303@sigill.intra.peff.net>
References: <CANmEAK_jGdzR9R=0DexC+-_0U6mb_7o_v5zSKTuhgoaYCaSiFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Douglas Garstang <doug.garstang@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 10:07:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spauk-0000J9-68
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 10:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab2GMIHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 04:07:38 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:58674
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab2GMIHf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 04:07:35 -0400
Received: (qmail 32734 invoked by uid 107); 13 Jul 2012 08:07:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jul 2012 04:07:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2012 04:07:31 -0400
Content-Disposition: inline
In-Reply-To: <CANmEAK_jGdzR9R=0DexC+-_0U6mb_7o_v5zSKTuhgoaYCaSiFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201394>

On Thu, Jul 12, 2012 at 03:17:09PM -0700, Douglas Garstang wrote:

> I'm a relative newcomer to git and I've just inherited a setup where
> all of the company's code is in a single git repository. Within this
> repository are multiple projects. It seems that git doesn't natively
> allow cloning/checking out of individual paths within the repo (ie
> projects), which would seem to make integrating git with a continuous
> build system rather difficult. That is, the build system has to clone
> the entire repo, and therefore a change to any project will result in
> the entire contents of the repo being built.
> 
> Correct....?

Yes. The feature you are looking for is either "sparse checkout" (only
check out a subset of the files in the repository databse to the working
tree) or "sparse clone" (only copy a subset of the files into the local
repository database during clone). Git v1.7.0 and later has sparse
checkout (see the "sparse checkout" section in "git help read-tree").
There is no implementation for sparse clone (and not likely to be one
any time soon, as it introduces a lot of complexity into the object
negotiation phase).

The usual advice is that you should break up your big repository into
logical projects. You can do so with git-filter-branch, but beware that
this involves rewriting history, which means a flag day for everybody
switching to the new history (or dealing with migrating commits from the
old history to the new history via rebase).

Finally, if you have a build system which is cloning repeatedly, you may
want to keep a repository on the build server all the time and just
fetch the updates into it. This is much more efficient even if you do
end up paring down your repository.

-Peff
