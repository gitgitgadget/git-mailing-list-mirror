From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: do not reuse_worktree_file for submodules
Date: Tue, 18 Feb 2014 13:01:22 -0800
Message-ID: <xmqqy518cezh.fsf@gitster.dls.corp.google.com>
References: <CAC_01E0Pu+_UeSniFVhaqfu90d=iaFDqLrKZ1zjM6GMA4BvcGQ@mail.gmail.com>
	<d08b7e5a36ee13226d1ad56a731016762ae89938.1392569505.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Gr=C3=A9gory?= Pakosz <gregory.pakosz@gmail.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Feb 18 22:01:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFrna-0006mn-Vo
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 22:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbaBRVBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 16:01:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbaBRVBp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 16:01:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EA236DDD2;
	Tue, 18 Feb 2014 16:01:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fK81Rpn/234K
	qq0Vj6+H0M1QfWk=; b=MAEaOpO/dM4my0P8/a1clSsV5r5FbY16W7ifDn1CdfGJ
	LsA2OqOzXxtNT1V8ZYG8J62S9s9yJuoazr97dvkz/+k4trTe8gccGdV64DHcx3I7
	DKVknUJlVNrhDsGg6cxBNZF4ZKZnEdV4wof9ZbwoBXGpuD5baPiyTwZkpPs/hJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ULMAKD
	ZCm3UzRaUqe+fx/9SvCO3PcbDOGgUvok0pzzZO3wLYNIocRFOfWRaLON3HNCS5u/
	GuBJjMPNogsMeXrnPqJBwTFgzR+Yu23uXvgMnnlspTEk3GOdQJQNGpEmK0Vwkb7n
	WFXAXvMtRpsKGIU+CLNAWrm53G5v8ZdOk5UyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D92C36DDCF;
	Tue, 18 Feb 2014 16:01:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46E6F6DDA8;
	Tue, 18 Feb 2014 16:01:24 -0500 (EST)
In-Reply-To: <d08b7e5a36ee13226d1ad56a731016762ae89938.1392569505.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Sun, 16 Feb 2014 17:52:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D3651450-98DF-11E3-837A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242354>

Thomas Rast <tr@thomasrast.ch> writes:

> The GIT_EXTERNAL_DIFF calling code attempts to reuse existing worktre=
e
> files for the worktree side of diffs, for performance reasons.
> However, that code also tries to do the same with submodules.  This
> results in calls to $GIT_EXTERNAL_DIFF where the old-file is a file o=
f
> the form "Submodule commit $sha1", but the new-file is a directory in
> the worktree.
>
> Fix it by never reusing a worktree "file" in the submodule case.
>
> Reported-by: Gr=C3=A9gory Pakosz <gregory.pakosz@gmail.com>
> Signed-off-by: Thomas Rast <tr@thomasrast.ch>
> ---
>  diff.c                   |  5 +++--
>  t/t4020-diff-external.sh | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 7c59bfe..e9a8874 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2845,8 +2845,9 @@ static struct diff_tempfile *prepare_temp_file(=
const char *name,
>  		remove_tempfile_installed =3D 1;
>  	}
> =20
> -	if (!one->sha1_valid ||
> -	    reuse_worktree_file(name, one->sha1, 1)) {
> +	if (!S_ISGITLINK(one->mode) &&
> +	    (!one->sha1_valid ||
> +	     reuse_worktree_file(name, one->sha1, 1))) {

I agree with the goal/end result, but I have to wonder if the
reuse_worktree_file() be the helper function that ought to
encapsulate such a logic?

Instead of feeding it an object name and a path, if we passed a
diff_filespec to the helper, it would have access to the mode as
well.  It would result in a more intrusive change, so I'd prefer to
see your patch applied first and then build such a refactor on top,
perhaps like the attached.

 diff.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index a96992a..74eec80 100644
--- a/diff.c
+++ b/diff.c
@@ -2582,11 +2582,13 @@ void fill_filespec(struct diff_filespec *spec, =
const unsigned char *sha1,
  * the work tree has that object contents, return true, so that
  * prepare_temp_file() does not have to inflate and extract.
  */
-static int reuse_worktree_file(const char *name, const unsigned char *=
sha1, int want_file)
+static int reuse_worktree_file(const struct diff_filespec *spec, int w=
ant_file)
 {
 	const struct cache_entry *ce;
 	struct stat st;
 	int pos, len;
+	const char *name =3D spec->path;
+	const unsigned char *sha1 =3D spec->sha1;
=20
 	/*
 	 * We do not read the cache ourselves here, because the
@@ -2698,7 +2700,7 @@ int diff_populate_filespec(struct diff_filespec *=
s, int size_only)
 		return diff_populate_gitlink(s, size_only);
=20
 	if (!s->sha1_valid ||
-	    reuse_worktree_file(s->path, s->sha1, 0)) {
+	    reuse_worktree_file(s, 0)) {
 		struct strbuf buf =3D STRBUF_INIT;
 		struct stat st;
 		int fd;
@@ -2844,17 +2846,17 @@ static struct diff_tempfile *prepare_temp_file(=
const char *name,
=20
 	if (!S_ISGITLINK(one->mode) &&
 	    (!one->sha1_valid ||
-	     reuse_worktree_file(name, one->sha1, 1))) {
+	     reuse_worktree_file(one, 1))) {
 		struct stat st;
-		if (lstat(name, &st) < 0) {
+		if (lstat(one->path, &st) < 0) {
 			if (errno =3D=3D ENOENT)
 				goto not_a_valid_file;
-			die_errno("stat(%s)", name);
+			die_errno("stat(%s)", one->path);
 		}
 		if (S_ISLNK(st.st_mode)) {
 			struct strbuf sb =3D STRBUF_INIT;
-			if (strbuf_readlink(&sb, name, st.st_size) < 0)
-				die_errno("readlink(%s)", name);
+			if (strbuf_readlink(&sb, one->path, st.st_size) < 0)
+				die_errno("readlink(%s)", one->path);
 			prep_temp_blob(name, temp, sb.buf, sb.len,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
@@ -2864,7 +2866,7 @@ static struct diff_tempfile *prepare_temp_file(co=
nst char *name,
 		}
 		else {
 			/* we can borrow from the file in the work tree */
-			temp->name =3D name;
+			temp->name =3D one->path;
 			if (!one->sha1_valid)
 				strcpy(temp->hex, sha1_to_hex(null_sha1));
 			else
