Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713781FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 22:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbdFSWAx (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 18:00:53 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35274 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdFSWAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 18:00:53 -0400
Received: by mail-wm0-f53.google.com with SMTP id x70so5316246wme.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7y5a/I1bkWFq/CLzr9MLQWZsVqEDpxqhBe56Nufsrc=;
        b=MEY1uI1zxsT5bAVsi2Eh49dNU7b8/hZHfzizuNCA5vCKGVf29XS8x1EBsbCN2I5gsi
         WZ5KpdKcojZ0q/Q45anvzQ8eem1TX82qb5fEMPyJreoCUhXeaXghbRGwRezTlT0clHUd
         RKpzNC+iuGF8tUjZ1aWlpyq/lZlF5kYiNphi6bIOoTUlNS3+zvqE8zK5En+JsOeeIkiO
         ePgtCQlcYaKwlLy4wSWEOp+1zHUihEFyzrA+7io8ok6hzo2WC8k9smWKObdsvM6O/vsP
         gKvChAyX+UsaPz2m5Gn15IRKey73c7WYIb6bZJXCkl6ysQIW6v4Dqa4JgZdQsJ87yuPu
         tcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7y5a/I1bkWFq/CLzr9MLQWZsVqEDpxqhBe56Nufsrc=;
        b=CQ8JJb7C6diL2R7RhZ17f0sEH2/k74t4ADmLgf9ezIwRxL/OLFu447lZJ7HuMCpZVl
         QiEycvcgww49OwXlOKan85x7IXZs20gq3PlNnIeuFzkav9DDo1CclaqrXk+ytKpo5/yo
         aA3mX8yNdb11gZmqM8OFV/6q6CAyga1g2ROCCwwEHh3VVqfnQbn3NPzfjWzTSwzdQCXh
         +MSg766VfETE52uOOf8UotCF4+fYfSdUSdkkLC/3j0MgZxqoHSFH7+OYcsTc0+0G0jXD
         cod0PFcHvpPbQLWOxqys9eoYZp6rDBfzhb5WoUTuJeNSBxasccWERexohNat1du7tNE9
         q0Lg==
X-Gm-Message-State: AKS2vOzXca8vdQiLgyDovGhEg4RcfJZAjorgQSD9aLMAY1BR0mGRC0fx
        8P1QvHQAv4iGAcq3cKQ=
X-Received: by 10.80.145.25 with SMTP id e25mr18831604eda.8.1497909651148;
        Mon, 19 Jun 2017 15:00:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k17sm6632672edb.37.2017.06.19.15.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 15:00:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] die routine: change recursion limit from 1 to 1024
Date:   Mon, 19 Jun 2017 22:00:36 +0000
Message-Id: <20170619220036.22656-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the recursion limit for the default die routine from a *very*
low 1 to 1024. This ensures that infinite recursions are broken, but
doesn't lose error messages.

The intent of the existing code, as explained in commit
cd163d4b4e ("usage.c: detect recursion in die routines and bail out
immediately", 2012-11-14), is to break infinite recursion in cases
where the die routine itself dies.

However, doing that very aggressively by immediately printing out
"recursion detected in die handler" if we've already called die() once
means that threaded invocations of git can go through the following
flow:

 1. Start a bunch of threads

 2. The threads start invoking die(), pretty much at the same time.

 3. The first die() invocation will be in the middle of trying to
    print out its message by the time another thread dies, that other
    thread then runs into the recursion limit and dies with "recursion
    detected in die handler".

 4. Due to a race condition the initial error may never get printed
    before the "recursion detected" thread calls exit() and aborts the
    program.

An example of this is running a threaded grep against e.g. linux.git:

    git grep -P --threads=4 '(*LIMIT_RECURSION=1)(*LIMIT_MATCH=1)-?-?-?---$'

With the current version of git this will print some combination of
multiple PCRE failures that caused the abort and multiple "recursion
detected", some invocations will print out multiple "recursion
detected" errors with no PCRE error at all!

Now, git-grep could make use of the pluggable error facility added in
commit c19a490e37 ("usage: allow pluggable die-recursion checks",
2013-04-16).

That should be done for git-grep in particular because before this
change (and after) it'll potentially print out the exact same error
from the N threads it starts, that should be de-duplicated.

But let's start by improving the default behavior shared across all of
git. Right now the common case is not an infinite recursion in the
handler, but us losing error messages by default because we're overly
paranoid about our recursion check.

So let's just set the recursion limit to a number higher than the
number of threads we're ever likely to spawn. Now we won't lose
errors, and if we have a recursing die handler we'll still die within
microseconds.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 usage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/usage.c b/usage.c
index 2f87ca69a8..1c198d4882 100644
--- a/usage.c
+++ b/usage.c
@@ -44,7 +44,9 @@ static void warn_builtin(const char *warn, va_list params)
 static int die_is_recursing_builtin(void)
 {
 	static int dying;
-	return dying++;
+	static int recursion_limit = 1024;
+
+	return dying++ > recursion_limit;
 }
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
-- 
2.13.1.518.g3df882009

