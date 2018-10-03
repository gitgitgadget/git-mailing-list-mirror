Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A141F453
	for <e@80x24.org>; Wed,  3 Oct 2018 11:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJCSax (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 14:30:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33662 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeJCSax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 14:30:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id o21-v6so3899573lfe.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 04:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zyRyjQqb8Mk4ojrUggpsKR7Q7R9H4mCxpPjWjQPAOLw=;
        b=ApSECliDq0EdIaFgDFtuXlqBZElQaACF5zzv1yXevkWU/R1tEy9SK2kBviN2tFVNlK
         9L0zpWfYCSgdM5oraFeLfpz79/XRvQgxeJKDDLeRmkY4B+FXnrdvVCuub9SJKV24V7ob
         Ok0k5MEHzAZrJ2F51/ABDL7E9uo8P9nmC29Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyRyjQqb8Mk4ojrUggpsKR7Q7R9H4mCxpPjWjQPAOLw=;
        b=e4LOMMFI4jdSwmZ2FOqNf5We9uIsmq7HGQEk9PNs+1arAnq9ZBtdtFmOFciwITX5Y9
         sRTU0Gr9usPKCxsd5BqYSfXhAmabSmpMJ43ybzlehkTkY2k4E/nL47W2QxDTysogLhIK
         j9DWW5YwKmodMXZiCeEGTG8s1bVHxZdmfz0hZUwA0sFt2evS9mtR5D8qYUTpzrPoqetk
         kQva1+ITRZ7PBVBCATWwqIjHJO2OiFulis7YawW27iaJsujt859rzoNTDm5RLXrkVb7x
         PuqyULIDJFYMcMhKn1Dmr6XgRiD+Zh8J9tH3tf3V0G1Zzs0huLTP7F0eOOLzlBRxXOz1
         O61A==
X-Gm-Message-State: ABuFfojqKQEZ6f6lTj08ypnhyM6eP+Asjlt8q5RVzoRV/TnREvLXeU3z
        Bjs5lYFKsEb9sX5kuHyfx5PmMMR4rrWxv20P
X-Google-Smtp-Source: ACcGV63cwMWKNcSnM5s4Y5nxybsGsjT96HCiXM+QwHaV3vtIalCbg0HzXAc8NQ/mTcHXKZiSJZi8oQ==
X-Received: by 2002:a19:2a8c:: with SMTP id q12-v6mr753106lfq.95.1538566968488;
        Wed, 03 Oct 2018 04:42:48 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f22-v6sm279500ljk.11.2018.10.03.04.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 04:42:47 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v3 2/3] git.c: handle_alias: prepend alias info when first argument is -h
Date:   Wed,  3 Oct 2018 13:42:41 +0200
Message-Id: <20181003114242.9858-3-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
References: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181003114242.9858-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most git commands respond to -h anywhere in the command line, or at
least as a first and lone argument, by printing the usage
information. For aliases, we can provide a little more information that
might be useful in interpreting/understanding the following output by
prepending a line telling that the command is an alias, and for what.

When one invokes a simple alias, such as "cp = cherry-pick"
with -h, this results in

$ git cp -h
'cp' is aliased to 'cherry-pick'
usage: git cherry-pick [<options>] <commit-ish>...
...

When the alias consists of more than one word, this provides the
additional benefit of informing the user which options are implicit in
using the alias, e.g. with "cp = cherry-pick -n":

$ git cp -h
'cp' is aliased to 'cherry-pick -n'
usage: git cherry-pick [<options>] <commit-ish>...
...

For shell commands, we cannot know how it responds to -h, but printing
this line to stderr should not hurt, and can help in figuring out what
is happening in a case like

$ git sc -h
'sc' is aliased to '!somecommand'
somecommand: invalid option '-h'

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 git.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git.c b/git.c
index a6f4b44af5..0211c2d4c0 100644
--- a/git.c
+++ b/git.c
@@ -318,6 +318,9 @@ static int handle_alias(int *argcp, const char ***argv)
 	alias_command = (*argv)[0];
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
+		if (*argcp > 1 && !strcmp((*argv)[1], "-h"))
+			fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
+				   alias_command, alias_string);
 		if (alias_string[0] == '!') {
 			struct child_process child = CHILD_PROCESS_INIT;
 			int nongit_ok;
-- 
2.19.0

