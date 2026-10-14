Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923A52D2A7
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984969; cv=none; b=Laqjy9nNraL1okbteuREjOrgUN4TqOvjkHKWFubm0owHqyBhubavwEvl7B4+nGBpq9EMZzF4Ma/uJpRIUvYND8d/vOO9woN2jnYQFYtzPQnFl7qGCzq8KtqeL26hDVR90iJ28MmJ8o+bbs6swba8lzG29SVEg+jLoz2XVMPpI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984969; c=relaxed/simple;
	bh=gJNVR3kiQZthZnhmaHnSD/J+20rlcienqi0R+kar28o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iyoD83sifnZVSBtGuW0lAgtl5dxE28WgaTIVMut72cu7OcQYW8LqlyGrIYE/TN+M7SkomkMVOXPDIlS2ATkHMMry9swRtL7ulWgryBwe0l/KpjMM55KLMcrcP+SrPbR6Z3TbZpe/3DvIiwl1RyTiPg+N2S5Zg+4xpHaXyfxUHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=WDllrSlS; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="WDllrSlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791984958; x=1792589758;
	i=johannes.schindelin@gmx.de;
	bh=lKEwsVUxMyjw+CBnTZdOQ/jHMfSDOgYc4gNbGLyhdHU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WDllrSlSH7uCpIdsFhILToIcPFJoMEbPPDMV8dnOta+pVhvLTKyNZQCYF5NZRxVf
	 Ldzypcn3SuDhbHU+6Yju/uHNtca5+ZEgL3GMeezlmQLCAtRljo8jnredgD4CRqWbR
	 7zaE9fM6TEFyzyT4wHm85imFno+MEpZxAybxncmSWO+uQQkRraM/ftiDITsoe8lDN
	 wUhQ3DlzwoRT/BNkPI64zSXdcJ2o2DASsS1irz2S+XMgELJBkDkrB7Bwo9P1wLEdY
	 J1auIsqHRDVIRDpih6xzpDua2q2yVzIfiHXYl6e5/dG7CEvR8txvHTZkZB22huMcL
	 STqOocoN9n+F3laP3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1xGRBP44P4-009WhV; Wed, 14
 Oct 2026 15:35:58 +0200
Date: Wed, 14 Oct 2026 15:35:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
    Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/6] odb/source-files: fix performance when reading
 objects with alternates
In-Reply-To: <20261014-pks-odb-files-alternates-cleanups-v2-1-fed9b2caa3be@pks.im>
Message-ID: <332d341e-0a1b-790f-4b0f-55a7ebb80f3f@gmx.de>
References: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im> <20261014-pks-odb-files-alternates-cleanups-v2-1-fed9b2caa3be@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=832332967213667617919849584358
X-Provags-ID: V03:K1:B3Cv2VlCQnEfYHjEIvXz9MXzMfvyRdlJeQ8x1LzbwGBQBicJ3zH
 /oBNktQ/yzmVp22b+rtxq5zaYbvsCj5qmlW15xUVpNxDKHkGVfCyUGu/xqO+lal2GZIncfQ
 2MUkvB6yBPuGV94zHy3C+QzMzsqVcRTjpZd3Rf345ZS5Ip6QhTYbkE8ZYzpRYwnrATDhDaW
 HCMedaY6AnSu0Xa3Uc+Hw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FcwiQv+OxH8=;4qzXF+3AgaMA6jdgFbiXytPpJ9x
 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
 xhyX2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--832332967213667617919849584358
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 14 Oct 2026, Patrick Steinhardt wrote:

