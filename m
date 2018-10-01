Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 562D61F453
	for <e@80x24.org>; Mon,  1 Oct 2018 11:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeJAR6e (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 13:58:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44035 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeJAR6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 13:58:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id t11-v6so13813625edq.11
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1ODIU9iEfHmqL7k7k7lWOMTtI2qht62/ymAyEfv31k=;
        b=NUEi8+tW74Hs6zU4+7WQeOn+NkZ/wY2/PadOe0LyrLBEpQR9AaLSb/9rzVLErHe5gU
         SbABXZP00KozxXsx/TZ/8bkCGIj5qQnDxaT23CurIZWCPkHYKRhMcHirWynBdvz1g6ux
         Bm3+2GJrrfYikdVfm6EzglathnzP6CiY5K/e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1ODIU9iEfHmqL7k7k7lWOMTtI2qht62/ymAyEfv31k=;
        b=FpMp5rmuAcDbk1Jgp/Lt1u2c9zZYffrDExevSAzvFEwP0k74B+jwQPDEfRQ1p44Zax
         Y42rAKzmfAOuVWro5qeJVzThUopEFkNwNtRv+Nu7yZm+JHlf3SIjREwOF/AGUO3F50Lz
         THg1xmuCSDRscheBQ6YgkNGQyQMSFrO1dVpG07WUek1A4dl/o/J/DdVIcm+0CWxfXcmB
         ThTgCL0W94L4eoQW4iDaH55ABmZxcYLmcILXKZp8pHdDlA59boTEgWN3M1AAZ8i2Akmb
         fSeuXMhU3hMP4KMzQR/0/krq+IYGohDYHjFl2y2p7Ldpxz40BOdQ53QfogxrsjyxA6fb
         78Gw==
X-Gm-Message-State: ABuFfogs4Jz6E2ICXHu7c5wobIUaZfClVh8L3Sq5T060TYPKhAjfdnI9
        WVF58kWbw94Ih6WJiSpyE+jHY+SNmxSmNQ==
X-Google-Smtp-Source: ACcGV62YmCo2+yR0LDXx7tWSTW/AvuApg+y83EaKcYEdYslaDV1HbE4Wme6nQzaIzAdwaGy/yQSpsQ==
X-Received: by 2002:a50:b399:: with SMTP id s25-v6mr16695991edd.217.1538392873821;
        Mon, 01 Oct 2018 04:21:13 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-116-96.cgn.ip.fibianet.dk. [5.186.116.96])
        by smtp.gmail.com with ESMTPSA id d13-v6sm1908560eda.51.2018.10.01.04.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 04:21:13 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 1/3] help: redirect to aliased commands for "git cmd --help"
Date:   Mon,  1 Oct 2018 13:21:05 +0200
Message-Id: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in the thread for v1 of this patch [1] [2], this changes the
rules for "git foo --help" when foo is an alias.

(0) When invoked as "git help foo", we continue to print the "foo is
aliased to bar" message and nothing else.

(1) If foo is an alias for a shell command, print "foo is aliased to
!bar" as usual.

(2) Otherwise, break the alias string into words, and pretend that "git
word0 --help" was called.

At least for me, getting the man page for git-cherry-pick directly with
"git cp --help" is more useful (and how I expect an alias to behave)
than the short "is aliased to" notice. It is also consistent with
"--help" generally providing more comprehensive help than "-h".

I believe that printing the "is aliased to" message also in case (2) has
value: Depending on pager setup, or if the user has help.format=web, the
message is still present immediately above the prompt when the user
quits the pager/returns to the terminal. That serves as an explanation
for why one was redirected to "man git-cherry-pick" from "git cp
--help", and if cp is actually 'cherry-pick -n', it reminds the user
that using cp has some flag implicitly set before firing off the next
command.

It also provides some useful info in case we end up erroring out, either
in the "bad alias string" check, or in the "No manual entry for gitbar"
case.

[1] https://public-inbox.org/git/20180926102636.30691-1-rv@rasmusvillemoes.dk/
[2] https://public-inbox.org/git/20180926184914.GC30680@sigill.intra.peff.net/

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/help.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 8d4f6dd301..4802a06f37 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -415,9 +415,29 @@ static const char *check_git_cmd(const char* cmd)
 
 	alias = alias_lookup(cmd);
 	if (alias) {
-		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
-		free(alias);
-		exit(0);
+		const char **argv;
+		int count;
+
+		/*
+		 * If we were invoked as "git help cmd", or cmd is an
+		 * alias for a shell command, we inform the user what
+		 * cmd is an alias for and do nothing else.
+		 */
+		if (!exclude_guides || alias[0] == '!') {
+			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
+			free(alias);
+			exit(0);
+		}
+		/*
+		 * Otherwise, we pretend that the command was "git
+		 * word0 --help.
+		 */
+		fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);
+		count = split_cmdline(alias, &argv);
+		if (count < 0)
+			die(_("bad alias.%s string: %s"), cmd,
+			    split_cmdline_strerror(count));
+		return alias;
 	}
 
 	if (exclude_guides)
-- 
2.19.0

