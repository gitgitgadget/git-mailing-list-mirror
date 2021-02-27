Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D6BC433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 19:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23CB164E56
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 19:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhB0TVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 14:21:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58942 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhB0TUw (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Feb 2021 14:20:52 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9FFE860DF5;
        Sat, 27 Feb 2021 19:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614453574;
        bh=GcOohfjKp17jqputF2pT1ge5wxxZVRtAELmP78xupv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=X3O2aXlZIuzNs3lynHQRvG2Q1UZV0PyIoWK+VqGYSc6jMDNBQwyffHlQZu4avY3oL
         4E3tAdXd4XUDPHLIIub6g26SfwmQIcPY/PObUKJ6+DjtFquAbyueYx2veVysN5G3lX
         YZMBt3qW3aWrxz3Ie1OgOvYHbv7ejg7ngR0zXb27CQgjyovFCxkwOKtA1rhR1cPQpq
         /dZr0aoAeIAP4b6cO5HblPrPRsN+vikaV6lsL2mlXypiBlEYdRW/Xf6s2InRDkUGE4
         3dXEgZEx1chIkQ9v+uByMgUYJ1ivhdrphW1oYERknMyZPHkmUjq8t9RcPeMzDqgtTl
         DHiJvQVAXmJiuB5KmobOxBJaxLRopSUeHwSjV45iqrWqofP8mpmUEs0wJgB/3IS3Jw
         /tHGSQxabJszTkPT/HbKuOdlssZu2HWXG3DxXqRKBk+VkHi+l09E/R4zF5tbCUmkLG
         /0oxUe06HJ4yd1Yqid8XlHQBhDJbbjrc3KBe846SYZyuuyJaVZo
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/4] docs: add a question on syncing repositories to the FAQ
Date:   Sat, 27 Feb 2021 19:18:10 +0000
Message-Id: <20210227191813.96148-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.1.721.g45526154a5
In-Reply-To: <20210227191813.96148-1-sandals@crustytoothpaste.net>
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is very common that users want to transport repositories with working
trees across machines.  While this is not recommended, many users do it
anyway and moreover, do it using cloud syncing services, which often
corrupt their data.  The results of such are often seen in tales of woe
on common user question fora.

Let's tell users what we recommend they do in this circumstance and how
to do it safely.  Warn them about the dangers of untrusted working trees
and the downsides of index refreshes, as well as the problems with cloud
syncing services.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index afdaeab850..042b11e88a 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -241,6 +241,45 @@ How do I know if I want to do a fetch or a pull?::
 	ignore the upstream changes.  A pull consists of a fetch followed
 	immediately by either a merge or rebase.  See linkgit:git-pull[1].
 
+[[syncing-across-computers]]
+How do I sync a Git repository across multiple computers, VMs, or operating systems?::
+	The best way to sync a repository across computers is by pushing and fetching.
+	This uses the native Git mechanisms to transport data efficiently and is the
+	easiest and best way to move data across machines.  If the machines aren't
+	connected by a network, you can use `git bundle` to create a file with your
+	changes and then fetch or pull them from the file on the remote machine.
+	Pushing and fetching are also the only secure ways to interact with a
+	repository you don't own or trust.
++
+However, sometimes people want to sync a repository with a working tree across
+machines.  While this isn't recommended, it can be done with `rsync` (usually
+over an SSH connection), but only when the repository is completely idle (that
+is, no processes, including `git gc`, are modifying it at all).  If `rsync`
+isn't available, you can use `tar` to create a tar archive of the repository and
+copy it to another machine.  Zip files shouldn't be used due to their poor
+support for permissions and symbolic links.
++
+You may also use a shared file system between the two machines that is POSIX
+compliant, such as SSHFS (SFTP) or NFSv4.  If you are using SFTP for this
+purpose, the server should support fsync and POSIX renames (OpenSSH does).  File
+systems that don't provide POSIX semantics, such as DAV mounts, shouldn't be
+used.
++
+Note that you must not work with untrusted working trees, since it's trivial
+for an attacker to set configuration options that will cause arbitrary code to
+be executed on your machine.  Also, in almost all cases when sharing a working
+tree across machines, Git will need to re-read all files the next time you run
+`git status` or otherwise refresh the index, which can be slow.  This generally
+can't be avoided and is part of the reason why sharing a working tree isn't
+recommended.
++
+In no circumstances should you share a working tree or bare repository using a
+cloud syncing service or store it in a directory managed by such a service.
+Such services sync file by file and don't maintain the invariants required for
+repository integrity; in addition, they can cause files to be added, removed, or
+duplicated unexpectedly.  If you must use one of these services, use it to store
+the repository in a tar archive instead.
+
 Merging and Rebasing
 --------------------
 
