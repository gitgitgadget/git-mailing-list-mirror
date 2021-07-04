Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDC8C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F1E6162A
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGDJFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 05:05:03 -0400
Received: from mout.web.de ([212.227.17.12]:49053 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhGDJFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 05:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625389339;
        bh=rddCVrCs1jB3/OoWuLju/es3rE6SVjxNOpbn4Mb9kYM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ANP0X5WO2NgO2TrTyUDk1GkNpWiSYTz1WbBju6th2B5LrAR5yzPs6fo/4hpeGOFfk
         9xhRKHIamYJUD8D3zlz0MrAawpAjciSwJTYXrxOWrNTWTieBeYbstSIp2prVAee2ZR
         Q9Qne9wS6Up4R661ZWhIoJrGJFyNk6VTnNGJ0L/0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MBTIY-1lsn1R3EGc-00ATaF; Sun, 04 Jul 2021 11:02:19 +0200
Subject: Re: [PATCH v2 1/5] speed up alt_odb_usable() with many alternates
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-2-e@80x24.org>
 <fc342ddd-1b35-62cc-dd4b-e0462d595819@web.de>
Message-ID: <d069bc0b-f989-0d15-61ec-19f85841bc51@web.de>
Date:   Sun, 4 Jul 2021 11:02:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fc342ddd-1b35-62cc-dd4b-e0462d595819@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FMFh5zNtkQiiU2lxc47i4EhgbPt5XPrYzOrrGwLx9qZZq9Cnqft
 FQwrE9AThvhaMzL0UOpCuL1r7ZuPQlXx1UydqODO3fBwNyWvg4nfa8cjHmaPBzRAL5+Y8rU
 7kO9mNsVjrVk23G2ZOz1Y1SF2aWTo3nj5ogala7jSR2ddHmVLH0JEM6andBgyxHWADHjjS+
 +4XtK4enegfAgWtgvgAng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AwtYwe28WzM=:LSiD1Bd0sBWKIwHpTnCulo
 gdZg5z8xQbEQO2dDhcMVmD/Ci8sQIfPTm7F5tvgUeZQ0v/ps8gjIp1EiCLrpfJtZVPewb2whP
 tE4GOEp2QOs456kT1ueFSLcNk1zHVrT7j8Qwei7eFGWonJolRSO6nKtVYD1mILtlavX2K2Esy
 V0nm6iMHnJ8wkGaf9f9bduFvBKf51BdT7ioHID6d0M0e+mmP6emOdc8QLabG83j7PX3WLt3Vr
 qNZDiC1KqXoOUY3Bmuj2UK42Zto9pKNWN9WVqtDcGsNs0TRFZ9oE6n+nBDWVt7RQpn+gH9RFc
 l4fPPH7ycI+t8QDI2ove0aExW62S/gxMVsluwu3xFxudXc+6lV3KCU8wPLsN6BvswPMo9nauA
 0oUvhexLPjn2e3hBX6k0wYfrhCcjpx6zTtIsBbwwknck88+x0lUc+LGOkqskGf1mbbtw2RSQJ
 0Hy1KocECn/Vf8q30+uupnXxdSDskxwirRa2NKb/VSwzMCASEPWM0s3np2LZrUXOavk84Gxu0
 1tHH88JsUWWlRnQwReYxNKijkmxqQH9xVJk5K/nCUdjyKWLV8giPGMShXixquZfwjK2+p3MYd
 NS2cNX8Ch7RW5UuPSwCBMN01rnbPU8QeBsG0FB+fQRyXShbPFkvTEFHBR78urFryfYU9JYy8O
 Dvekd+ZDLFStFwqXS4LWMXTsPReU/gZw3wLRxCJe5vqE2p7S7KIsrIlAY6rpewtUK85lWDRKa
 /Y9X6G5tUkJ68i3fPytom/YcWa2avMBhG8l1EgTyqPnXRZQen4q9328WyNjHHDhuxqHkaPUPv
 cdTlZBUEvYEZ6IiVd6JciwOXtoKg12IgNEYUZvsQkEiAtkDeNGLXC1iFv0/yDuiEGqhIGHIJ6
 jkBMZOMoh/S3O11syUFjBXPn6c90tToDhP39xZfVAeFuvi5MzRqLF537v50cdXNbqMEvaOG80
 THGGAaok6AojpvZyWc/zfK1H38vnC6CR+ZukmRD1gT7sqwZ4LK3ogKTBhDYZj6QoN+LmbIm78
 Cr4kl26EgERO8XVYvC9WhIiAlzD5UF+1Hgnas/WR7jY+OKtM6ZR7ySpU2KNqSQDKl3YommTON
 0Z1PGR4/t7t4Pn+QrFL76O63WlRwcO17i/O
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.07.21 um 12:05 schrieb Ren=C3=A9 Scharfe:
> Am 29.06.21 um 22:53 schrieb Eric Wong:
>> +	*pos =3D kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
>> +	if (r < 0) die_errno(_("kh_put_odb_path_map"));

>> +	/* r: 0 =3D exists, 1 =3D never used, 2 =3D deleted */
>> +	return r =3D=3D 0 ? 0 : 1;

> I like the solution in oidset.c to make this more readable, though: Call
> the return value "added" instead of "r" and then a "return !added;"
> makes sense without additional comments.

That's probably because I wrote that part; see 8b2f8cbcb1 (oidset: use
khash, 2018-10-04) -- I had somehow forgotten about that. o_O

