Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D885120189
	for <e@80x24.org>; Tue, 21 Jun 2016 10:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbcFUKje (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:39:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:63654 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcFUKgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:36:04 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lg1QN-1biKRq0pnH-00pZNf; Tue, 21 Jun 2016 12:35:17
 +0200
Date:	Tue, 21 Jun 2016 12:35:16 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 7/9] format-patch: explicitly switch off color when writing
 to files
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
Message-ID: <16e3e24e6f81fa334cfe5535c7a21ec50114bd97.1466505223.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vH2Dty+lFW9bq9AotEPxARUOLnJZg/Gy+5oGs5g4meHksMxIgin
 8v7PCfzSEMnhZcTmymzjG5lJevXOt/oaqOuiOl6Ste2ywlXTwhiJN9kPrpzjgYFS7MGz9ac
 mqbs3J69p9S3h0tOHuYppHpz15OYep6KreBnHVIE1RWG2ZV6pzeAKtGcgO/8md2nS4xOKNV
 U6TLBn9kAMkPJLHMf4k9Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:clrIkDT8YSE=:H+Vhk9dmA9/BdPLXlADeUb
 QSRKKUfz2+sPwT3ZKqaOI6eV52dzIm3ZTdYKt58r2/F020Z/qFHEDS8byGmOUuAvF74PHlPTT
 RIrptjl1lYFs1bhSwyHuXSnkW5wJ/Thna8fwC9iQ8EdoirrCYn54Z0pk8g72aRRXP2wJ5OWf3
 1qmWCcpIah50MyPxTsHhdFSBmRcs/0FUkFh+2KHhH6g0cjlhU8SlEmR/TfZpYAcQ/gfoyZGkb
 5HmmIVxorIWcgqG6wC0f7os9O8T73kmi6dRuoAiQrcM896WlihHcGq/CpPjuzLo/1k/z5UhMn
 6dLK4AXU8l5zAyXUA2CyEA4W5Nrm0ybGnRByBzS49ZjGwurNpcipCxo708QVrooiuzT1tZdKz
 wHh+7U0MvL2WB3HKqCNVxeqDwIDqbojEXuxghU0Tr5yj6QjyGuknHKfRxzXB9L5ALaFq/tAV6
 9NlWu6lBXpnUWTinKw40LDyflG18Cb07FJv5GKeJe9KQhheVPUJR7OCa6OsnrlRfP040epaUt
 mdfJDhIBU5vyNhS/CdDQCVuV3j3vpeG+PnS1tDxnOTbRl0omkWK9zcwsbZSsr6LETmTwFRJzC
 q18utwmi9eN8bWex+w32oI1VengvAyzRwsaM/x8u7WYiV5X0SgWqQRyICNJczRSmO0t+/yYkD
 ve1Wmn7bR3oJSHBrdNGom8BMJ8JCXNjZ0RD79mCk5he/rcLTkSbjQQxsPVSUSz/o+ie9V3Ebw
 2e1ZlUtq2YNIAmtgTsKDhI92nWgJDc9daTuW7flVP3prCMU0dbqiELvBa9SPDJT0B044jRsIf
 VwXSbLh
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We rely on the auto-detection ("is stdout a terminal?") to determine
whether to use color in the output of format-patch or not. That happens
to work because we freopen() stdout when redirecting the output to files.

However, we are about to fix that work-around, in which case the
auto-detection has no chance to guess whether to use color or not.

But then, we do not need to guess to begin with. We know that we do not
want to use ANSI color sequences in the output files. So let's just be
explicit about our wishes.

It might be argued that we should only do this when the variable
git_use_color_default still has its default value, GIT_COLOR_AUTO.
As of 7787570c (format-patch: ignore ui.color, 2011-09-13) we
do not allow the ui.color setting to affect format-patch's output,
therefore this will always be the case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/log.c b/builtin/log.c
index 099f4f7..abd889b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1569,6 +1569,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	if (output_directory) {
+		rev.diffopt.use_color = 0;
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
-- 
2.9.0.118.g0e1a633


