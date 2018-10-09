Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13F41F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 11:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJITPz (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 15:15:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34830 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJITPx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 15:15:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id y19-v6so1430559edd.2
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhMDVfNznqjcUO+ycKjNTSJVv06LYKubyTeqk0ipeVw=;
        b=Q4JQPPivvMryJ5kUoOLtTxEGYxTod1XySdbByZLuowz0ycDkOB+J1A7sbxPGa1aiHc
         zcwj99g8ecK8VIkcyfQFQdwX6yjy8UEEsoAocTkewtNutu/AE2fsCzcQV6PtVKaTe1Bx
         VhOt2WCf9muCvh2WC7j40FCs+DA/QphydUVBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhMDVfNznqjcUO+ycKjNTSJVv06LYKubyTeqk0ipeVw=;
        b=kbxoZB0cRxWepXX1aBmnui5VCYpmcRsfsfTbpY3EUKuAM+rJ16adSL4umBIY8i+iqy
         qA1KfM8Spl3VzH6Vox/xYwP3Bz6felGoMCinluoz+EJtBCkjXKoXmX3KQFOs/iDsEOXc
         bZp2JsoZ25AeIFeaeUNwKMUaptAU5F0RtEpuYLpZ8gCbNR2A2XaFOVKAbrfSqE5m1HRg
         BlAGrSEbqpmiKEI1/ZVCSw1lVfhQ2+alGTE2Z/mUy9KpB67/37MX+dn9pPEHaytwbSQb
         5DAtKkt+21Tz3h6wwi3+8+WCzJxr27+47ji2nKzHsKeSFOnyDi/QSiBix/tmgxncAhKB
         spXQ==
X-Gm-Message-State: ABuFfogZ9LrQ4pV5hWuL5nGZHCWwOuGQ1L9xGaiGpK7MgASDHs4WYYVm
        N23UKKtcpm3woCwnOeAW/YaBz0Pkn8Y=
X-Google-Smtp-Source: ACcGV63l1jNSANvo8cvu+Fvg9de+LLvAj8rzHcRMppzsgAxpvCiWlKKtrpxM+aGVX+IG69RpqiwMGg==
X-Received: by 2002:a50:9a81:: with SMTP id p1-v6mr22831476edb.112.1539086355003;
        Tue, 09 Oct 2018 04:59:15 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id o4-v6sm3522556ejx.30.2018.10.09.04.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:59:14 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v4 1/3] help: redirect to aliased commands for "git cmd --help"
Date:   Tue,  9 Oct 2018 13:59:07 +0200
Message-Id: <20181009115909.16648-2-rv@rasmusvillemoes.dk>
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

As discussed in the thread for v1 of this patch [1] [2], this changes the
rules for "git foo --help" when foo is an alias.

(1) When invoked as "git help foo", we continue to print the "foo is
aliased to bar" message and nothing else.

(2) If foo is an alias for a shell command, print "foo is aliased to
!bar" as usual.

(3) Otherwise, print "foo is aliased to bar" to the standard error
stream, and then break the alias string into words and pretend as if
"git word[0] --help" were called.

Getting the man page for git-cherry-pick directly with "git cp --help"
is consistent with "--help" generally providing more comprehensive help
than "-h". Printing the alias definition to stderr means that in certain
cases (e.g. if help.format=web or if the pager uses an alternate screen
and does not clear the terminal), one has

'cp' is aliased to 'cherry-pick -n'

above the prompt when one returns to the terminal/quits the pager, which
is a useful reminder that using 'cp' has some flag implicitly set. There
are cases where this information vanishes or gets scrolled
away, but being printed to stderr, it should never hurt.

[1] https://public-inbox.org/git/20180926102636.30691-1-rv@rasmusvillemoes.dk/
[2] https://public-inbox.org/git/20180926184914.GC30680@sigill.intra.peff.net/

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/help.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 8d4f6dd301..e0e3fe62e9 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -415,9 +415,37 @@ static const char *check_git_cmd(const char* cmd)
 
 	alias = alias_lookup(cmd);
 	if (alias) {
-		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
-		free(alias);
-		exit(0);
+		const char **argv;
+		int count;
+
+		/*
+		 * handle_builtin() in git.c rewrites "git cmd --help"
+		 * to "git help --exclude-guides cmd", so we can use
+		 * exclude_guides to distinguish "git cmd --help" from
+		 * "git help cmd". In the latter case, or if cmd is an
+		 * alias for a shell command, just print the alias
+		 * definition.
+		 */
+		if (!exclude_guides || alias[0] == '!') {
+			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
+			free(alias);
+			exit(0);
+		}
+		/*
+		 * Otherwise, we pretend that the command was "git
+		 * word0 --help". We use split_cmdline() to get the
+		 * first word of the alias, to ensure that we use the
+		 * same rules as when the alias is actually
+		 * used. split_cmdline() modifies alias in-place.
+		 */
+		fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);
+		count = split_cmdline(alias, &argv);
+		if (count < 0)
+			die(_("bad alias.%s string: %s"), cmd,
+			    split_cmdline_strerror(count));
+		free(argv);
+		UNLEAK(alias);
+		return alias;
 	}
 
 	if (exclude_guides)
-- 
2.19.1.4.g721af0fda3

