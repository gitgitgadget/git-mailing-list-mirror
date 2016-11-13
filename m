Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1238F2021E
	for <e@80x24.org>; Sun, 13 Nov 2016 01:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbcKMBkJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 20:40:09 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:46595 "EHLO
        homiemail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752647AbcKMBkJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Nov 2016 20:40:09 -0500
Received: from homiemail-a14.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTP id 3D16E392075;
        Sat, 12 Nov 2016 17:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        in-reply-to:references:from:date:subject:to:cc
        :content-transfer-encoding:message-id:mime-version; s=
        mattmccutchen.net; bh=MKZm2lNBWqFAM7yldfsMd1dD1f0=; b=W2dUQV3poV
        znoxmktvhMEORskYrfeT+pAn6h8+RgP1Md0DrWFld/skJBxCsXKPZzI9Et9d2bME
        Vqtc76+6Y6lQvREarKkkvbWVJC15i990aR+QODHV2mnv+00uhFfZYJjO7n2wDPuj
        2JBsmARXrz6Y1cUVk25IVv5BvyyJ3LkZA=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTPSA id B90E8392076;
        Sat, 12 Nov 2016 17:40:07 -0800 (PST)
In-Reply-To: <xmqqy416uvan.fsf@gitster.mtv.corp.google.com>
References: <xmqqy416uvan.fsf@gitster.mtv.corp.google.com>
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Sat, 12 Nov 2016 20:25:55 -0500
Subject: [PATCH] fetch/push: document that private data can be leaked
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 7bit
Message-ID: <1479001205.3471.1.camel@mattmccutchen.net>
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A malicious server may be able to use the fetch and push protocols to
steal data from a user's repository that the user did not intend to
share, via attacks similar to those described in the gitnamespaces(7)
man page. Mention this in the git-fetch(1), git-pull(1), and git-push(1)
man pages and recommend using separate repositories for private data and
interaction with untrusted servers.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---

And here's a proposed patch.  Based on the maint branch, ac84098.

 Documentation/fetch-push-security.txt | 9 +++++++++
 Documentation/git-fetch.txt           | 2 ++
 Documentation/git-pull.txt            | 2 ++
 Documentation/git-push.txt            | 2 ++
 4 files changed, 15 insertions(+)
 create mode 100644 Documentation/fetch-push-security.txt

diff --git a/Documentation/fetch-push-security.txt b/Documentation/fetch-push-security.txt
new file mode 100644
index 0000000..00944ed
--- /dev/null
+++ b/Documentation/fetch-push-security.txt
@@ -0,0 +1,9 @@
+SECURITY
+--------
+The fetch and push protocols are not designed to prevent a malicious
+server from stealing data from your repository that you did not intend to
+share. The possible attacks are similar to the ones described in the
+"SECURITY" section of linkgit:gitnamespaces[7]. If you have private data
+that you need to protect from the server, keep it in a separate
+repository.
+
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 9e42169..a461b4b 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -192,6 +192,8 @@ The first command fetches the `maint` branch from the repository at
 objects will eventually be removed by git's built-in housekeeping (see
 linkgit:git-gc[1]).
 
+include::fetch-push-security.txt[]
+
 BUGS
 ----
 Using --recurse-submodules can only fetch new commits in already checked
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d033b25..0af2de9 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -237,6 +237,8 @@ If you tried a pull which resulted in complex conflicts and
 would want to start over, you can recover with 'git reset'.
 
 
+include::fetch-push-security.txt[]
+
 BUGS
 ----
 Using --recurse-submodules can only fetch new commits in already checked
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 47b77e6..5ebef9e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -559,6 +559,8 @@ Commits A and B would no longer belong to a branch with a symbolic name,
 and so would be unreachable.  As such, these commits would be removed by
 a `git gc` command on the origin repository.
 
+include::fetch-push-security.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.7.4


