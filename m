From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: Reduce heads before trying to merge them
Date: Wed, 18 Apr 2012 22:19:55 -0700
Message-ID: <7vd374i9hg.fsf@alter.siamese.dyndns.org>
References: <CA+55aFzGwPYNn2baFhEr4msBTV7__nkTSUqAZ7=PRVoYrchV5w@mail.gmail.com>
 <1334687118-5386-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7vzkaambre.fsf@alter.siamese.dyndns.org>
 <CA+55aFzLFA535CtjLJe1p62H=nunQ=vrL_mPYsYJB0e8U7mpdg@mail.gmail.com>
 <7vvckym6ec.fsf@alter.siamese.dyndns.org> <20120418201426.7070315f@gmail.com>
 <7vzka8kd1m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 07:20:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKjmn-00054M-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 07:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab2DSFUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 01:20:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab2DSFT7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 01:19:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B49872ED;
	Thu, 19 Apr 2012 01:19:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QKD8IUdk5KCT
	qhfN4ilwAzYHxmQ=; b=oPV5zQDDpiNDGZPbfEXin4qVmKS3mXELr1yfLQPafrhG
	MhVbiAQ3JaQwXe6EyOhaQLWyXJF6GYQYOvfJJ/kgwbgiyTAZgilVrDIveOFQoJMp
	vQkOoy2enIKc1UG3GJx9PR1tl4nPBdLHVSzTgbPYYTZOuvjGipZR75nlcVUmMPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CQyuYX
	Qiau0PZL7it/aAmB0X8AXiehVYX1nwSXg95Nrhcmsss61wNRN4EEd5RdvD0r6fZq
	R6XOSVRdS7L3lVm04XCPdp1M93gcE6bOWUFU602XR7ipkhStADDbzTWJUGrVvtBZ
	XMtA26Q9sPvbwc3hULvQhDQ9SnrRBhxk1WiyE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 007C972EC;
	Thu, 19 Apr 2012 01:19:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FB8872EB; Thu, 19 Apr 2012
 01:19:57 -0400 (EDT)
In-Reply-To: <7vzka8kd1m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 18 Apr 2012 13:20:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DA839DE-89DF-11E1-8003-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195921>

Junio C Hamano <gitster@pobox.com> writes:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>> =20
>>> I was cooking a fix on-and-off since yesterday evening, and sent it=
 out a
>>> few minutes ago. I think the spirit is almost the same as Micha=C5=82=
's updated
>>> patch, but it reduces the heads even earlier to catch cases where M=
icha=C5=82's
>>> updated patch may misdiagnose arity of the resulting merge due to i=
ts use
>>> of remoteheads->next before the list is reduced (namely, the choice=
 of the
>>> default strategy based on how many we are merging).
>>
>> I like your patches, especially how reducing heads is now done in
>> collect_parents() instead of doing it twice (before merging and in
>> finish_automerge()).  And that you got rid of global remoteheads too=
=2E
>
> Thanks.  Linus also said "Yes, that sounds right (on the road with ju=
st my
> phone, sorry for the html)" off-list to the series.

There was another bit still missing from my 4-patch series.

"merge" passes the updated test only because it runs the fmt_merge_msg(=
)
internally after the reduction of the remotes, but without this update =
to
builtin/fmt-merge.msg.c, "pull" doesn't and its merge summary lists
unnecessary heads, because it calls the plumbing version from the scrip=
t
with full set of possibly redundant parents.

-- >8 --
Subject: [PATCH] fmt-merge-msg: discard needless merge parents

This is used by "git pull" to construct a merge message from list of
remote refs.  When pulling redundant set of refs, however, it did not
filter them even though the merge itself discards them as unnecessary.

Teach the command to do the same for consistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fmt-merge-msg.c       |  125 +++++++++++++++++++++++++++++++++=
+++++---
 t/t7603-merge-reduce-heads.sh |   31 +++++++++-
 2 files changed, 146 insertions(+), 10 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index c81a7fe..dcc12ea 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -53,7 +53,47 @@ static void init_src_data(struct src_data *data)
 static struct string_list srcs =3D STRING_LIST_INIT_DUP;
 static struct string_list origins =3D STRING_LIST_INIT_DUP;
=20
-static int handle_line(char *line)
+struct merge_parents {
+	int alloc, nr;
+	struct merge_parent {
+		unsigned char given[20];
+		unsigned char commit[20];
+		unsigned char used;
+	} *item;
+};
+
+/*
+ * I know, I know, this is inefficient, but you won't be pulling and m=
erging
+ * hundreds of heads at a time anyway.
+ */
+static struct merge_parent *find_merge_parent(struct merge_parents *ta=
ble,
+					      unsigned char *given,
+					      unsigned char *commit)
+{
+	int i;
+	for (i =3D 0; i < table->nr; i++) {
+		if (given && hashcmp(table->item[i].given, given))
+			continue;
+		if (commit && hashcmp(table->item[i].commit, commit))
+			continue;
+		return &table->item[i];
+	}
+	return NULL;
+}
+
+static void add_merge_parent(struct merge_parents *table,
+			     unsigned char *given,
+			     unsigned char *commit)
+{
+	if (table->nr && find_merge_parent(table, given, commit))
+		return;
+	ALLOC_GROW(table->item, table->nr + 1, table->alloc);
+	hashcpy(table->item[table->nr].given, given);
+	hashcpy(table->item[table->nr].commit, commit);
+	table->nr++;
+}
+
+static int handle_line(char *line, struct merge_parents *merge_parents=
)
 {
 	int i, len =3D strlen(line);
 	struct origin_data *origin_data;
@@ -61,6 +101,7 @@ static int handle_line(char *line)
 	struct src_data *src_data;
 	struct string_list_item *item;
 	int pulling_head =3D 0;
+	unsigned char sha1[20];
=20
 	if (len < 43 || line[40] !=3D '\t')
 		return 1;
@@ -71,14 +112,15 @@ static int handle_line(char *line)
 	if (line[41] !=3D '\t')
 		return 2;
=20
-	line[40] =3D 0;
-	origin_data =3D xcalloc(1, sizeof(struct origin_data));
-	i =3D get_sha1(line, origin_data->sha1);
-	line[40] =3D '\t';
-	if (i) {
-		free(origin_data);
+	i =3D get_sha1_hex(line, sha1);
+	if (i)
 		return 3;
-	}
+
+	if (!find_merge_parent(merge_parents, sha1, NULL))
+		return 0; /* subsumed by other parents */
+
+	origin_data =3D xcalloc(1, sizeof(struct origin_data));
+	hashcpy(origin_data->sha1, sha1);
=20
 	if (line[len - 1] =3D=3D '\n')
 		line[len - 1] =3D 0;
@@ -366,6 +408,68 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 	strbuf_release(&tagbuf);
 }