> With the move towards pluggable object databases we reorganized how we
> access alternates. Before the introduction of pluggability, we were
> reading objects by first scanning through packfiles from all alternates
> before scanning through all loose object directories. With the change
> though, we are now iterating through the sources one by one, checking
> each of them for whether they contain the object either as a packed or
> loose object.
>=20
> Checking whether an object exists in packfiles is comparatively cheap
> because the list of packs is cached, and the pack indices are likely to
> be in the page cache. In contrast to that, checking whether an object
> exists in loose format always incurs one stat(3p) syscall. So scanning
> for objects one alternate at a time led to a performance regression in
> in the case where most of the objects are contained in a packfile of an
> alternate, as reported in [1].
>=20
> We could fix that issue by introducing another flag that tells the
> backends to only search the optimized storage backend. But that is
> adding more complexity to the object database layers that is ultimately
> only really required because of the way the "files" backend stores its
> data. So for an alternate backend, such new infrastructure would not
> really be a good fit.
>=20
> But since then we have moved handling of alternates into the "files"
> backend itself. One of the consequences of this is that this backend is
> now having full control over all of its sub-sources, and that also makes
> it way easier for us to optimize for this access pattern again.
>=20
> Do so by first trying to read objects from packfiles located in any of
> its object directories before trying to read loose objects.
>=20
> The following benchmark demonstrates that this significantly improves
> performance in some cases. The benchmark uses the Git repository itself
> and sets up its object directory as an alternate, while the primary
> object directory is simply an empty object directory. It then reads all
> commits enumerated via `git rev-list HEAD` with git-cat-file(1):
>=20
>   Benchmark 1: git cat-file --batch-check --unordered (rev =3D HEAD~)
>     Time (mean =C2=B1 =CF=83):     179.4 ms =C2=B1   2.6 ms    [User: 11=
4.6 ms, System: 61.4 ms]
>     Range (min =E2=80=A6 max):   177.1 ms =E2=80=A6 187.7 ms    16 runs
>=20
>   Benchmark 2: git cat-file --batch-check --unordered (rev =3D HEAD)
>     Time (mean =C2=B1 =CF=83):      95.0 ms =C2=B1   1.5 ms    [User: 79=
.8 ms, System: 15.0 ms]
>     Range (min =E2=80=A6 max):    93.0 ms =E2=80=A6  97.9 ms    30 runs
>=20
>   Summary
>     git cat-file --batch-check --unordered (rev =3D HEAD) ran
>       1.89 =C2=B1 0.04 times faster than git cat-file --batch-check --un=
ordered (rev =3D HEAD~)
>=20
> [1]: <CAFXJcxvpKHoVDwE5mBOd=3Dw-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.c=
om>
>=20
> Reported-by: Wolfgang Kritzinger <wkritzinger@atlassian.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Thank you so much for this! This fixes the bug we had to patch
independently in dc305fc33833 (odb: scan all sources=E2=80=99 packfiles be=
fore
loose objects), via https://github.com/microsoft/git/pull/975, first
contained in Microsoft Git v2.55.0.vfs.0.7. Would you kindly include (my
colleague) Tyrie Vella's regression test in the next iteration of this
patch series?

=2D- snip --
From: Tyrie Vella <tyrielv@gmail.com>
Date: Wed, 14 Oct 2026 15:01:45 +0200
Subject: [PATCH] t5615: verify packed alternates precede local loose objec=
ts

This regression tests protects the packed-first lookup order required for
decent performance in setups where the majority of Git objects lives in a
separate alternate's packfiles (such as is the case with typical Scalar or
VFS for Git setups).

The test was originally added to Microsoft Git via
https://github.com/microsoft/git/pull/975

Assisted-by: GPT-6.1 Sol
Signed-off-by: Tyrie Vella <tyrielv@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t5615-alternate-env.sh | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index 9d6aa2187f2..c982e8e95d2 100755
=2D-- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -88,4 +88,47 @@ test_expect_success !MINGW 'broken quoting falls back t=
o interpreting raw' '
 	EOF
 '
