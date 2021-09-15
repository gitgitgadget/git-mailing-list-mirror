Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B030EC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7BE61209
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhIOIMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhIOILh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 04:11:37 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A97C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:10:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x5so1556735qtq.13
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=meQLh/fOvDEJEhDTGNwuyd4iAd78b+Ha5Rm3teYRLak=;
        b=nQKfHDJH1qoX59GoKboM8SyTTEgtziLSz7oRylmi3l1kcpQdYUOr5fvRbyG3VJfxvl
         9cS03eNqsNzEsJXZ3TDuY79dXFIw4lKhOkyzvXZ4jF+wQdIiAmDg078kvTds5rSJBwxG
         OXF4xEn/oveyrymaX5K7vtWf1XWcQOx02Hbj4H461MnOT8h6WFOvlTWeFhw8aFuLvSA+
         TNAN2OWqRZ4R0ee/n7SN/pMyZgc64X6hGAjxePwNq52I9upXfDHyZcvtL0R/RR03eR6i
         AcDppX/Brmvt0mXmBEYnEodPDE+UWTUIVCJseu0N0wBRU/ZWdODvrXGqNJQIt/sGO25n
         5z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=meQLh/fOvDEJEhDTGNwuyd4iAd78b+Ha5Rm3teYRLak=;
        b=gYwvd9wJBD/xG6K2AWaLuNTJnXXpe6lumkx7tiPosk1KiRpd2Zu6e4PndW8tXsrV9t
         tVvAqv7rs9dA3H6M5I5kjLCDM3WKLWF/1s2LdR9glVzuTSmnf4RAad5rMiVs79ihp0Px
         3JY7qNniJdjg3ZWGEr9fJKdixj4REeVVIrhkWxA8WM884PwP2z3jzmoswcI+8OTNZHuT
         dLui1zGKp8Y5hPfeIOSZoZCP04wuxk733AX12VqcTqKKsH+9/ZROBD587987/PlDGYE4
         XRECGijErJ/FTVYn7CXYpb5ruYN4uN/JEikBZUUybyR1wpyPKGcpeaZzN9Dl7e0hpQoZ
         gAzg==
X-Gm-Message-State: AOAM5315hgMTQ/lDTrds+17tJ4KDiOyAqvU+QWHRG8YU40Vmx86IlYLA
        MjJvKl80RG38kdn3IR8nVkHOt2RBsw4=
X-Google-Smtp-Source: ABdhPJyP5OlLZI8O/0/voxvynzQdg8I1usXLXAO60RfjByIenhUe98LIT6RGNLEB0FlVPhVrIg1svg==
X-Received: by 2002:ac8:5617:: with SMTP id 23mr8788010qtr.20.1631693402890;
        Wed, 15 Sep 2021 01:10:02 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 20sm9661435qkn.31.2021.09.15.01.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:10:02 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sam@vilain.net, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] git-cvsserver: use crypt correctly to compare password hashes
Date:   Wed, 15 Sep 2021 01:09:46 -0700
Message-Id: <20210915080948.11891-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210915080948.11891-1-carenas@gmail.com>
References: <20210915080948.11891-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c057bad370 (git-cvsserver: use a password file cvsserver pserver,
2010-05-15) adds a way for `git cvsserver` to provide authenticated
pserver accounts without having clear text passwords, but uses the
username instead of the password to the call for crypt(3).

Correct that, and make sure the documentation correctly indicates how
to obtain hashed passwords that could be used to populate this
configuration, as well as correcting the hash that was used for the
tests.

This change will require that any user of this feature updates the
hashes in their configuration, but has the advantage of using a more
similar format than cvs uses, probably also easying any migration.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/git-cvsserver.txt | 10 ++++------
 git-cvsserver.perl              |  2 +-
 t/t9400-git-cvsserver-server.sh |  4 +++-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index f2e4a47ebe..4d13367c77 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -118,13 +118,11 @@ for example:
    myuser:$1$BA)@$vbnMJMDym7tA32AamXrm./
 ------
 You can use the 'htpasswd' facility that comes with Apache to make these
-files, but Apache's MD5 crypt method differs from the one used by most C
-library's crypt() function, so don't use the -m option.
+files, but only with the -d option (or -B if your system suports it).
 
-Alternatively you can produce the password with perl's crypt() operator:
------
-   perl -e 'my ($user, $pass) = @ARGV; printf "%s:%s\n", $user, crypt($user, $pass)' $USER password
------
+Preferably use the system specific utility that manages password hash
+creation in your platform (e.g. mkpasswd in Linux, encrypt in OpenBSD or
+pwhash in NetBSD) and paste it in the right location.
 
 Then provide your password via the pserver method, for example:
 ------
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ed035f32c2..4c93b5d099 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -222,7 +222,7 @@
         open my $passwd, "<", $authdb or die $!;
         while (<$passwd>) {
             if (m{^\Q$user\E:(.*)}) {
-                if (crypt($user, descramble($password)) eq $1) {
+                if (crypt(descramble($password), $1) eq $1) {
                     $auth_ok = 1;
                 }
             };
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 2d29d486ee..59b40359c7 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -36,6 +36,8 @@ CVSWORK="$PWD/cvswork"
 CVS_SERVER=git-cvsserver
 export CVSROOT CVS_SERVER
 
+PWDHASH='lac2ItudM3.KM'
+
 rm -rf "$CVSWORK" "$SERVERDIR"
 test_expect_success 'setup' '
   git config push.default matching &&
@@ -54,7 +56,7 @@ test_expect_success 'setup' '
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
   GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" &&
   GIT_DIR="$SERVERDIR" git config gitcvs.authdb "$SERVERDIR/auth.db" &&
-  echo cvsuser:cvGVEarMLnhlA > "$SERVERDIR/auth.db"
+  echo "cvsuser:$PWDHASH" >"$SERVERDIR/auth.db"
 '
 
 # note that cvs doesn't accept absolute pathnames
-- 
2.33.0.481.g26d3bed244