=20
+static struct merge_parents *find_merge_parents(struct strbuf *in, uns=
igned char *head)
+{
+	struct commit_list *parents, *next;
+	struct commit *head_commit;
+	struct merge_parents *result =3D xcalloc(1, sizeof(*result));
+	int pos =3D 0, i, j;
+
+	parents =3D NULL;
+	while (pos < in->len) {
+		int len;
+		char *p =3D in->buf + pos;
+		char *newline =3D strchr(p, '\n');
+		unsigned char sha1[20];
+		struct commit *parent;
+		struct object *obj;
+
+		len =3D newline ? newline - p : strlen(p);
+		pos +=3D len + !!newline;
+
+		if (len < 43 ||
+		    get_sha1_hex(p, sha1) ||
+		    p[40] !=3D '\t' ||
+		    p[41] !=3D '\t')
+			continue; /* skip not-for-merge */
+		/*
+		 * Do not use get_merge_parent() here; we do not have
+		 * "name" here and we do not want to contaminate its
+		 * util field yet.
+		 */
+		obj =3D parse_object(sha1);
+		parent =3D (struct commit *)peel_to_type(NULL, 0, obj, OBJ_COMMIT);
+		if (!parent)
+			continue;
+		commit_list_insert(parent, &parents);
+		add_merge_parent(result, obj->sha1, parent->object.sha1);
+	}
+	head_commit =3D lookup_commit(head);
+	if (head_commit)
+		commit_list_insert(head_commit, &parents);
+	parents =3D reduce_heads(parents);
+
+	while (parents) {
+		for (i =3D 0; i < result->nr; i++)
+			if (!hashcmp(result->item[i].commit,
+				     parents->item->object.sha1))
+				result->item[i].used =3D 1;
+		next =3D parents->next;
+		free(parents);
+		parents =3D next;
+	}
+
+	for (i =3D j =3D 0; i < result->nr; i++) {
+		if (result->item[i].used) {
+			if (i !=3D j)
+				result->item[j] =3D result->item[i];
+			j++;
+		}
+	}
+	result->nr =3D j;
+	return result;
+}
+
 int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		  struct fmt_merge_msg_opts *opts)
 {
@@ -373,6 +477,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf =
*out,
 	unsigned char head_sha1[20];
 	const char *current_branch;
 	void *current_branch_to_free;
+	struct merge_parents *merge_parents;
=20
 	/* get current branch */
 	current_branch =3D current_branch_to_free =3D
@@ -382,6 +487,8 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf =
*out,
 	if (!prefixcmp(current_branch, "refs/heads/"))
 		current_branch +=3D 11;
=20
+	merge_parents =3D find_merge_parents(in, head_sha1);
+
 	/* get a line */
 	while (pos < in->len) {
 		int len;
@@ -392,7 +499,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf =
*out,
 		pos +=3D len + !!newline;
 		i++;
 		p[len] =3D 0;
-		if (handle_line(p))
+		if (handle_line(p, merge_parents))
 			die ("Error in line %d: %.*s", i, len, p);
 	}
=20
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads=
=2Esh
index a3b08a6..9894895 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -57,7 +57,36 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
 	test -f c2.c &&
 	test -f c3.c &&
 	test -f c4.c &&
-	test -f c5.c
+	test -f c5.c &&
+	git show --format=3D%s -s >actual &&
+	! grep c1 actual &&
+	grep c2 actual &&
+	grep c3 actual &&
+	! grep c4 actual &&
+	grep c5 actual
+'
+
+test_expect_success 'pull c2, c3, c4, c5 into c1' '
+	git reset --hard c1 &&
+	git pull . c2 c3 c4 c5 &&
+	test "$(git rev-parse c1)" !=3D "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse c1)" =3D "$(git rev-parse HEAD^1)" &&
+	test "$(git rev-parse c2)" =3D "$(git rev-parse HEAD^2)" &&
+	test "$(git rev-parse c3)" =3D "$(git rev-parse HEAD^3)" &&
+	test "$(git rev-parse c5)" =3D "$(git rev-parse HEAD^4)" &&
+	git diff --exit-code &&
+	test -f c0.c &&
+	test -f c1.c &&
+	test -f c2.c &&
+	test -f c3.c &&
+	test -f c4.c &&
+	test -f c5.c &&
+	git show --format=3D%s -s >actual &&
+	! grep c1 actual &&
+	grep c2 actual &&
+	grep c3 actual &&
+	! grep c4 actual &&
+	grep c5 actual
 '
=20
 test_expect_success 'setup' '
--=20
1.7.10.333.gf16fa
