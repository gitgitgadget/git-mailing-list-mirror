Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1582B1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 23:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408036AbfJWXeJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 19:34:09 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35376 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389743AbfJWXeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 19:34:09 -0400
Received: by mail-pl1-f201.google.com with SMTP id p14so2309476plq.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 16:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kI0jhB5bq1EVk7+e92uzEmWHWcjZ5S/tmzYeUaCvCuk=;
        b=FKLNKJxTqmjTEPKHlHnFfuvuhDUDGHW6I6vt1nk/wa9NvpWKcLTKO/t6eUf9MNfOTr
         o0WNmcknQyu34FS2T2IjfW4DBpkb7scgsifyGa/qFbsOqw5wJ7xVKB7CCo62SI1xS/r1
         wn0thN09doennjZNR89xhrt5kEbe/EIUAqNUXr50FiZoF7vLeID8Iz3vpCOl4cgKMyJV
         JnM+Op7Otf3KLxXoqwaXuwzG+f92vxxhQkjd/aLpsITO33k6pxsaljhpzNztLjghy+32
         myc1dAHiQPSCR4vdaP4MGolXYPX9zgksHfidxioLzIpL6SoTqubY0sTvzxhRViWw3wf5
         EoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kI0jhB5bq1EVk7+e92uzEmWHWcjZ5S/tmzYeUaCvCuk=;
        b=iqxgmRQFxQyhu9DXQGCSr1kk9Q7KrxhRU6Qubx63n4IFP1xIGuqZsq8I1c9drjS+o9
         KBrmE1nMamfLqIx+vVunolbNe/LXlcpYl/yr8p0odTBSPloQzrh2JNluyUeL0lV0osKU
         GofqqaPyyfVU1+mHjLC+xlnAm9L9f4w3uwv98HFNH63vv1+N+qTaSlOgsZ2R+xxMn4Sf
         YJqtrPcpAB+ygqznvRY/BhrayLdnD5306aFX/njFUQiyOttz8gOvw2yN6Gl0K7pd+sJq
         uZiUwD3K1x+jlNiOsQPQbq55P8t1TsxaKNDAitA/ucUKMJKcNSbnABZ7xcIiFt975Qr2
         GXtw==
X-Gm-Message-State: APjAAAX2BknZki9SDdcXoAYZzJmBceZGo64FMV4hb2yKXEfH7+mFJqdP
        BGAPOm3hvjvaXy1OT8qZF67RZGpRBPfAy7d2Lp/eiizienDsi891GuRL+fk4OWpCNbny0DfrzAq
        m3Fz3zD3RvLIH4Hfoxd53hLrY/4LI1EanEmpCBXkDI4tQiL0g2c1oU/mBTaIkhy/fZXIUHALBGt
        Sn
X-Google-Smtp-Source: APXvYqz52n9u+tcsM6fTiDXYdzTSlpNWnBhasSDCoc0Ywx6Hlz6VsFhDDpqdR/yE4aR4eJ+CLvH6ZmFmn90rIhneCE4C
X-Received: by 2002:a63:5619:: with SMTP id k25mr10609010pgb.439.1571873646544;
 Wed, 23 Oct 2019 16:34:06 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:34:03 -0700
In-Reply-To: <20191007181825.13463-1-jonathantanmy@google.com>
Message-Id: <20191023233403.145457-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191007181825.13463-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v3] fetch: delay fetch_if_missing=0 until after config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose, from a repository that has ".gitmodules", we clone with
--filter=blob:none:

  git clone --filter=blob:none --no-checkout \
    https://kernel.googlesource.com/pub/scm/git/git

Then we fetch:

  git -C git fetch

This will cause a "unable to load config blob object", because the
fetch_config_from_gitmodules() invocation in cmd_fetch() will attempt to
load ".gitmodules" (which Git knows to exist because the client has the
tree of HEAD) while fetch_if_missing is set to 0.

fetch_if_missing is set to 0 too early - ".gitmodules" here should be
lazily fetched.  Git must set fetch_if_missing to 0 before the fetch
because as part of the fetch, packfile negotiation happens (and we do
not want to fetch any missing objects when checking existence of
objects), but we do not need to set it so early. Move the setting of
fetch_if_missing to the earliest possible point in cmd_fetch(), right
before any fetching happens.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
No change from v2 except that I've added Signed-off-by.
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0c345b5dfe..863c858fde 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1755,8 +1755,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch");
 
-	fetch_if_missing = 0;
-
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++)
@@ -1824,6 +1822,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	fetch_if_missing = 0;
+
 	if (remote) {
 		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
-- 
2.23.0.866.gb869b98d4c-goog

