From: Fraser Tweedale <frase@frase.id.au>
Subject: Re: [PATCH] documentation: add git transport security notice
Date: Tue, 25 Jun 2013 07:57:35 +1000
Message-ID: <20130624215733.GU2457@bacardi.hollandpark.frase.id.au>
References: <1372069414-12601-1-git-send-email-frase@frase.id.au>
 <7vppvbbhoi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 23:57:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrElf-00047A-IT
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 23:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab3FXV5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 17:57:43 -0400
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:59985
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750958Ab3FXV5m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 17:57:42 -0400
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r5OLvaZU039123;
	Tue, 25 Jun 2013 07:57:36 +1000 (EST)
	(envelope-from frase@frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r5OLvZ2W039122;
	Tue, 25 Jun 2013 07:57:35 +1000 (EST)
	(envelope-from frase@frase.id.au)
X-Authentication-Warning: bacardi.hollandpark.frase.id.au: fraser set sender to frase@frase.id.au using -f
Content-Disposition: inline
In-Reply-To: <7vppvbbhoi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228911>

On Mon, Jun 24, 2013 at 09:24:29AM -0700, Junio C Hamano wrote:
> Fraser Tweedale <frase@frase.id.au> writes:
> 
> > The fact that the git transport has no end-to-end security is easily
> > overlooked.  Add a brief security notice to the "GIT URLS" section
> > of the documentation stating that the git transport should be used
> > with caution on unsecured networks.
> >
> > Signed-off-by: Fraser Tweedale <frase@frase.id.au>
> > ---
> >  Documentation/urls.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> > index 3ca122f..c218af5 100644
> > --- a/Documentation/urls.txt
> > +++ b/Documentation/urls.txt
> > @@ -11,6 +11,9 @@ and ftps can be used for fetching and rsync can be used for fetching
> >  and pushing, but these are inefficient and deprecated; do not use
> >  them).
> >  
> > +The git protocol provides no end-to-end security and should be used
> > +with caution on unsecured networks.
> 
> Is this necessary?
> 
> I thought we already say the git protocol does not even authenticate
> elsewhere in the document, and if not, I think it is a sensible
> thing to say here.  And once it is done, I doubt it is necessary to
> bring up a narrower concept such as "end-to-end security" which
> requires a lot more than authentication.
> 
Certainly in this part of the documentation there is no mention of
(lack of) authentication or security concerns.  git-daemon(1) does
mention the lack of authentication in the SERVICES/receive-pack
section.

Once you are aware that the git transport is insecure it seems
obvious in hindsight, but even as a security-minded person I simply
overlooked this until recently.  A brief note in the GIT URLS
section (which is included in the man pages for a number of
essential commands) would have brought this to my attention much
sooner.

Junio, do you prefer the following more generic wording?  If so I
will re-roll the patch (also note s/protocol/transport/ which is
more appropriate, I think).

 The git transport is insecure and should be used with caution on
 unsecured networks.

> The only thing git protocol ensures is that the receiving end
> validates that what is fetched from an unknown server, and what is
> pushed by an unknown pusher, is internally consistent.
> 
> If you allowed a push over the git protocol by enabling the
> receive-pack service in "git daemon" (not recommended), you may
> allow anonymous users to delete branches and to do other funky
> things unless you protect your repository with pre-receive hook, but
> that won't corrupt the repository (of course, deleting all the refs
> may make the repository an empty but not corrupt one, which is just
> as unusable as a corrupt one, so there may not be a huge practical
> difference).  If you fetched from an unauthenticated server,
> possibly with MITM, over the git protocol, you may end up getting
> something you did not ask for, but the resulting history in your
> repository would still be internally consistent (the commits may be
> malicious ones, of course, but that is what signed tags are there to
> protect you against).
