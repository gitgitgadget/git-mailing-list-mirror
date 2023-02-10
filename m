Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2B5C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjBJROf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjBJROW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 12:14:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122312E826
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:14:19 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id bx22so5814770pjb.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HktniWCcMzicNhMdR1SQk51bMxLx0kzQh49b+IAXh5A=;
        b=fM4LMd+6P1jjVX3ahoPjKGqyu+RKet77c8ihCwOXEbe+81q2fKwATnq10L48+hJtHw
         bo5r/ag0vy6TvK7SThtzT50CLIOVbgiOgQdAh7g/zzeRBoGq1Ayh0CQIVeQZuEu3yctb
         chyRmaFYHAigIhcUzzaJmBkitUmmvcRokmTv6INvPOM77dbtb6oanFKFtZW9Jb1GmvLb
         r1qyvhm9KPM8f4zf4syEIAvDHsHpILALDSCmuSRHkqLUJKo7zusEUXN+Qji6gUQ8JMjH
         Ofuc/d3q0boT4DBiCoXUQa/QYe5rNfMSrEozvasZIJzahS2kXEJHkl2BAi4B0Xa0tWa6
         RzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HktniWCcMzicNhMdR1SQk51bMxLx0kzQh49b+IAXh5A=;
        b=vua4+iMFkjYwXxlf8elENJYnLz1ILDAbOJUV7wMkqJuQ/uB6p6U1jSnL+gpbxLInK2
         yQRABUehaY6LEXeRku3f8anxDUK5bPrfnAEUmu1Q0PfnP/knyyLxXp9JCTzD5IvPoFY8
         xepliKAP/U++isif+9Z3Sy1ojczXKEW0+MeX09+fKM0NN0+iowtoCPOPYxP/1Ev23+cV
         AJNzABjvIYEfq7FYX3z+D1EtZInar1IsUVyQIDL6eC8P8L2pIPkn8BffJDZH76nTiprO
         kf+2H40d0lUuKbp9ocAp7igiO3y+97eoJXk/zI0EDcmh838Dexca/gVEb5/UhXLMUv8/
         T+7w==
X-Gm-Message-State: AO0yUKXKsrjdoFN+an8fgwDiQN+WhraG0H8/Du7Q5uiwrnsZ4Yi/ar07
        mhfqUIb3oXQvneFcjSI2BWizj7OowX3vqQ==
X-Google-Smtp-Source: AK7set8oqlARLkpDSl34SdmMIBN/TV3O/moc5QuKQ2r4Br4GCjJlTSuddVpoL2aP5byO+nCQvsexXQ==
X-Received: by 2002:a17:902:c949:b0:196:5787:d73a with SMTP id i9-20020a170902c94900b001965787d73amr18836971pla.53.1676049258493;
        Fri, 10 Feb 2023 09:14:18 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6805:20dd:94a9:fa14:fe37:b9ef])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902eb0a00b001928c204428sm3622401plb.142.2023.02.10.09.14.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Feb 2023 09:14:17 -0800 (PST)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [PATCH v2 3/3] {apply,alias}: convert pre-processor macros to enums
Date:   Fri, 10 Feb 2023 22:43:38 +0530
Message-Id: <20230210171338.81906-4-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
References: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change variables int side and int patch_method to enum in apply.c.
This allows for proper listing of enum constants during debugging.

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>

---
 apply.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 1e9cf2f4f2..8612bd44c8 100644
--- a/apply.c
+++ b/apply.c
@@ -205,9 +205,6 @@ struct fragment {
  * or deflated "literal".
  */
 #define binary_patch_method leading
-/* #define BINARY_DELTA_DEFLATED   1 */
-/* #define BINARY_LITERAL_DEFLATED 2 */
-
 enum binary_type_deflated {
 	BINARY_DELTA_DEFLATED = 1,
 	BINARY_LITERAL_DEFLATED
@@ -924,9 +921,6 @@ static int gitdiff_hdrend(struct gitdiff_data *state UNUSED,
  * to make sure..
  */
 
-/* #define DIFF_OLD_NAME 0 */
-/* #define DIFF_NEW_NAME 1 */
-
 enum diff_name {
 	DIFF_OLD_NAME = 0,
 	DIFF_NEW_NAME
@@ -936,7 +930,7 @@ static int gitdiff_verify_name(struct gitdiff_data *state,
 			       const char *line,
 			       int isnull,
 			       char **name,
-			       int side)
+			       enum diff_name side)
 {
 	if (!*name && !isnull) {
 		*name = find_name(state->root, line, NULL, state->p_value, TERM_TAB);
@@ -1921,7 +1915,7 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
 	int llen, used;
 	unsigned long size = *sz_p;
 	char *buffer = *buf_p;
-	int patch_method;
+	enum binary_type_deflated patch_method;
 	unsigned long origlen;
 	char *data = NULL;
 	int hunk_size = 0;
-- 
2.39.1

