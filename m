From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCHv6 1/2] repack: rewrite the shell script in C
Date: Thu, 22 Aug 2013 00:15:29 +0200
Message-ID: <52153C01.6040101@googlemail.com>
References: <5214F816.3010303@googlemail.com> <1377106096-28195-1-git-send-email-stefanbeller@googlemail.com> <xmqqfvu2u5io.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF83EA11BC4B1A12DA14F286E"
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 00:15:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCGgd-0008Up-1M
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 00:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab3HUWP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 18:15:27 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:55178 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab3HUWP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 18:15:26 -0400
Received: by mail-ee0-f47.google.com with SMTP id d49so544058eek.20
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=V+aSlIuEQRYNuWPMwDAAy2cydL3xWEX/MJT1Fcso2CQ=;
        b=dy7mas3drYpkQPngHuxiXW2IjHO17sL1wdfiS8E3O+4tPGxtzgxwyZGqVsOPvSNib1
         sBb1E6Ld1buGyvBhOql4j/z1EpQ/K0ifLtCug6abtiTOFxpY0LCcIASEAmhKxZbYld2M
         IRDEWn7ehVuY5J30szsYRrjzn6kvpdIpzE0bRHiK4VqPRhjuGgHa/OVh0PmlvbXb0Vav
         obmxwiqAPXeCqjQUJwlFgFt28StX+dv1xdezRvEtcqV/1aLGT1Vab4jICnzk/TLJek0L
         9L7wy31aKTuVxjRqCICVGAG5JoliZp4m6eoqhlxJItQ+dYNfTFyB6Z7fgioZSAbgercP
         tvrw==
X-Received: by 10.14.184.3 with SMTP id r3mr13286271eem.49.1377123324798;
        Wed, 21 Aug 2013 15:15:24 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r48sm13002535eev.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 15:15:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <xmqqfvu2u5io.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232743>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF83EA11BC4B1A12DA14F286E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/21/2013 10:56 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> The motivation of this patch is to get closer to a goal of being
>> able to have a core subset of git functionality built in to git.
>> That would mean
>>
>>  * people on Windows could get a copy of at least the core parts
>>    of Git without having to install a Unix-style shell
>>
>>  * people deploying to servers don't have to rewrite the #! line
>>    or worry about the PATH and quality of installed POSIX
>>    utilities, if they are only using the built-in part written
>>    in C
>=20
> I am not sure what is meant by the latter.  Rewriting #! is part of
> any scripted Porcelain done by the top-level Makefile, and I do not
> think we have seen any problem reports on it.
>=20
> As to "quality of ... utilities", I think the real issue some people
> in the thread had was not about "deploying to servers" but about
> installing in a minimalistic chrooted environment where standard
> tools may be lacking.
>=20
>> diff --git a/builtin/repack.c b/builtin/repack.c
>> new file mode 100644
>> index 0000000..fb050c0
>> --- /dev/null
>> +++ b/builtin/repack.c
>> @@ -0,0 +1,376 @@
>> +/*
>> + * The shell version was written by Linus Torvalds (2005) and many ot=
hers.
>> + * This is a translation into C by Stefan Beller (2013)
>> + */
>=20
> I am not sure if we want to record "ownership" in the code like
> this; it will go stale over time.

I'll remove it. Initially I put it there as I found similar=20
comments in other files as well.


>> +static int delta_base_offset =3D 1;
>> +char *packdir;
>=20
> Does this have to be global?

We could pass it to all the functions, making it not global.
I'd be ok with that for the functions get_pack_filenames=20
and remove_redundant_pack, but we also need to know
packdir in remove_temporary_files which is called from
the signal handler remove_pack_on_signal.

As the path is pretty obvious (get_object_directory() + "/pack"),
we could however also construct it again in the signal handler.


> So in summary:
>=20
> 	dir =3D opendir(packdir);
>         if (!dir)
> 		return;
>=20
> 	strbuf_addf(&buf, "%s-", packtmp);

packtmp is not yet a global variable, but could be passed to=20
to this function. Currently we're reconstructing it here.

