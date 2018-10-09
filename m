Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE3F1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 11:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJITP4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 15:15:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32848 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeJITPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 15:15:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id h13-v6so1440334edq.0
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 04:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6wGanSTic0GkmIJIBk/1Ka+z5Jfcd7Opj4cU5OaPNg=;
        b=eM7Rg4wnsyeIgLye4lQ2XWbG7c+4FKpzT1uiCQcRM+zj+vF8fPY1q8Ra2uCLINOelZ
         bIupQRua4vWLzBfpqCSCuZOCreyHOSGsBAXKwMf/b/QWADgxSJusY2iXVdfV2zGgD7gK
         Pk4UpAdWsbouB5HQQBqEv7jyeNzNhmKXmI9ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6wGanSTic0GkmIJIBk/1Ka+z5Jfcd7Opj4cU5OaPNg=;
        b=jCoYHJw1hwSjNWXCeF7vc9PELR8g3YmfeGYmqw7b7diDGUKQjD354b7lYO9TVcMlGG
         2ncHGVjFQoMtGOEEtmlohxiNfKZZ5p2aau/fGyyBvMEMbaR3UNMl7MOK8sEoXznffd0w
         7LZFaC6B3YIV+bxh+yGTTHt1C8YbsHKFGQV9y2XWv1xsMDdMHC+16tt6ZOORharlmvpN
         j+NJ7zjEz1BUq1+aerTuwemKFWhJTTIo6e64/BwNpWwA1DIvS+YBjrygq6xstLGHAEAd
         gTpfRvYuKK1ssVVzgSHZ4OwPNrsl0t9I6A3q2jfHe5uWGYsdMctmDwD/kZFa/8avgTPI
         e7oA==
X-Gm-Message-State: ABuFfojMlH1HjNUj/vnWfS8D93oheBSwP2nXWSWQl/mKPM3mOa+nI5yV
        TFg7kG9hMQOrzdgxFKvLOY1pJmbKlCY=
X-Google-Smtp-Source: ACcGV60yRi7IhUBPbO+gzeGftHRMjipMeq4+yxFdkvgiysR182J61jmg3DLxxTg63skJ9mOPmFYuhg==
X-Received: by 2002:a05:6402:6d8:: with SMTP id n24mr33144545edy.99.1539086356323;
        Tue, 09 Oct 2018 04:59:16 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id o4-v6sm3522556ejx.30.2018.10.09.04.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:59:15 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v4 2/3] git.c: handle_alias: prepend alias info when first argument is -h
Date:   Tue,  9 Oct 2018 13:59:08 +0200
Message-Id: <20181009115909.16648-3-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009115909.16648-1-rv@rasmusvillemoes.dk>
References: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
 <20181009115909.16648-1-rv@rasmusvillemoes.dk>
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
2.19.1.4.g721af0fda3

