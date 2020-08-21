Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F19FC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA6520791
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kp6yFTOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHUUgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:36:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57812 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgHUUgh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 16:36:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 896C0E22BB;
        Fri, 21 Aug 2020 16:36:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J/9twjsb5ICuXMfbd6/q+KwiZXI=; b=Kp6yFT
        ObJzNyC9kWfdMDUb/SJT+W++Epa0yMahRcnKYpbZFC1YT9/O1LP3y1r/7FnOFEaf
        Ow9SAQoruZgfFOl3HDMxo9CvC0nKG/xKqVJcFUfs7Cen1cVEnM3kE9AytDnwefsq
        LMI+89faQuD83pP+KuEBC+NBJ15KidN8XN3vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CKYnMEnBzX7/2j52dgTJj8OHjKStpKvS
        fjIrXbdsUrn3ezrOKHxy8zT4hav09dptgqJO+9vn7tHtcwzn9Vg2VL3wzBlyhN94
        lXrktVk8921LTlAMqJVuuZk0L8yoGexIZgSE9zTSxozWZwVmuRUZprEYZkOmYA5I
        WiK4PE8yuxs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82271E22B9;
        Fri, 21 Aug 2020 16:36:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B2171E22B7;
        Fri, 21 Aug 2020 16:36:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Alvaro Aleman <aaleman@redhat.com>
Subject: [PATCH] ident: say whose identity is missing when giving user.name hint
References: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
        <87ft8fvoow.fsf@igel.home> <xmqqr1rz96ry.fsf@gitster.c.googlers.com>
        <CAOW=8D3WZyoc=PpyzmPRYM2MT_=F4tnuTxJ0Z+_dHMb4Xk8imQ@mail.gmail.com>
Date:   Fri, 21 Aug 2020 13:36:28 -0700
In-Reply-To: <CAOW=8D3WZyoc=PpyzmPRYM2MT_=F4tnuTxJ0Z+_dHMb4Xk8imQ@mail.gmail.com>
        (Alvaro Aleman's message of "Fri, 21 Aug 2020 15:55:51 -0400")
Message-ID: <xmqq5z9b91o3.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE0FE990-E3ED-11EA-9E7B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, so here is essentially the same patch but with a bit of cleaning
up, with a test update and a proposed log message.

-- >8 --
When the author or the committer identity is missing when required,
"git" errors out with a message that suggests to set these
configuration variables at the per-user level as the easiest way
forward.  This message is given to a brand-new user, whose
~/.gitconfig hasn't been configured for user.name and user.email,
who runs "git commit --author=...", too, but such a user may find it
confusing ("why?  I just gave you a name and e-mail").

State whose identity is missing as the reason why we are erroring
out, when we give the hint, to help reduce the confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c                       | 48 ++++++++++++++++++++++-------------
 t/t7518-ident-corner-cases.sh | 13 +++++++++-
 2 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/ident.c b/ident.c
index e666ee4e59..813741c06c 100644
--- a/ident.c
+++ b/ident.c
@@ -345,18 +345,32 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	return 0;
 }
 
-static const char *env_hint =
-N_("\n"
-   "*** Please tell me who you are.\n"
-   "\n"
-   "Run\n"
-   "\n"
-   "  git config --global user.email \"you@example.com\"\n"
-   "  git config --global user.name \"Your Name\"\n"
-   "\n"
-   "to set your account\'s default identity.\n"
-   "Omit --global to set the identity only in this repository.\n"
-   "\n");
+
+static void ident_env_hint(enum want_ident whose_ident)
+{
+	switch (whose_ident) {
+	case WANT_AUTHOR_IDENT:
+		fputs(_("Author identity unknown\n"), stderr);
+		break;
+	case WANT_COMMITTER_IDENT:
+		fputs(_("Committer identity unknown\n"), stderr);
+		break;
+	default:
+		break;
+	}
+
+	fputs(_("\n"
+		"*** Please tell me who you are.\n"
+		"\n"
+		"Run\n"
+		"\n"
+		"  git config --global user.email \"you@example.com\"\n"
+		"  git config --global user.name \"Your Name\"\n"
+		"\n"
+		"to set your account\'s default identity.\n"
+		"Omit --global to set the identity only in this repository.\n"
+		"\n"), stderr);
+}
 
 const char *fmt_ident(const char *name, const char *email,
 		      enum want_ident whose_ident, const char *date_str, int flag)
@@ -375,12 +389,12 @@ const char *fmt_ident(const char *name, const char *email,
 	if (!email) {
 		if (strict && ident_use_config_only
 		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
-			fputs(_(env_hint), stderr);
+			ident_env_hint(whose_ident);
 			die(_("no email was given and auto-detection is disabled"));
 		}
 		email = ident_default_email();
 		if (strict && default_email_is_bogus) {
-			fputs(_(env_hint), stderr);
+			ident_env_hint(whose_ident);
 			die(_("unable to auto-detect email address (got '%s')"), email);
 		}
 	}
@@ -397,13 +411,13 @@ const char *fmt_ident(const char *name, const char *email,
 		if (!name) {
 			if (strict && ident_use_config_only
 			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
-				fputs(_(env_hint), stderr);
+				ident_env_hint(whose_ident);
 				die(_("no name was given and auto-detection is disabled"));
 			}
 			name = ident_default_name();
 			using_default = 1;
 			if (strict && default_name_is_bogus) {
-				fputs(_(env_hint), stderr);
+				ident_env_hint(whose_ident);
 				die(_("unable to auto-detect name (got '%s')"), name);
 			}
 		}
@@ -411,7 +425,7 @@ const char *fmt_ident(const char *name, const char *email,
 			struct passwd *pw;
 			if (strict) {
 				if (using_default)
-					fputs(_(env_hint), stderr);
+					ident_env_hint(whose_ident);
 				die(_("empty ident name (for <%s>) not allowed"), email);
 			}
 			pw = xgetpwuid_self(NULL);
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index b22f631261..dc3e9c8c88 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -29,7 +29,18 @@ test_expect_success 'empty configured name does not auto-detect' '
 		sane_unset GIT_AUTHOR_NAME &&
 		test_must_fail \
 			git -c user.name= commit --allow-empty -m foo 2>err &&
-		test_i18ngrep "empty ident name" err
+		test_i18ngrep "empty ident name" err &&
+		test_i18ngrep "Author identity unknown" err
+	)
+'
+
+test_expect_success 'empty configured name does not auto-detect for committer' '
+	(
+		sane_unset GIT_COMMITTER_NAME &&
+		test_must_fail \
+			git -c user.name= commit --allow-empty -m foo 2>err &&
+		test_i18ngrep "empty ident name" err &&
+		test_i18ngrep "Committer identity unknown" err
 	)
 '
 
-- 
2.28.0-416-g2947c83ecf

