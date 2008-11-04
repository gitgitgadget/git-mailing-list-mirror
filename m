From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libxdiff and patience diff
Date: Tue, 04 Nov 2008 16:23:51 +0100
Message-ID: <20081104152351.GA21842@artemis.corp>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/WwmFnJnmDyWGHa4";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: davidel@xmailserver.org, Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 04 16:25:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxNmH-00030R-4n
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 16:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbYKDPX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 10:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbYKDPX4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 10:23:56 -0500
Received: from pan.madism.org ([88.191.52.104]:48586 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254AbYKDPXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 10:23:54 -0500
Received: from madism.org (unknown [213.223.38.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 31D84F8DB;
	Tue,  4 Nov 2008 16:23:52 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 33A1A384EA; Tue,  4 Nov 2008 16:23:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100082>


--/WwmFnJnmDyWGHa4
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2008 at 02:34:37PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 4 Nov 2008, Pierre Habouzit wrote:
>=20
> > On Tue, Nov 04, 2008 at 05:39:48AM +0000, Johannes Schindelin wrote:
> >=20
> > > On Tue, 4 Nov 2008, Pierre Habouzit wrote:
> > >=20
> > > > I've been working tonight, trying to make libxdiff support the=20
> > > > patience diff algorithm, but I've totally failed, because I=20
> > > > _thought_ I understood what xdl_split was doing, but it appears I=
=20
> > > > don't.
> > >=20
> > > I thought about it, too, at the GitTogether, although I want to finis=
h=20
> > > my jGit diff first.
> > >=20
> > > The main idea I had about patience diff is that you can reuse a lot o=
f=20
> > > functions in libxdiff.
> > >=20
> > > But the requirement of taking just unique lines/hashes into account,=
=20
> > > and _after_ splitting up, _again_ determine uniqueness _just_ in the=
=20
> > > between-hunk part made me think that it may be wiser to have a=20
> > > separate function for the patience diff stuff.
> > >=20
> > > Basically, you would start to have libxdiff split the lines and hash=
=20
> > > them as normal, but then determine the unique hashes (I'd start with=
=20
> > > the smaller text, just to have a better chance to end up with unique=
=20
> > > hashes).
> > >=20
> > > Once they are determined, you can search for those exact lines (hash=
=20
> > > first) in the post-document.
> >=20
> > Actually my current implementation just puts all the hashes into an=20
> > array, sorts them by hash (which is O(n log(n)) with the position from=
=20
> > left or right file it's in, ordered by increasing right position. (and=
=20
> > the struct is filled with the left pos to -1 if the right pos is set,=
=20
> > and vice versa).
>=20
> Yeah, that would be much more efficient using a hash-multiset.  Still=20
> linear size (albeit twice as much).  And you can already discard double=
=20
> entries early (although you have to keep one pointer in the hash-multiset=
=20
> to prevent other identical lines from being misdetected as "unique").

Probably, I just wanted something to work first, and then optimize it
using the proper structure.

> I am not sure that you really end up with patience diff that way.  I=20
> _think_ that you need to determine the longest sequence of unique lines=
=20
> which has the property of being ordered in both texts first, and only=20
> _then_ recurse into the not-yet-handled lines.

I must have been using really bad english because it's what I do ;)

> > > Once that is done, you'd have to find the longest common subsequence,=
=20
> > > which you could do using the existing infrastructure, but that would=
=20
> > > require more work (as we already know the lines are unique).
> >=20
> > Patience diff gives you the algorithm to do that, it's pretty simple,
> > and is more efficient than the current infrastructure (in time, I don't
> > know for space though).
>=20
> Actually, IIRC it is pretty easy to see that the time complexity is linea=
r=20
> (and therefore, the space complexity, too).

Well the space complexity of the patience diff would be linear too for
me, though I'm afraid that the current state of my implementation has a
big factor front ;)


> > In fact when I look at the records I have in xdiffi.c I had the=20
> > impression they were already somehow collapsed, which makes it a too=20
> > late point to apply the patience diff ...
>=20
> AFAICS xdiffi.c contains the classical diff algorithm (incidentally, I th=
e=20
> inventor of that algorithm is about 50 meters away from me at this very=
=20
> moment).  It should not have anything of interest to you, except for the=
=20
> fall-back case.
>=20
> So I think that you should add a new file xpatience.c.
>=20
> In that, I'd implement that hash multi-set, and use a prepared xdfenv_t t=
o=20
> fill it (smaller file first, then you can traverse the other file,=20
> checking for uniqueness in that file and for a match in the other file at=
=20
> the same time).
>=20
> You _could_ build the longest list of ordered pairs at the same time, too=
,=20
> but that may make the code a bit too complex.

Well, technically, if I'm correct, xdiffi.c already has a pruned list of
hashed (I suppose ->ha is a hash value somehow ?) lines (pruned from
lines without a match left or right), and I was massaging that. Though
it absolutely fails so I fear I didn't understand what the ha stuff is
for real.

Attached is my current work (YES it is horrible, it's WIP), probably
most of it can be put in an xpatience.c file, but still, I absolutely
don't understand what gets wrong. On the simple example from
glandium.org it _looks_ like it catches the "unique" include line fine,
but somehow not.

The nasty thing about the patience diff is that it still needs the usual
diff algorithm once it has split the file into chunks separated by
"unique lines". So you cannot make really independant stuff. What I
could do is put most of the xpatience diff into xpatience.c but it would
still have to use some functions from xdiffi.c that are currently
private, so it messes somehow the files more than it's worth IMHO.


Anyways, I'm waiting for a client to finally setup his network for the
test I'm supposed to do right now, I'll try to have a closer look
tonight...

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="wip.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/diff.c b/diff.c
index f644947..0901cdc 100644
--- a/diff.c
+++ b/diff.c
@@ -2447,6 +2447,8 @@ int diff_opt_parse(struct diff_options *options, cons=
t char **av, int ac)
 		options->xdl_opts |=3D XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		options->xdl_opts |=3D XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--patience"))
+		options->xdl_opts |=3D XDF_USE_PATIENCE;
=20
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 84fff58..bba915c 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -32,6 +32,7 @@ extern "C" {
 #define XDF_IGNORE_WHITESPACE (1 << 2)
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
+#define XDF_USE_PATIENCE (1 << 5)
 #define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPAC=
E_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
=20
 #define XDL_PATCH_NORMAL '-'
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 9d0324a..1a5b13a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -37,8 +37,235 @@ typedef struct s_xdpsplit {
 	int min_lo, min_hi;
 } xdpsplit_t;
=20
+typedef struct s_xduniqmatch {
+	struct s_xduniqmatch *next;
+	long i1, i2, len;
+} xduniqmatch_t;
+
+typedef struct s_xdp_ha {
+	struct s_xdp_ha *up, *down;
+	struct s_xdp_ha *left;
+	long ha;
+	long off1;
+	long off2;
+} xdp_ha_t;
+
+
+static xduniqmatch_t *xdl_uniq_match_alloc(long i1, long i2, long len)
+{
+	xduniqmatch_t *match =3D xdl_malloc(sizeof(xduniqmatch_t));
+	if (match) {
+		match->next =3D NULL;
+		match->i1 =3D i1;
+		match->i2 =3D i2;
+		match->len =3D len;
+	}
+	return match;
+}
+
+static xduniqmatch_t *xdl_uniq_popfree(xduniqmatch_t *lst)
+{
+	xduniqmatch_t *next =3D lst->next;
+	xdl_free(lst);
+	return next;
+}
+
+static int xdp_ha_cmp_by_ha(const void *a1, const void *a2)
+{
+	const xdp_ha_t *ha1 =3D a1;
+	const xdp_ha_t *ha2 =3D a2;
+	if (ha1->ha =3D=3D ha2->ha) {
+		return ha1->off2 - ha2->off2;
+	}
+	return ha1->ha - ha2->ha;
+}
+
+static int xdp_ha_cmp_by_off2(const void *a1, const void *a2)
+{
+	const xdp_ha_t *ha1 =3D a1;
+	const xdp_ha_t *ha2 =3D a2;
+	return ha2->off2 - ha1->off2;
+}
+
+static int patience_bisect_stack(xdp_ha_t **stacks, long len, long off1)
+{
+	long l =3D 0, r =3D len;
+
+	while (l < r) {
+		long i =3D (r + l) / 2;
+
+		if (off1 < stacks[i]->off1) {
+			l =3D i + 1;
+		} else {
+			r =3D i;
+		}
+	}
+	return l;
+}
+
+static int xdl_patience_split_aux(xduniqmatch_t *lcs, xdp_ha_t *ha)
+{
+	xduniqmatch_t *tmp;
+
+	while (ha) {
+		tmp =3D xdl_uniq_match_alloc(ha->off1, ha->off2, 1);
+		if (!tmp)
+			return -1;
+		tmp->next =3D lcs->next;
+		lcs->next =3D tmp;
+		lcs =3D tmp;
+
+		while ((ha =3D ha->down ? ha->down : ha->left)) {
+			if (lcs->i1 + lcs->len + 1 =3D=3D ha->off1 && lcs->i2 + lcs->len + 1 =
=3D=3D ha->off2) {
+				lcs->len++;
+				continue;
+			}
+			break;
+		}
+	}
+	return 0;
+}
+
+static int xdl_patience_split(unsigned long const *ha1, unsigned long cons=
t *ha2,
+			      xduniqmatch_t *begin, xduniqmatch_t *end)
+{
+	xdp_ha_t *recs;
+	long off1 =3D begin->i1 + begin->len, lim1 =3D end->i1;
+	long off2 =3D begin->i2 + begin->len, lim2 =3D end->i2;
+	long len, i, j, uniq;
+
+	len =3D lim1 - off1 + lim2 - off2;
+	recs =3D (xdp_ha_t *)xdl_malloc(sizeof(xdp_ha_t) * len);
+	if (recs =3D=3D NULL)
+		return -1;
+
+	for (i =3D 0, j =3D off1; j < lim1 - off1; j++, i++) {
+		recs[i].ha =3D ha1[j];
+		recs[i].off1 =3D j;
+		recs[i].off2 =3D -1;
+		recs[i].up =3D recs[i].down =3D recs[i].left =3D NULL;
+	}
+	for (j =3D off2; j < lim2; j++, i++) {
+		recs[i].ha =3D ha2[j];
+		recs[i].off1 =3D -1;
+		recs[i].off2 =3D j;
+		recs[i].up =3D recs[i].down =3D recs[i].left =3D NULL;
+	}
+
+	qsort(recs, len, sizeof(xdp_ha_t), xdp_ha_cmp_by_ha);
+
+	uniq =3D 0;
+	for (i =3D 0; i < len - 1; ) {
+		long ha =3D recs[i].ha;
+
+		if (ha !=3D recs[i + 1].ha) {
+			i++;
+			continue;
+		}
+
+		if (i < len - 2 && ha =3D=3D recs[i + 2].ha) {
+			i +=3D 3;
+			while (i < len - 1 && recs[i].ha =3D=3D ha && i < len - 1) {
+				i++;
+			}
+			continue;
+		}
+
+		if (recs[i].off2 < 0 && recs[i + 1].off1 < 0) {
+			long a, b;
+			recs[uniq].ha   =3D ha;
+			a =3D recs[uniq].off1 =3D recs[i].off1;
+			b =3D recs[uniq].off2 =3D recs[i + 1].off2;
+			uniq++;
+		}
+		i +=3D 2;
+	}
+
+	if (uniq) {
+		xdp_ha_t **stacks;
+		long alloc, len;
+
+		qsort(recs, uniq, sizeof(xdp_ha_t), xdp_ha_cmp_by_off2);
+
+		alloc =3D xdl_bogosqrt(uniq);
+		stacks =3D xdl_malloc(sizeof(xdp_ha_t *) * alloc);
=20
+		if (stacks =3D=3D NULL)
+			goto error;
=20
+		len =3D 1;
+		stacks[0] =3D recs;
+
+		for (i =3D 1; i < uniq; i++) {
+			long off1 =3D recs[i].off1;
+			long k;
+
+			if (off1 < stacks[len - 1]->off1) {
+				if (len >=3D alloc) {
+					alloc *=3D 2;
+					stacks =3D xdl_realloc(stacks, sizeof(xdp_ha_t *) * alloc);
+					if (!stacks)
+						goto error;
+				}
+				stacks[k =3D len++] =3D NULL;
+			} else {
+				k =3D patience_bisect_stack(stacks, len - 1, off1);
+			}
+
+			if (k > 0) {
+				recs[i].left =3D stacks[k - 1];
+			}
+			if (stacks[k]) {
+				stacks[k]->down =3D &recs[i];
+				recs[i].up =3D stacks[k];
+			}
+			stacks[k] =3D &recs[i];
+		}
+
+		if (xdl_patience_split_aux(begin, stacks[len - 1]) < 0) {
+			xdl_free(stacks);
+			goto error;
+		}
+
+		xdl_free(stacks);
+	}
+
+	xdl_free(recs);
+	return 0;
+
+error:
+	xdl_free(recs);
+	return -1;
+}
+
+static int xdl_patience_lcs(xdfenv_t *xe, xduniqmatch_t *begin, xduniqmatc=
h_t *end)
+{
+	unsigned long const *ha1 =3D xe->xdf1.ha, *ha2 =3D xe->xdf2.ha;
+	long off1 =3D begin->i1 + begin->len, lim1 =3D end->i1;
+	long off2 =3D begin->i2 + begin->len, lim2 =3D end->i2;
+	xduniqmatch_t *next;
+
+	for (; off1 < lim1 && off2 < lim2 && ha1[off1] =3D=3D ha2[off2]; off1++, =
off2++);
+	for (; off1 < lim1 && off2 < lim2 && ha1[lim1 - 1] =3D=3D ha2[lim2 - 1]; =
lim1--, lim2--);
+
+	begin->len +=3D off1 - begin->i1;
+	end->len   +=3D end->i1 - lim1;
+	end->i1     =3D lim1;
+	end->i2     =3D lim2;
+
+	if (off1 =3D=3D lim1 || off2 =3D=3D lim2)
+		return 0;
+
+	if (xdl_patience_split(ha1, ha2, begin, end))
+		return -1;
+
+	for (next =3D begin->next; next !=3D end; begin =3D next, next =3D begin-=
>next) {
+		if (xdl_patience_lcs(xe, begin, next) < 0)
+			return -1;
+	}
+
+	return 0;
+}
=20
 static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 		      unsigned long const *ha2, long off2, long lim2,
@@ -321,13 +548,13 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim=
1,
 	return 0;
 }
=20
-
 int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdfenv_t *xe) {
 	long ndiags;
 	long *kvd, *kvdf, *kvdb;
 	xdalgoenv_t xenv;
 	diffdata_t dd1, dd2;
+	int need_min =3D (xpp->flags & XDF_NEED_MINIMAL) !=3D 0;
=20
 	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0) {
=20
@@ -364,12 +591,54 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam=
_t const *xpp,
 	dd2.rchg =3D xe->xdf2.rchg;
 	dd2.rindex =3D xe->xdf2.rindex;
=20
-	if (xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
-			 kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) !=3D 0, &xenv) < 0) {
+	if (xpp->flags & XDF_USE_PATIENCE) {
+		xduniqmatch_t *lcs;
+		long i1, i2;
+
+		lcs =3D xdl_uniq_match_alloc(0, 0, 0);
+		if (!lcs)
+			goto error;
+		lcs->next =3D xdl_uniq_match_alloc(xe->xdf1.nreff, xe->xdf2.nreff, 0);
+		if (!lcs->next || xdl_patience_lcs(xe, lcs, lcs->next) < 0) {
+			while ((lcs =3D xdl_uniq_popfree(lcs)));
+			goto error;
+		}
=20
-		xdl_free(kvd);
-		xdl_free_env(xe);
-		return -1;
+		i1 =3D i2 =3D lcs->len;
+		if (lcs->len) {
+			fprintf(stderr, "skip  %ld:%ld -> %ld:%ld\n",
+				lcs->i1, i1, lcs->i2, i2);
+		}
+
+		while ((lcs =3D xdl_uniq_popfree(lcs))) {
+			fprintf(stderr, "usual %ld:%ld -> %ld:%ld\n",
+				i1, lcs->i1, i2, lcs->i2);
+			fprintf(stderr, "l/r: %ld / %ld\n",
+				xe->xdf1.rindex[lcs->i1],
+				xe->xdf2.rindex[lcs->i2]);
+			if (xdl_recs_cmp(&dd1, i1, lcs->i1, &dd2, i2, lcs->i2,
+					 kvdf, kvdb, need_min, &xenv) < 0) {
+				while ((lcs =3D xdl_uniq_popfree(lcs)));
+				goto error;
+			}
+			i1 =3D lcs->i1 + lcs->len;
+			i2 =3D lcs->i2 + lcs->len;
+			if (lcs->len) {
+				fprintf(stderr, "skip  %ld:%ld -> %ld:%ld (len %ld)\n",
+					lcs->i1, i1, lcs->i2, i2, lcs->len);
+				fprintf(stderr, "l/r: %ld / %ld\n",
+					xe->xdf1.rindex[lcs->i1 + lcs->len],
+					xe->xdf2.rindex[lcs->i2 + lcs->len]);
+			}
+		}
+	} else {
+		if (xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
+				 kvdf, kvdb, need_min, &xenv) < 0) {
+error:
+			xdl_free(kvd);
+			xdl_free_env(xe);
+			return -1;
+		}
 	}
=20
 	xdl_free(kvd);

--J2SCkAp4GZ/dPZZf--

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkQaQUACgkQvGr7W6HudhxKxgCdFBsF8enttm7XrEvTs92fgLBX
P2EAn3DBVeohPd9J7Er8xFFTFxFWsNRO
=cSt7
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
