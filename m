Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4BF2022A
	for <e@80x24.org>; Wed,  3 Aug 2016 17:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbcHCRpu (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 13:45:50 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34499 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbcHCRps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 13:45:48 -0400
Received: by mail-lf0-f68.google.com with SMTP id l69so12349291lfg.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 10:45:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=37jHvwwiyzFowP9hQCkBeNueTbtZ2mYCMykxgQ+RKnE=;
        b=SAy0DV7WCybEg4EjS+CnhCedIqD/aYZDr8VEDMuHWZpcZMI8qvTahdMVGuTNoi/V10
         KKM9R7c9iwWK6Bp9w8I8VMwSvzqQpoPYT5vqUIhkocMkCiN9Z8mX4bLSdZ1szyg1k3vt
         iDNHL6N5s5rBkvCVQH4E0P2fhour5xNzXP7IT3iKiLcK4KeeZ9R/yWLs60SYt/eIUV/H
         NbGTokLFzTKi4SVH74Ii7A5mCkfmnwd71ue+/Ih9OIKLJJfuCCh61AMPLH5L69riPoMB
         Vadi0L9r3Ac3YF7yHJgjN6ToXfabwtqcrvKD8qrY96qQFfyjpNwIcgpaKGJ+2zuZpyyc
         Pqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=37jHvwwiyzFowP9hQCkBeNueTbtZ2mYCMykxgQ+RKnE=;
        b=NW4zQYv+htlJ0buSMkiMU6gOgWbmR3l8Z4nCJJ6M1Gp/WeXt4W43ZuE0TMVW3G+j0w
         mfMpiEq3+FV7PGrjIMMLxduge2ixh+n0lCdIqrFb+YnOgoSU/82MAd46eN3JX4XcoTuU
         AIIb84j8tOTOM/sfEEDGgTuGFeqjPdL81kLRz8rzDCpmgTU2lIgnBSR5OVkQl3+iGUgn
         6Uunv8kgeHxLVSuQGyhMMgzQKK48+2reMr6Hs/Kay+LneOTpyeTg8e6EyNv92evU9VEB
         jd8kv99PjGyPyyarMkR4A5OcX7+nlRCh6n81aVkeR/iNqoD6LzBU/v6RXmUQ1IBgqVt5
         ZqUQ==
X-Gm-Message-State: AEkoouv8/FnznFcRJ43lJ7wsrOMoVWZFjG17mwz0rt3U6+sZUDFJl/TRuXwfq5fZNwgBSQ==
X-Received: by 10.25.142.204 with SMTP id q195mr19219188lfd.220.1470246345752;
        Wed, 03 Aug 2016 10:45:45 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u11sm1555498lja.12.2016.08.03.10.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 10:45:44 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, e@80x24.org, tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] t7063: work around FreeBSD's lazy mtime update feature
Date:	Wed,  3 Aug 2016 19:45:22 +0200
Message-Id: <20160803174522.5571-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160803160536.15596-1-pclouds@gmail.com>
References: <20160803160536.15596-1-pclouds@gmail.com>
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
 v3 differs from v2 in one line

    --- a/t/t7063-status-untracked-cache.sh
    +++ b/t/t7063-status-untracked-cache.sh
    @@ -11,7 +11,7 @@ test_description='test untracked cache'
     # containing directory in sync with the reality after doing blah and
     # before checking the fast path behaviour
     sync_mtime () {
    -	find . -type d -exec ls -ld {} \; >/dev/null
    +	find . -type d -ls >/dev/null
     }
 
 avoid_racy() {
 t/t7063-status-untracked-cache.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a971884..d31d080 100755
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
+	find . -type d -ls >/dev/null
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

