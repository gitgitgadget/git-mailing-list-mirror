Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEFAD208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 22:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbdHOWnf (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 18:43:35 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33557 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdHOWnf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 18:43:35 -0400
Received: by mail-pg0-f45.google.com with SMTP id u5so14075815pgn.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEN7IHDeduqHlLtAImuTH44xNpbBysOgSmQSPgJk5Ww=;
        b=WsQceLcaA05E4wCRA4AYZbU1bN7+TcHmGGe4G5jLnC1NVNCGkija+M6GRuUCU3wac2
         drCisvRgnyw9B/6cAJ2CTf+/nXoENaIrBf0QNMCFg0ZB8SD7qUlacT1e1bD948F8ghF6
         Lq5kvGrDcqp2X84lIyTgbC72OHY4C8iAaKj2pB1AkHqj4kZLkp/4JceMjOkVNMlVzuaa
         Y4I04cv74hZzVBkR21mPr9lK7Tiib2zokuOJlzJl9dyo/HIesUSnp4ItAOhsET9osnJR
         N/BUE07N3KopqGdnr9lsZhaQkRj7sgPPTwCrD7wIbyCrxWv66tR3iAm6P8LisYnAT57G
         CHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEN7IHDeduqHlLtAImuTH44xNpbBysOgSmQSPgJk5Ww=;
        b=Je/g/3MbV0mbOGS5QxdUAfpMunQk9RWusLj8rq9sJSHoWSxOJSn8Jp1fWxZpkpXZ0I
         Hsa4QJTHTrpOtT130IyLrxzzHscCq6VzUGxtQ0eRxeE1Q/SOjjr0jUxiSIf5f+4s0Owb
         HaHoFWcdXm/15UC4owO7vJ+cidiDi4YE8PzxtMNtIptfsCMm+jvcjC2NjufP0vLx/30Y
         oAX6NEesiRiQ4IBYsQkoCDRXkdmoL7qakb5ejsp3ZnfXmJX+WItUiaHhYL8S/YHlBK7/
         m5+oq1U58GaTIk3ITe47/8bQ7bSu7ER7+XUbmAsgWPoxrf1jIcScUO40aR4vM62hh27S
         2OxQ==
X-Gm-Message-State: AHYfb5h3ua8vFvKOey+5tOORU9r8br5u69JYIo2QWJ6tfIGFM8hI3VsH
        TtHrqAPleo15qM+8e2LwVg==
X-Received: by 10.84.137.169 with SMTP id 38mr32647149pln.331.1502837014397;
        Tue, 15 Aug 2017 15:43:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:f954:a93e:8e20:9fe8])
        by smtp.gmail.com with ESMTPSA id n23sm19102511pfh.133.2017.08.15.15.43.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 15:43:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: [PATCH] push: do not add submodule odb as an alternate when recursing on demand
Date:   Tue, 15 Aug 2017 15:43:32 -0700
Message-Id: <20170815224332.22730-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git push --recurse-submodules=on-demand" adds each submodule as an
alternate with add_submodule_odb before checking whether the
submodule has anything to push and pushing it if so.

However, it never accesses any objects from the submodule.  In the
parent process it uses the submodule's ref database to see if there
is anything to push.  The actual push (which does rely on objects)
occurs in a child process.

The same was true when this call was originally added in
v1.7.11-rc0~111^2 (push: teach --recurse-submodules the on-demand
option, 2012-03-29).  Most likely it was added by analogy with
fetch --recurse-submodules=on-demand, which did use the submodule's
object database.

Use is_submodule_populated_gently instead, which is simpler and
cheaper.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Originally I intended to send this out as part of a larger series,
 but the series is getting too large series, sending all things in smaller
 units!
 
 Thanks,
 Stefan

 submodule.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 111a3007fc..e20216bc0f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -966,7 +966,9 @@ static int push_submodule(const char *path,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
-	if (add_submodule_odb(path))
+	int code;
+
+	if (!is_submodule_populated_gently(path, &code))
 		return 1;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
-- 
2.14.0.rc0.3.g6c2e499285

