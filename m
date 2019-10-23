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
	by dcvr.yhbt.net (Postfix) with ESMTP id B19F51F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 21:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392664AbfJWVod (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 17:44:33 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47451 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733202AbfJWVoc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 17:44:32 -0400
Received: by mail-pg1-f202.google.com with SMTP id 196so2520303pge.14
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 14:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sp3+YO/oNG8kwH1RONCurVKNVuvZ1h13hHP20NTkzks=;
        b=gz4NYAKXay1OGHRvbqYwz//E7Y0GHLw6CPeEtOPhmxtRhYjbpg8cvbnXOMQ//ulq6y
         XMcKJ07ohJITRGdKW4XrIrQdHCmFD2NnOKe5jFFreerO6DEBITIFMgx5SBGeJnngu0+Q
         dcAeOWCnIiK5NFCVHiTRA0zg7B9QqUdq2fNlVF3DJynl61tVgYpjIAPwL1IJJHMketvY
         tKlohJ8am4C2pwGqLE4ZsvcAZIXsIjEp7GHFbW+s2ZR1yRvKYUUs5fII8QSQJE2gdkLh
         HLgyNOsirEkngoi+V04F+LCR4wmV87WSa9R6WidTLRZmR4/4zq5+Cb7mFX+9lxsboRb2
         FQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sp3+YO/oNG8kwH1RONCurVKNVuvZ1h13hHP20NTkzks=;
        b=TOW2lmKULfWl3gog5EOCwbr0XKEQeErdhcCAVIZal9mrIKoiIA1IEgzx6Vo0nT4ly3
         mpVwBnnfY2WQ4k+UIFZWYrlDgN8KHA8nqwAfWgmRd6oDd5EjYd3Kl3AB8fvq2RSvIbyn
         8Q4gxcCCHALyMH2dZmtgGDB8G8SOt2UHOj1M4I1JODpzs63sNe/DLhUJ8N7vN1iZVwSX
         iZDrlrZ9tZWJ0IWvbJ4fcWAsYMXf73z6jeowWg3x/dlumc0V4l2Efkf2tFC3VOFc00hg
         21BIp48ManL+Ci66xr9vRpJa0iieqx2AgQgkEpluykf3yEDthY7eYYieN1GH2nYe78Az
         NJJA==
X-Gm-Message-State: APjAAAVsU+qloXevwALhuRCWv4qeGtCMrT5ykfPYIsI+WV5hpVf48grP
        hEDxKW6ifKJ7EyrMSp3Ht0GosACoSghGQyq9ROM3VwIzyvRThwRf1vyv2JMfYmET3XO7dZ0oSnL
        HiO41haBsInx9NYvJFih1eBk/5N3mXn6H0Ey4rgomTpFNrHnoAXOqrNEXgUVE+VC51cwX0bQe6t
        Ve
X-Google-Smtp-Source: APXvYqwzlnQ0N0U4r0nd/NC159i+HGmFRXKeAS0SVreqvB+ULdw49rwU4D7h4aBketf+GqxXLYu3CtFMpQUIMql7i0Tp
X-Received: by 2002:a63:ff1c:: with SMTP id k28mr9074776pgi.281.1571867071672;
 Wed, 23 Oct 2019 14:44:31 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:44:28 -0700
In-Reply-To: <20191007181825.13463-1-jonathantanmy@google.com>
Message-Id: <20191023214428.129593-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191007181825.13463-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2] fetch: delay fetch_if_missing=0 until after config
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
---
No changes from v1 except that I improved the commit message.

Thanks, Emily, for taking a look.

> I'm having some trouble figuring out which object is actually missing.
> Is this the .git/config object? (That doesn't make much sense to me...)
> Is it .gitmodules?

Yes, it is indeed .gitmodules. I improved the commit message to further
explain what is going on.

> By the way, I think I understand that this is OK to go in
> unconditionally because:
>  - In the full clone case, it's a no-op; we haven't got anything that's
>    missing, so who cares.
>  - In the filter case, it's as you said - we don't want to
>    fetch_if_missing because that will turn someone's partial clone into
>    a a full clone.
>    - This probably applies to bare checkout, too.

Yes, that is correct. What do you mean by bare checkout? If you mean the
checkout that happens after clone (that we can suppress with
--no-checkout), that indeed happens after fetch_if_missing=0, so we
shouldn't have a problem there.

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

