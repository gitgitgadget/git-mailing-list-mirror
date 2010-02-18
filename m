From: Jeff King <peff@peff.net>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 21:04:09 -0500
Message-ID: <20100218020409.GA20960@coredump.intra.peff.net>
References: <201002171627.57599.arvidjaar@mail.ru>
 <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
 <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com>
 <20100218011620.GA15870@coredump.intra.peff.net>
 <32541b131002171751n454081a9w90f2957d7a40d87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 03:04:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhvkZ-0002up-0r
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 03:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab0BRCEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 21:04:13 -0500
Received: from peff.net ([208.65.91.99]:33413 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866Ab0BRCEN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 21:04:13 -0500
Received: (qmail 23970 invoked by uid 107); 18 Feb 2010 02:04:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 17 Feb 2010 21:04:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2010 21:04:09 -0500
Content-Disposition: inline
In-Reply-To: <32541b131002171751n454081a9w90f2957d7a40d87@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140284>

On Wed, Feb 17, 2010 at 08:51:27PM -0500, Avery Pennarun wrote:

> On Wed, Feb 17, 2010 at 8:16 PM, Jeff King <peff@peff.net> wrote:
> > Agreed. It's a minor point, but one that can mislead users who don't
> > know about packed refs. Maybe something like this?
> 
> Wow, you really go all out.  Looks pretty good to me, except maybe this:

Well, if we're going to spend the mental energy to change one spot, we
may as well grep and change them all. :)

> > ++
> > +For any of the `$GIT_DIR/refs` cases above, packed refs from
> > +`$GIT_DIR/packed-refs` may be substituted (e.g., a line with
> > +`refs/heads/master` in the packed-refs file would have the same
> > +precedence as the file `$GIT_DIR/refs/heads/master`).
> 
> Are they really equal precedence?  How does git decide, when there's
> one of each?  I'd guess packed-refs might actually be strictly higher
> precedence, but I'm not sure.

No, packed refs are just below actual ref files in precedence, because
any writes since the pack will be in the actual ref file. What I meant
by "same precedence" was that a packed ref behaves in the lookup
precedence "as if" its ref file existed.

Perhaps it should read:

  (e.g., a line with `refs/heads/master` in the packed-refs file would
  have precedence just below `$GIT_DIR/refs/heads/master` but above
  `$GIT_DIR/refs/remotes/master`)

but that is really conflating two types of precedence (packed refs
versus ref files, and fully-qualifying ref names). They do form a strict
ordering when combined, but that does not necessarily mean that is the
best way for users to understand what is happening.

Maybe that section should also just lose the $GIT_DIR/ from all of the
refs examples, and then we should note later that they may come from
$GIT_DIR or from packed-refs.

-Peff
