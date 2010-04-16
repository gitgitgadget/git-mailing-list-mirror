From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 6/6] http-fetch: Use temporary files for pack-*.idx
 until verified
Date: Fri, 16 Apr 2010 10:03:07 +0800
Message-ID: <20100416100307.0000423f@unknown>
References: <201004152134.10555.j6t@kdbg.org>
	<1271366704-25262-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 04:03:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2au9-0001YI-OA
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 04:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532Ab0DPCD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 22:03:29 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:63744 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638Ab0DPCD2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 22:03:28 -0400
Received: by gxk9 with SMTP id 9so1214627gxk.8
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 19:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=DOJUkdLto5Q/6hgdLgcL+X8MNoaDGJIrupdM5mvFQto=;
        b=Fg9WQE3E1rbyQuEoMhvmraXFJdSRqqUK8XffbNtxnnEubhVv6TFKHypESo+ZtShkAU
         lOLNm7W/Y3b6waafdHkg2As6ml2uPjA1QArLfxVPWnL9ZcHaiBNyzdukTN8jD/+q3cuP
         qKk3R1MkYINpprSwYw2Lkm5boij/yGmfpE0ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=ddw/gPAWtEh4A/rkVCq/ZR3nvrtZ5IyYWR/TR+96zGgsAFhaajkUdcMmqnIDMUvzze
         efJF955t9NBlgph39JOGkJtp6l2m4dKmiBC3NzfKxlEhVweLQyR2LhqsX8iBdLgPwj4F
         oxd9pfZGJZ4YtZq8n/XyrbJqUmO6f4g0szMD8=
Received: by 10.101.28.5 with SMTP id f5mr1851182anj.35.1271383403430;
        Thu, 15 Apr 2010 19:03:23 -0700 (PDT)
