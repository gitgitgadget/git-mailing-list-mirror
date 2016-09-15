Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C1F2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbcIOU6d (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:58:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52014 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751570AbcIOU6c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:58:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48F3E3D8DC;
        Thu, 15 Sep 2016 16:58:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gr4mZ065VHmL89FvCfmAZfflYM0=; b=t4r50S
        XUOYo3Cv9LqtAQEHx/L6JBYtZzvyeZxF6fiOsxLjesZtiS9zCdXLDopdRFsYD40X
        svQKchqlk/yhJhn6LcBqBb8wHPfbYr0y5m8llm+mP+7zwzCoINPwDXpB5SoSrgXz
        EJo8YMvFYUtPulXhESqS8++5FGBW8gbUmT4Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mOfEve2nQ3NRve+E2Z1GMLs33YWR8xyQ
        4cO2Y7mxPQiLcW6zoABnjH/ikSqFYQa95Wq7pPRZ+ly/O0wltn0sAjW8PkKQQUcF
        tgGZgKXicJZNPEaQxiPbc2lQaD7pMVwTqVk8Rn6G3hudwpq3iELP+I7jkljtoBfP
        n5xxHzhiWdI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42F063D8DB;
        Thu, 15 Sep 2016 16:58:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB9BE3D8D9;
        Thu, 15 Sep 2016 16:58:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] ls-files: adding support for submodules
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
        <1473726835-143289-1-git-send-email-bmwill@google.com>
        <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 15 Sep 2016 13:58:28 -0700
In-Reply-To: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 13 Sep 2016 09:31:18 -0700")
Message-ID: <xmqq60pwnamj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 284EF51C-7B87-11E6-8998-5D827B1B28F4-77302942!pb-smtp2.pobox.com
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

