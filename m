Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030931F453
	for <e@80x24.org>; Fri, 19 Oct 2018 04:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJSNCC (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 09:02:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45336 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJSNCB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 09:02:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id f17-v6so4183863wrs.12
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S0Q+oWyx65xBWlolPRDvYl/bF07nbBGYyoLfK0GnefM=;
        b=md4ecHrBK0yRIJkg/Yb0wOIbjXEkPYSCkm4d4Dc5V/U0xee4BnI4yQ32viQLW4bNPt
         V3nq0Exk34wLhtAEEsk0OkluSiB6d17llUuMgYRXnJYTnfIz0BSUOELtiGsqbesIQRSf
         orZMbE8ZISBeegJA7nKvy3sxEZIwhcnisWW1QZ3tO33Nl017JMZCjtnH3ab463MjAR47
         NBh/Yz9HSug9GoJdlRSVB8GNteXH/s412I7fRbwjN2GeecB4miuiF5z4Vya5e1Ldupqq
         2oA0cDnkiAKvCtum3gxlUBbY5yuuf76MQdjMn+Z4DsrYP0m6lggVFCZ/a5ngoejLW+vL
         tJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S0Q+oWyx65xBWlolPRDvYl/bF07nbBGYyoLfK0GnefM=;
        b=AWZOxuqTr2K9msWOa245iLtNdwhfYvdwrE8DfhVlrYG9hjJCBG/ILKp72XaUMnwKIO
         Q538RdGrk6QOvLiRaDYH52sTNkoynHg9RZxDKw52hQ+wgzOWGrG47s9K84ygh06SLEAL
         8IhVocin7XCmCpIcprFW/4PzMz7EoDKKucFzOzmxliaz7BDtVBGqr1nu3+VLkSbbuakl
         zdfPi8X+W4NTD5+cYF13F96HLMQCxC7JEzMo6zvCwZuX9Bch48qnOnkKY4IE3e3lVClm
         XSqm3tLzHyrthAXKLKdtVcN8YxTjAsyZsmlNU9IWxpAizsLJj6t2E7JufVhgXTE8Titw
         RnRA==
X-Gm-Message-State: ABuFfohniaAb+CVyDQvDfvTCJFPrHbkVQqOCz0LhYW9eU1+wGoAcW3A8
        uuMY1YaLjecig5o0tlHAQX0vB5C6qAE=
X-Google-Smtp-Source: ACcGV62m8lMr6Nz6EyTM1/Vqv36ZnwDyIh88cZuaIezxx2IXc/s+D1iWzhRhCOSk3gEjnus5vw/pag==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr24016643wrx.103.1539925056502;
        Thu, 18 Oct 2018 21:57:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m136-v6sm2533259wmb.4.2018.10.18.21.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 21:57:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Rajesh Madamanchi <rmadamanchi@gmail.com>
Subject: [PATCH] receive: denyCurrentBranch=updateinstead should not blindly update
References: <CANahLXm7O6scvLdaL6bm14d5oGM5Zp+S-rpQDo554ssagRFNoQ@mail.gmail.com>
        <xmqqsh124wqb.fsf@gitster-ct.c.googlers.com>
        <xmqq4ldi38u7.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 19 Oct 2018 13:57:35 +0900
In-Reply-To: <xmqq4ldi38u7.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 19 Oct 2018 12:37:36 +0900")
Message-ID: <xmqqpnw61qkg.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The handling of receive.denyCurrentBranch=updateInstead was added to
a switch statement that handles other values of the variable, but
all the other case arms only checked a condition to reject the
attempted push, or let later logic in the same function to still
intervene, so that a push that does not fast-forward (which is
checked after the switch statement in question) is still rejected.

But the handling of updateInstead incorrectly took immediate effect,
without giving other checks a chance to intervene.

Instead of calling update_worktree() that causes the side effect
immediately, just note the fact that we will need to call the
funciton later, and first give other checks chance to reject the
request.  After the update-hook gets a chance to reject the push
(which happens as the last step in a series of checks), call
update_worktree() when we earlier detected the need to.

Reported-by: Rajesh Madamanchi
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 12 +++++++++---
 t/t5516-fetch-push.sh  |  8 +++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 95740f4f0e..79ee320948 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1026,6 +1026,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *ret;
 	struct object_id *old_oid = &cmd->old_oid;
 	struct object_id *new_oid = &cmd->new_oid;
+	int do_update_worktree = 0;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -1051,9 +1052,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				refuse_unconfigured_deny();
 			return "branch is currently checked out";
 		case DENY_UPDATE_INSTEAD:
-			ret = update_worktree(new_oid->hash);
-			if (ret)
-				return ret;
+			/* pass -- let other checks intervene first */
+			do_update_worktree = 1;
 			break;
 		}
 	}
@@ -1118,6 +1118,12 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return "hook declined";
 	}
 
+	if (do_update_worktree) {
+		ret = update_worktree(new_oid->hash);
+		if (ret)
+			return ret;
+	}
+
 	if (is_null_oid(new_oid)) {
 		struct strbuf err = STRBUF_INIT;
 		if (!parse_object(the_repository, old_oid)) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 7a8f56db53..7316365a24 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1577,7 +1577,13 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		test $(git -C .. rev-parse master) = $(git rev-parse HEAD) &&
 		git diff --quiet &&
 		git diff --cached --quiet
-	)
+	) &&
+
+	# (6) updateInstead intervened by fast-forward check
+	test_must_fail git push void master^:master &&
+	test $(git -C void rev-parse HEAD) = $(git rev-parse master) &&
+	git -C void diff --quiet &&
+	git -C void diff --cached --quiet
 '
 
 test_expect_success 'updateInstead with push-to-checkout hook' '
-- 
2.19.1-450-ga4b8ab5363

