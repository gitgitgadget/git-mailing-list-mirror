Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9461D1F406
	for <e@80x24.org>; Fri, 11 May 2018 23:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeEKXR6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 19:17:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36281 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeEKXR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 19:17:57 -0400
Received: by mail-pg0-f67.google.com with SMTP id z70-v6so3024287pgz.3
        for <git@vger.kernel.org>; Fri, 11 May 2018 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zat9NFe+TAsxaaCzS92MpimCXuiiE2vrm+uU1Fbz+Rc=;
        b=aDgem5te2KdrosZgTjONNv/ZP21wN62YUGqCBzih+GTfCsD9/aBt/d/Vb5b/fbEoMi
         BTA57NeNhcgdVh7QJYlxHF0pdj1UqKeOIkA6biXaD0WUH+xjjRB/Gp+R2SQ7l2xoAPCP
         DjPCJIGKU6CgRTcmndzXdgtusAa43c5gdvN0VGqhG/OTtMh4pyzGD/6zBgF6UdHzG0dS
         2+HnmYXoi+fBJI60UCJTiQSeEkNr3hK/c7V8EewAq9eT3Z8nncrLNGYu0bnBKbcQUUdT
         I3lom18ZvoHxk1mKOksaCM6g5eUsIhtTzkROP6O1w/0chNANPzlgTzsd/bcBXtLJr1UC
         4JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zat9NFe+TAsxaaCzS92MpimCXuiiE2vrm+uU1Fbz+Rc=;
        b=gy3YBbUzd/7TadBza2CD3/c86yX0XjQa4EXH2mD0M4kEHZqyvWe8dzV+Pt07QKwUPN
         3YrbxnoB+ZC6TBGct2/BpP2wSAfeUCWrmUNgJEoWHIwvz2bs8rfX22+9H49OSmLAKF4G
         rDqJznZ0EukCHIzA815dO483vVw74EcV+bmP4i56Wopr9skJCQZwSAeYNngNHAKAuTXR
         Oj2x8McTNkOWnaCGVuHpErhVauSqrU0gRPydB99Z/C/w4nNqBmNlKTe4vwNatn7UJDwY
         rpLyV8MJuoWusEvNuu39Y5MsOtz6X9QUzMTqSCCWJeHenPK4ggQlhhgiiHCRP6wW8Yur
         z8QQ==
X-Gm-Message-State: ALKqPwd5yNQevFQQJo+4+33DBMhygPX8wLS4b1GYhBGKadnvGXBvDL8q
        LJlAcj9bXw6xGCGHbv2JaRk7qLJ6apE=
X-Google-Smtp-Source: AB8JxZqSnhtaNJOZpnUuPG2l4hcwoHCoAQrWG0c+MrG9SgtfoV7OzyqnA8mjPNL/dQ19sHDK9OBwSA==
X-Received: by 2002:a63:5f0d:: with SMTP id t13-v6mr831457pgb.132.1526080676943;
        Fri, 11 May 2018 16:17:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 131-v6sm8849453pfa.128.2018.05.11.16.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 May 2018 16:17:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] git-submodule.sh: try harder to fetch a submodule
Date:   Fri, 11 May 2018 16:17:51 -0700
Message-Id: <20180511231751.162855-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the logical continuum of fb43e31f2b4 (submodule: try harder to
fetch needed sha1 by direct fetching sha1, 2016-02-23) and fixes it as
some assumptions were not correct.

> If $sha1 was not part of the default fetch ... fail ourselves here
assumes that the fetch_in_submodule only fails when the serverside does
not support fetching by sha1.

There are other failures, why such a fetch may fail, such as
    fatal: Couldn't find remote ref HEAD
which can happen if the remote side doesn't advertise HEAD. Not advertising
HEAD is allowed by the protocol spec and would happen, if HEAD points at a
ref, that this user cannot see (due to ACLs for example).

So do try even harder for a submodule by ignoring the exit code of the
first fetch and rather relying on the following is_tip_reachable to
see if we try fetching again.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 24914963ca2..13b378a6c8f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -614,7 +614,6 @@ cmd_update()
 				# is not reachable from a ref.
 				is_tip_reachable "$sm_path" "$sha1" ||
 				fetch_in_submodule "$sm_path" $depth ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 
 				# Now we tried the usual fetch, but $sha1 may
 				# not be reachable from any of the refs
-- 
2.17.0.582.gccdcbd54c44.dirty

