Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8E4421
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XXWt5rvB"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8791BA
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:08:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 34BAB3094A;
	Tue, 17 Oct 2023 23:08:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hW2WR+jMB3BbjFEU+Y4NQN5DKaoh/5B06Eu/5W
	0ZQhg=; b=XXWt5rvBsMvHwkhK8DTXVo46+7gf8yDqeA1ray8qpjRcDcaF4UPkXT
	nf5EE0XvVdQPYZGvcyOjXyilobBVQ9u3pEV/VDIrUDx/zexh1CU5W9ojkrN5x/4P
	8WhXNIbGnNb56nDJ3ki3U+njgf2yumeU8YIloVWwA4lVIxyE/SnEs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F9E130949;
	Tue, 17 Oct 2023 23:08:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99AE530948;
	Tue, 17 Oct 2023 23:08:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH] commit: do not use cryptic "new_index" in end-user facing
 messages
In-Reply-To: <xmqqwmvkve83.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	17 Oct 2023 19:47:24 -0700")
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
	<xmqqzg0gx6k9.fsf@gitster.g>
	<CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
	<xmqqwmvkve83.fsf@gitster.g>
Date: Tue, 17 Oct 2023 20:08:51 -0700
Message-ID: <xmqqo7gwvd8c.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AA99567C-6D63-11EE-86E9-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These error messages say "new_index" as if that spelling has some
significance to the end users (e.g. the file "$GIT_DIR/new_index"
has some issues), but that is not the case at all.  The i18n folks
were made to include the word literally in the translated messages,
which was not a good idea at all.  Spell it "new index", as we are
just telling the users that we failed to create a new index file.
The term is expected to be translated to the end-users' languages,
not left as if it were a literal file name.

This dates all the way back to the first re-implemenation of "git
commit" command in C (the scripted version did not have such wording
in its error messages), in f5bbc322 (Port git commit to C.,
2007-11-08).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Junio C Hamano <gitster@pobox.com> writes:

    > Jiang Xin <worldhello.net@gmail.com> writes:
    > ...
    > Wait.  Is this supposed to be a good example of validator working
    > well?  We use this exact message three times in builtin/commit.c; is
    > the validator insisting on the translated message to have verbatim
    > string "new_index" in it so that the end-users will see it?
    > ...
    > I'd suggest doing s/new_index/new index/ to msgid string for these
    > anyway.

    Just so that we do not forget, in case my "using new_index in
    the message is wrong" is not my misunderstanding, here is such a
    patch.  Note that "checkout", "clone", "read-tree", and "stash"
    all use the "new index" spelling so this is not introducing any
    new message.  "git merge" and "git pull" that fast-forward also
    use this same message when they cannot write a new index file.

 builtin/commit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 985a0445b7..7abd566bc7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -446,7 +446,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		refresh_cache_or_die(refresh_flags);
 		cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
-			die(_("unable to write new_index file"));
+			die(_("unable to write new index file"));
 		commit_style = COMMIT_NORMAL;
 		ret = get_lock_file_path(&index_lock);
 		goto out;
@@ -470,7 +470,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 			cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-			die(_("unable to write new_index file"));
+			die(_("unable to write new index file"));
 		commit_style = COMMIT_AS_IS;
 		ret = get_index_file();
 		goto out;
@@ -518,7 +518,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 	cache_tree_update(&the_index, WRITE_TREE_SILENT);
 	if (write_locked_index(&the_index, &index_lock, 0))
-		die(_("unable to write new_index file"));
+		die(_("unable to write new index file"));
 
 	hold_lock_file_for_update(&false_lock,
 				  git_path("next-index-%"PRIuMAX,
@@ -1852,7 +1852,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (commit_index_files())
 		die(_("repository has been updated, but unable to write\n"
-		      "new_index file. Check that disk is not full and quota is\n"
+		      "new index file. Check that disk is not full and quota is\n"
 		      "not exceeded, and then \"git restore --staged :/\" to recover."));
 
 	git_test_write_commit_graph_or_die();
-- 
2.42.0-398-ga9ecda2788

