Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0426020229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756445AbcJWJ1x (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34074 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756341AbcJWJ11 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id d199so5246172wmd.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g/7EZ21lQwDNumXAPsrNTPL3zk5ZFVunHwfXvcb/yuY=;
        b=eNGKuLgDeyDvPcAhJL1CDmN7Ks4XhHOfGq83sCE/pkQSA0Ud2JZ9FIxmV5ytyn3qH4
         8frKodsQoAFdvyATLQhBrJW/ArsE2VApypW/gTiwTYcJHqiA0Xa2/MRxtRMnrdumjnN/
         2+CRRXAL9wGYG2xCqQaYQiXCB+dR/dMPL7vAGzDxEg7men2/f66iDDNRiCW5j9UI0YdU
         bVLqTMZNXrM0rAs5hDhCrJWilzXpOMJuHJbsL3UryK+Zsnx1qmfYExWh/P90snZfYVPJ
         yrLIVKb03Ur9usFQKEJYWHWUSFzTspEeTA2Vs/iY14W2HZZrk7gg6Mx6mZb4HsCJUqqb
         q0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g/7EZ21lQwDNumXAPsrNTPL3zk5ZFVunHwfXvcb/yuY=;
        b=IKUhNmLrtodvSOBlqhaqDpp04Glu1rWBGOZSgsjNUk8OhnTpGc92ZCPaZH+YMIfJNm
         ZPdns0LheYRY0dEuUs7E1guHyuAaCwcN3yEqOemK+lpD2nuqU4ELBn2pKXoXFCz8croy
         j2sqMXvoZ3aJqy6fyhY3NZnhfCk4oa/J6na3wZTe5YlyoLYBUeFK56a4j3f7EWUrMAhv
         HP3rZRbAoLWmdsgGYyaHRqfBaOgmeFvFt2ui+bY5Hc4n7G6msEP34EvLPV4AWXORooyU
         22FQAU6QVaxrqqjcCj0vpHIVHADCjswHqx9JHeZYWXkIMKzJF0H1JyHFyI5AZo+c67Dd
         Gd7w==
X-Gm-Message-State: ABUngvfL+qThtbqeD/mNdy7PmxTtqqg6ncyPjo10Jat1WtN63GKxDCm1fxWyBNpu03BJFQ==
X-Received: by 10.194.103.165 with SMTP id fx5mr7089662wjb.188.1477214845831;
        Sun, 23 Oct 2016 02:27:25 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 14/19] read-cache: touch shared index files when used
Date:   Sun, 23 Oct 2016 11:26:43 +0200
Message-Id: <20161023092648.12086-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a split-index file is created, let's update the mtime of the
shared index file that the split-index file is referencing.

In a following commit we will make shared index file expire
depending on their mtime, so updating the mtime makes sure that
the shared index file will not be deleted soon.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index a91fabe..3aeff77 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2268,6 +2268,12 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		int ret = write_shared_index(istate, lock, flags);
 		if (ret)
 			return ret;
+	} else {
+		/* Signal that the shared index is used */
+		const char *shared_index = git_path("sharedindex.%s",
+						    sha1_to_hex(si->base_sha1));
+		if (!check_and_freshen_file(shared_index, 1))
+			warning("could not freshen '%s'", shared_index);
 	}
 
 	return write_split_index(istate, lock, flags);
-- 
2.10.1.462.g7e1e03a

