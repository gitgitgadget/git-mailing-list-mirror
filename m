Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D802070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbcIOU7y (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:59:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64170 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752575AbcIOU7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FB883D53C;
        Thu, 15 Sep 2016 16:51:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Gr4m
        Z065VHmL89FvCfmAZfflYM0=; b=g9q/kdZ/R/y3oVq/jJF/wDXH2eu1gQ47x8Mt
        VJt3hRuxPluB7o/oXOYjid9oDovzX6ist0v6bsWjH7wvTcaofFET47v9IYH3JhhQ
        2sSdUd54xRhqbaccLYkQrYcHpqSZ4vQ4q5qBuZEgce+tJmb9x0Bc2PtzvWWzyqyQ
        sEjNPdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=yfnG+F
        EIETfX6P2sqqQeX5XoKgFl5Ar0nB0eUFfb5bHJr5DTc5hcHyU9BrRuBSKrwAeYrR
        efqCNB9djc5Heiy2qcS0Zx8nPfOgH6N5vwayESXLL0GtipQv0cZ7RLohS11OF18m
        ZMHelWL0WFuJX7IUZ8F0RHWWrAneVA6EDV8oE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 320603D53B;
        Thu, 15 Sep 2016 16:51:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2F993D539;
        Thu, 15 Sep 2016 16:51:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] SQUASH???  Undecided
Date:   Thu, 15 Sep 2016 13:51:09 -0700
Message-Id: <20160915205109.12240-3-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-458-g97b4043
In-Reply-To: <20160915205109.12240-1-gitster@pobox.com>
References: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com>
 <20160915205109.12240-1-gitster@pobox.com>
X-Pobox-Relay-ID: 26B7D60C-7B86-11E6-BC2A-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we were to follow the convention to leave an optional string
variable to NULL, we'd need to do this on top.  I am not sure if it
is a good change, though.
---
 builtin/ls-files.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6e78c71..687e475 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -29,7 +29,7 @@ static int show_valid_bit;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
-static const char *output_path_prefix = "";
+static const char *output_path_prefix;
 static int recurse_submodules;
 
 static const char *prefix;
@@ -78,7 +78,7 @@ static void write_name(const char *name)
 	 * churn.
 	 */
 	static struct strbuf full_name = STRBUF_INIT;
-	if (*output_path_prefix) {
+	if (output_path_prefix && *output_path_prefix) {
 		strbuf_reset(&full_name);
 		strbuf_addstr(&full_name, output_path_prefix);
 		strbuf_addstr(&full_name, name);
@@ -181,7 +181,8 @@ static void show_gitlink(const struct cache_entry *ce)
 	argv_array_push(&cp.args, "ls-files");
 	argv_array_push(&cp.args, "--recurse-submodules");
 	argv_array_pushf(&cp.args, "--output-path-prefix=%s%s/",
-			 output_path_prefix, ce->name);
+			 output_path_prefix ? output_path_prefix : "",
+			 ce->name);
 	cp.git_cmd = 1;
 	cp.dir = ce->name;
 	status = run_command(&cp);
-- 
2.10.0-458-g97b4043

