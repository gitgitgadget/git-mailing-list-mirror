From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: remote helpers: best practices for using the "refspec"
 capability
Date: Mon, 30 May 2011 13:43:02 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1105301300520.2233@iabervon.org>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com> <20110529232405.GA8369@elie> <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com> <20110530145203.GA10879@elie> <BANLkTinRscvPLHbob55pxhXSTKqm+eSF6g@mail.gmail.com> <20110530155256.GC10879@elie>
 <20110530164013.GG10879@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 19:44:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR6Vm-0007b9-9q
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 19:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab1E3RoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 13:44:13 -0400
Received: from iabervon.org ([66.92.72.58]:38621 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab1E3RoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 13:44:12 -0400
Received: (qmail 8433 invoked by uid 1000); 30 May 2011 17:43:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 May 2011 17:43:02 -0000
In-Reply-To: <20110530164013.GG10879@elie>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174764>

On Mon, 30 May 2011, Jonathan Nieder wrote:

> Jonathan Nieder wrote:
> 
> > | error: Ref refs/remotes/origin/master is at d94a46270250454f1fc6c1fb47abfde31a2196c9 but expected dfb79bbc658333d5c9b0427b71f6b1bc48629949
> > | From mediawiki::http://localhost/mediawiki
> > |  ! dfb79bb...c57c15b master     -> origin/master  (unable to update local ref)
> > | error: Could not fetch origin
> >
> > which means that the transport machinery thought the helper was going
> > to be fetching directly to "master".  I suspect you will want a
> > 'refspec' capability like
> >
> >	refspec refs/heads/*:refs/mediawiki/${remotename}/*
> >
> > to fix this.
> >
> > Cc-ing Daniel who invented v1.7.0-rc0~62^2~19 (Allow helper to map
> > private ref names into normal names, 2009-11-18).  What namespace
> > should a helper use when asked to fetch to FETCH_HEAD without a remote
> > name, like
> >
> >	git fetch mediawiki::testwiki
> >
> > ?

The main purpose of having the private ref names is to support incremental 
imports, where you obviously need to identify the sha1 of the last thing 
you imported, and you may have included sufficient machine-readable 
information in your imported commit messages to know what the foreign 
state was that generated that sha1. (And you need a namespace because you 
may have multiple refs that you imported.) I'm not sure that it makes much 
sense to do incremental imports without a remote name, since that's 
generally an operation you're not planning do repeatedly.

But the purpose of the namespacing is to be able to continue the correct 
incremental import, so it would make sense to do some arbitrary 
transformation to make your url be a valid ref directory, and use that.

It would make sense to add support for a namespace where fast-import can 
write whatever it wants, and it'll get discarded after the fetch is done, 
if it's the case that anyone can stand not having incremental imports.

	-Daniel
*This .sig left intentionally blank*
