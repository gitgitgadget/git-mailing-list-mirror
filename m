Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EDDE20986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbcJDVEH (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:04:07 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34417 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbcJDVEG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:04:06 -0400
Received: by mail-pa0-f53.google.com with SMTP id rz1so21520689pab.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKulRAcZ9E0FpX+bGKgRxq4xtiEEnam6nfw1zWlouD4=;
        b=lE8+8wdr0bLF+W0LH93jqyXFuywUKu0k5W4ocVjMaN2ce6gT6UHkSdYk8ZD0V5STWa
         OSqZjjzQNxPWV6sA7R2hNsEx4Fa20GV8OoCK+tY1VaAhJe0lchVCWAozPIfWG288Ty4U
         Vyg17XnrhX1eDOv5ijGnwbmhn8Mkk1XkW4NdKNTYtd0H5BUVIf9JqJ8Z0Lh7xDO1ckm/
         oWcglCtMEwLY6GC2+EFs3pYU/l9PeWnqU1BU4Vs7TyqzbgZ57kaMYShtJGV7Njz5HOLu
         er3UBTJDAlOZFzHCXWyb+Mzm0G7rF3Caw0jX2AuM6W95LecLMPdWatHMrOjcddukF6SS
         PsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKulRAcZ9E0FpX+bGKgRxq4xtiEEnam6nfw1zWlouD4=;
        b=DVowBpqTY84DhcvL8bQ0sRGBhmX2S9hE+IZVt6a33wzfIQVnaomcPlE85viFfXy3QG
         0sgez5UKHBqTFHLutYZrT61gzaf6plSRczbjBUoggARdps8f0UeZF6Qq6UPnBXEVIqEH
         9tgcb31UE2qC/fNJgsCLHKOvf76/VaQqMuuUyHxyANgg48OAvS25tC5L6WoJUJgcCn2U
         FI5tMixmrmfKrmaLi8uXHKOzX0YbDcDHJk/KiUpn/MhJBBz5ewWC8JbZeiAT0tFI3ARI
         4+aPiv5wQvugLsrDwRVbWP7Uzg2zaTF6nnCmwjnRdqnlUNnJwf8DsGvf2XNu7CsPCLZb
         /lSQ==
X-Gm-Message-State: AA6/9RkjskmjqSqzaDgX/dmz9SC8DgNHwkH7W/+RI99a4byykiSIcVegXqZftJwoEC3Tcy2A
X-Received: by 10.66.78.9 with SMTP id x9mr7915837paw.201.1475615045568;
        Tue, 04 Oct 2016 14:04:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d1d:42df:48d7:33a4])
        by smtp.gmail.com with ESMTPSA id e1sm8140900pap.11.2016.10.04.14.04.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 14:04:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/2] push: change submodule default to check when submodules exist
Date:   Tue,  4 Oct 2016 14:03:58 -0700
Message-Id: <20161004210359.15266-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.129.g35f6318
In-Reply-To: <CAGZ79kbt+SZoogKTV_-rVfOOFzf6xrhWytrBo2H3r6NQw34WTw@mail.gmail.com>
References: <CAGZ79kbt+SZoogKTV_-rVfOOFzf6xrhWytrBo2H3r6NQw34WTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working with submodules, it is easy to forget to push the submodules.
The setting 'check', which checks if any existing submodule is present on
at least one remote of the submodule remotes, is designed to prevent this
mistake.

Flipping the default to check for submodules is safer than the current
default of ignoring submodules while pushing.

However checking for submodules requires additional work[1], which annoys
users that do not use submodules, so we turn on the check for submodules
based on a cheap heuristic, the existence of the .git/modules directory.
That directory doesn't exist when no submodules are used and is only
created and populated when submodules are cloned/added.

When the submodule directory doesn't exist, a user may have changed the
gitlinks via plumbing commands. Currently the default is to not check.
RECURSE_SUBMODULES_DEFAULT is effectively RECURSE_SUBMODULES_OFF currently,
though it may change in the future. When no submodules exist such a check
is pointless as it would fail anyway, so let's just turn it off.

[1] https://public-inbox.org/git/CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com/

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Jeff,
thanks for the suggestions, both git_path(..) as well as checking the config,
this seems quite readable to me:

 builtin/push.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3bb9d6b..65bb1df 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "refs.h"
+#include "dir.h"
 #include "run-command.h"
 #include "builtin.h"
 #include "remote.h"
@@ -22,6 +23,7 @@ static int deleterefs;
 static const char *receivepack;
 static int verbosity;
 static int progress = -1;
+static int has_submodules;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static enum transport_family family;
 
@@ -31,6 +33,14 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
 
+static void preset_submodule_default(void)
+{
+	if (has_submodules || file_exists(git_path("modules")))
+		recurse_submodules = RECURSE_SUBMODULES_CHECK;
+	else
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+}
+
 static void add_refspec(const char *ref)
 {
 	refspec_nr++;
@@ -495,7 +505,8 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		const char *value;
 		if (!git_config_get_value("push.recursesubmodules", &value))
 			recurse_submodules = parse_push_recurse_submodules_arg(k, value);
-	}
+	} else if (starts_with(k, "submodule.") && ends_with(k, ".url"))
+		has_submodules = 1;
 
 	return git_default_config(k, v, NULL);
 }
@@ -552,6 +563,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("push");
+	preset_submodule_default();
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 	set_push_cert_flags(&flags, push_cert);
-- 
2.10.0.129.g35f6318

