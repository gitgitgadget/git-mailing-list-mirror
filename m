From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 3/6] Add a method to get refs by object Id
Date: Mon, 6 Oct 2008 15:43:48 -0700
Message-ID: <20081006224348.GB13687@spearce.org>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com> <20081006081554.GD27516@spearce.org> <200810070037.53841.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 00:45:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmyp2-0001eH-UK
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 00:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbYJFWnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbYJFWnt
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 18:43:49 -0400
Received: from george.spearce.org ([209.20.77.23]:57320 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbYJFWns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 18:43:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 58DE53835F; Mon,  6 Oct 2008 22:43:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200810070037.53841.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97641>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> m=C3=A5ndagen den 6 oktober 2008 10.15.54 skrev Shawn O. Pearce:
> > Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > > =20
> > >  	/**
> > > +	 * @return a map with all objects referenced by a peeled ref.
> > > +	 */
> > > +	public Map<AnyObjectId, List<Ref>> getAllRefsByPeeledObjectId()=
 {
> >=20
> > Do we really want to promise List here?  Can we make it just
> > Collection instead?
>
> Sure. Our promise is actually slightly better, it is Set, but Java do=
esn't have a suitable class for that.

java.util.Set?  java.util.HashSet?

What am I missing?
=20
> > > +		for (Map.Entry<String,Ref> e : allRefs.entrySet()) {
> > > +			Ref ref =3D e.getValue();
> >=20
> > I think this is cleaner:
> >=20
> > 	for (Ref ref : allRefs.values()) {
> >=20
> > as you never use the key.
>
> Yes. I was thinking it might be less efficient, but the JDK implement=
ation looks quite well optimized in 1.6 at least
> so values() is slightly faster.

I wasn't concerned about performance, I was going for readability.
This loop is probably not performance critical as its done once
early when the PlotWalk starts.  I just found that grabbing the
entrySet when all you care about is the values was odd.
=20
> > 	List<Ref> nl =3D Collections.singletonList(ref);
> > 	List<Ref> ol =3D ret.put(target, nl);
> > 	if (ol !=3D null) {
> > 		if (ol.size() =3D=3D 1) {
> > 			nl =3D new ArrayList<Ref>(2);
> > 			nl.add(ol.get(0));
> > 			nl.add(ref);
> > 			ret.put(target, nl);
> > 		} else {
> > 			ol.add(ref)
> > 			ret.put(target, ol);
> > 		}
> > 	}
>=20
> ok, I guess one just has has to include the comment on why for the ca=
sual reader.=20

I'm probably too used to this pattern of "put, then test" because
I use it a lot when the odds of put returning null are very high.
Its an odd idiom.  I think most developers wouldn't write it.
So I guess a comment of some sort is probably a good idea if you
chose to use this mess.  ;-)

--=20
Shawn.