=20
+test_expect_success 'packs across sources are checked before loose object=
s' '
+	# Regression test for a performance issue in which an object that
+	# resides in an alternate as a packed object caused a spurious loose
+	# object lookup (a filesystem stat) on the main object store before the
+	# alternate packfile was consulted. Reading such an object must resolve
+	# to the alternate packfile, never to a loose copy in the main store.
+	#
+	# Build an alternate whose object "B" is stored as a delta in a
+	# packfile. git deltifies successive versions of a tracked file, so the
+	# older, shorter blob "B" becomes a delta against the newer, longer
+	# blob "O". A loose object has no delta base, so %(deltabase) tells us
+	# which store answered the read: the alternate pack (O) or a loose copy
+	# (the zero oid).
+	git init alt-src &&
+	test_seq 1 200 >alt-src/file &&
+	git -C alt-src add file &&
+	git -C alt-src commit -q -m base &&
+	B=3D$(git -C alt-src rev-parse HEAD:file) &&
+	git -C alt-src cat-file blob "$B" >b-content &&
+	test_seq 1 210 >alt-src/file &&
+	git -C alt-src add file &&
+	git -C alt-src commit -q -m more &&
+	O=3D$(git -C alt-src rev-parse HEAD:file) &&
+	git -C alt-src repack -adf --window=3D10 --depth=3D50 &&
+
+	# Precondition: in the alternate, B is a delta based on O.
+	echo "$B" >in &&
+	echo "$O" >expect &&
+	git -C alt-src cat-file --batch-check=3D"%(deltabase)" <in >actual &&
+	test_cmp expect actual &&
+
+	# Main repo: write B as a loose object, before any alternate is active.
+	git init main &&
+	git -C main hash-object -w --stdin <b-content >/dev/null &&
+	test -e "main/.git/objects/$(test_oid_to_path "$B")" &&
+
+	# With the alternate active, B must resolve to the alternate packfile
+	# (deltabase O), not to the main store loose copy (deltabase zero oid).
+	GIT_ALTERNATE_OBJECT_DIRECTORIES=3D"$PWD/alt-src/.git/objects" \
+		git -C main cat-file --batch-check=3D"%(deltabase)" <in >actual &&
+	test_cmp expect actual
+'
+
 test_done
=2D- snap --

I ran the test on Linux with both SHA-1 and SHA-256. In both formats, the
unfixed base passes the nine existing tests; With vanilla v2.56.0 the
added case fails at its final lookup-order assertion: `%(deltabase)`
returns the zero OID despite the packed-delta precondition passing. Patch
1 (and of course the full patch series) pass the tests.

Ciao,
Johannes

> ---
>  odb/source-files.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 455f409db0..9268f5aa9a 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -426,6 +426,7 @@ static enum odb_read_status odb_source_files_read_ob=
ject_info(struct odb_source
>  {
>  	struct odb_source_files *files =3D odb_source_files_downcast(source);
>  	enum odb_read_status status =3D ODB_READ_NOT_FOUND;
> +	enum odb_read_status ret;
> =20
>  	/*
>  	 * Reading an object may fail even though the object exists, for
> @@ -434,15 +435,15 @@ static enum odb_read_status odb_source_files_read_=
object_info(struct odb_source
>  	 * prefer the first such error in case multiple reads have failed.
>  	 */
>  	for (struct odb_files_dir *dir =3D files->dirs; dir; dir =3D dir->next=
) {
> -		enum odb_read_status ret;
> -
>  		ret =3D odb_source_read_object_info(&dir->packed->base, oid, oi, flag=
s,
>  						  status =3D=3D ODB_READ_NOT_FOUND ? errmsg : NULL);
>  		if (!ret)
>  			return 0;
>  		if (ret !=3D ODB_READ_NOT_FOUND && status =3D=3D ODB_READ_NOT_FOUND)
>  			status =3D ret;
> +	}
> =20
> +	for (struct odb_files_dir *dir =3D files->dirs; dir; dir =3D dir->next=
) {
>  		ret =3D odb_source_read_object_info(&dir->loose->base, oid, oi, flags=
,
>  						  status =3D=3D ODB_READ_NOT_FOUND ? errmsg : NULL);
>  		if (!ret)
>=20
> --=20

--832332967213667617919849584358--
