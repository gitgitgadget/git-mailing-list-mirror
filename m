Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA1F20467
	for <e@80x24.org>; Thu, 12 Oct 2017 06:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbdJLG61 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 02:58:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53508 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750750AbdJLG60 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 02:58:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 562219CBE7;
        Thu, 12 Oct 2017 02:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SOatc2PmcwGe6HvyoNBYpqcqkAQ=; b=bBCLmL
        pQ/l08mBOjE5vdmBSOZxOFvtCrJnbtc1o8UjyWf06puje1kvYmKxRh+mcgYVji9G
        QbVfUTof6ml3tAFokYOVDY3TupVtBtaZwI71BQ1/xXDBbF80Jo2GIIiW9SkYjN+V
        ssy9bA6CIhogF6U7Gzkoy7hhMokWmRzLK/VeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CnPmKtbeUI2RR6BAtgQwZtP2uD7WwGEU
        UCyBeNgiPJp66bfY2tqOm9MvF10BiBZHr7BMMR6hItdkDh5HvcJs3P5+Yg3qU9Qu
        CuJuzbVtnrvCpShJhxAWkcsQlrNomsvzQQ9mIs3xoeiVBow3bj10M50/0HHwr93E
        ZoPVU+rdaW8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D15A9CBE6;
        Thu, 12 Oct 2017 02:58:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ADAE39CBE5;
        Thu, 12 Oct 2017 02:58:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
        <20171012021007.7441-1-gitster@pobox.com>
        <20171012021007.7441-2-gitster@pobox.com>
        <20171012044724.GD155740@aiede.mtv.corp.google.com>
        <xmqqa80x0xcw.fsf@gitster.mtv.corp.google.com>
        <20171012054049.GF155740@aiede.mtv.corp.google.com>
        <xmqq1sm828pi.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 12 Oct 2017 15:58:18 +0900
In-Reply-To: <xmqq1sm828pi.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 12 Oct 2017 15:15:05 +0900")
Message-ID: <xmqqwp40zwc5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BADF6D9A-AF1A-11E7-8460-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> We need to be able to answer "why does '-c color.ui=always' work
> only from the command line?", but I doubt we want to actively
> encourage the use of it, though, so I dunno.

For today's pushout, I've queued this as [PATCH 3/2]

Thanks..

-- >8 --
From: Jonathan Nieder <jrnieder@gmail.com>
Subject: color: document that "git -c color.*=always" is a bit special
Date: Wed, 11 Oct 2017 21:47:24 -0700

When used from the command line as an option to "git" potty,
'always' does not get demoted to 'auto', to help third-party scripts
that (ab)used it to override the settings the end-user has.
Document it.

While at it, clarify description for per-command configuration
variables (color.branch, color.grep, color.interactive,
color.showBranch and color.status) so that they can more easily
share the new text to talk about this special-casing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 68 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ba01b8d3df..f79e82b79a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1051,11 +1051,15 @@ clean.requireForce::
 	-i or -n.   Defaults to true.
 
 color.branch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-branch[1]. May be set to `false` (or `never`) to
-	disable color entirely, `auto` (or `true` or `always`) in which
-	case colors are used only when the output is to a terminal.  If
-	unset, then the value of `color.ui` is used (`auto` by default).
+	When to use color in the output of linkgit:git-branch[1].
+	May be set to `never` (or `false`) to disable color entirely,
+	or `auto` (or `true`) in which case colors are used only when
+	the output is to a terminal.  If unset, then the value of
+	`color.ui` is used (`auto` by default).
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it is a historical synonym
+for `--color=always`.
 
 color.branch.<slot>::
 	Use customized color for branch coloration. `<slot>` is one of
@@ -1068,10 +1072,13 @@ color.diff::
 	Whether to use ANSI escape sequences to add color to patches.
 	If this is set to `true` or `auto`, linkgit:git-diff[1],
 	linkgit:git-log[1], and linkgit:git-show[1] will use color
-	when output is to the terminal. The value `always` is a
-	historical synonym for `auto`.  If unset, then the value of
+	when output is to the terminal. If unset, then the value of
 	`color.ui` is used (`auto` by default).
 +
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it is a historical
+synonym for `--color=always`.
++
 This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
@@ -1091,10 +1098,14 @@ color.decorate.<slot>::
 	branches, remote-tracking branches, tags, stash and HEAD, respectively.
 
 color.grep::
-	When set to `always`, always highlight matches.  When `false` (or
+	When to highlight matches using color. When `false` (or
 	`never`), never.  When set to `true` or `auto`, use color only
 	when the output is written to the terminal.  If unset, then the
 	value of `color.ui` is used (`auto` by default).
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it is a historical synonym
+for `--color=always`.
 
 color.grep.<slot>::
 	Use customized color for grep colorization.  `<slot>` specifies which
@@ -1126,9 +1137,11 @@ color.interactive::
 	When set to `true` or `auto`, use colors for interactive prompts
 	and displays (such as those used by "git-add --interactive" and
 	"git-clean --interactive") when the output is to the terminal.
-	When false (or `never`), never show colors. The value `always`
-	is a historical synonym for `auto`.  If unset, then the value of
-	`color.ui` is used (`auto` by default).
+	When false (or `never`), never show colors.
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it means to use color
+regardless of whether output is to the terminal.
 
 color.interactive.<slot>::
 	Use customized color for 'git add --interactive' and 'git clean
@@ -1141,18 +1154,24 @@ color.pager::
 	use (default is true).
 
 color.showBranch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-show-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
+	When to use color in the output of linkgit:git-show-branch[1].
+	May be set to `never` (or `false`) to disable color or `auto`
+	(or `true`) to use colors only when the output is to a terminal.
+	If unset, the value of `color.ui` is used (`auto` by default).
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it is a historical synonym
+for `--color=always`.
 
 color.status::
-	A boolean to enable/disable color in the output of
-	linkgit:git-status[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
+	When to use color in the output of linkgit:git-status[1].
+	May be set to `never` (or `false`) to disable color or `auto`
+	(or `true`) to use colors only when the output is to the terminal.
+	If unset, then the value of `color.ui` is used (`auto` by default).
++
+The value `always` is a historical synonym for `auto`, except when
+passed on the command line using `-c`, where it means to use color
+regardless of whether output is to the terminal.
 
 color.status.<slot>::
 	Use customized color for status colorization. `<slot>` is
@@ -1177,8 +1196,11 @@ color.ui::
 	color unless enabled explicitly with some other configuration
 	or the `--color` option. Set it to `true` or `auto` to enable
 	color when output is written to the terminal (this is also the
-	default since Git 1.8.4). The value `always` is a historical
-	synonym for `auto` and its use is discouraged.
+	default since Git 1.8.4).
++
+The value `always` is a historical synonym for `auto` (and its use is
+discouraged), except when passed on the command line using `-c`, where
+it means to use color regardless of whether output is to the terminal.
 
 column.ui::
 	Specify whether supported commands should output in columns.
-- 
2.15.0-rc1-154-g0b692121ee

