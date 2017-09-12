Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06CCA1FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 17:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdILRac (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 13:30:32 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36057 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdILRab (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 13:30:31 -0400
Received: by mail-pg0-f66.google.com with SMTP id d8so6477147pgt.3
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=moU9y7kNZ7WAF54/CPSJN5MZCJ6QP2jAZlbZImYADKk=;
        b=cyR2TDw11NicvOOM5NXPROaP3mLuzlfhCfG1OlNP0WrBcrbMIWIhTceyEPlbZl89FU
         Kgry4ZkYFK1ZHJProKhxksTd1X0/phMisSrYrVXigv2IIvqox/KR0wtDzxEQiUR7/OF/
         4pEN2Mrx+AWIR63mL36EbgxI/T4lFESerfxQ2iV/DgqVnVN5c6QSYL8zmalGL1ujc7pc
         G6cH6UA//Awz4mgjDKJmV9+tQvNL+tUVkVVvXUUUamtNbxa8dBlapwSXFhP7sfYbuhup
         1ZV1pM62QeGGR2fU9hnrFbXgILDrAbLq8+IH2M/9WmUqhAMDirxL378rJFjbtka+yBQj
         iOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=moU9y7kNZ7WAF54/CPSJN5MZCJ6QP2jAZlbZImYADKk=;
        b=GGyKbpAqjuC+ZEJGddiv0vw/WB9tF3u00TVyrT6qBl7tvTlrGMEDa/2B15+cU21ihI
         GTr3NtmHJCpIdqdmWH0WdhyPDP8sRivU59rlMA/1AgpF4/b/0usNwsuUxwI1e02kDQSn
         nKnRMxJyvOOk/VvPUDM2SPWgH5kRfFtZOavNoKOz+RYEbdYmPnA9TwEjUN5TXN/HoZhJ
         +1xTMeZRH2uK9kOHIWMUMxueZEiUHJSasZ7mdSHbOwMZg3dIHpOaaiTWGpLn/IyG24TG
         aWFDFch1OGcVjHf5eEkCh6n58s+nRAc3au9TwzRNyBcZsoO94IOxu0boWjp4UQfv7/tl
         A5Lg==
X-Gm-Message-State: AHPjjUjNlhetaS+2DTzZ2+WeQXCgExeLit/rWOMbP7o6+fZHo5YxqcZ+
        lb49FUFY1Z/SbrYu3zg=
X-Google-Smtp-Source: ADKCNb5kya0tl3n5BxNbdaqrlaGS1lKGR/peOC2HA7OJXOT0YHCBOIdm8hv2FeqN8LQ9ZiHy+9Gn2g==
X-Received: by 10.84.244.3 with SMTP id g3mr17998662pll.12.1505237430078;
        Tue, 12 Sep 2017 10:30:30 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9def:8161:22df:85ca])
        by smtp.gmail.com with ESMTPSA id h82sm22871222pfd.148.2017.09.12.10.30.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 10:30:29 -0700 (PDT)
Date:   Tue, 12 Sep 2017 10:30:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 2/4] push, fetch: error out for submodule entries not
 pointing to commits
Message-ID: <20170912173027.GC144745@aiede.mtv.corp.google.com>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912172330.GA144745@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

The check_has_commit helper uses resolves a submodule entry to a
commit, when validating its existence. As a side effect this means
tolerates a submodule entry pointing to a tag, which is not a valid
submodule entry that git commands would know how to cope with.

Tighten the check to require an actual commit, not a tag pointing to a
commit.

Also improve the error handling when a submodule entry points to
non-commit (e.g., a blob) to error out instead of warning and
pretending the pointed to object doesn't exist.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 submodule.c                    | 33 +++++++++++++++++++++++++--------
 t/t5531-deep-submodule-push.sh | 10 ++++++++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3cea8221e0..e0da55920d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -767,19 +767,36 @@ static int append_oid_to_argv(const struct object_id *oid, void *data)
 	return 0;
 }
 
+struct has_commit_data {
+	int result;
+	const char *path;
+};
+
 static int check_has_commit(const struct object_id *oid, void *data)
 {
-	int *has_commit = data;
+	struct has_commit_data *cb = data;
 
-	if (!lookup_commit_reference(oid))
-		*has_commit = 0;
+	enum object_type type = sha1_object_info(oid->hash, NULL);
 
-	return 0;
+	switch (type) {
+	case OBJ_COMMIT:
+		return 0;
+	case OBJ_BAD:
+		/*
+		 * Object is missing or invalid. If invalid, an error message
+		 * has already been printed.
+		 */
+		cb->result = 0;
+		return 0;
+	default:
+		die(_("submodule entry '%s' (%s) is a %s, not a commit"),
+		    cb->path, oid_to_hex(oid), typename(type));
+	}
 }
 
 static int submodule_has_commits(const char *path, struct oid_array *commits)
 {
-	int has_commit = 1;
+	struct has_commit_data has_commit = { 1, path };
 
 	/*
 	 * Perform a cheap, but incorrect check for the existence of 'commits'.
@@ -795,7 +812,7 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
 
 	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
 
-	if (has_commit) {
+	if (has_commit.result) {
 		/*
 		 * Even if the submodule is checked out and the commit is
 		 * present, make sure it exists in the submodule's object store
@@ -814,12 +831,12 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
 		cp.dir = path;
 
 		if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) || out.len)
-			has_commit = 0;
+			has_commit.result = 0;
 
 		strbuf_release(&out);
 	}
 
-	return has_commit;
+	return has_commit.result;
 }
 
 static int submodule_needs_pushing(const char *path, struct oid_array *commits)
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 0f84a53146..39cb2c1c34 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -298,6 +298,16 @@ test_expect_success 'push succeeds if submodule commit disabling recursion from
 	)
 '
 
+test_expect_success 'submodule entry pointing at a tag is error' '
+	git -C work/gar/bage tag -a test1 -m "tag" &&
+	tag=$(git -C work/gar/bage rev-parse test1^{tag}) &&
+	git -C work update-index --cacheinfo 160000 "$tag" gar/bage &&
+	git -C work commit -m "bad commit" &&
+	test_when_finished "git -C work reset --hard HEAD^" &&
+	test_must_fail git -C work push --recurse-submodules=on-demand ../pub.git master 2>err &&
+	test_i18ngrep "is a tag, not a commit" err
+'
+
 test_expect_success 'push fails if recurse submodules option passed as yes' '
 	(
 		cd work/gar/bage &&
-- 
2.14.1.690.gbb1197296e

