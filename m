Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB69A1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 18:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbcG3SUX (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 14:20:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35655 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcG3SUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 14:20:22 -0400
Received: by mail-lf0-f66.google.com with SMTP id l89so6727371lfi.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 11:20:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6Cy6/3Sd3Bzg2jdJXnnuST0IkYMcOK1tQ7SnAgTCyU=;
        b=s/KqrNuwi1jKOkkcpcIoCR2zwrWyX/XYyTJXmniHOfrvJA1+wCNhulTyh+Uihlw9W+
         v6i6awWguo3uUF3rM9FgDrZQULarlAiHDuk/SnvkNCsyPjeNz6F/brZOeNImnigUa3gy
         YpOG+4gST+OvUFDRVLtPL1rGoeV3XBZUqU/1qqY3O0wGi9VJzeeBorGMIRB8eSL98wwe
         r0VUcGDh87bDDnEBOIfHIgF+tLrVs/9eIri9iQi8kPKtnr9WKtZaAVZiHzTfYj+8driF
         tfGvo4cjIURnkZEXfV5mC/ZWT6RRmqOgutqTxsGXnLFJtQVg7tztI+QvlVcoxTdK0/4a
         tiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6Cy6/3Sd3Bzg2jdJXnnuST0IkYMcOK1tQ7SnAgTCyU=;
        b=IjCxZ2F3j+Pq1AaQMTuZuxbLk0tphuusAD1bXAtfqW1KOreWI1srp08eMDxIfO7AjD
         rJQL60jeQ7KFcqvRbGFuNx3gLRSoGjRa3FdvGZVpGXmaxI7fk9CjewkzNQg6eoqugnXf
         WICPnXy70tv7ikd01tPcb5xu/9iiC10WbrQLThLeqY3ipPMWlAfJx/v5Zt7nZ4JlfA9z
         5C12B5bcv8YWZJ+QyFyujC17GRpNSb/slcauNrGe5Knf4kc5+IdQktpKPbyp2rkB0IKj
         A+9Yt5Uouo7Lk72xjxlGcdieEPmkGnH5+ava+rKJWn3ejogvRqszTQUqZi5b/5tUvrMW
         NVbA==
X-Gm-Message-State: AEkoout5o5USybP3/euWfz/xSMgZtec/qHVCqQcNYdRGFlZnACgF6iGVVKzjq433n6HOhw==
X-Received: by 10.25.134.65 with SMTP id i62mr14026063lfd.128.1469902819996;
        Sat, 30 Jul 2016 11:20:19 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id h88sm3728362ljh.23.2016.07.30.11.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 11:20:19 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, e@80x24.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t7063: work around FreeBSD's lazy mtime update feature
Date:	Sat, 30 Jul 2016 20:20:05 +0200
Message-Id: <20160730182005.14426-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160718223038.GA66056@plume>
References: <20160718223038.GA66056@plume>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Let's start with the commit message of [1] from freebsd.git [2]

    Sync timestamp changes for inodes of special files to disk as late
    as possible (when the inode is reclaimed).  Temporarily only do
    this if option UFS_LAZYMOD configured and softupdates aren't
    enabled.  UFS_LAZYMOD is intentionally left out of
    /sys/conf/options.

    This is mainly to avoid almost useless disk i/o on battery powered
    machines.  It's silly to write to disk (on the next sync or when
    the inode becomes inactive) just because someone hit a key or
    something wrote to the screen or /dev/null.

    PR:             5577 [3]

The short version of that, in the context of t7063, is that when a
directory is updated, its mtime may be updated later, not
immediately. This can be shown with a simple command sequence

    date; sleep 1; touch abc; rm abc; sleep 10; ls -lTd .

One would expect that the date shown in `ls` would be one second from
`date`, but it's 10 seconds later. If we put another `ls -lTd .` in
front of `sleep 10`, then the date of the last `ls` comes as
expected. The first `ls` somehow forces mtime to be updated.

t7063 is really sensitive to directory mtime. When mtime is too "new",
git code suspects racy timestamps and will not trigger the shortcut in
untracked cache, in t7063.26 (or t7063.25 before this patch) and
eventually be detected in t7063.28

We have two options thanks to this special FreeBSD feature:

1) Stop supporting untracked cache on FreeBSD. Skip t7063 entirely
   when running on FreeBSD

2) Work around this problem (using the same 'ls' trick) and continue
   to support untracked cache on FreeBSD

I initially wanted to go with 1) because I didn't know the exact
nature of this feature and feared that it would make untracked cache
work unreliably, using the cached version when it should not.

Since the behavior of this thing is clearer now. The picture is not
that bad. If this indeed happens often, untracked cache would assume
racy condition more often and _fall back_ to non-untracked cache code
paths. Which means it may be less effective, but it will not show
wrong things.

This patch goes with option 2.

PS. For those who want to look further in FreeBSD source code, this
flag is now called IN_LAZYMOD. I can see it's effective in ext2 and
ufs. zfs is questionable.

[1] 660e6408e6df99a20dacb070c5e7f9739efdf96d
[2] git://github.com/freebsd/freebsd.git
[3] https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=5577

Reported-by: Eric Wong <e@80x24.org>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This is only of those commits that commit messages are more important
 than the patch itself. One of the good notes about directory mtime,
 if we start to use it in more places in git.

 t/t7063-status-untracked-cache.sh | 4 ++++
 t/test-lib.sh                     | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a971884..08fc586 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -419,6 +419,10 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	rm base
 '
 
+test_expect_success FREEBSD 'Work around lazy mtime update' '
+	ls -ld . >/dev/null
+'
+
 test_expect_success 'test sparse status with untracked cache' '
 	: >../trace &&
 	avoid_racy &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..3c730a2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -961,6 +961,12 @@ case $(uname -s) in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	;;
+*FreeBSD*)
+	test_set_prereq FREEBSD
+	test_set_prereq POSIXPERM
+	test_set_prereq BSLASHPSPEC
+	test_set_prereq EXECKEEPSPID
+	;;
 *)
 	test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
-- 
2.9.1.566.gbd532d4

