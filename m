From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC 00/11] Foreign VCS helper program for CVS repositories
Date: Mon, 27 Jul 2009 14:58:24 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907271412190.2147@iabervon.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net> <alpine.LNX.2.00.0907271251280.2147@iabervon.org> <200907272011.19430.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVVP6-0002kP-G4
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 20:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbZG0S6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 14:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbZG0S6Z
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 14:58:25 -0400
Received: from iabervon.org ([66.92.72.58]:58779 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbZG0S6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 14:58:24 -0400
Received: (qmail 14173 invoked by uid 1000); 27 Jul 2009 18:58:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jul 2009 18:58:24 -0000
In-Reply-To: <200907272011.19430.johan@herland.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124185>

On Mon, 27 Jul 2009, Johan Herland wrote:

> On Monday 27 July 2009, Daniel Barkalow wrote:
> > On Mon, 27 Jul 2009, Johan Herland wrote:
> > > This series is a first draft towards implementing a foreign VCS
> > > helper program for CVS.
> > >
> > > It is based on the 'db/foreign-scm' and 'jh/notes' topics in 'pu'.
> > > As such, this patch series should apply cleanly to current 'pu'.
> > >
> > > The first 4 patches supply the necessary parts of Daniel Barkalow's
> > > foreign-scm topic that has not yet been merged to 'pu' (i.e.
> > > everything remaining in Daniel's original patch series, except the
> > > p4-specific stuff).
> >
> > I've got some changes to this series in the works; I just made a few
> > changes to share the transport-side code for interacting with the
> > helper with the transport-side code for interacting with
> > native-object helpers. Mainly, this means starting each line in the
> > "list" response with "?" to indicate that you don't know the hash,
> > since the protocol is trying to be compatible with cases where you do
> > know.
> 
> No problem. I'm actually considering whether I should rewrite the CVS 
> helper to a full-fledged git-shim (btw, thanks for the shim work; it 
> looks really promising). I would still probably have to use 
> git-fast-import, but I would have more control over the fast-import 
> process (e.g. by closing the fast-import process myself, I could 
> simplify the code maintaining the marks database).
> 
> With the git-shim feature already having found an excellent use case 
> (the HTTP fetcher), how do you see the future for the foreign-scm 
> topic? I like the idea of rewriting foreign-scm on top of git-shim, but 
> is there anything substantial _left_ in foreign-scm after such a 
> rewrite?

Things that are still there:

 - vcs helpers make active use of the ability to state that there is a 
   remote ref by a particular name, without having any idea what hash it 
   currently holds (until they're told to import it).

 - vcs helper is specified directly by the user's config, possibly to 
   invoke a helper distributed separately; shim helpers are determined by 
   transport_get() when it identifies that the url can be handled by that 
   shim.

 - vcs helpers don't necessarily use URLs, or anything that works in the 
   same way, to identify the remote repo.

 - vcs export wants to deal with the remote server pretty much always 
   rewriting exported commits.

 - For export, the vcs helper is going to want to get the commits ordered 
   in some way that makes each export a single-commit export operation, so 
   that each helper doesn't have to deal with ordering the commits 
   suitably; this is particularly significant because the transport-side 
   code should make sure that the history is something that can be 
   represented in the foreign vcs. The native shim helper wants just the 
   endpoint.

> > > Next, there are 3 patches tweaking and expanding the git-vcs API
> > > (with corresponding implementations in the foreign transport code)
> > > to adjust for the CVS helper's needs.
> >
> > These make sense to me. I assume you're planning to support exporting
> > in some ways, but haven't got it working yet?
> 
> Indeed. The current version is only a first draft that fetches 
> successfully from simple toy repositories (but probably not many 
> real-world CVS repos). I hope to support both fetching and pushing to 
> real-world CVS repos at some point.

Great.
	-Daniel
*This .sig left intentionally blank*
