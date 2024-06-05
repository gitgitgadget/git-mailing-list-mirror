Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837C10E5
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564573; cv=none; b=XKmkvTuJy5iKF68IyleiyNa4LxCsUvYY21naPxE2dws4Vj4AVQf1FhxZSFCeuaij5DYlhRporrYKdfAOPxdpUB8X9NGsCh35QTr2nnu8rmBydAKpjsXpejDytuejQQKJzSR2FWi1Zp6DEPQk3OXgPZNQ7ZKgobBDI7g4EekOWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564573; c=relaxed/simple;
	bh=IWP4qSKUFrOBr0mTG8Om3MOew2KIvOIT2MKGmBC1k5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xa5gYB3zMWRX+sd1BugnhQwa599ddZifcLEaSLDCdcAGOSF7yQsUIdflVFJ8PLTisMHR763mrQ4siqePsmDTq0UHQRNwTebggmhXzz7e+qtgQMWXliUBdeSH9/Hp1h6kLzzRvjJoVn4hNPSKByK/0uFLMI0kvmhoPksQyjyJSF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AgVb/Z/3; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AgVb/Z/3"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 28CFF21201;
	Wed,  5 Jun 2024 01:16:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IWP4qSKUFrOBr0mTG8Om3MOew2KIvOIT2MKGmB
	C1k5Q=; b=AgVb/Z/3pP4zg6tagRakQUAUmS5AIRYSNOmCk8tQhrJvsfGE+K8Wef
	Gbub1yP69/XRX7sURNlRhwZA3ZRyBaVcVlV590yLxtwN6aLHoklGYLewpF/qJ/nL
	todByNTs/MRn2g+Qkhp705i003fGdug547OJ/d4BQHxEOSB+KFvQ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1455521200;
	Wed,  5 Jun 2024 01:16:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A53D211FF;
	Wed,  5 Jun 2024 01:16:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 6/6] add-patch: introduce the command '|'
In-Reply-To: <xmqqy17kws2k.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	04 Jun 2024 10:12:03 -0700")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
	<75a3cc89-4d23-4eae-b0ad-e52e2c8ba550@gmail.com>
	<xmqqy17kws2k.fsf@gitster.g>
Date: Tue, 04 Jun 2024 22:16:06 -0700
Message-ID: <xmqq4ja8ynop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B71F7640-22FA-11EF-AC85-8F8B087618E4-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> By the way, it should be trivial to make the "custom" pager more sticky.

Here is what you can squash into this step.  I gave many other
pieces of style and design advices in other messages, which are not
covered by this patch but the necessary fixes should be obvious.

This message is only about making the custom pager stick during a
session.  It does not adjust the command help to give the last pager
command (or literally "your pager"), either.

---- >8 ----
Subject: [PATCH] add-p: make custom pager sticky during a session

The original design kept resetting the choice of the custom pager
every time the '|' command is used.  This was way cumbersome to use.

Keep track of the last choice in the add_p_state.custom_pager
member.  This value can stick across calls to patch_update_file()
function, so a custom pager used for choosing hunks in one file
can be carried over to the view hunks in the next file.

As we make the custom pager stick, we need a way to reset it back to
the default value (which we use NULL for, as set_custom_pager()
takes the value to mean "use the default one").

As there is no value that can say "pager is not used" suitable for
the custom_pager member to take, we need a separate "use_pager" flag
so that the fact that '|' command was used can be propagated to the
next iteration of the loop, independent from what custom pager is
used.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 add-patch.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index da13e267db..71ee7f9a94 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -272,6 +272,7 @@ struct add_p_state {
 	/* patch mode */
 	struct patch_mode *mode;
 	const char *revision;
+	char *custom_pager;
 };
 
 static void add_p_state_clear(struct add_p_state *s)
@@ -285,6 +286,7 @@ static void add_p_state_clear(struct add_p_state *s)
 	for (i = 0; i < s->file_diff_nr; i++)
 		free(s->file_diff[i].hunk);
 	free(s->file_diff);
+	free(s->custom_pager);
 	clear_add_i_state(&s->s);
 }
 
@@ -1403,7 +1405,7 @@ static int patch_update_file(struct add_p_state *s,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len, quit = 0;
 	enum prompt_mode_type prompt_mode_type;
-	const char* pager = NULL;
+	int use_pager = 0;
 	enum {
 		ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
 		ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK = 1 << 1,
@@ -1452,14 +1454,14 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
-				if (pager)
-					setup_custom_pager(pager);
+				if (use_pager)
+					setup_custom_pager(s->custom_pager);
 				render_hunk(s, hunk, 0, colored, &s->buf);
 				fputs(s->buf.buf, stdout);
 				rendered_hunk_index = hunk_index;
-				if (pager) {
+				if (use_pager) {
 					wait_for_pager();
-					pager = NULL;
+					use_pager = 0;
 				}
 			}
 
@@ -1685,15 +1687,26 @@ static int patch_update_file(struct add_p_state *s,
 		} else if (s->answer.buf[0] == 'p') {
 			rendered_hunk_index = -1;
 		} else if (ch == '|') {
-			strbuf_remove(&s->answer, 0, 1);
-			if (s->s.use_single_key && s->answer.len == 0) {
+			if (!s->s.use_single_key) {
+				strbuf_remove(&s->answer, 0, 1);
+			} else {
 				printf("%s", _("program? "));
 				fflush(stdout);
 				strbuf_getline(&s->answer, stdin);
-				strbuf_trim_trailing_newline(&s->answer);
 			}
-			strbuf_trim(&s->answer);
-			pager = s->answer.buf;
+			strbuf_trim_trailing_newline(&s->answer);
+
+			if (!s->answer.len)
+				; /* empty input - reuse the previous */
+			else {
+				strbuf_trim(&s->answer);
+				FREE_AND_NULL(s->custom_pager);
+				if (!s->answer.len)
+					; /* semi-empty - use your pager */
+				else
+					s->custom_pager = xstrdup(s->answer.buf);
+			}
+			use_pager = 1;
 			rendered_hunk_index = -1;
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
-- 
2.45.2-409-g7b0defb391

