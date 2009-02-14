From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] builtin-remote: better handling of multiple remote HEADs
Date: Sat, 14 Feb 2009 05:30:30 -0500
Message-ID: <1234607430-5403-1-git-send-email-jaysoffian@gmail.com>
References: <20090214034345.GB24545@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, barkalow@iabervon.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 11:32:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYHob-0000NG-En
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 11:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbZBNKai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 05:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbZBNKah
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 05:30:37 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:8496 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZBNKag (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 05:30:36 -0500
Received: by yx-out-2324.google.com with SMTP id 8so750816yxm.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 02:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nPYUwjfgRQHZSLs36b+OcqWBEP+ToC55GNOiChROGkk=;
        b=cns07dXZlPPjCfAl6j14SnicseLyIdx+p3vnU6OJ9REM+Ps9UhGMC90s1K1kzTSlyE
         FKtrO4FJFnUL5DE5/3ftwN0g4iBRe5EFVV8hPQRzdJhfvX8w1LlBBXljy4v1xN94Gbz5
         k3qxgybeCnokNM2CI5hUKsNyGM38i5X7hudKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=f16vh4W6kUUM3aOqiRWSN837Duw63mJ4uUxQk9XQU5l+Pj23OE3nXWT+2imqJ1IuLJ
         2C6/ITHfQrOmgaYO8oaYc3I4t1t3bHPJcdyiis32GEJj5ueUbE/ACgDnHkgall0zzOHV
         mYWV2hJfzV/m7f/1DB08J2nKqjIQGZC+gImDI=
Received: by 10.100.144.20 with SMTP id r20mr1700986and.40.1234607434586;
        Sat, 14 Feb 2009 02:30:34 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c1sm3275574ana.0.2009.02.14.02.30.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 02:30:33 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.238.ge8815
In-Reply-To: <20090214034345.GB24545@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109856>

It is not currently possible to determine the remote HEAD unambiguously
when multiple remote branches share the same SHA1 as the remote HEAD.

In this situation, git remote set-head --auto should not try to guess
which HEAD the user wants. This patch causes set-head to provide a
useful error instead:

$ git remote set-head origin --auto
error: Multiple remote HEAD branches. Please choose one explicitly with=
:
  git remote set-head origin another
  git remote set-head origin master

Also, the output of git remote show now shows the multiple HEADs:

$ git remote show origin
* remote origin
  URL: ...
  HEAD branches:
    another
    master

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
On Fri, Feb 13, 2009 at 10:43 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 13, 2009 at 09:59:06PM -0500, Jay Soffian wrote:
>
>> But I will propose an alternative. In the output of "get remote show
>> origin", we show all matching branches. If the user does a set-head
>> --auto and we cannot determine HEAD unambiguously, we do something
>> like:
>>
>> $ git remote set-head origin --auto
>> error: Multiple branches match HEAD. Please choose one explicitly wi=
th:
>>    git remote set-head origin master
>>    git remote set-head origin frotz
>
> I like that proposal. It doesn't hide from the user that we are doing=
 a
> matching guess, which means we are less likely to surprise them in th=
e
> long run.
>
> -Peff

Voil=C3=A0

Junio - this obviously goes on-top of the rest of the builtin-remote
series I sent.

 builtin-clone.c   |    2 +-
 builtin-remote.c  |   56 +++++++++++++++++++++++++++++++++++----------=
--------
 remote.c          |   28 ++++++++++++++++++-------
 remote.h          |    6 ++++-
 t/t5505-remote.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 5 files changed, 114 insertions(+), 31 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index d179d1c..d57818c 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -510,7 +510,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		mapped_refs =3D write_remote_refs(refs, &refspec, reflog_msg.buf);
=20
 		head_points_at =3D guess_remote_head(refs, mapped_refs,
-						   &remote_head);
+						   &remote_head, NULL);
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
diff --git a/builtin-remote.c b/builtin-remote.c
index fcb166b..608c0f3 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -212,8 +212,7 @@ static void read_branches(void)
=20
 struct ref_states {
 	struct remote *remote;
-	struct string_list new, stale, tracked;
-	char *head_name;
+	struct string_list new, stale, tracked, heads;
 };
=20
 static int handle_one_branch(const char *refname,
@@ -273,24 +272,26 @@ static int get_ref_states(const struct ref *ref, =
struct ref_states *states)
 	return 0;
 }
