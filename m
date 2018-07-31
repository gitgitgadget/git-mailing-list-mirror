Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7214E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 22:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbeHAAL1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 20:11:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33298 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbeHAAL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 20:11:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so18207423wrp.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 15:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fbt4qdaZ8LkTvSNij6RQ7u2sl7ZLqgEblpsdpvP09Ts=;
        b=aPNpK0UOMMguG6BOWeVx/KCm2j/V+uzA1KzT9REnw8+RL5LOumMzqHWAxFiOXu+TSP
         U0d/3pEh+S7bx7aY8VErddl8CexfUrLk0Ae4UX2VwcoTHg4BHzn7gR6njy8fb1I1TCt7
         X9ZjzyGoQ2wmnWMpPr2INOhKlK57JA0gYzOcoVaj8g7eKvf2EpmEoEdlOX4u0ngNlzhP
         qeldJS2vSeIieEBLiuPQoPMmKhFyfLQHy05+KopAq4hBPUohlVYIicMU95JQFoitNwCK
         p6P+sdy24rEN8XprvS+QbY4q0sO9hK38QzWwS5oX5XK8XpTYv8y/5n104Odbuls7EMj8
         OuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fbt4qdaZ8LkTvSNij6RQ7u2sl7ZLqgEblpsdpvP09Ts=;
        b=ed0D97t/dyCwbaldyAXyKNEbBN+59Bix9E3l/W3plvUn/B1/MDtF/t2gQLxHBR+Za9
         v11hXpEDVMT1d3DZZli6NnRNu44P+XgSlE9/i23t6vfCfjh4Y6KptlmDy+GQA09l2mlY
         NJAZfC/OmmOZfjQgFYMAPOFlt2hjV/gUuyYaAA2kNyZuS8xP44FuQRPK3+CHOlXfbZuI
         wZkomA9L0PuEQk1UdoWAV+aGX+VOf9AEM1pHopssf0n3WU/VMr51eOA2nqmQ19QUXe0a
         IZce6vbYKPaZFC51A3biCTZIXjzwcAYYuJwUJdYfkisChXrbjmmPIKyvW1Fdwaqs2bF0
         SFGg==
X-Gm-Message-State: AOUpUlGpL7GwMxJ4gl8ur4DbmhHsIo6n//WD4xUFyodRShKKHlRHqfFH
        i5lL4476yed0z2BLmZmqc8d8lv1+
X-Google-Smtp-Source: AAOMgpeADxSvCdniolvVBQtwhXpsmZyjavzItcXIo/qDigp5sdic9oStPxmQJpb7BiNjBbzjuh8YXQ==
X-Received: by 2002:adf:adae:: with SMTP id w43-v6mr23139441wrc.251.1533076136862;
        Tue, 31 Jul 2018 15:28:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q1-v6sm21854955wrw.42.2018.07.31.15.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 15:28:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote: prefer exact matches when using refspecs
References: <20180731211832.142014-1-jonathantanmy@google.com>
        <xmqq600v9imy.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 31 Jul 2018 15:28:55 -0700
In-Reply-To: <xmqq600v9imy.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 31 Jul 2018 14:53:41 -0700")
Message-ID: <xmqq1sbj9h08.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In order to resolve this correctly with the precedence rules, I
> think you need to make refname_match() return the precedence number
> (e.g. give 1 to "%.*s", 2 to "refs/%.*s", etc., using the index in
> ref_rev_parse_rules[] array), and make this loop keep track of the
> "best" match paying attention to the returned precedence.

That is, something like this, perhaps.  The resulting behaviour
should match how "git rev-parse X" would give precedence to tag X
over branch X by going this route.  What do you think?

 refs.c   |  8 +++-----
 remote.c | 13 ++++++++++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 457fb78057..fd1a7f7478 100644
--- a/refs.c
+++ b/refs.c
@@ -495,11 +495,9 @@ int refname_match(const char *abbrev_name, const char *full_name)
 	const char **p;
 	const int abbrev_name_len = strlen(abbrev_name);
 
-	for (p = ref_rev_parse_rules; *p; p++) {
-		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
-			return 1;
-		}
-	}
+	for (p = ref_rev_parse_rules; *p; p++)
+		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name)))
+			return (p - ref_rev_parse_rules) + 1;
 
 	return 0;
 }
diff --git a/remote.c b/remote.c
index 86e6098774..ed2f80e45c 100644
--- a/remote.c
+++ b/remote.c
@@ -1689,11 +1689,18 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const char *name)
 {
 	const struct ref *ref;
+	const struct ref *best_match = NULL;
+	int best_score = -1;
+
 	for (ref = refs; ref; ref = ref->next) {
-		if (refname_match(name, ref->name))
-			return ref;
+		int score = refname_match(name, ref->name);
+
+		if ((score && (best_score < 0 || score < best_score))) {
+			best_match = ref;
+			best_score = score;
+		}
 	}
-	return NULL;
+	return best_match;
 }
 
 struct ref *get_remote_ref(const struct ref *remote_refs, const char *name)
