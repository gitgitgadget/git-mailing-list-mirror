Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E404DC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 17:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjBJROZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjBJROT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 12:14:19 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E2A78D59
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:14:09 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b5so7136435plz.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA7KmM/UI/tV2TITQXVgFrhnvQ7IHMFvovtitN0A32Q=;
        b=g0aZe63FVZuW5cQWu57bPKDLJlCnAP0Hs3g7WvgHcYWz1lEmXRkUy4m12lTxSpw7Tc
         AU21oqrpmIOXSrdn6rICCBtVj5P2awDPI9YgyKMfdtLmo4zbZXw4COBLx576glH50rOD
         XZqLIJKG/lXxN+9Dacn6IHzureCIas+wFGM1juAkRe4OxxVATOeTHhjhxQfeEFRWfIzJ
         2uOMTIVrmjcWoTe1hs0mqImZmgy/gIyU27ukuTy3cL7tRL4Zbr0bLxNph84butVZvxv2
         3KLL0eI5+wE8BxZNbEXYlYTC5jqmTdr/omyyufFAaseI6DGfJVxC22LSp58PtbNZEZ9F
         jnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA7KmM/UI/tV2TITQXVgFrhnvQ7IHMFvovtitN0A32Q=;
        b=iXCXF4nOJdUl76CS4rIXE4OTQNJfc8qi1E1+hjaHbRfpRkFS4wvd3CN8s/NjRjyBnQ
         ywqcKS+UmcAhgs59ftc7rU2lI7pQhRX0sVLILjJ1AZ14HRyYJpc3tjekwzeG/2hyVprL
         +mlUpM5fieDbIXB0Xy59tJV+VnsfwqNt0ai9VeZ/zaB8Lvj94iE8M7U6fpBIcdOTEieT
         u+DMoiiRuxAf7zEmBfKBU3WfByu4MzrD0Rr8y71kiXqUjyBDyK3WvBW4ToQ8uBnxYpHv
         cdVI/h9iMlmYd9PN+za6KUluSLqQpAJZV53y1uAP2jz+MapqPCAaLD6HmonCIi3yuX6o
         6a6w==
X-Gm-Message-State: AO0yUKU7CV8q2eNpfMQjJNm1coAquHpTEp11gjAptInddznPRBTotQf4
        10JolKAs1pjhlQxr8zvy0OY=
X-Google-Smtp-Source: AK7set/mvIg7SP+jUTTtss4h28lC+Sf/Ka8YZV4lsckYjMmdFEQPmOOg3MilyAsw9rsg9RVUXyzBEw==
X-Received: by 2002:a17:90a:7809:b0:233:bfa0:11d2 with SMTP id w9-20020a17090a780900b00233bfa011d2mr230745pjk.47.1676049249247;
        Fri, 10 Feb 2023 09:14:09 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6805:20dd:94a9:fa14:fe37:b9ef])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902eb0a00b001928c204428sm3622401plb.142.2023.02.10.09.14.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Feb 2023 09:14:08 -0800 (PST)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [PATCH v2 2/3] {apply,alias}: convert pre-processor macros to enums
Date:   Fri, 10 Feb 2023 22:43:37 +0530
Message-Id: <20230210171338.81906-3-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
References: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revert the changes made to alias.c in v1.

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>

---
 alias.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/alias.c b/alias.c
index 61ef2c0c54..deb871d59c 100644
--- a/alias.c
+++ b/alias.c
@@ -44,14 +44,9 @@ void list_aliases(struct string_list *list)
 	read_early_config(config_alias_cb, &data);
 }
 
-/* #define SPLIT_CMDLINE_BAD_ENDING 1 */
-/* #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2 */
-/* #define SPLIT_CMDLINE_ARGC_OVERFLOW 3 */
-enum split_cmdline_error {
-	SPLIT_CMDLINE_BAD_ENDING = 1,
-	SPLIT_CMDLINE_UNCLOSED_QUOTE,
-	SPLIT_CMDLINE_ARGC_OVERFLOW
-};
+#define SPLIT_CMDLINE_BAD_ENDING 1
+#define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
+#define SPLIT_CMDLINE_ARGC_OVERFLOW 3
 
 static const char *split_cmdline_errors[] = {
 	N_("cmdline ends with \\"),
-- 
2.39.1