=20
-static char *get_head_name(const struct ref *refs)
+static int get_head_names(const struct ref *refs,
+	const char *remote_name, struct ref_states *states)
 {
-	const struct ref *head_points_at;
-	struct ref *mapped_refs =3D NULL;
-	struct ref **tail =3D &mapped_refs;
+	struct ref *ref, *matches =3D NULL;
+	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
 	struct refspec refspec;
=20
 	refspec.force =3D 0;
 	refspec.pattern =3D 1;
 	refspec.src =3D refspec.dst =3D "refs/heads/";
+	states->heads.strdup_strings =3D 1;
+	get_fetch_map(refs, &refspec, &fetch_map_tail, 0);
+	guess_remote_head(refs, fetch_map, NULL, &matches);
+	for(ref =3D matches; ref; ref =3D ref->next)
+		string_list_append(abbrev_branch(ref->name), &states->heads);
=20
-	get_fetch_map(refs, &refspec, &tail, 0);
-
-	head_points_at =3D guess_remote_head(refs, mapped_refs, NULL);
-	if (head_points_at)
-		return xstrdup(abbrev_branch(head_points_at->name));
+	free_refs(fetch_map);
+	free_refs(matches);
=20
-	return NULL;
+	return 0;
 }
=20
 struct known_remote {
@@ -659,7 +660,7 @@ static void free_remote_ref_states(struct ref_state=
s *states)
 	string_list_clear(&states->new, 0);
 	string_list_clear(&states->stale, 0);
 	string_list_clear(&states->tracked, 0);
-	free(states->head_name);
+	string_list_clear(&states->heads, 0);
 }
=20
 static int get_remote_ref_states(const char *name,
@@ -681,7 +682,7 @@ static int get_remote_ref_states(const char *name,
 		ref =3D transport_get_remote_refs(transport);
 		transport_disconnect(transport);
=20
-		states->head_name =3D get_head_name(ref);
+		get_head_names(ref, name, states);
 		get_ref_states(ref, states);
 	}
=20
@@ -726,9 +727,15 @@ static int show(int argc, const char **argv)
 		printf("* remote %s\n  URL: %s\n", *argv,
 			states.remote->url_nr > 0 ?
 				states.remote->url[0] : "(no URL)");
-		if (!no_query)
-			printf("  HEAD: %s\n", states.head_name ?
-				states.head_name : "(unknown)");
+		if (no_query)
+			printf("  HEAD branch: (not queried)\n");
+		else if (!states.heads.nr)
+			printf("  HEAD branch: (unknown)\n");
+		else if (states.heads.nr =3D=3D 1)
+			printf("  HEAD branch: %s\n",
+				states.heads.items[0].string);
+		else
+			show_list("  HEAD branch%s:", &states.heads, "");
=20
 		for (i =3D 0; i < branch_list.nr; i++) {
 			struct string_list_item *branch =3D branch_list.items + i;
@@ -780,7 +787,7 @@ static int show(int argc, const char **argv)
=20
 static int set_head(int argc, const char **argv)
 {
-	int opt_a =3D 0, opt_d =3D 0, result =3D 0;
+	int i, opt_a =3D 0, opt_d =3D 0, result =3D 0;
 	struct strbuf buf =3D STRBUF_INIT, buf2 =3D STRBUF_INIT;
 	char *head_name =3D NULL;
=20
@@ -802,7 +809,16 @@ static int set_head(int argc, const char **argv)
 		struct ref_states states;
 		memset(&states, 0, sizeof(states));
 		get_remote_ref_states(argv[0], &states, 1);
-		head_name =3D xstrdup(states.head_name);
+		if (!states.heads.nr)
+			result |=3D error("Cannot determine remote HEAD");
+		else if (states.heads.nr > 1) {
+			result |=3D error("Multiple remote HEAD branches. "
+					"Please choose one explicitly with:");
+			for (i =3D 0; i < states.heads.nr; i++)
+				fprintf(stderr, "  git remote set-head %s %s\n",
+					argv[0], states.heads.items[i].string);
+		} else
+			head_name =3D xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc =3D=3D 1) {
 		if (delete_ref(buf.buf, NULL, REF_NODEREF))
@@ -818,6 +834,8 @@ static int set_head(int argc, const char **argv)
 			result |=3D error("Not a valid ref: %s", buf2.buf);
 		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
 			result |=3D error("Could not setup %s", buf.buf);
+		if (opt_a)
+			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
 	}
=20
diff --git a/remote.c b/remote.c
index 447f091..6385a22 100644
--- a/remote.c
+++ b/remote.c
@@ -1379,18 +1379,23 @@ int format_tracking_info(struct branch *branch,=
 struct strbuf *sb)
=20
 const struct ref *guess_remote_head(const struct ref *refs,
 				    const struct ref *mapped_refs,
-				    const struct ref **remote_head_p)
+				    const struct ref **remote_head_p,
+				    struct ref **all_matches_p)
 {
 	const struct ref *remote_head =3D NULL;
 	const struct ref *remote_master =3D NULL;
+	const struct ref *ret =3D NULL;
 	const struct ref *r;
+	struct ref **tail =3D all_matches_p;
+
 	for (r =3D refs; r; r =3D r->next)
 		if (!strcmp(r->name, "HEAD"))
 			remote_head =3D r;
=20
-	for (r =3D mapped_refs; r; r =3D r->next)
-		if (!strcmp(r->name, "refs/heads/master"))
-			remote_master =3D r;
+	if (!all_matches_p)
+		for (r =3D mapped_refs; r; r =3D r->next)
+			if (!strcmp(r->name, "refs/heads/master"))
+				remote_master =3D r;
=20
 	if (remote_head_p)
 		*remote_head_p =3D remote_head;
@@ -1407,9 +1412,16 @@ const struct ref *guess_remote_head(const struct=
 ref *refs,
 	/* Look for another ref that points there */
 	for (r =3D mapped_refs; r; r =3D r->next)
 		if (r !=3D remote_head &&
-		    !hashcmp(r->old_sha1, remote_head->old_sha1))
-			return r;
+		    !hashcmp(r->old_sha1, remote_head->old_sha1)) {
+			struct ref *cpy;
+			if (!ret)
+				ret =3D r;
+			if (!all_matches_p)
+				break;
+			*tail =3D cpy =3D copy_ref(r);
+			cpy->peer_ref =3D NULL;
+			tail =3D &cpy->next;
+		}
=20
-	/* Nothing is the same */
-	return NULL;
+	return ret;
 }
diff --git a/remote.h b/remote.h
index cabb14a..8409d42 100644
--- a/remote.h
+++ b/remote.h
@@ -141,9 +141,13 @@ int format_tracking_info(struct branch *branch, st=
ruct strbuf *sb);
  * Look in refs for HEAD. Then look for a matching SHA1 in mapped_refs=
,
  * first checking if refs/heads/master matches. Return NULL if nothing=
 matches
  * or if there is no HEAD in refs. remote_head_p is assigned HEAD if n=
ot NULL.
+ * If all_matches_p is NULL, return after the first possible match. Ot=
herwise
+ * all_matches_p is set to a ref list of each branch head with the sam=
e SHA1 as
+ * HEAD.
  */
 const struct ref *guess_remote_head(const struct ref *refs,
 				    const struct ref *mapped_refs,
-				    const struct ref **remote_head_p);
+				    const struct ref **remote_head_p,
+				    struct ref **all_matches_p);
=20
 #endif
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8808580..49f99e9 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -136,7 +136,7 @@ EOF
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
-  HEAD: master
+  HEAD branch: master
   Remote branch merged with 'git pull' while on branch master
     master
   New remote branch (next fetch will store in remotes/origin)
