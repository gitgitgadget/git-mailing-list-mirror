Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B669C433E1
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 05:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8DA20724
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 05:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QJOwuJQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGMFOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:14:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50061 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMFOv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 01:14:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C4F96160E;
        Mon, 13 Jul 2020 01:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AiybsiGWk9Q3kZdFtst26ASGGyA=; b=QJOwuJ
        QoBquw7kW6U3WG20xqrNHd/6moub78o4MfvicEx+kTMKTybFKUq621qcetTSL6tw
        99TcOBLrwFt5XC5pN/WOPuq+Ra8MPn/xTMC0Ug/apIY1uEMh8jmrvHtNyVt2lfic
        NvcN0yhXHFOgc4YauNBqjE5ftRwHpDQNe74g4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wp5OrAwLpjSGxU+nclg460d0mGbSHtcL
        9+FTyNG2TjG7BxQpKqHYQy4vwftvL62Mk8qA9eTxuQvnH5EOQGoyCFphR9YrvbQg
        oD1WzDTgsl2EPva+W2yu/OsmfNu6PkwBJr0bUyvd/360W/ZILdL1ywRhoAQ7C99W
        M7WemHdjHMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E60346160D;
        Mon, 13 Jul 2020 01:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53FD96160C;
        Mon, 13 Jul 2020 01:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v16] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v15.git.git.1594543148959.gitgitgadget@gmail.com>
        <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com>
        <xmqqzh84pq3l.fsf@gitster.c.googlers.com>
Date:   Sun, 12 Jul 2020 22:14:46 -0700
In-Reply-To: <xmqqzh84pq3l.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 12 Jul 2020 11:04:14 -0700")
Message-ID: <xmqq5zasov21.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C52A3968-C4C7-11EA-901E-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> Now that the --bool-or-string would be silent, you have to give an
> error message yourself here, no?  Have you hand-tested the result of
> applying your patch to see if all the cases we care about (i.e.
> various scenarios we raised and thought together how the code should
> react to the situation during the review discussion so far)?
>
> We are not in a hurry, and we will not be paying too much attention
> on topics that are not yet in 'next' until the upcoming release is
> done anyway, so take your time to try polishing before sending
> anything out.

Just for fun, I've queued the following on top of v16 and merged the
result to 'seen'.

As this adds a new feature to "git config", it also needs updates to
Documentation/git-config.txt and tests for the feature, and it
probably makes sense to make it a two-patch series.  Everything
related to the "git config" enhancement as 1/2, and change to
mergetools/meld as 2/2.

 builtin/config.c | 16 +++++++---------
 config.c         | 14 --------------
 config.h         |  7 -------
 mergetools/meld  | 16 ++++++++++------
 4 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 6f2ddadc80..7891e070a4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -65,7 +65,7 @@ static int show_scope;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5
 #define TYPE_COLOR		6
-#define TYPE_BOOL_OR_STR        7
+#define TYPE_BOOL_OR_STR	7
 
 #define OPT_CALLBACK_VALUE(s, l, v, h, i) \
 	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
@@ -255,12 +255,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 			else
 				strbuf_addf(buf, "%d", v);
 		} else if (type == TYPE_BOOL_OR_STR) {
-			int is_bool, v;
-			v = git_config_bool_or_str(NULL, key_, value_, &is_bool);
-			if (is_bool)
-				strbuf_addstr(buf, v ? "true" : "false");
-			else
+			int v = git_parse_maybe_bool(value_);
+			if (v < 0)
 				strbuf_addstr(buf, value_);
+			else
+				strbuf_addstr(buf, v ? "true" : "false");
 		} else if (type == TYPE_PATH) {
 			const char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
@@ -423,9 +422,8 @@ static char *normalize_value(const char *key, const char *value)
 			return xstrdup(v ? "true" : "false");
 	}
 	if (type == TYPE_BOOL_OR_STR) {
-		int is_bool, v;
-		v = git_config_bool_or_str(NULL, key, value, &is_bool);
-		if (!is_bool)
+		int v = git_parse_maybe_bool(value);
+		if (v < 0)
 			return xstrdup(value);
 		else
 			return xstrdup(v ? "true" : "false");
diff --git a/config.c b/config.c
index 4c6c06d10b..8db9c77098 100644
--- a/config.c
+++ b/config.c
@@ -1100,20 +1100,6 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 	return git_config_int(name, value);
 }
 
-int git_config_bool_or_str(const char **dest, const char *name, const char *value, int *is_bool)
-{
-	int v = git_parse_maybe_bool_text(value);
-	if (0 <= v) {
-		*is_bool = 1;
-		return v;
-	}
-	*is_bool = 0;
-	if (dest != NULL)
-	  return git_config_string(dest, name, value);
-	else
-	  return 0;
-}
-
 int git_config_bool(const char *name, const char *value)
 {
 	int discard;
diff --git a/config.h b/config.h
index 175b88d9c5..060874488f 100644
--- a/config.h
+++ b/config.h
@@ -217,13 +217,6 @@ ssize_t git_config_ssize_t(const char *, const char *);
  */
 int git_config_bool_or_int(const char *, const char *, int *);
 
-/**
- * Same as `git_config_bool`, except that `is_bool` flag is unset, then if
- * `dest` parameter is non-NULL, it allocates and copies the value string
- * into the `dest`, if `dest` is NULL and `is_bool` flag is unset it return 0.
- */
-int git_config_bool_or_str(const char **, const char *, const char *, int *);
-
 /**
  * Parse a string into a boolean value, respecting keywords like "true" and
  * "false". Integer values are converted into true/false values (when they
diff --git a/mergetools/meld b/mergetools/meld
index bc2ea894d7..aab4ebb935 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -36,7 +36,7 @@ check_meld_for_features () {
 	then
 		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
 		case "$meld_has_output_option" in
-		true|false)
+		true | false)
 			: use configured value
 			;;
 		*)
@@ -44,7 +44,7 @@ check_meld_for_features () {
 			init_meld_help_msg
 
 			case "$meld_help_msg" in
-			*"--output="*|*'[OPTION...]'*)
+			*"--output="* | *'[OPTION...]'*)
 				# All version that has [OPTION...] supports --output
 				meld_has_output_option=true
 				;;
@@ -59,9 +59,10 @@ check_meld_for_features () {
 	if test -z "$meld_use_auto_merge_option"
 	then
 		meld_use_auto_merge_option=$(
-			git config --bool-or-str mergetool.meld.useAutoMerge)
+			git config --bool-or-str mergetool.meld.useAutoMerge
+		)
 		case "$meld_use_auto_merge_option" in
-		true|false)
+		true | false)
 			: use well formatted boolean value
 			;;
 		auto)
@@ -69,7 +70,7 @@ check_meld_for_features () {
 			init_meld_help_msg
 
 			case "$meld_help_msg" in
-			*"--auto-merge"*|*'[OPTION...]'*)
+			*"--auto-merge"* | *'[OPTION...]'*)
 				meld_use_auto_merge_option=true
 				;;
 			*)
@@ -77,9 +78,12 @@ check_meld_for_features () {
 				;;
 			esac
 			;;
-		*)
+		"")
 			meld_use_auto_merge_option=false
 			;;
+		*)
+			die "unknown mergetool.meld.useAutoMerge: $meld_use_auto_merge_option"
+			;;
 		esac
 	fi
 }
-- 
2.28.0-rc0

