From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/5] Document details of transport function APIs
Date: Wed, 25 Mar 2009 14:42:05 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903251435480.19665@iabervon.org>
References: <alpine.LNX.1.00.0903242303250.19665@iabervon.org> <7v63hy9k0l.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0903251142470.19665@iabervon.org> <7vmyb95vky.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmY5l-0003Rn-9Z
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760788AbZCYSmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760121AbZCYSmK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:42:10 -0400
Received: from iabervon.org ([66.92.72.58]:40765 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759700AbZCYSmI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:42:08 -0400
Received: (qmail 5231 invoked by uid 1000); 25 Mar 2009 18:42:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 18:42:05 -0000
In-Reply-To: <7vmyb95vky.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114645>

On Wed, 25 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> > +	 * If, in the process, the transport determines that the
> >> > +	 * remote side actually responded to the push by updating the
> >> > +	 * ref to a different value, the transport should modify the
> >> > +	 * new_sha1 in the ref. (Note that this is a matter of the
> >> > +	 * remote accepting but rewriting the change, not rejecting it
> >> > +	 * and reporting that a different update had already taken
> >> > +	 * place)
> >> > +	 **/
> >> 
> >> It this even a sane thing to allow?  How would it interact with the
> >> "pretend we immediately turned around and fetched them into the remote
> >> tracking branches" local updates we usually do?
> >
> > We already allow a git server to rewrite refs with a hook when it gets 
> > them, and we record the pre-rewriting value. This allows the transport to 
> > propagate the post-rewriting value back (if it can get it), and we'd 
> > update the tracking branches with what the server actually did instead of 
> > what we asked it to (i.e., we do what we would do if we really did turn 
> > around and fetch them immediately).
> 
> But how are you guaranteeing that objects necessary to complete the
> history the remote end re-written are already available on the local end?
> Do you have a reverse object transfer phase now in send-pack protocol?

The current send-pack protocol wouldn't be able to use this feature (I 
don't think it can even report the replacement hashes, so there's little 
danger of that).

The foreign VCS transport would actually reimport the objects (in the 
process of discovering the hash), so that's fine.

> Otherwise I am afraid that you are corrupting the local repository.

It wouldn't be any different from fetch() reporting success when it hadn't 
actually succeeded, but I think it would be worth being explicit here that 
you can't simply report the other end's hash if you may not have it.

	-Daniel
*This .sig left intentionally blank*
