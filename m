Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323D1C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A42B20855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZW8vFkvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHNBHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:07:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65326 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgHNBHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 21:07:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BAFCDFDB1;
        Thu, 13 Aug 2020 21:07:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=V
        LcnTqFwH4ImC8KLo42p9rQgifk=; b=ZW8vFkvjba5uBdGzk+rclgPTEw+E4E+4p
        KIL/R4NVc6n1u2p/HwMtY2W55QwkX88CrOy5BJf8o3AgeJipaliSM44vHNGW7RLa
        jnofwlAtAEDmEhHlI8/2jVnppCToZ8re/nSbq2MLX5Cu6bxHG2KYSyfOx6YruYW2
        4HGv8Au4CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=dp2VIXiVxmm+00/KHpwRJnMH6GRymrn0Tuy/PZSm22JHe0dTvDfRBQgc
        5vuU7k4scYXSm1GFnmaR2QZAOpYrbntme8yJPstR9WSX7OIJrU7vCiqO/cyNEOjT
        V5ya6tUM4RR53cvKHzkeh3wZZcw7gNhEKdwV9d2l4f1TqDScnr8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33EA4DFDB0;
        Thu, 13 Aug 2020 21:07:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6805FDFDAE;
        Thu, 13 Aug 2020 21:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] messages: avoid SHA-1 in end-user facing messages
Date:   Thu, 13 Aug 2020 18:07:12 -0700
Message-ID: <xmqqy2miyr0f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D5A1EE8-DDCA-11EA-AA5C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are still a handful mentions of SHA-1 when we meant the
(hexadecimal) object names in end-user facing messages.  Rewrite
them.

I was hoping that this can mostly be s/SHA-1/object name/, but
a few messages needed rephrasing to keep the result readable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c          | 2 +-
 builtin/name-rev.c       | 2 +-
 builtin/pack-objects.c   | 2 +-
 parse-options.h          | 2 +-
 t/t0040-parse-options.sh | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 94ef57c1cc..76ffdf11c6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -842,7 +842,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	const char *contents_from = NULL;
 	const struct option options[] = {
 		OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
-		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
+		OPT_BOOL('b', NULL, &blank_boundary, N_("Blank object names of boundary commits (Default: off)")),
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
 		OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a9dcd25e46..725dd04519 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -521,7 +521,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
-		OPT_BOOL(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
+		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
 		OPT_STRING_LIST(0, "refs", &data.ref_filters, N_("pattern"),
 				   N_("only use refs matching <pattern>")),
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a8692d27f1..5617c01b5a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3357,7 +3357,7 @@ static void get_object_list(int ac, const char **av)
 			if (starts_with(line, "--shallow ")) {
 				struct object_id oid;
 				if (get_oid_hex(line + 10, &oid))
-					die("not an SHA-1 '%s'", line + 10);
+					die("not an object name '%s'", line + 10);
 				register_shallow(the_repository, &oid);
 				use_bitmap_index = 0;
 				continue;
diff --git a/parse-options.h b/parse-options.h
index 46af942093..7030d8f3da 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -314,7 +314,7 @@ int parse_opt_passthru_argv(const struct option *, const char *, int);
 #define OPT__FORCE(var, h, f) OPT_COUNTUP_F('f', "force",   (var), (h), (f))
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
-	  N_("use <n> digits to display SHA-1s"),	\
+	  N_("use <n> digits to display object names"),	\
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
 #define OPT__COLOR(var, h) \
 	OPT_COLOR_FLAG(0, "color", (var), (h))
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index f8178ee4e3..14cafc138b 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -44,7 +44,7 @@ Magic arguments
     --no-ambiguous        negative ambiguity
 
 Standard options
-    --abbrev[=<n>]        use <n> digits to display SHA-1s
+    --abbrev[=<n>]        use <n> digits to display object names
     -v, --verbose         be verbose
     -n, --dry-run         dry run
     -q, --quiet           be quiet
