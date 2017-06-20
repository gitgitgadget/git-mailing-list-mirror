Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7DC1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdFTCs3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:29 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35007 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdFTCs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:27 -0400
Received: by mail-pg0-f41.google.com with SMTP id 132so22940278pgb.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JDcybFjxc0T/4dojFqcQZbqNYq22S5CI7HusdCP9fbE=;
        b=KEPI0lwPW/MRa5Js221bcgtflsdAoBwQnKr7DCa1Cnb9teBdl3Sb8duBodNhdwzHZ3
         ZAok7TPXHCXOuKRpNj/M/3oLQ+2ciyraXxTyXhLkjaL2H3ldRg3pXJnMeQ19onj9s1ds
         LUXfXi/gpFrMUh0VARsP1tVFp55DjiiSE6BoOb8TMv+oVYIKaSBjrLsCdkrUGsPriNta
         DJZ3H+VYurCBI1uPhmddnulkpNZ5LxJ+E3TdZdvoi2FWT7IXYN/i46GFC4RjH/Blw3DT
         mtlZbdr8WwgfNF0rR5d2dqtNbNV7VIe+U0FnqC4HALB9wxnJlqemkckvvETAE9b7JoeR
         qbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JDcybFjxc0T/4dojFqcQZbqNYq22S5CI7HusdCP9fbE=;
        b=G8otWdDGHhHCTbgogToB3qEAA8us/00ksqS61Nk3UwS5/BAWFLT6a1PPwG5kCxphRj
         8w7NhSqzEdDtQuyVDYnk9paM/EdbHUmA0e3A9pNCoMmkl04TykoS2JSzpjAwJsiOEMGq
         9bTuLG0IPu48wlDw2m69rajafsyQPBKkt82wZb2CH7IvDLRHm9rEnTNJ80tlVrs/z/l5
         rCc4KBj2kqW8aJqXmUQ4paPeEFO/YSB/JYuvYE1JEsvnLI8BaD7DV1zubQTIhceYwf8j
         fRje9GvXgsRbnInRLftI2TKvZWXFoY3WlWcvLUtSL3Y/LMcUDYzobETTXZ0Rz0FvTKIp
         8h9A==
X-Gm-Message-State: AKS2vOz6iLhv6/brfXkitCH89yjnXh9+U1sSN0uI3HTlziFNLduXELXn
        f/H1CzoVRwFmFPKO
X-Received: by 10.84.175.65 with SMTP id s59mr32756585plb.20.1497926906630;
        Mon, 19 Jun 2017 19:48:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id u1sm22671842pgq.53.2017.06.19.19.48.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 01/26] diff.c: readability fix
Date:   Mon, 19 Jun 2017 19:47:51 -0700
Message-Id: <20170620024816.20021-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have dereferenced 'p->two' into a local variable 'two'.
Use that.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 74283d9001..3f5bf8b5a4 100644
--- a/diff.c
+++ b/diff.c
@@ -3283,8 +3283,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	const char *other;
 	const char *attr_path;
 
-	name  = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	name  = one->path;
+	other = (strcmp(name, two->path) ? two->path : NULL);
 	attr_path = name;
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
-- 
2.12.2.575.gb14f27f917

