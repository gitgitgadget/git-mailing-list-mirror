Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F9A1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964817AbeB1XEh (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:04:37 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:43574 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964808AbeB1XEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:04:36 -0500
Received: by mail-wr0-f177.google.com with SMTP id u49so4145712wrc.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qL51pPdJ9WeVotHeLHSQIffM0LeSKy/vkPekrPTUFyQ=;
        b=UGafpn/6CGUY14CiCL2tDmChlifHzIfcYnf/KlAtqgw1f1QxK83nR9BNEZxGIRZeZ/
         BkQbfyHXWZzA1TJk/lhhnSxSCL33bokJJTqlv5ncDbfNd938wW7cJKAU0T7ixmuGrvUU
         mxhi+br1gYFhiGT5+HWz0DQrfmWeLryEUJTWQh7hwmd7GIm7Hdxdt26XG0pKVctKCXN8
         aTXfAUlV9+euL93ILwLbWGaIJIoc1BBbiBoGnb1VNifKLk1hzOlnZGYn+kOx9vtARt01
         6bVfFclMhEG7EkZP9ZqhforHbGLS8q9D1j7VD/ejF8E7sB/EfkovdSXM8v1uxenaERDB
         uZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qL51pPdJ9WeVotHeLHSQIffM0LeSKy/vkPekrPTUFyQ=;
        b=gqzC6fI3nkDd1ve+uNVrl18aIe7rLYvYSxlWQcjKLPRJcSKluknCOg9SBbfHtz+2yO
         kD5sNEwx/NuTYZ69407FzyU3lDD6tSIlMlatrrgzv9wWvNlpK4cltWjmgJ4hbVqQefW0
         0kXO04INBqAdb89WkBapFnx9R6nEh3JhDj5m2fG/huiEeYcOBgTO9KAuneVruN5j0P4q
         awnXwMKlRMqrAdzh8MElUEapmGkMs5b7MgIvd7YPPi5DFPIDJbdS84czJXs/I5DJQoCh
         G7a7oA6aJAkXHwmEBhsCfOA7r90SlIYl70+jdY4/0w7FwsXGkSdksoygEDK4U20crI0M
         useQ==
X-Gm-Message-State: APf1xPAKAfe9wAKc3gmISZMcrsfkOBO7c+ExAPI+Wr+okRb+hgHHW0Fb
        icLRCvKsmANpMajlATCWwFHaqLQF
X-Google-Smtp-Source: AH8x224bXPsWZ8018/a6K5SBM3NwyaDden6VndYKlCqDZr1HG41ZLgeEW7fO7xYhNqY9wqnOI81hsA==
X-Received: by 10.223.187.19 with SMTP id r19mr16731237wrg.110.1519859074376;
        Wed, 28 Feb 2018 15:04:34 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id n64sm3315869wmd.11.2018.02.28.15.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 15:04:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] commit: run git gc --auto just before the pre-commit hook
Date:   Wed, 28 Feb 2018 23:04:25 +0000
Message-Id: <20180228230425.14952-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <xmqqzi3siw88.fsf@gitster-ct.c.googlers.com>
References: <xmqqzi3siw88.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of git-commit back to what it was back in
d4bb43ee27 ("Invoke "git gc --auto" from commit, merge, am and
rebase.", 2007-09-05) when it was git-commit.sh.

Shortly afterwards in f5bbc3225c ("Port git commit to C.", 2007-11-08)
when it was ported to C, the "git gc --auto" invocation went away.

Before this, git gc --auto only ran for
git-{am,merge,fetch,receive-pack}. Therefore it was possible to write
a script that would "git commit" a lot of data locally, and gc would
never run.

One such repository that was locally committing generated zone file
changes had grown to a size of ~60GB before a daily cronjob was added
to "git gc", bringing it down to less than 1GB. This will make such
cases work without intervention.

I think fixing such pathological cases where the repository will grow
forever is a worthwhile trade-off for spending a couple of
milliseconds calling "git gc --auto" (in the common cases where it
doesn't do anything).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Feb 28 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Change the behavior of git-commit back to what it was back in
>> d4bb43ee27 ("Invoke "git gc --auto" from commit, merge, am and
>> rebase.", 2007-09-05) when it was git-commit.sh.
>
> ... which was to run it just before post-commit.  Do I retitle this
> patch before queuing?

Do'h. Of course I screw up something simple like that, sorry. This v2
fixes it, and I also rephrased the commit message a bit (more commas &
full-stops).

> So this is a decade late regression fix?  As they say, better late
> than never, probably.

Yup.

I wonder if it would also be a good idea to run git gc --auto on "git
push". It itself won't create any objects, but it would be a nice
proxy in many cases for picking up anything else we missed due to
various object writing commands that won't run --auto.

 builtin/commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index e8e8d13be4..a16a056f6a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1402,6 +1402,7 @@ int run_commit_hook(int editor_is_used, const char *index_file, const char *name
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
+	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 	static struct wt_status s;
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
@@ -1607,6 +1608,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	rerere(0);
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(current_head, &oid);
-- 
2.15.1.424.g9478a66081

