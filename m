Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCCA020281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdIWT4G (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:56:06 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:42064
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751609AbdIWTz6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506196556;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=AnxYzDXOe8XKaSe7u09GGT+cSl3HbKvMDuHMLEYnOAw=;
        b=Cz0e5AjbYqM75wbhzFi2ZzRMIkcYNqF0KlEXL3fALyvetARuwblXS8PaLWut3ZU2
        IU6ef/HK0Mns8B8u74JravfYN8pC+Jf4OpLObFApO12ch6w/GUsaTNPTJttXhCwzaf4
        hvs3WVQ/8lUqnfgz+BwJ81O5u/ISHqjWCiPEZiHg=
From:   Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Message-ID: <0102015eb04f89f3-1c6db13e-2a6c-47b8-9519-b27a6c91e420-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
References: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 5/9] perf/run: add get_subsections()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Sep 2017 19:55:56 +0000
X-SES-Outgoing: 2017.09.23-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function makes it possible to find subsections, so that
we will be able to run different tests for different subsections
in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index 6bd15e701756b..4c966c0ae420e 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -93,6 +93,13 @@ run_dirs () {
 	done
 }
 
+get_subsections () {
+	section="$1"
+	test -z "$GIT_PERF_CONFIG_FILE" && return
+	git config -f "$GIT_PERF_CONFIG_FILE" --name-only --get-regex "$section\..*\.[^.]+" |
+	sed -e "s/$section\.\(.*\)\..*/\1/" | sort | uniq
+}
+
 get_var_from_env_or_config () {
 	env_var="$1"
 	conf_var="$2"

--
https://github.com/git/git/pull/408
