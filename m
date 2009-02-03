From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Fix AbstractTreeIterator path comparion betwen
	'a' and 'a/b'
Date: Tue, 3 Feb 2009 09:03:37 -0800
Message-ID: <20090203170337.GX26880@spearce.org>
References: <1233605617-14513-1-git-send-email-torarnv@gmail.com> <20090203161539.GV26880@spearce.org> <49887274.8040601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:06:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOhu-0002l9-6X
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZBCRDk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 12:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbZBCRDk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:03:40 -0500
Received: from george.spearce.org ([209.20.77.23]:47018 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbZBCRDj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:03:39 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id CB33A38210; Tue,  3 Feb 2009 17:03:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49887274.8040601@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108216>

Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> Shawn O. Pearce wrote:
> > Aside from this test not running, Eclipse says the tests pass.  But
> > Maven tells another story: Tests run: 773, Failures: 3, Errors: 0
>=20
> Strange :/
>=20
> Nevertheless, there shouldn't be any failures, I see all three of the=
m
> when running in Eclipse, so I messed up, sorry for that. Will fix ASA=
P.

OK, so I think this is a valid test case, and as it turns out,
it passes with the library unmodified:

--8<--
+	public void testPathCompare() throws Exception {
+		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
+				new FakeTreeIterator("a", FileMode.TREE)) =3D=3D 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.REGULAR_FILE).pathComp=
are(
+				new FakeTreeIterator("a", FileMode.REGULAR_FILE)) =3D=3D 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.REGULAR_FILE).pathComp=
are(
+				new FakeTreeIterator("a", FileMode.TREE)) < 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
+				new FakeTreeIterator("a", FileMode.REGULAR_FILE)) > 0);
+	}
----

Which means whatever problem you have been seeing in the decorator
code is different than what we were originally thinking.  Perhaps you
are trying to use the tree iterator APIs in a way that they aren't
meant to be used (like passing in full paths where only a path name
component is expected?), or there is something else lurking that
we don't understand.

--=20
Shawn.
