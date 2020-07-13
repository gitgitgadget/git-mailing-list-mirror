Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB888C433E2
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD05206F5
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OcF7klkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgGMUAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:00:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62825 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMUAi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:00:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EC2D67B68;
        Mon, 13 Jul 2020 16:00:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uLCu+SM4SDUr56JZ6Q3306+tV8Y=; b=OcF7kl
        kvelUjOcrc/mZBe90VL7Yj+Lega6XVbpxwMQSp379oQHsUSgIXfA5BlsdlE9SDWM
        jMF2q4ySD/EgmnWdvdX7CyOwaxhCxwV62hJS4gffzIbB/4vA6IH3Gipq9cvlEyOV
        T8Z9K5HFjm/brVGCcJ83IHKDVggeMjUkqu3aY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QvMmWCxfFuwlVA38udsWukbf5eT/UffB
        tkMVUMJwK9/3ZbkW+WbdonWv3WZgAEkj9GOh2QtZM6YiLYdNJhjFycglBlHXD82W
        dXVrk81QQ8SaTT1OAygltS0fb0KQv2J9G0FhUyOTo3PxYrz7uBt8kyHJF0Xf3dFa
        7ngyKX0exq4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 377E767B65;
        Mon, 13 Jul 2020 16:00:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC20A67B63;
        Mon, 13 Jul 2020 16:00:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] setup: warn if extensions exist on old format
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
        <xmqqblkjnr5m.fsf@gitster.c.googlers.com>
Date:   Mon, 13 Jul 2020 13:00:35 -0700
In-Reply-To: <xmqqblkjnr5m.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 13 Jul 2020 12:36:37 -0700")
Message-ID: <xmqqy2nnmbh8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84187DAA-C543-11EA-8093-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> An alternative may be to grandfather some extensions that were
> enabled by git by mistake without updating the format version, and
> we update the repository even if the repository has extensions that
> should not exist, but those offending extensions are limited only to
> those that we decide to special case.  That would make the end-user
> experience even smoother.
>
> Is extenions.worktreeCOnfig the only one that needs this escape
> hatch?

Assuming that worktreeconfig is the only thing, the change may look
like this.  With this change, we might want to drop the new warning
in hunk ll.542- to avoid encouraging people to muck with their
repository with random configuration variables that happen to share
extensions.* prefix with us.

 cache.h |  2 +-
 setup.c | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index e5885cc9ea..8ff46857f6 100644
--- a/cache.h
+++ b/cache.h
@@ -1042,8 +1042,8 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
-	int has_extensions;
 	char *work_tree;
+	int has_unallowed_extensions;
 	struct string_list unknown_extensions;
 };
 
diff --git a/setup.c b/setup.c
index eb066db6d8..5f4786d3b9 100644
--- a/setup.c
+++ b/setup.c
@@ -455,12 +455,13 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
-		data->has_extensions = 1;
 		/*
 		 * record any known extensions here; otherwise,
 		 * we fall through to recording it as unknown, and
 		 * check_repository_format will complain
 		 */
+		int is_unallowed_extension = 1;
+
 		if (!strcmp(ext, "noop"))
 			;
 		else if (!strcmp(ext, "preciousobjects"))
@@ -469,10 +470,13 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			if (!value)
 				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
-		} else if (!strcmp(ext, "worktreeconfig"))
+		} else if (!strcmp(ext, "worktreeconfig")) {
 			data->worktree_config = git_config_bool(var, value);
-		else
+			is_unallowed_extension = 0;
+		} else
 			string_list_append(&data->unknown_extensions, ext);
+
+		data->has_unallowed_extensions |= is_unallowed_extension;
 	}
 
 	return read_worktree_config(var, value, vdata);
@@ -542,6 +546,11 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		}
 	}
 
+	if (candidate->version == 0 && candidate->has_unallowed_extensions) {
+		warning(_("some extensions are enabled, but core.repositoryFormatVersion=0"));
+		warning(_("if you intended to use extensions, run 'git config core.repositoryFormatVersion 1'"));
+	}
+
 	return 0;
 }
 
@@ -560,7 +569,7 @@ int upgrade_repository_format(int target_version)
 		return 0;
 
 	if (verify_repository_format(&repo_fmt, &err) < 0 ||
-	    (!repo_fmt.version && repo_fmt.has_extensions)) {
+	    (!repo_fmt.version && repo_fmt.has_unallowed_extensions)) {
 		warning("unable to upgrade repository format from %d to %d: %s",
 			repo_fmt.version, target_version, err.buf);
 		strbuf_release(&err);