@@ -147,6 +147,11 @@ cat > test/expect << EOF
   Local branches pushed with 'git push'
     master:upstream
     +refs/tags/lastbackup
+* remote two
+  URL: ../two
+  HEAD branches:
+    another
+    master
 EOF
=20
 test_expect_success 'show' '
@@ -155,6 +160,7 @@ test_expect_success 'show' '
 		refs/heads/master:refs/heads/upstream &&
 	 git fetch &&
 	 git branch -d -r origin/master &&
+	 git config --add remote.two.url ../two &&
 	 (cd ../one &&
 	  echo 1 > file &&
 	  test_tick &&
@@ -163,13 +169,14 @@ test_expect_success 'show' '
 		refs/heads/master:refs/heads/upstream &&
 	 git config --add remote.origin.push \
 		+refs/tags/lastbackup &&
-	 git remote show origin > output &&
+	 git remote show origin two > output &&
 	 test_cmp expect output)
 '
=20
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
+  HEAD branch: (not queried)
   Remote branch merged with 'git pull' while on branch master
     master
   Tracked remote branches
@@ -198,6 +205,48 @@ test_expect_success 'prune' '
 	 test_must_fail git rev-parse refs/remotes/origin/side)
 '
=20
+test_expect_success 'set-head --delete' '
+	(cd test &&
+	 git symbolic-ref refs/remotes/origin/HEAD &&
+	 git remote set-head --delete origin &&
+	 test_must_fail git symbolic-ref refs/remotes/origin/HEAD)
+'
+
+cat > test/expect <<EOF
+origin/HEAD set to master
+EOF
+
+test_expect_success 'set-head --auto' '
+	(cd test &&
+	 git remote set-head --auto origin > output &&
+	 git symbolic-ref refs/remotes/origin/HEAD &&
+	test_cmp expect output)
+'
+
+cat >test/expect <<EOF
+error: Multiple remote HEAD branches. Please choose one explicitly wit=
h:
+  git remote set-head two another
+  git remote set-head two master
+EOF
+
+test_expect_success 'set-head --auto fails w/multiple HEADs' '
+	(cd test &&
+	 test_must_fail git remote set-head --auto two >& output &&
+	test_cmp expect output)
+'
+
+cat >test/expect <<EOF
+refs/remotes/origin/side2
+EOF
+
+test_expect_success 'set-head explicit' '
+	(cd test &&
+	 git remote set-head origin side2 &&
+	 git symbolic-ref refs/remotes/origin/HEAD >output &&
+	 git remote set-head origin master &&
+	 test_cmp expect output)
+'
+
 cat > test/expect << EOF
 Pruning origin
 URL: $(pwd)/one
--=20
1.6.2.rc0.238.g0c1fe
