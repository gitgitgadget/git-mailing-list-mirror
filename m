From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, 4th version] git-branch: register where to merge from, when branching off a remote branch
Date: Fri, 2 Mar 2007 05:32:40 -0500
Message-ID: <20070302103240.GA13217@coredump.intra.peff.net>
References: <45E69297.8070001@lu.unisi.ch> <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com> <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com> <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch> <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E7DC04.5010701@lu.unisi.ch> <45E7E53E.5020704@gnu.org> <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 11:33:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN54u-0001rO-Jz
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 11:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbXCBKco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 05:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933318AbXCBKco
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 05:32:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3739 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933316AbXCBKcn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 05:32:43 -0500
Received: (qmail 24997 invoked from network); 2 Mar 2007 05:32:57 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Mar 2007 05:32:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2007 05:32:40 -0500
Content-Disposition: inline
In-Reply-To: <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41186>

On Fri, Mar 02, 2007 at 01:52:29AM -0800, Junio C Hamano wrote:

>  - (moderately serious) The code blindly trusts that
>    "refs/remotes/foo/bar" tracks "refs/heads/bar" from remote
>    named "foo", which is a bit disturbing.  With the default
>    configuration git-clone and git-remote creates, it always is
>    the case, but I suspect you might want to at least verify
>    that assumption (the user can have different settings in the
>    config), if not figuring them out by reading the existing
>    configuration yourself.

Sorry to come into this conversation a bit late, but I am catching up on
git reading. I agree that this assumption seems a bit suspect; this is
the exact sort of thing I was envisioning a 'mergeLocal' or similar
config option for; it avoids the need to make the reverse mapping.

In fact, the way I thought about it was that branching might set the
branch.*.branched_from variable. Then any porcelain which wanted
to have a sane default for various operations (merge, rebase, etc) could
use their regular, user-specified config (e.g., merge checks
branch.*.merge; if not set, it defaults to branch.*.branched_from; if
not set, barf).

Thus you are compatible with the config features we have now, but in the
case where we would currently die, this gives another option. It is
safer to remove this variable on branch deletion (I know some people
raised concerns about automatically removing parts of the config file)
because the user would never set 'branched_from'; they would set
'merge'.

IOW, my point is that branching should write the information it _knows_
into the config: branch X was branched from branch Y. It should be up to
the programs to _use_ that information in a reasonable way. As it is
now, this patch makes the decision about how to use the information at
the time of branching, which seems to be the source of a lot of objects.

My 2 cents,
-Peff
