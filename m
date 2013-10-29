From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Mon, 28 Oct 2013 22:08:24 -0400
Message-ID: <20131029020824.GE11861@sigill.intra.peff.net>
References: <20131024122255.GI9378@mwanda>
 <20131024122512.GB9534@mwanda>
 <20131026181709.GB10488@kroah.com>
 <20131027013402.GA7146@leaf>
 <526CA7D4.1070904@alum.mit.edu>
 <20131027071407.GA11683@leaf>
 <526E283A.1070801@alum.mit.edu>
 <CALKQrgfsk3fjyF77XL9+CPyJ_s-AfzkNAj4Eaj1LT-G0Ph=bfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Josh Triplett <josh@joshtriplett.org>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: linux-kernel-owner@vger.kernel.org Tue Oct 29 03:08:38 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VayjT-0003Ue-Qn
	for glk-linux-kernel-3@plane.gmane.org; Tue, 29 Oct 2013 03:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003Ab3J2CI3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 28 Oct 2013 22:08:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:57469 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755879Ab3J2CI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Oct 2013 22:08:28 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2013 22:08:28 EDT
Received: (qmail 31264 invoked by uid 102); 29 Oct 2013 02:08:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 21:08:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 22:08:24 -0400
Content-Disposition: inline
In-Reply-To: <CALKQrgfsk3fjyF77XL9+CPyJ_s-AfzkNAj4Eaj1LT-G0Ph=bfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236888>

On Mon, Oct 28, 2013 at 12:29:32PM +0100, Johan Herland wrote:

> > A hook-based solution could do this.  But a built-in "all-purpose"
> > handler like "footer.Fixes.arg=commit", which was intended to be
> > reusable, wouldn't be able to do such footer-specific extra work without
> > having to create new special cases in git each time.
> 
> Which begs the question (posed to all, not specifically to you): Why
> would we want solve this issue in config instead of in hooks? The
> hooks will always be more flexible and less dependent on making
> changes in git.git. (...a suitably flexible hook could even use the
> config options discussed above as input...) In both cases, we need the
> user to actively enable the functionality (either installing hooks, or
> setting up config), and in both cases we could bundle Git with
> defaults that solve the common cases, so that is not a useful
> differentiator between the two approaches. I would even venture to
> ask: If we end up solving this problem in config and not in hooks,
> then why do we bother having hooks in the first place?

One thing that is much nicer with config vs hooks is that you can manage
config for all of your repositories by tweaking ~/.gitconfig (and that
is where I would expect this type of config to go).

Managing hooks globally means having each repo symlink to a central hook
area, and having the forethought to set up the symlink farm and use
init.templatedir before cloning any repos.  We could probably make this
friendlier by reading from ~/.githooks and defining some semantics for
multiple hooks. E.g., fall back to ~/.githooks if the repo hook is not
executable, or possibly run them both (or even allow multiple instances
of a hook in ~/.githooks, which can help organization), and consider the
hook a failure if any of them fail.

-Peff
