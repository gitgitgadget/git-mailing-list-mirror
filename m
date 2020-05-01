Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5608C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C25C20787
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgEAGUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 02:20:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:33300 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728159AbgEAGUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 02:20:40 -0400
Received: (qmail 1828 invoked by uid 109); 1 May 2020 06:20:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 May 2020 06:20:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15506 invoked by uid 111); 1 May 2020 06:20:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2020 02:20:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 May 2020 02:20:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     douglas.fuller@gmail.com, git@vger.kernel.org
Subject: [PATCH 1/2] gitcredentials(7): clarify quoting of helper examples
Message-ID: <20200501062039.GA25603@coredump.intra.peff.net>
References: <20200501061917.GC23665@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501061917.GC23665@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We give several helper config examples, but don't make clear that these
are raw values. It's up to the user to add the appropriate quoting to
put them into a config file (either by running with "git config" and
quoting against the shell, or by adding double-quotes as appropriate
within the git-config file).

Let's flesh them out as full config blocks, which makes the syntax more
clear (and makes it possible for people to just cut-and-paste them as a
starting point). I added double-quotes to any values larger than a
single word. That isn't strictly necessary in all cases, but it
sidesteps explaining the rules about exactly when you need to quote a
value.

The existing quotes can be converted to single-quotes in one instance,
and simply omitted in another for simplicity (unless you have odd
whitespace in your password, the shell whitespace-splitting behavior is
fine). I also swapped out backticks for our preferred $().

Reported-by: douglas.fuller@gmail.com
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitcredentials.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 1814d2d23c..8a20343dd7 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -216,20 +216,25 @@ Here are some example specifications:
 
 ----------------------------------------------------
 # run "git credential-foo"
-foo
+[credential]
+helper = foo
 
 # same as above, but pass an argument to the helper
-foo --bar=baz
+[credential]
+helper = "foo --bar=baz"
 
 # the arguments are parsed by the shell, so use shell
 # quoting if necessary
-foo --bar="whitespace arg"
+[credential]
+helper = "foo --bar='whitespace arg'"
 
 # you can also use an absolute path, which will not use the git wrapper
-/path/to/my/helper --with-arguments
+[credential]
+helper = "/path/to/my/helper --with-arguments"
 
 # or you can specify your own shell snippet
-!f() { echo "password=`cat $HOME/.secret`"; }; f
+[credential]
+helper = "!f() { echo password=$(cat $HOME/.secret); }; f"
 ----------------------------------------------------
 
 Generally speaking, rule (3) above is the simplest for users to specify.
-- 
2.26.2.933.gdf62622942

