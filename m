Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F33C11F6A
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A918C613F4
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhGBL3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 07:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhGBL3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 07:29:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B643C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 04:27:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p8so12074247wrr.1
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5W7k9QjEAK1Hb5opkyjXRAO6gQtXIxhKlWPQXzaW3A=;
        b=oqZqnSCMPYKzg4a3PFUkY6aOY8RPe2ZmqvJUTw3feL9NrAwik8KKu+yocIxCIvuhZ2
         x3iOyf2U/MYqLGwUCyGHWQak+b6r3CK8oxWGrlMhZElX3pyItTTSy7il5iey33iAdPKp
         Wmmn2cGZ7fDoubYqqEDovozlVmw/8R1rCLSJJiQoJZlsbvD9bk7Dk9qKVK0ZFpbHl2Sn
         K5e+7S/ctMjCxOPPvx2A38OXlPsk20bLmVf/gL2KMqvlu1qkAP572BayhaoPIjAXYlWt
         iqZCK6OKH+XWmcfoOZ5Lb+DICOMmgGG9BLiBhEegzqmV3+Ato+nXyWztkIyFFV8E7yaM
         HRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5W7k9QjEAK1Hb5opkyjXRAO6gQtXIxhKlWPQXzaW3A=;
        b=SkcNBD3glgY3CZ4y+EE4EAthY+/s2LeJV5qhSa+VIRokNvnX2fYhox1kO8KLhyL6+p
         /MU7lGnz/HIrNp6OIkbg1OslRp7eZvUkuqZZcxGjHaic0snpo2VLhF/jtI6ul/HZAdJq
         xXck40VdOf+OO47lYddAm80Kia3mky0WU0pXtTG7ha2srGmLND6HNCMvXpobqn+qW/nY
         8rxfNaZa3zIKJITYNmQUX+sS+YFBqTKpx+VQHZdyJcaw055VdCnMriz4qf9w0hkZDbAa
         AOqVdZW42jbeyoPvPWEidEVN4r0g/+yfGLmkdAnCzfHVVYZ2uT5cjTZq0JJtoJMoTe3f
         MxFg==
X-Gm-Message-State: AOAM530h3wrVnL2w7o3M5k29nbBw5Vkfp5ZppRhFY9wbfEab7Ge0LPPb
        g4+NW1IPCgeAh9tQMff5wDkwM9sZAcWWSg==
X-Google-Smtp-Source: ABdhPJxPSbmqQCClDMgu5dTqjEH8UzAMRPVAgKLkFIS0jvoXSpUBLFsDXFhbiC1g3MFoByrRLH1iWw==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr5191821wrn.398.1625225219660;
        Fri, 02 Jul 2021 04:26:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m18sm2763887wmq.45.2021.07.02.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 04:26:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/3] bundle doc: elaborate on rev<->ref restriction
Date:   Fri,  2 Jul 2021 13:26:55 +0200
Message-Id: <patch-3.3-6d8f2f27088-20210702T112254Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g49a94b9226d
In-Reply-To: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com> <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elaborate on the restriction that you cannot provide a revision that
doesn't resolve to a reference in the "SPECIFYING REFERENCES" section
with examples.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 47 ++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index f5430029b8c..9a96afedaf3 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -145,14 +145,45 @@ unbundle <file>::
 SPECIFYING REFERENCES
 ---------------------
 
-'git bundle' will only package references that are shown by
-'git show-ref': this includes heads, tags, and remote heads.  References
-such as `master~1` cannot be packaged, but are perfectly suitable for
-defining the basis.  More than one reference may be packaged, and more
-than one basis can be specified.  The objects packaged are those not
-contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g. `^master~10`), or implicitly (e.g.
-`master~10..master`, `--since=10.days.ago master`).
+Revisions must accompanied by reference names to be packaged in a
+bundle, since the header of the bundle is in a format similar to 'git
+show-ref'.
+
+More than one reference may be packaged, and more than one basis can
+be specified.  The objects packaged are those not contained in the
+union of the given bases.
+
+The 'git bundle create' command resolves the reference names for you
+using the same rules as `git rev-parse --abbrev-ref=loose`. Each
+basis can be specified explicitly (e.g. `^master~10`), or implicitly
+(e.g. `master~10..master`, `--since=10.days.ago master`).
+
+All of these simple cases are OK (assuming we have a "master" and
+"next" branch):
+
+----------------
+$ git bundle create master.bundle master
+$ echo master | git bundle create master.bundle --stdin
+$ git bundle create master-and-next.bundle master next
+$ (echo master; echo next) | git bundle create master-and-next.bundle --stdin
+----------------
+
+And so are these (and the same but omitted `--stdin` examples):
+
+----------------
+$ git bundle create recent-master.bundle master~10..master
+$ git bundle create recent-updates.bundle master~10..master next~5..next
+----------------
+
+A revision name or a range whose right-hand-side cannot be resolved to
+a reference is not accepted:
+
+----------------
+$ git bundle create HEAD.bundle $(git rev-parse HEAD)
+fatal: Refusing to create empty bundle.
+$ git bundle create master-yesterday.bundle master~10..master~5
+fatal: Refusing to create empty bundle.
+----------------
 
 OBJECT PREREQUISITES
 --------------------
-- 
2.32.0.632.g49a94b9226d

