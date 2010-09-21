From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH/RFC] Documentation/git-gc.txt: add reference to githooks
Date: Tue, 21 Sep 2010 16:18:54 -0700
Message-ID: <7vtyliu1lt.fsf_-_@alter.siamese.dyndns.org>
References: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
 <1277744834-7546-1-git-send-email-judge.packham@gmail.com>
 <20100921181406.GA7389@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Sep 22 01:20:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyC86-0006H9-2m
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 01:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0IUXTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 19:19:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0IUXTD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 19:19:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39EBBD8D8C;
	Tue, 21 Sep 2010 19:19:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nLmsdPd1zzW3vzEtNWEf4UGIIxk=; b=NQiVzk
	y1knBb3SftYZsazaQM0/AZBidEwPBI+fNTIF389xkxxoaW713q8vWzzP/wqszWNK
	0XdufIsQzTSwKl4ljfq/6FM8CD4AQW8m9Xl/sRqqyi6o7i2XwO/XRa3n7di8jQjB
	PYZgc0AP6zl5xRvEGSd3DlNYGO84EViJRdjVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zc9VX/2bajGTUqm3NtnVneULTVFgcM3K
	1mWqw3gQ/E7sK9jVzPch0LqzUwX1h1OKzord5c9gm49GjmbNtQ6ECj1TIh1FBT2b
	lXV2vb0EnJMpA9nepnyR0iz0xJShlj6lwPXALPTg/Vlo5dib9zjrgkY+sbWLz3ne
	RGBV2N4z89k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14F67D8D8B;
	Tue, 21 Sep 2010 19:18:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D37EFD8D8A; Tue, 21 Sep
 2010 19:18:55 -0400 (EDT)
In-Reply-To: <20100921181406.GA7389@huya.qualcomm.com> (David Brown's message
 of "Tue\, 21 Sep 2010 11\:14\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9CE8AC5A-C5D6-11DF-9951-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156768>

David Brown <davidb@codeaurora.org> writes:

> Suppose I want to publish some changes to a tree.  I have a server
> available where I can run a git daemon, but for one reason or another
> I want to force people to use the another git repo as a reference.
> The reason could be one of bandwidth, or someone who isn't comfortable
> making all of the other source available.  Ideally, someone who
> already has the other git repo cloned, and just adds mine as a remote
> wouldn't notice the difference.
>
> Is there a way to do this?  I've tried various ways of using
> alternates to keep the blobs out of the repository I want to export,
> but the daemon just follows the alternates.  If I remove the
> alternates, I then seem to have a broken repository.  Most things I
> try, at least carry objects for all of the files in the HEAD tree,
> which most of the time is a large portion of the data.

I've seen people ask for something like this in the past for a few times.
Once might have been during GitTogether'08 by you.

I don't think there is a way to do that, though.

Perhaps something like this totally untested patch?  The code may be
utterly wrong but you should be able to get the idea from the test
scripts.  Add configuration to the repository for you to declare which
objects are prerequiste for pulling from you, with a message to suggest
where to grab them from.

I am a bit reluctant to suggest upload-pack to start reading from the
repository configuration, though.

 t/t5532-upload-limit.sh |  107 +++++++++++++++++++++++++++++++++++++++++
 upload-pack.c           |  120 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+), 0 deletions(-)

diff --git a/t/t5532-upload-limit.sh b/t/t5532-upload-limit.sh
new file mode 100755
index 0000000..070594e
--- /dev/null
+++ b/t/t5532-upload-limit.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Google Inc.
+#
+
+test_description='git upload-pack honoring clonelimit configuration'
+
+. ./test-lib.sh
+
+grow () {
+	for a
+	do
+		echo "$a" >file &&
+		git add file &&
+		git commit -m "$a" || exit
+	done
+}
+
+setup_clone () {
+	git clone "file://$(pwd)/src" "$1" &&
+	(
+		cd "$1" &&
+		git rev-parse --verify "$2" >actual
+	) &&
+	test_cmp src/expect "$1/actual"
+}
+
+test_expect_success 'setup' '
+	mkdir src &&
+	(
+		cd src &&
+		git init &&
+		grow a b c &&
+		git rev-parse --verify master >expect
+	) &&
+	setup_clone dst-0 master &&
+	setup_clone dst-1 master &&
+	(
+		cd src &&
+		grow d e &&
+		git tag -a -m mark mark &&
+		git rev-parse --verify mark >expect
+	) &&
+	setup_clone dst-2 mark &&
+	setup_clone dst-3 mark &&
+	(
+		cd src &&
+		grow f g h &&
+		git tag -a -m tip tip &&
+		git rev-parse --verify tip >expect
+	)
+'
+
+test_expect_success 'baseline - no limitation in fetch' '
+	(
+		cd dst-0 &&
+		git fetch &&
+		git rev-parse --verify tip >actual
+	) &&
+	test_cmp src/expect dst-0/actual
+'
+
+test_expect_success 'clone refused when limitation is set' '
+	(
+		cd src &&
+		git config clonelimit.mark.message "go away"
+	) &&
+	test_must_fail git clone "file://$(pwd)/src" dst-4 &&
+	! test -d dst-4
+'
+
+test_expect_success 'fetch refused when limitation is unmet' '
+	(
+		cd dst-1 &&
+		test_must_fail git fetch &&
+		test_must_fail git rev-parse --verify tip
+	)
+'
+
+test_expect_success 'fetch works when limitation is met' '
+	(
+		cd src &&
+		git config clonelimit.mark.message "go away"
+	) &&
+	(
+		cd dst-2 &&
+		git fetch &&
+		git rev-parse --verify tip >actual
+	) &&
+	test_cmp src/expect dst-2/actual
+'
+
+test_expect_success 'missing tag is not a limitation violation' '
+	(
+		cd src &&
+		git config clonelimit.mark.message "go away"
+	) &&
+	(
+		cd dst-3 &&
+		git tag -d mark &&
+		git fetch &&
+		git rev-parse --verify tip >actual
+	) &&
+	test_cmp src/expect dst-3/actual
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 92f9530..9d4a367 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -655,6 +655,124 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag
 	return 0;
 }
 
