From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Minor : Make ObjectId, RemoteConfig Serializable
Date: Sun, 8 Feb 2009 20:45:22 +0100
Message-ID: <200902082045.22703.robin.rosenberg.lists@dewire.com>
References: <320075ff0902060702n7573aaecu9054626ee9a6991@mail.gmail.com> <320075ff0902080526g2bee8188g395397b06a0c80ee@mail.gmail.com> <20090208191024.GA30557@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nigel Magnay <nigel.magnay@gmail.com>, Git ML <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 08 20:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWFca-0001vm-7t
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 20:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbZBHTp3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 14:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbZBHTp2
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 14:45:28 -0500
Received: from mail.dewire.com ([83.140.172.130]:20326 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbZBHTp1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 14:45:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 95DAE147E880;
	Sun,  8 Feb 2009 20:45:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fboiw9pCq1Cv; Sun,  8 Feb 2009 20:45:24 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id CF743147E7FE;
	Sun,  8 Feb 2009 20:45:24 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <20090208191024.GA30557@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109004>

s=F6ndag 08 februari 2009 20:10:24 skrev Shawn O. Pearce:
> Nigel Magnay <nigel.magnay@gmail.com> wrote:
> > > A problem (big problem) with serialization is that it often leads=
 to
> > > fragile interfaces. One might want to have precise control over
> > > the serialization so a change in the implementation doesn't affec=
t
> > > compatibility. Serializing AnyObjectId should not depend on the
> > > implementation de jour. Second, how do we handle subclasses?
> > >
> > > But maybe leaving it this way would be our way of saying that
> > > the interface may break at any time, promise.
> >=20
> > Well, we can of course implement writeObject / readObject (or do so
> > if/when compatibility breaks, and it's cared about)
> >=20
> > That's how I tend to view it anyway (may break at any time) - you
> > can't just update a jar library to a significantly new version and
> > expect it all to stay compatible. Also for half my use, it's not fo=
r
> > persistence, it's for transferring over the wire to a slave process=
=2E

Over-the wire has the same issue. Clients and servers often run with
slightly different versions.

> > Thinking a bit more clearly, I probably don't need AnyObjectId, jus=
t
> > ObjectId - but I've also missed RefSpec and URIish as they're used =
in
> > RemoteConfig..
>=20
> Here's my two cents... we can do this, but only if we implement
> Externalizable and do the read and write ourselves so we have a
> stable format.

> In the case of any of the types you are discussing there is an easy
> canonical form for them to be written on the wire, or to read back:
>=20
>   ObjectId     - the 20 byte SHA-1
>   RefSpec      - the string form as it appears in the config file
>   URIish       - the string form as it appears in the config file
with our without the password?

>   RemoteConfig - a map of keys/values as it appears in the config

I lean toward the do it correctly side too. Don't forget a few test cas=
es
with pre-recorded serializations to verify compatibility over different
versions of jgit.

-- robin
