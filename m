Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321AA1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757799AbcHCQHr (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:07:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34547 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbcHCQHp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:07:45 -0400
Received: by mail-lf0-f67.google.com with SMTP id l69so12225591lfg.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:05:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rkrEf7Jmp+4LOdO7NSvWPDhZySK4tDtCOISPT6hbads=;
        b=To1sGXpaMMrjh3/aImqjCMQAytzpEqz/dk2Kmvy1lI06WMpReFlxw9Cq68TZ45OGVw
         P53dIzP7RwvBW1BeAeXs66GJBjYQbJonHYVSs/TZ8V++JF6kWUZvjszU6F5Z47gHzrwM
         Mpa1txO6iKsinKSshbNOt/nNmSw/eu549+ZRjAEG7jNIbeUvi7+KiJL/QpoxF66UJ2/n
         Uu6jwtYE9CCVzKB6SMMAJQXA1nu3yutGautdVZGqFpug55D4giZLPTeaaU4Cw+1iNAKU
         dpdcqw7M3vpjFSw/V8ita5P/XEoBL9Dd4QpoCz75qCYu30lVoimTjn6iuKLRW56eJCY9
         MHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rkrEf7Jmp+4LOdO7NSvWPDhZySK4tDtCOISPT6hbads=;
        b=khpqjmQc7fJu8M0LQsPoCU6Hyi2LS+IIy+2SbJi8ODZYKgALKZPE4fZEzmoyyfCitc
         XGb2PrY3R50Iya8fmffhZ0gnl1Lh77g8p1aVreY9tEnXrdTJM7QwoPWmLTJC87Gw5uCt
         PGqXHXU6GMjMeGE7bNE0sQ4NVcjr0vdd2A5h+uIhRhJj1RdmULKHk5/94uiNP25Tng8x
         /eQ4bSsPoeILAkR7yc8qeQv9iJ65k9Sz/oJVAuGWCn6UzGZpKQ7xXdH4ojks6aMSqI9S
         ak+ihEYuJUX0NWm052A34sSOpWbML3cmd2QPj7vFyZQeLX5GfVuKhQ11NF8Fx6FjYWFZ
         uWuQ==
X-Gm-Message-State: AEkooutxd+pAKt6OAUYcHAtx620xKLzU2o9qMG7Lp6euWf4UnB5ZmKSu41UZFhtcUS373w==
X-Received: by 10.25.76.137 with SMTP id z131mr18804671lfa.49.1470240358032;
        Wed, 03 Aug 2016 09:05:58 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id p21sm1508140lfp.4.2016.08.03.09.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:05:56 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, e@80x24.org, tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] t7063: work around FreeBSD's lazy mtime update feature
Date:	Wed,  3 Aug 2016 18:05:36 +0200
Message-Id: <20160803160536.15596-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160730182005.14426-1-pclouds@gmail.com>
References: <20160730182005.14426-1-pclouds@gmail.com>
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
untracked cache, in t7063.24 and eventually be detected in t7063.27

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
ufs. zfs is not affected.

[1] 660e6408e6df99a20dacb070c5e7f9739efdf96d
[2] git://github.com/freebsd/freebsd.git
[3] https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=5577

Reported-by: Eric Wong <e@80x24.org>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 goes with Junio's suggestion (good one!). And since there is an
 intention to reuse this new function, I make sure all directories are
 stat'd to pin down their mtime.

 t/t7063-status-untracked-cache.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a971884..7dd4de0 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -4,6 +4,16 @@ test_description='test untracked cache'
 
 . ./test-lib.sh
 
+# On some filesystems (e.g. FreeBSD's ext2 and ufs) this and that
+# happens when we do blah, which forces the untracked cache code to
+# take the slow path.  A test that wants to make sure the fast path
+# works correctly should call this helper to make mtime of the
+# containing directory in sync with the reality after doing blah and
+# before checking the fast path behaviour
+sync_mtime () {
+	find . -type d -exec ls -ld {} \; >/dev/null
+}
+
 avoid_racy() {
 	sleep 1
 }
@@ -416,7 +426,8 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	echo four >done/four && # four is gitignored at a higher level
 	echo five >done/five && # five is not gitignored
 	echo test >base && #we need to ensure that the root dir is touched
-	rm base
+	rm base &&
+	sync_mtime
 '
 
 test_expect_success 'test sparse status with untracked cache' '
-- 
2.9.1.566.gbd532d4