+/*
+ * Some repositories may not want to allow a full clone, and
+ * want users to first fetch from other repositories with
+ * better connection.  By having a configuration variable like
+ * this:
+ *
+ * [clonelimit "v0.99"]
+ *   message = go to git://git.kernel.org/pub/scm/git/...
+ *
+ * a fetch request by a fetcher that does not have the named commit
+ * is denied with the given message.
+ */
+struct clone_limit {
+	struct clone_limit *next;
+	struct commit *commit;
+	char *ref; /* points at the tail of msg to store symbolic ref */
+	char msg[FLEX_ARRAY]; /* message and more */
+};
+
+static int check_clone_limit(const char *var, const char *value, void *cb_)
+{
+	int msglen, reflen;
+	const char *lastdot;
+	struct clone_limit **clp = cb_;
+	struct clone_limit *limit;
+	unsigned char sha1[20];
+
+	if (prefixcmp(var, "clonelimit."))
+		return 0;
+
+	if (debug_fd) {
+		write_str_in_full(debug_fd, "config: ");
+		write_str_in_full(debug_fd, var);
+		write_str_in_full(debug_fd, " = <");
+		write_str_in_full(debug_fd, value);
+		write_str_in_full(debug_fd, ">\n");
+	}
+
+	var += 11; /* skip "clonelimit." */
+	lastdot = strrchr(var, '.');
+	reflen = lastdot - var;
+	if (reflen < 0 || memcmp(var + reflen, ".message", 9))
+		return 0; /* not our variable */
+
+	/*
+	 * The remainder will ignore a malformed entry; we might
+	 * want to abort the whole operation.  I dunno.
+	 */
+	if (!value)
+		return 0;
+	msglen = strlen(value) + 1;
+	limit = xmalloc(sizeof(*limit) + msglen + reflen + 1);
+	memcpy(limit->msg, value, msglen);
+	limit->ref = limit->msg + msglen;
+	memcpy(limit->ref, var, reflen);
+	limit->ref[reflen] = '\0';
+	if (get_sha1(limit->ref, sha1)) {
+		free(limit);
+		return 0;
+	}
+	limit->commit = lookup_commit_reference_gently(sha1, 0);
+	if (!limit->commit) {
+		free(limit);
+		return 0;
+	}
+	limit->next = *clp;
+	*clp = limit;
+	return 0;
+}
+
+static int limit_served_history(void)
+{
+	int has_missing, i, n;
+	struct clone_limit *clone_limit = NULL;
+	struct clone_limit *cl;
+	struct commit **twos = NULL;
+	struct commit_list *l;
+
+	git_config(check_clone_limit, &clone_limit);
+	if (!clone_limit)
+		return 0;
+
+	twos = xcalloc(have_obj.nr, sizeof(*twos));
+	for (i = n = 0; i < have_obj.nr; i++) {
+		struct object *o = have_obj.objects[i].item;
+		struct commit *have = lookup_commit_reference_gently(o->sha1, 0);
+		if (!have)
+			continue;
+		twos[n++] = have;
+	}
+
+	has_missing = 0;
+	for (cl = clone_limit; cl; cl = cl->next) {
+		int seen = 0;
+		l = get_merge_bases_many(cl->commit, n, twos, 1);
+		while (l) {
+			struct commit_list *next = l->next;
+			if (!hashcmp(l->item->object.sha1, cl->commit->object.sha1))
+				seen = 1;
+			free(l);
+			l = next;
+		}
+		if (!seen) {
+			has_missing = 1;
+			error("you do not have object '%s'; %s",
+			      cl->ref, cl->msg);
+		}
+	}
+
+	while (clone_limit) {
+		struct clone_limit *next = clone_limit->next;
+		free(clone_limit);
+		clone_limit = next;
+	}
+	free(twos);
+	return has_missing;
+}
+
 static void upload_pack(void)
 {
 	if (advertise_refs || !stateless_rpc) {
@@ -672,6 +790,8 @@ static void upload_pack(void)
 	receive_needs();
 	if (want_obj.nr) {
 		get_common_commits();
+		if (limit_served_history())
+			die("git upload-pack: missing prerequisites");
 		create_pack_file();
 	}
 }
