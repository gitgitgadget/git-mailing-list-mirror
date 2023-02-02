Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695D9C63797
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjBBJcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBBJco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:32:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A159E6F
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:32:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso3263537wms.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q710yGKSb1Do3Dgf89StzbHJ8k5WkyplrSoApE6W3E=;
        b=ZrwWLvOyy/LMFOQDKEKqnUDKSYP0/eTX5M+qYTeWWXsTR3zltCCNLxZRPxfSnJmeAR
         sOhkFitHFhQO3akLK39004TLKQLEEe0btStHjoqP/Ke4gGgqC5xuuQM7NgQhTuNiKLTy
         SCRejks6ktlBfdsEKXyt36vr5vikIXLWxc3yCxLJQXYOPtPkfJB+EQ9sU5Ikx7i/1ttL
         kofbkIZicA70Px97b95ifIk+DG4GKZFiBQlEwoF9xelTJLo3aI0OicVf2NSlhGt4TpaZ
         a3hKHU+aDdZXglYqIA4Dr1Xfse78scl9Zqin9z9t1FVM4XO3wfX+dycmA56o8JuS/wOt
         d1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q710yGKSb1Do3Dgf89StzbHJ8k5WkyplrSoApE6W3E=;
        b=hd3Zy4Ba+RQbnwI8wJU+4zLX6xaE69rc6VPp5rllnUl+Uz7HGANERTyZM+iwX2sNft
         U/US+5ck/JiQmCOumWzf3LPe5RYJG194eltCJeqO03U0fjaeTjV1znBGuru65+LafG4s
         m9QdNP1/sUL5gGBb6on90JwqIEEOnw1C1FxldR9ZMZWwqIBKptVy3LaRacTKzTGwQvoS
         UypJjPqD9OT/UtxmGhdmVyo3z47A3GKxzt56o2TL0LQ/khbhoe/EUSQ65loEV3++JxjZ
         ffGZ4HWWCPFlTvyQ0uxTR2+Wjl92a6oRAkTLZrvVwhCGxQbpiMGJXpmSWU6HpgrE50XV
         n+gg==
X-Gm-Message-State: AO0yUKWo5yTOITWoHoHXoaeaAasAEFA87QH84koPJl4iQ+IiiJwHS3Is
        hdrLHiqCQ6WhRQJsOxGEzNuxtEqjaXGnZ9+N
X-Google-Smtp-Source: AK7set8U3euTJHXiioIpJcDoEa7lj80XALcwI2tXC87NzJzK6f3kPVUGS8F7pGXHOkjaFoSQ6VFu6A==
X-Received: by 2002:a05:600c:4a9b:b0:3de:1d31:1043 with SMTP id b27-20020a05600c4a9b00b003de1d311043mr5248972wmp.21.1675330360182;
        Thu, 02 Feb 2023 01:32:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm4238753wmc.0.2023.02.02.01.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:32:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/9] archive & tar config docs: de-duplicate configuration section
Date:   Thu,  2 Feb 2023 10:32:21 +0100
Message-Id: <patch-1.9-feb3e1bebd7-20230202T093212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com> <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "tar.umask" documentation was initially added in [1], and was
duplicated from the start. Then with [2] the two started drifting
apart. Let's consolidate them with a change like the ones made in the
commits merged in [3].

1. ce1a79b6a74 (tar-tree: add the "tar.umask" config option,
   2006-07-20)
2. 687157c736d (Documentation: update tar.umask default, 2007-08-21)
3. 7a54d740451 (Merge branch 'ab/dedup-config-and-command-docs',
   2022-09-14)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/tar.txt  | 4 +++-
 Documentation/git-archive.txt | 8 +-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/tar.txt b/Documentation/config/tar.txt
index de8ff48ea9d..c68e294bbc5 100644
--- a/Documentation/config/tar.txt
+++ b/Documentation/config/tar.txt
@@ -3,4 +3,6 @@ tar.umask::
 	tar archive entries.  The default is 0002, which turns off the
 	world write bit.  The special value "user" indicates that the
 	archiving user's umask will be used instead.  See umask(2) and
-	linkgit:git-archive[1].
+	linkgit:git-archive[1] for
+	details. If `--remote` is used then only the configuration of
+	the remote repository takes effect.
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 60c040988bb..bbb407d4975 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -131,13 +131,7 @@ tar
 CONFIGURATION
 -------------
 
-tar.umask::
-	This variable can be used to restrict the permission bits of
-	tar archive entries.  The default is 0002, which turns off the
-	world write bit.  The special value "user" indicates that the
-	archiving user's umask will be used instead.  See umask(2) for
-	details.  If `--remote` is used then only the configuration of
-	the remote repository takes effect.
+include::config/tar.txt[]
 
 tar.<format>.command::
 	This variable specifies a shell command through which the tar
-- 
2.39.1.1392.g63e6d408230

