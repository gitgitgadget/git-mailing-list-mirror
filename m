From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Disambiguate "push not supported" from
	"repository not found"
Date: Mon, 1 Sep 2008 22:42:13 -0700
Message-ID: <20080902054213.GE13248@spearce.org>
References: <1219969118-31672-1-git-send-email-spearce@spearce.org> <48B7E927.2000205@gmail.com> <20080829143116.GB7403@spearce.org> <200808311028.59348.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 07:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaOgQ-000196-K2
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 07:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbYIBFmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 01:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYIBFmO
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 01:42:14 -0400
Received: from george.spearce.org ([209.20.77.23]:34277 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbYIBFmO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 01:42:14 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B351038375; Tue,  2 Sep 2008 05:42:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808311028.59348.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94647>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> fredagen den 29 augusti 2008 16.31.16 skrev Shawn O. Pearce:
> > Marek Zawirski <marek.zawirski@gmail.com> wrote:
> > > Robin Rosenberg wrote:
> > >>
> > >> Why an extra method for instantiating the exception?
> > >
> > > Isn't it overrode in subclass - BasePackPushConnection?
> > 
> > Correct.  I introduced the method so the subclass can inject its
> > own implementation for the catch block.  But its required to give
> > back a TransportException so the catch block can throw it, as we
> > do not want the subclass to be able to continue at this point.
> 
> Mind if I squash this into the patch?

No, not at all.  This looks fine.
 

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
> index e35f850..16e4897 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
> @@ -182,6 +182,15 @@ private void readAdvertisedRefsImpl() throws IOException {
>                 available(avail);
>         }
> 
> +       /**
> +        * Create an exception to indicate problems finding a remote repository. The
> +        * caller is expected to throw the returned exception.
> +        *
> +        * Subclasses may override this method to provide better diagnostics.
> +        *
> +        * @return a TransportException saying a repository cannot be found and
> +        *         possibly why.
> +        */
>         protected TransportException noRepository() {
>                 return new NoRemoteRepositoryException(uri, "not found.");
>         }

-- 
Shawn.
