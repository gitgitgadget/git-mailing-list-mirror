From: Mike Hommey <mh@glandium.org>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 07:39:21 +0200
Organization: glandium.org
Message-ID: <20080722053921.GA4983@glandium.org>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 07:40:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLAcB-0007v5-Pl
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 07:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760040AbYGVFjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 01:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758389AbYGVFjp
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 01:39:45 -0400
Received: from vuizook.err.no ([194.24.252.247]:47535 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760028AbYGVFjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 01:39:43 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KLAau-0001Ob-DF; Tue, 22 Jul 2008 07:39:34 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KLAan-0001KR-BY; Tue, 22 Jul 2008 07:39:21 +0200
Content-Disposition: inline
In-Reply-To: <20080722044157.GA20787@sigill.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89439>

On Tue, Jul 22, 2008 at 12:41:57AM -0400, Jeff King wrote:
> On Mon, Jul 21, 2008 at 07:40:28PM -0700, Junio C Hamano wrote:
> 
> > Actually, the situation is now even worse than I originally thought
> > especially with Jeff's pager.<cmd> patch on 'master' recently.  For
> > example, you can screw yourself quite badly by forcing diff-files used in
> > the scripts you run to page, defeating --exit-code option.  Which means
> 
> Actually, you could _always_ do that with "git -p diff-files". Which is
> obviously stupid, just as setting pager.diff-files is. In the reported
> case, though, "status" is broken, which we now do by default. So no
> stupidity required.
> 
> >  (2) Then why are we even allowing to configure the plumbing to page?
> 
>   1. Laziness. We just never marked which shouldn't be allowed to page.
>      But again, in this case, we have explicitly marked status as "this
>      should page" so I don't think this is a plumbing / porcelain thing.
>      Status fulfills both roles here (some people want it paged, because
>      they use it as porcelain, and some people want the exit code).
> 
>   2. We don't always know all git commands. We execute user scripts as
>      "git foo", but we don't know what they do. Worse than that, we have
>      to commit our pager choice early because we might be exec'ing (but
>      this is somewhat of an artifact of the way the code is structured,
>      and not necessarily an impossible obstacle).
> 
> > Should we maintain a table of commands that we allow paging to be
> > customized, and ignore pager.<cmd> for commands that are not in the list?
> 
> The patch below sets up the infrastructure, which is trivial. Note that
> this _doesn't_ handle the case of "git -p status", because we have to
> commit that choice at a different time (again, we might be able to
> overcome that with a little code restructuring).
> 
> This marks diff-files as FORBID_PAGER; I will leave it to others to
> fight about which commands should have it. But it doesn't make sense to
> mark "status" since some people obviously _want_ the paging there.

Why not "simply" forbid the pager when output is not a terminal ?

Mike
