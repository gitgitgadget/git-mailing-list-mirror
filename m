Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122F2C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECD7221EF
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503140AbgLNU2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:28:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52095 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503314AbgLNU1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 15:27:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4A7211A3DD;
        Mon, 14 Dec 2020 15:26:59 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=OWphhU9qsw54QbAf1wFR6s8CY
        UU=; b=Hpx0KFDJCL5V7Elrn+iQ2RewgwxpXioNOTPdSyhMnrTMNRDo3d7iI4JEV
        L/3fdaRTUL9Og8xuYyzEAzun11Sghn9lVdvXdg2pI+cMQwzWxQjmJYNjKBb3S1qv
        1FvbKFzb5VUAJoZgSgq98nBnVVm5FhAi73luvf7yr3yplb+ja0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=qamtzKOlYBpaZPWp+6E
        LEapwRshw/ocwkyzMMFwvTI/bNrPWL42KiTOf6VPRQ5uReluXWrSBHDDzgmrV5w9
        4oaI/UggRNNc2sCi2smYgwKYVlQEAwsQ3vxWmD5dLM8QaFPvwhJaRCER/Vbpum1c
        uk+93haU6TQyBfyEtgsUnNIg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD88511A3DC;
        Mon, 14 Dec 2020 15:26:59 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28CFF11A3D9;
        Mon, 14 Dec 2020 15:26:57 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v7 3/5] pull: get rid of unnecessary global variable
Date:   Mon, 14 Dec 2020 12:26:45 -0800
Message-Id: <20201214202647.3340193-4-gitster@pobox.com>
X-Mailer: git-send-email 2.30.0-rc0-186-g20447144ec
In-Reply-To: <20201214202647.3340193-1-gitster@pobox.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: B64AEBF2-3E4A-11EB-AE97-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is easy enough to do, gives a more descriptive name to the
variable, and there is no reason to make the code deliberately worse
by ignoring improvement offered on the list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pull.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index ff8e3ce137..2976b8e5cb 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,8 +27,6 @@
 #include "commit-reach.h"
 #include "sequencer.h"
=20
-static int default_mode;
-
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value=
 is
@@ -326,7 +324,7 @@ static const char *config_get_ff(void)
  * looks for the value of "pull.rebase". If both configuration keys do n=
ot
  * exist, returns REBASE_FALSE.
  */
-static enum rebase_type config_get_rebase(void)
+static enum rebase_type config_get_rebase(int *rebase_unspecified)
 {
 	struct branch *curr_branch =3D branch_get("HEAD");
 	const char *value;
@@ -346,7 +344,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
=20
-	default_mode =3D 1;
+	*rebase_unspecified =3D 1;
=20
 	return REBASE_FALSE;
 }
@@ -934,6 +932,7 @@ int cmd_pull(int argc, const char **argv, const char =
*prefix)
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
 	int autostash;
+	int rebase_unspecified =3D 0;
=20
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -955,7 +954,7 @@ int cmd_pull(int argc, const char **argv, const char =
*prefix)
 		opt_ff =3D xstrdup_or_null(config_get_ff());
=20
 	if (opt_rebase < 0)
-		opt_rebase =3D config_get_rebase();
+		opt_rebase =3D config_get_rebase(&rebase_unspecified);
=20
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
@@ -1029,7 +1028,7 @@ int cmd_pull(int argc, const char **argv, const cha=
r *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
=20
-	if (default_mode && opt_verbosity >=3D 0 && !opt_ff) {
+	if (rebase_unspecified && opt_verbosity >=3D 0 && !opt_ff) {
 		advise(_("Pulling without specifying how to reconcile divergent branch=
es is\n"
 			 "discouraged. You can squelch this message by running one of the fol=
lowing\n"
 			 "commands sometime before your next pull:\n"
--=20
2.30.0-rc0-186-g20447144ec

