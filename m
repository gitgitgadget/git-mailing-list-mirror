From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Minor : Make ObjectId, RemoteConfig Serializable
Date: Sun, 8 Feb 2009 11:10:24 -0800
Message-ID: <20090208191024.GA30557@spearce.org>
References: <320075ff0902060702n7573aaecu9054626ee9a6991@mail.gmail.com> <320075ff0902061315g3f8b9c9bj92f528e700d59c50@mail.gmail.com> <200902080313.21785.robin.rosenberg.lists@dewire.com> <320075ff0902080526g2bee8188g395397b06a0c80ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 20:11:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWF4K-0000w8-Ny
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 20:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbZBHTK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 14:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbZBHTK0
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 14:10:26 -0500
Received: from george.spearce.org ([209.20.77.23]:45117 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbZBHTKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 14:10:25 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id ABE7238210; Sun,  8 Feb 2009 19:10:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <320075ff0902080526g2bee8188g395397b06a0c80ee@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109000>

Nigel Magnay <nigel.magnay@gmail.com> wrote:
> > A problem (big problem) with serialization is that it often leads to
> > fragile interfaces. One might want to have precise control over
> > the serialization so a change in the implementation doesn't affect
> > compatibility. Serializing AnyObjectId should not depend on the
> > implementation de jour. Second, how do we handle subclasses?
> >
> > But maybe leaving it this way would be our way of saying that
> > the interface may break at any time, promise.
> 
> Well, we can of course implement writeObject / readObject (or do so
> if/when compatibility breaks, and it's cared about)
> 
> That's how I tend to view it anyway (may break at any time) - you
> can't just update a jar library to a significantly new version and
> expect it all to stay compatible. Also for half my use, it's not for
> persistence, it's for transferring over the wire to a slave process.
> 
> Thinking a bit more clearly, I probably don't need AnyObjectId, just
> ObjectId - but I've also missed RefSpec and URIish as they're used in
> RemoteConfig..

Here's my two cents... we can do this, but only if we implement
Externalizable and do the read and write ourselves so we have a
stable format.

In the case of any of the types you are discussing there is an easy
canonical form for them to be written on the wire, or to read back:

  ObjectId     - the 20 byte SHA-1
  RefSpec      - the string form as it appears in the config file
  URIish       - the string form as it appears in the config file
  RemoteConfig - a map of keys/values as it appears in the config

-- 
Shawn.
