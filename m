Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0C3201A7
	for <e@80x24.org>; Thu, 18 May 2017 01:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbdERBm2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 21:42:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33812 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753667AbdERBm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 21:42:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so3786723pfk.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 18:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xiCpD/7pJC5z0Q66e2q1rR3K6Qp93dAdeLkrE5W7FiY=;
        b=CzSzcHXwjstdeGwQx7G27WNwS9rsYMymMvSaHtCoaGPg/qmJv24HH+rBDZ8v/3H7zq
         jSgGnvFqguZ8nevIZuFIQXiMe/6bVinNqPhBY7bNUB3hHnUhMX4G0td6GypiSJmiqeLc
         1AfDHf7/u2qu80ifGOrKIjjSObKqYqKc0nW6AIfLLkVVClOsYttbIN41msHdj6p8Lv2v
         EirS7Z5GlkCye0sXvaN6FLTuqyeEDPobrJ6vhAJeG5mQqtlOfGRdGytlu7pUOiowicKI
         RSIOU3RTfR+opM6W/XWu4Uo/Fc4JKPqd8Hk+wwp72s4O7wISZbF0AwBzNWQ4yQG+yLme
         cQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=xiCpD/7pJC5z0Q66e2q1rR3K6Qp93dAdeLkrE5W7FiY=;
        b=bGMqflNUqPjqeNsCjTrXU4H8l1m/T8pRaJZ8ehbJMWI9Inc+l5hw+Rpl468mmrp9Mw
         c81VqHvR5Nu2cS/PF6pxyphtGKbec7dSa8cZe5Ql1oq4SQXKVdUoZWQnzMSKj1dNc0D4
         fwJs43acxnZvGvDmYBJk+9HlaWrfqtg9+H3jYHJWChGcHOzltkmgGbW6duPPB1iksm37
         LBbN7VAXOYua7mi7lM0NNxsBMr3XuBWq6oojSY/COgQY9wF19+UZOx8WG4GQYxs29AE/
         NS+28JPAw5soEB58ErLUpGD8Qn79C/sEVFlsbE6HsO7a4sU5L+hwRh7lEdq1sk8jBpES
         2DpA==
X-Gm-Message-State: AODbwcBBFEz0vyZSgr+t2qRTblgt5QIAu9+W/gzBFtbMxebqjhZ53xPO
        GpaE1epSZxUNuw==
X-Received: by 10.98.62.86 with SMTP id l83mr1703093pfa.114.1495071745782;
        Wed, 17 May 2017 18:42:25 -0700 (PDT)
Received: from ligo.sfo1.mozilla.com (corp-nat.fw1.untrust.sfo1.mozilla.net. [63.245.222.198])
        by smtp.gmail.com with ESMTPSA id i15sm7749705pfj.51.2017.05.17.18.42.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 18:42:25 -0700 (PDT)
From:   manishearth@gmail.com
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Manish Goregaokar <manishearth@gmail.com>
Subject: [PATCH v2 2/2] reachable: Add HEADs of all worktrees to reachability analysis
Date:   Wed, 17 May 2017 18:42:10 -0700
Message-Id: <20170518014210.94189-2-manishearth@gmail.com>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20170518014210.94189-1-manishearth@gmail.com>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
 <20170518014210.94189-1-manishearth@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manish Goregaokar <manishearth@gmail.com>

* reachable.c:
  mark_reachable_objects: Include other worktrees

Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
---
 reachable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/reachable.c b/reachable.c
index d0199ca..439708e 100644
--- a/reachable.c
+++ b/reachable.c
@@ -178,6 +178,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	/* detached HEAD is not included in the list above */
 	head_ref(add_one_ref, revs);
 
+	/* worktrees are not included in either */
+	for_each_worktree_ref(add_one_ref, revs);
+
 	/* Add all reflog info */
 	if (mark_reflog)
 		add_reflogs_to_pending(revs, 0);
-- 
2.10.1

