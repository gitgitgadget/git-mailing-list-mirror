Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329CF20281
	for <e@80x24.org>; Thu,  5 Oct 2017 13:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdJENXX (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 09:23:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37823 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdJENWt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 09:22:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id v38so6612081wrc.4
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=dbwxUis0Qz/52hILvg+wvXq0KFvkePSsMY1JeOqciUc=;
        b=r2wF8n8WD2HlNIMib6G/iISrDziGxsHmxu8qwhjw+jiM5kndxbSOjtsZJ3ytqylmyf
         /tKWbHipe5tKg6vfkTCtBwDMbuDUbO1tjLOyQNJ4nsXwljfMpWDY/Bugatl0GsoAVTD+
         ICGunEJNh1gF6GE8Tza4Pmqlpik/XhFLUyIik1Nx7B2cVx9zvEReiH2ZgDhG+1QCZj3A
         NB+fouK4hf4i37TTY/8+Sv8KLMXVGRn8PxEEzZ0leSjZwDmsqLmMAOG2Xd8p0IkFS/UX
         PtewTmojMC/UkczvPyMfMQ22pznUbVskvKEcFmMdJmCCicf5hiW970Tigyo/+PJGx+V2
         yg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=dbwxUis0Qz/52hILvg+wvXq0KFvkePSsMY1JeOqciUc=;
        b=We3Vvorn7o6JIF8p+9ssvogRWrSIUujiJQIRhT/PbLQv2e/ww9Kh2HakjuRxDf1zIl
         abCiY5vtTLXPPrcPksxLq7y9nyuf5bNzRiUxuySI2inFela5gtQzVKWZROzrH2GmI7yQ
         U56Se/9lsCXEBxRouJrFD1audI5QAevZ5/MfOj6GVAVpuFjgPY9M3hd77VbBOGU3H0Ub
         4FcilaR6FufR0w552D5z6R8UKyBkdK66OTknf1BBjfCuR61dYq+dSAo7oJubLDo2e/Qm
         fSd9ZRS2FTzhg1x9iiAO+9TuGosIgAZ6a908PnNeQF/zZhpFHU8fq/BUIK2CJlrRj5Xl
         oc+g==
X-Gm-Message-State: AMCzsaUZB7Ot5zcnXkxeZ/Psfm/k5JUh92/NIqSKeOIHxVIiCi+94J3g
        AEuQmLCBsglE/y4h7cP9/ssNJhv/
X-Google-Smtp-Source: AOwi7QAkG7GrYZb8EjDTF+0YDz68fLrjToIlelaLMeNSS9NhJwLshMgrMPI9BKePAdvNcHYFkdnpVg==
X-Received: by 10.223.172.129 with SMTP id o1mr4936608wrc.135.1507209767528;
        Thu, 05 Oct 2017 06:22:47 -0700 (PDT)
Received: from donizetti.redhat.com (dynamic-adsl-78-12-246-117.clienti.tiscali.it. [78.12.246.117])
        by smtp.gmail.com with ESMTPSA id r15sm10864439wrc.30.2017.10.05.06.22.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 06:22:46 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] trailer: simplify check_if_different
Date:   Thu,  5 Oct 2017 15:22:41 +0200
Message-Id: <20171005132243.27058-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171005132243.27058-1-pbonzini@redhat.com>
References: <20171005132243.27058-1-pbonzini@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check_all argument is pointless, because the function degenerates
to !same_trailer when check_all==0 (if same_trailer fails, it always
ends up returning 1).  Remove it, switching the check_all==0 caller
to use same_trailer directly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 trailer.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/trailer.c b/trailer.c
index 4ba28ae33..91f89db7f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -194,14 +194,11 @@ static void add_arg_to_input_list(struct trailer_item *on_tok,
 
 static int check_if_different(struct trailer_item *in_tok,
 			      struct arg_item *arg_tok,
-			      int check_all,
 			      struct list_head *head)
 {
 	enum trailer_where where = arg_tok->conf.where;
 	struct list_head *next_head;
-	do {
-		if (same_trailer(in_tok, arg_tok))
-			return 0;
+	while (!same_trailer(in_tok, arg_tok)) {
 		/*
 		 * if we want to add a trailer after another one,
 		 * we have to check those before this one
@@ -209,10 +206,10 @@ static int check_if_different(struct trailer_item *in_tok,
 		next_head = after_or_end(where) ? in_tok->list.prev
 						: in_tok->list.next;
 		if (next_head == head)
-			break;
+			return 1;
 		in_tok = list_entry(next_head, struct trailer_item, list);
-	} while (check_all);
-	return 1;
+	}
+	return 0;
 }
 
 static char *apply_command(const char *command, const char *arg)
@@ -283,12 +280,12 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 		break;
 	case EXISTS_ADD_IF_DIFFERENT:
 		apply_item_command(in_tok, arg_tok);
-		if (check_if_different(in_tok, arg_tok, 1, head))
+		if (check_if_different(in_tok, arg_tok, head))
 			add_arg_to_input_list(on_tok, arg_tok);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
 		apply_item_command(in_tok, arg_tok);
-		if (check_if_different(on_tok, arg_tok, 0, head))
+		if (!same_trailer(on_tok, arg_tok))
 			add_arg_to_input_list(on_tok, arg_tok);
 		break;
 	default:
-- 
2.14.2