And here we wouldn't negate.  Passing on the value verbatim, without
normalizing 2 to 1, would work fine.

alt_odb_usable() and its caller become quite entangled due to the
hashmap insert operation being split between them.  I suspect the code
would improve by inlining the function in a follow-up patch, making
return code considerations moot.  The improvement is not significant
enough to hold up this series in case you don't like the idea, though.

Rough demo:

 object-file.c | 82 +++++++++++++++++++++++++++---------------------------=
-----
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/object-file.c b/object-file.c
index 304af3a172..a5e91091ee 100644
=2D-- a/object-file.c
+++ b/object-file.c
@@ -512,45 +512,6 @@ const char *loose_object_path(struct repository *r, s=
truct strbuf *buf,
 	return odb_loose_path(r->objects->odb, buf, oid);
 }

-/*
- * Return non-zero iff the path is usable as an alternate object database=
.
- */
-static int alt_odb_usable(struct raw_object_store *o,
-			  struct strbuf *path,
-			  const char *normalized_objdir, khiter_t *pos)
-{
-	int r;
-
-	/* Detect cases where alternate disappeared */
-	if (!is_directory(path->buf)) {
-		error(_("object directory %s does not exist; "
-			"check .git/objects/info/alternates"),
-		      path->buf);
-		return 0;
-	}
-
-	/*
-	 * Prevent the common mistake of listing the same
-	 * thing twice, or object directory itself.
-	 */
-	if (!o->odb_by_path) {
-		khiter_t p;
-
-		o->odb_by_path =3D kh_init_odb_path_map();
-		assert(!o->odb->next);
-		p =3D kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
-		if (r < 0) die_errno(_("kh_put_odb_path_map"));
-		assert(r =3D=3D 1); /* never used */
-		kh_value(o->odb_by_path, p) =3D o->odb;
-	}
-	if (!fspathcmp(path->buf, normalized_objdir))
-		return 0;
-	*pos =3D kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
-	if (r < 0) die_errno(_("kh_put_odb_path_map"));
-	/* r: 0 =3D exists, 1 =3D never used, 2 =3D deleted */
-	return r =3D=3D 0 ? 0 : 1;
-}
-
 /*
  * Prepare alternate object database registry.
  *
@@ -575,6 +536,9 @@ static int link_alt_odb_entry(struct repository *r, co=
nst char *entry,
 	struct object_directory *ent;
 	struct strbuf pathbuf =3D STRBUF_INIT;
 	khiter_t pos;
+	int ret =3D -1;
+	int added;
+	struct raw_object_store *o =3D r->objects;

 	if (!is_absolute_path(entry) && relative_base) {
 		strbuf_realpath(&pathbuf, relative_base, 1);
@@ -585,8 +549,7 @@ static int link_alt_odb_entry(struct repository *r, co=
nst char *entry,
 	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
 		error(_("unable to normalize alternate object path: %s"),
 		      pathbuf.buf);
-		strbuf_release(&pathbuf);
-		return -1;
+		goto out;
 	}

 	/*
@@ -596,11 +559,37 @@ static int link_alt_odb_entry(struct repository *r, =
const char *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] =3D=3D '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);

-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos)) {
-		strbuf_release(&pathbuf);
-		return -1;
+	/* Detect cases where alternate disappeared */
+	if (!is_directory(pathbuf.buf)) {
+		error(_("object directory %s does not exist; "
+			"check .git/objects/info/alternates"),
+		      pathbuf.buf);
+		goto out;
+	}
+
+	/*
+	 * Prevent the common mistake of listing the same
+	 * thing twice, or object directory itself.
+	 */
+	if (!o->odb_by_path) {
+		khiter_t p;
+
+		o->odb_by_path =3D kh_init_odb_path_map();
+		assert(!o->odb->next);
+		p =3D kh_put_odb_path_map(o->odb_by_path, o->odb->path, &added);
+		if (added < 0) die_errno(_("kh_put_odb_path_map"));
+		assert(added);
+		kh_value(o->odb_by_path, p) =3D o->odb;
 	}

+	if (!fspathcmp(pathbuf.buf, normalized_objdir))
+		goto out;
+
+	pos =3D kh_put_odb_path_map(o->odb_by_path, pathbuf.buf, &added);
+	if (added < 0) die_errno(_("kh_put_odb_path_map"));
+	if (!added)
+		goto out;
+
 	CALLOC_ARRAY(ent, 1);
 	/* pathbuf.buf is already in r->objects->odb_by_path */
 	ent->path =3D strbuf_detach(&pathbuf, NULL);
@@ -615,7 +604,10 @@ static int link_alt_odb_entry(struct repository *r, c=
onst char *entry,
 	/* recursively add alternates */
 	read_info_alternates(r, ent->path, depth + 1);

-	return 0;
+	ret =3D 0;
+out:
+	strbuf_release(&pathbuf);
+	return ret;
 }

 static const char *parse_alt_odb_entry(const char *string,

