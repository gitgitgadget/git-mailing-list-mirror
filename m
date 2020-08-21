Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69099C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 10:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4835E20656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 10:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2HOqgh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgHUKLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgHUKLI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 06:11:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF0C061387
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 03:11:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b17so644650wru.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=obr7vrjW8EfxlMosv0HNmUXesii9n8cwKnFfiKqp6wo=;
        b=C2HOqgh4MPnrIQ5oRfdDiX5IidtuTXzPQ3MGbswNWjfYbjllpBFMFmq5tfUjCrXXwu
         WPQrxLzlBQu/wh7r3Kr2p/k7jDbjTGuVnKohexeL9SN480WkPUxg+rhLBpLtKp8oUCg5
         Mh8TUfVA2AUvSprsEyGQ6JUEMaHZHIJT/pseJDebgAMNs/PBT13kA0ttbu3SddpENouV
         cmJ4MeqUgXQHTUCJPI09tLtfYiXwYoV6Ed//6+Q7Oo2JxbM0M2v1Cp2fUKVre2mtxVpj
         6vAnweDyJPzh7TzkHgLcVpl1nfb8HJ1vQtqF5MLSTTiKwbjMGqUpCamYUX0NNbQMMnJG
         5tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=obr7vrjW8EfxlMosv0HNmUXesii9n8cwKnFfiKqp6wo=;
        b=W/zyvyUWvu3b9/UAgRLPA0JzKVph/5JKfrqC6IqTN+WatmPgMPRGYMeX3GCkCCPOC9
         CrsZxeljsJZqJJW/6cek/OSoOy+RU7cVptnTgWkMTTk30d2pd9q1KS5VJfbd1m0n3AJX
         uvVKY8IU6dQiskcTUvZ6+WfiY+NyGjS+F5UGZ9iSXUSyHUpt5MN3kx9MyhZ3AZ62glVI
         6+CEnXqvQHgz+xn1/yqbZgsqBVcjY+CIJLLpbpJzS09+2kohLTGxPmSvAoKShm13JopM
         tSKczbE0SFrzpciVnupi7mJhaiKJ9yAUOehglgW6z8z/GbO5Y3zjtpkUzSQjGKgZXdZx
         1qWQ==
X-Gm-Message-State: AOAM530GiPJg/Hq/MS3AK9vxehiGNa/bCtCYVt5t1bly37oDUIZuHnUQ
        FVJ70t+P2qltjs/O+JBOq13qwsqP2eA=
X-Google-Smtp-Source: ABdhPJypigXyMts3YsfwpuP2jV3ei2YPPXbHA9jVFrBZtbrbPphPNC2l9KJLzhLVWKRe/mcOQTgPxQ==
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr1933544wrc.134.1598004666321;
        Fri, 21 Aug 2020 03:11:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6sm3772621wmc.12.2020.08.21.03.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:11:05 -0700 (PDT)
Message-Id: <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
        <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 10:11:02 +0000
Subject: [PATCH v2 2/2] ref-filter: 'contents:trailers' show error if `:` is
 missing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

The 'contents' atom does not show any error if used with 'trailers'
atom and semicolon is missing before trailers arguments.

e.g %(contents:trailersonly) works, while it shouldn't.

It is definitely not an expected behavior.

Let's fix this bug.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c            | 21 ++++++++++++++++++---
 t/t6300-for-each-ref.sh |  9 +++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ba85869755..fa131c4854 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -332,6 +332,22 @@ static int trailers_atom_parser(const struct ref_format *format, struct used_ato
 	return 0;
 }
 
+static int check_format_field(const char *arg, const char *field, const char **option)
+{
+	const char *opt;
+	if (skip_prefix(arg, field, &opt)) {
+		if (*opt == '\0') {
+			*option = NULL;
+			return 1;
+		}
+		else if (*opt == ':') {
+			*option = opt + 1;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static int contents_atom_parser(const struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
@@ -345,9 +361,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
-	else if (skip_prefix(arg, "trailers", &arg)) {
-		skip_prefix(arg, ":", &arg);
-		if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
+	else if (check_format_field(arg, "trailers", &arg)) {
+		if (trailers_atom_parser(format, atom, arg, err))
 			return -1;
 	} else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0570380344..6d535653d9 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -823,6 +823,15 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '
+	# error message cannot be checked under i18n
+	cat >expect <<-EOF &&
+	fatal: unrecognized %(contents) argument: trailersonly
+	EOF
+	test_must_fail git for-each-ref --format="%(contents:trailersonly)" 2>actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
-- 
gitgitgadget