Received: from unknown (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id n2sm7213563ann.2.2010.04.15.19.03.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 19:03:22 -0700 (PDT)
In-Reply-To: <1271366704-25262-2-git-send-email-spearce@spearce.org>
X-Mailer: Claws Mail 3.7.4cvs1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145046>

Hi

On Fri, Apr 16, 2010 at 5:25 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> [snip]
> diff --git a/pack-check.c b/pack-check.c
> index 166ca70..9baba12 100644
> --- a/pack-check.c
> +++ b/pack-check.c
> @@ -133,14 +133,13 @@ static int verify_packfile(struct packed_git *p=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
> =C2=A0}
>
> -int verify_pack(struct packed_git *p)
> +int verify_pack_index(struct packed_git *p)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0off_t index_size;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned char *index_base;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git_SHA_CTX ctx;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char sha1[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 struct pack_window *w_curs =3D NULL;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (open_pack_index(p))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("=
packfile %s index not opened", p->pack_name);
> @@ -154,9 +153,17 @@ int verify_pack(struct packed_git *p)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hashcmp(sha1, index_base + index_size =
- 20))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D error(=
"Packfile index for %s SHA1 mismatch",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0p->pack_name);
> + =C2=A0 =C2=A0 =C2=A0 return err;
> +}
> +
> +int verify_pack(struct packed_git *p)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int err =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 struct pack_window *w_curs =3D NULL;
>
> - =C2=A0 =C2=A0 =C2=A0 /* Verify pack file */
> - =C2=A0 =C2=A0 =C2=A0 err |=3D verify_packfile(p, &w_curs);
> + =C2=A0 =C2=A0 =C2=A0 err |=3D verify_pack_index(p);
> + =C2=A0 =C2=A0 =C2=A0 if (!err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err |=3D verify_pa=
ckfile(p, &w_curs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unuse_pack(&w_curs);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
> diff --git a/pack.h b/pack.h
> index d268c01..bb27576 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -57,6 +57,7 @@ struct pack_idx_entry {
>
> =C2=A0extern const char *write_idx_file(const char *index_name, struc=
t pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
> =C2=A0extern int check_pack_crc(struct packed_git *p, struct pack_win=
dow **w_curs, off_t offset, off_t len, unsigned int nr);
> +extern int verify_pack_index(struct packed_git *);
> =C2=A0extern int verify_pack(struct packed_git *);
> =C2=A0extern void fixup_pack_header_footer(int, unsigned char *, cons=
t char *, uint32_t, unsigned char *, off_t);
> =C2=A0extern char *index_pack_lockfile(int fd);

These should probably go into a separate patch.

> diff --git a/http.c b/http.c
> index aa3e380..2d88034 100644
> --- a/http.c
> +++ b/http.c
> @@ -897,47 +897,65 @@ int http_fetch_ref(const char *base, struct ref=
 *ref)
> =C2=A0}
>
> =C2=A0/* Helpers for fetching packs */
> -static int fetch_pack_index(unsigned char *sha1, const char *base_ur=
l)
> +static char *fetch_pack_index(unsigned char *sha1, const char *base_=
url)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 char *hex =3D xstrdup(sha1_to_hex(sha1));
> [snip]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (http_is_verbose)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, "G=
etting index for pack %s\n", hex);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, "G=
etting index for pack %s\n", sha1_to_hex(sha1));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0end_url_with_slash(&buf, base_url);
> - =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&buf, "objects/pack/pack-%s.idx", =
hex);
> + =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&buf, "objects/pack/pack-%s.idx", =
sha1_to_hex(sha1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D strbuf_detach(&buf, NULL);

I think the replacing of "hex" with "sha1_to_hex(sha1)" is unrelated.

> - =C2=A0 =C2=A0 =C2=A0 if (has_pack_index(sha1)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;
> - =C2=A0 =C2=A0 =C2=A0 }
> -

It probably should be mentioned in the commit message or elsewhere that
as fetch_and_setup_pack_index() now checks for the pack index locally
before fetching, we no longer need this check.

> =C2=A0static int fetch_and_setup_pack_index(struct packed_git **packs=
_head,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char *sha1, const char *base_url)
> =C2=A0{
> [snip]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D verify_pac=
k_index(new_pack);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 close_pack_index(new_pack);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D move_temp_to_file(tmp_idx, sha1_pack_index_name(sha1));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(tmp_idx);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -1;

The conflation of "ret" as the result of both verify_pack_index() and
move_temp_to_file() is pretty confusing.

Also, perhaps the below could be squashed in to reduce if()'s on tmp_id=
x.

-- >8 --
diff --git a/http.c b/http.c
index 6b7b899..e5bb54a 100644
--- a/http.c
+++ b/http.c
@@ -945,35 +945,37 @@ static int fetch_and_setup_pack_index(struct pack=
ed_git **packs_head,
 {
 	struct packed_git *new_pack;
 	char *tmp_idx =3D NULL;
+	int ret;
=20
-	if (!has_pack_index(sha1)) {
-		tmp_idx =3D fetch_pack_index(sha1, base_url);
-		if (!tmp_idx)
-			return -1;
+	if (has_pack_index(sha1)) {
+		new_pack =3D parse_pack_index(sha1, NULL);
+		if (!new_pack)
+			return -1; /* parse_pack_index() already issued error message */
+		goto add_pack;
 	}
=20
+	tmp_idx =3D fetch_pack_index(sha1, base_url);
+	if (!tmp_idx)
+		return -1;
+
 	new_pack =3D parse_pack_index(sha1, tmp_idx);
 	if (!new_pack) {
-		if (tmp_idx) {
-			unlink(tmp_idx);
-			free(tmp_idx);
-		}
+		unlink(tmp_idx);
+		free(tmp_idx);
+
 		return -1; /* parse_pack_index() already issued error message */
 	}
=20
-	if (tmp_idx) {
-		int ret;
-
-		ret =3D verify_pack_index(new_pack);
-		if (!ret) {
-			close_pack_index(new_pack);
-			ret =3D move_temp_to_file(tmp_idx, sha1_pack_index_name(sha1));
-		}
-		free(tmp_idx);
-		if (ret)
-			return -1;
+	ret =3D verify_pack_index(new_pack);
+	if (!ret) {
+		close_pack_index(new_pack);
+		ret =3D move_temp_to_file(tmp_idx, sha1_pack_index_name(sha1));
 	}
+	free(tmp_idx);
+	if (ret)
+		return -1;
=20
+add_pack:
 	new_pack->next =3D *packs_head;
 	*packs_head =3D new_pack;
 	return 0;


--=20
Cheers,
Ray Chuan
