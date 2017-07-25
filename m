Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E391F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 17:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbdGYR5L (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 13:57:11 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:35566
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751196AbdGYR5L (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Jul 2017 13:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1501005429;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=af88F5huqP5uGuzj5JaFkzLiMWZgxaRvWS+XDwUrke4=;
        b=ePieZAY83uOA3z3FhakbxOxP3zWZRD0/KjR3tqEo9Rg9Zm1kFFtobdn2jBBbIjuN
        QlgrRN9uM+VGl2mDA2p43BvZ5JS1937VsVyOXrViKRu+xdBodg7N3fl8UuWmxbT/Zit
        9jqM7m4U5gWA3MXQDHde4MebdgiMOD5tET8RreSE=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
Subject: [PATCH/RFC] setup: update error message to be more meaningful
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Jul 2017 17:57:09 +0000
X-SES-Outgoing: 2017.07.25-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error message shown when a flag is found when expecting a
filename wasn't clear as it didn't communicate what was wrong
using the 'suitable' words in *all* cases.

Correct case,

        $ git rev-parse commit.c --flags
        commit.c
        --flags
        fatal: bad flag '--flags' used after filename

Incorrect case,

        $ git grep "test" -n
        fatal: bad flag '-n' used after filename

Change the error message to be general and communicative. This results
in the following output,

        $ git rev-parse commit.c --flags
        commit.c
        --flags
        fatal: found flag '--flags' in place of a filename

        $ git grep "test" -n
        fatal: found flag '-n' in place of a filename

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 860507e1fdb2d..0433d7889e6b3 100644
--- a/setup.c
+++ b/setup.c
@@ -230,7 +230,7 @@ void verify_filename(const char *prefix,
 		     int diagnose_misspelt_rev)
 {
 	if (*arg == '-')
-		die("bad flag '%s' used after filename", arg);
+		die("found flag '%s' in place of a filename", arg);
 	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);

--
https://github.com/git/git/pull/388
