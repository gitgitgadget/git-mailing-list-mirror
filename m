Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661C3205C9
	for <e@80x24.org>; Sun,  8 Jan 2017 16:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756455AbdAHQzZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 11:55:25 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:35672
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754196AbdAHQzW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jan 2017 11:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1483894520;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=x8eyJlSugx10FW6tSHqV5UYXpyY63nfv3lmPUZpfsRc=;
        b=dNW2C6w4SBbme1G2drPZOGH79CtCNY0wAz/rvAYbWTBqFkpvcFHY/zyQVjxvC7Lv
        vkHS9N1VlaYTlVdJXr3JzyZGhj5HmWZgSmcOJBJdb94Lwi02UxfFnHqCiyFRuXwEjSW
        85ViWdE1ezYLRH4QZc7dcwOy5/AbH+Hq12edJ544=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201597f0179fb-fc4c0240-5ec7-466b-96b9-59f4840954d7-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201597f017978-356bf9e9-ee78-498b-926b-5c00466b1d9e-000000@eu-west-1.amazonses.com>
References: <010201597f017978-356bf9e9-ee78-498b-926b-5c00466b1d9e-000000@eu-west-1.amazonses.com>
Subject: [PATCH v4 2/2] t9813: avoid using pipes
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 8 Jan 2017 16:55:20 +0000
X-SES-Outgoing: 2017.01.08-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t9813-git-p4-preserve-users.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index 76004a5..bda222a 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -118,12 +118,12 @@ test_expect_success 'not preserving user with mixed authorship' '
 		make_change_by_user usernamefile3 Derek derek@example.com &&
 		P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
-		git p4 commit |\
-		grep "git author derek@example.com does not match" &&
+		git p4 commit >actual &&
+		grep "git author derek@example.com does not match" actual &&
 
 		make_change_by_user usernamefile3 Charlie charlie@example.com &&
-		git p4 commit |\
-		grep "git author charlie@example.com does not match" &&
+		git p4 commit >actual &&
+		grep "git author charlie@example.com does not match" actual &&
 
 		make_change_by_user usernamefile3 alice alice@example.com &&
 		git p4 commit >actual &&

--
https://github.com/git/git/pull/314