>=20
>         /* Point at the slash at the end of ".../objects/pack/" */
> 	dirlen =3D strlen(packdir) + 1;
>         /* Point at the dash at the end of ".../.tmp-%d-pack-" */
>         prefixlen =3D buf.len - dirlen;
>=20
> You would need to move the initialization of packdir and packtmp
> before sigchain_push() in cmd_repack() if you were to do this.

Ah ok, I'll do so.

>> +
>> +		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
>> +			string_list_append_nodup(fname_list, fname);
>=20
> mental note: this is getting names of non-kept packs, not all packs.

I should document that. ;)


>> +	while (strbuf_getline(&line, out, '\n') !=3D EOF) {
>> +		if (line.len !=3D 40)
>> +			die("repack: Expecting 40 character sha1 lines only from pack-obje=
cts.");
>> +		strbuf_addstr(&line, "");
>=20
> What is this addstr() about?

According to the documentation of strbufs, we cannot assume to have sane =

strings, but anything. Adding an empty string however will make sure to
add a NUL-terminated string to the buffer, no?

In a previous roll of this patch, which operated on char* line,
there was just line[40] =3D '\0'; // replacing '\n' by '\0'
to have it sane in the string list.


>=20
>> +		string_list_append(&names, line.buf);
>> +		count_packs++;
>=20
> It probably is more in line with our naming convention to call this
> nr_packs, num_packs, etc.  "count_packs" sounds more like a boolean
> that instructs the code to either count or not bother counting,
> which this thing is not.

This is something subtle, but important to know. Thanks, will be fixed in=

the reroll.


>> +
>> +			if (rename(fname, fname_old)) {
>> +				failed =3D 1;
>> +				break;
>=20
> "break"-ing from here leaks fname_old.  As the only out-of-line call
> file_exists() is just a thin wrapper around lstat(), I think it is
> fine not to pathdup the fname_old here.

fixed

I'd really appreciate, if there was documentation on these functions.
(When is mkpath safe? What is better in which situation: mkpath or strbuf=
s?)
Maybe I could start doing it (but only those functions I used so far,
there are many more in cache.h)

>=20
>> +			}
>> +			string_list_append_nodup(&rollback, fname);
>> +			free(fname);
>=20
> This looks bad, doesn't it?  append_nodup() lets &rollback string
> list to take the ownership of the piece of memory pointed at by
> fname, but then you free it here, no?
>=20
> If you initialize &rollback with INIT_NODUP, you would not have to
> call append_nodup().

Removed the free.
Having rollback initialized with NODUP and then not explicitely=20
using append_nodup() makes me feel unhappy, because now you need
to check different places to make sure there is no leaking memory,
(you need to know the list is NODUP). I changed it nevertheless,
maybe I feel enlightened later on. ;)

As Matthieu proposed, I also set
CFLAGS +=3D -Wdeclaration-after-statement in config.mak now. Hopefully
I don't screw up again now.

Thanks,
Stefan

--8<--
=46rom 79945f5ae45f08fa2dbabfa1f6b7cd0b344ec0b3 Mon Sep 17 00:00:00 2001
From: Stefan Beller <stefanbeller@googlemail.com>
Date: Thu, 22 Aug 2013 00:13:35 +0200
Subject: [PATCH] Suggestions by Junio

---
 builtin/repack.c | 68 ++++++++++++++++++++++++++------------------------=
------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 1f13e0d..bb90f07 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,8 +1,3 @@
-/*
- * The shell version was written by Linus Torvalds (2005) and many other=
s.
- * This is a translation into C by Stefan Beller (2013)
- */
-
 #include "builtin.h"
 #include "cache.h"
 #include "dir.h"
@@ -13,9 +8,8 @@
 #include "string-list.h"
 #include "argv-array.h"
=20
-/* enabled by default since 22c79eab (2008-06-25) */
 static int delta_base_offset =3D 1;
-char *packdir;
+char *packdir, *packtmp;
=20
 static const char *const git_repack_usage[] =3D {
 	N_("git repack [options]"),
@@ -41,18 +35,16 @@ static void remove_temporary_files(void)
 	DIR *dir;
 	struct dirent *e;
=20
-	/* .git/objects/pack */
-	strbuf_addstr(&buf, get_object_directory());
-	strbuf_addstr(&buf, "/pack");
-	dir =3D opendir(buf.buf);
-	if (!dir) {
-		strbuf_release(&buf);
+	dir =3D opendir(packdir);
+	if (!dir)
 		return;
-	}
=20
-	/* .git/objects/pack/.tmp-$$-pack-* */
+	strbuf_addstr(&buf, packdir);
+
+	/* dirlen holds the length of the path before the file name */
 	dirlen =3D buf.len + 1;
-	strbuf_addf(&buf, "/.tmp-%d-pack-", (int)getpid());
+	strbuf_addf(&buf, "%s", packtmp);
+	/* prefixlen holds the length of the prefix */
 	prefixlen =3D buf.len - dirlen;
=20
 	while ((e =3D readdir(dir))) {
@@ -73,11 +65,16 @@ static void remove_pack_on_signal(int signo)
 	raise(signo);
 }
=20
+/*
+ * Adds all packs hex strings to the fname list, which do not
+ * have a corresponding .keep file.
+ */
 static void get_pack_filenames(struct string_list *fname_list)
 {
 	DIR *dir;
 	struct dirent *e;
 	char *fname;
+	size_t len;
=20
 	if (!(dir =3D opendir(packdir)))
 		return;
@@ -86,7 +83,7 @@ static void get_pack_filenames(struct string_list *fnam=
e_list)
 		if (suffixcmp(e->d_name, ".pack"))
 			continue;
=20
-		size_t len =3D strlen(e->d_name) - strlen(".pack");
+		len =3D strlen(e->d_name) - strlen(".pack");
 		fname =3D xmemdupz(e->d_name, len);
=20
 		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
@@ -95,14 +92,14 @@ static void get_pack_filenames(struct string_list *fn=
ame_list)
 	closedir(dir);
 }
=20
-static void remove_redundant_pack(const char *path, const char *sha1)
+static void remove_redundant_pack(const char *path_prefix, const char *h=
ex)
 {
 	const char *exts[] =3D {".pack", ".idx", ".keep"};
 	int i;
 	struct strbuf buf =3D STRBUF_INIT;
 	size_t plen;
=20
-	strbuf_addf(&buf, "%s/%s", path, sha1);
+	strbuf_addf(&buf, "%s/%s", path_prefix, hex);
 	plen =3D buf.len;
=20
 	for (i =3D 0; i < ARRAY_SIZE(exts); i++) {
@@ -115,15 +112,14 @@ static void remove_redundant_pack(const char *path,=
 const char *sha1)
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	const char *exts[2] =3D {".idx", ".pack"};
-	char *packtmp;
 	struct child_process cmd;
 	struct string_list_item *item;
 	struct argv_array cmd_args =3D ARGV_ARRAY_INIT;
 	struct string_list names =3D STRING_LIST_INIT_DUP;
-	struct string_list rollback =3D STRING_LIST_INIT_DUP;
+	struct string_list rollback =3D STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs =3D STRING_LIST_INIT_DUP;
 	struct strbuf line =3D STRBUF_INIT;
-	int count_packs, ext, ret;
+	int nr_packs, ext, ret, failed;
 	FILE *out;
=20
 	/* variables to be filled by option parsing */
@@ -173,11 +169,11 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	argc =3D parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
=20
-	sigchain_push_common(remove_pack_on_signal);
-
 	packdir =3D mkpathdup("%s/pack", get_object_directory());
 	packtmp =3D mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
=20
+	sigchain_push_common(remove_pack_on_signal);
+
 	argv_array_push(&cmd_args, "pack-objects");
 	argv_array_push(&cmd_args, "--keep-true-parents");
 	argv_array_push(&cmd_args, "--honor-pack-keep");
@@ -233,14 +229,14 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	if (ret)
 		return ret;
=20
-	count_packs =3D 0;
+	nr_packs =3D 0;
 	out =3D xfdopen(cmd.out, "r");
 	while (strbuf_getline(&line, out, '\n') !=3D EOF) {
 		if (line.len !=3D 40)
 			die("repack: Expecting 40 character sha1 lines only from pack-objects=
=2E");
 		strbuf_addstr(&line, "");
 		string_list_append(&names, line.buf);
-		count_packs++;
+		nr_packs++;
 	}
 	fclose(out);
 	ret =3D finish_command(&cmd);
@@ -248,10 +244,10 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 		return ret;
 	argv_array_clear(&cmd_args);
=20
-	if (!count_packs && !quiet)
+	if (!nr_packs && !quiet)
 		printf("Nothing new to pack.\n");
=20
-	int failed =3D 0;
+	failed =3D 0;
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < 2; ext++) {
 			char *fname, *fname_old;
@@ -262,7 +258,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
 				continue;
 			}
=20
-			fname_old =3D mkpathdup("%s/old-%s%s", packdir,
+			fname_old =3D mkpath("%s/old-%s%s", packdir,
 						item->string, exts[ext]);
 			if (file_exists(fname_old))
 				unlink(fname_old);
@@ -271,15 +267,13 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 				failed =3D 1;
 				break;
 			}
-			string_list_append_nodup(&rollback, fname);
-			free(fname);
-			free(fname_old);
+			string_list_append(&rollback, fname);
 		}
 		if (failed)
 			break;
 	}
 	if (failed) {
-		struct string_list rollback_failure;
+		struct string_list rollback_failure =3D STRING_LIST_INIT_DUP;
 		for_each_string_list_item(item, &rollback) {
 			char *fname, *fname_old;
 			fname =3D mkpathdup("%s/%s", packdir, item->string);
@@ -289,7 +283,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
 			free(fname);
 		}
=20
-		if (rollback.nr) {
+		if (rollback_failure.nr) {
 			int i;
 			fprintf(stderr,
 				"WARNING: Some packs in use have been renamed by\n"
@@ -299,10 +293,10 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 				"WARNING: attempt to rename them back to their\n"
 				"WARNING: original names also failed.\n"
 				"WARNING: Please rename them in %s manually:\n", packdir);
-			for (i =3D 0; i < rollback.nr; i++)
+			for (i =3D 0; i < rollback_failure.nr; i++)
 				fprintf(stderr, "WARNING:   old-%s -> %s\n",
-					rollback.items[i].string,
-					rollback.items[i].string);
+					rollback_failure.items[i].string,
+					rollback_failure.items[i].string);
 		}
 		exit(1);
 	}
--=20
1.8.4.rc3.1.gc1ebd90




--------------enigF83EA11BC4B1A12DA14F286E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSFTwBAAoJEJQCPTzLflhqtgQP/ApS0JEybsQOBDQrPJE5NKR3
bo7EW+52bjGzRI9i7uyzFioVp9DeBORAnPcJrHDDZQyTeqYwQM9tS80oBMbTgBP3
7hZY2L4aO/Z0IJ5N3EEENRSmiKC4RPEPi3yzvaSSsPwQPYMaOOe8eAjoojfDqQ5i
0INBjDOc0u5Or2L+NADfckvN61Aea7nXqQALbKDCbizBpxmXwtnB2hva2AY2wXwk
vuT5tvVlKVmC7F/lGJoJvyckDIU1MFeZeQ02VNpSHQUN/0DcvKfNNJWh5I/89U/2
r068vgHdjnw/FsJv6gie9UD4btQm/SVwInxgIODdQ6f05SKAtCEtc5Duw8z4ZBB8
krajlurO+LM1oukMu1mRMKP4lv2DA5igjNc0KpJUR48KkyvIa/ThIxvoyUDgfEQQ
uXnNZU6Ha2xnAU+upTjc+xPD9fIwR29fls1XXc41ZBGHPt3AKNv0szyNBH+FKiX2
kLkSB0ZxqJimH5E8o4KHNsGUvJrw6/Rg4xXhv13+WuHf3r4FIfv2AShBHWK27Diy
dwaOfJ7xZVsLNzpneofDKaD4SvuJioyFz6/uHOXG/EJbPggyspVA4rsdt9v4ETnf
EOgTvb8wZXj7tdII4eeYjmmhnQrje5Mx0PQNvr2YxYj/ePdGvgPIjftl9dilzCH/
3S9jAfEgpbi1gSDhux4m
=SVtw
-----END PGP SIGNATURE-----

--------------enigF83EA11BC4B1A12DA14F286E--
