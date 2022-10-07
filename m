Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57811C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJGJaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJGJaq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:30:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A5AE31BF
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:30:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so6347660wrb.13
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCm3WGvF9XGA2N853MNnGYeBD9JeHf6YfnlCoEZFwns=;
        b=msBD+9U0KG9WgWAQdgA0tw/nyRZoC8CiZDKqxEihxFaBooholBO5PuYVaPrbuudvQU
         YXNZtg69Lo/U+M17ias+l8PJSIiYbUvyv56DLJLS/DMO5VrINw0C0YxaXAD3wlxznsDn
         +rL8QdMrdOXS3u3mBy5uRXiCJ4hT2/MwSgjDS9pD9bDGuEjLduMbbQTfzCP81cBoYry8
         Wkk+PC+Obh9DH71i7ArYsyN+22/prO4SpIB9St56Mj4SaVqA1JucYBtHaHlOEcs2AeDc
         vzLj/pXPLRpyn/gB6zbopP2m2nC6WVx6hbP4zKLxq9tGeA7CyFxi82a9XmrN/NEg5IBE
         ISWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCm3WGvF9XGA2N853MNnGYeBD9JeHf6YfnlCoEZFwns=;
        b=Ga7eJrnljh27D/5MGjIbFIxyPe7bBW+O6OWqk6BK7fLVtCxvxUPaF03BfS2Aqr33r0
         FfM17AyY2TR9oT80b3vFwCp9c3h7rxohq5zsj0lAy3VHCMf6QfrtQa64DwzUvgR0us1w
         8DodIg6caeMUHLvTVZ/mufesmWzW3QOegRdfvOnl4hU1K9CDmIQs7NT7mWedSqIQeZPq
         acPeiCSRbXyavvCROnjTCeYyLd1CxNeCP/Aj7dST7C74huA1ad00UPFcQ0FCaQBBSyw0
         rRpbhbsVLcfVwbqVNFmyINPL+fxNp+Bhoq9oU90AqxJqB3Q9piyP9o/dl/wC3uMWDWUc
         03tw==
X-Gm-Message-State: ACrzQf0+5dOHLJFRSjm+5wRN2zgYNrcn2ghSqSZstzB/dJ7zkUrIeDkq
        44HMYN7GhD1olyW5un2aFXdeGJ55N4QG1g==
X-Google-Smtp-Source: AMsMyM5PsJ+D/S7Sl4n1a7v0OpmEjTK6uZcMlmd+LhXdO30Ce4tnDD5sSow5HIheSJ3F+x9WAc2XFw==
X-Received: by 2002:a05:6000:18ad:b0:22a:f7b5:16f8 with SMTP id b13-20020a05600018ad00b0022af7b516f8mr2572208wri.305.1665135043227;
        Fri, 07 Oct 2022 02:30:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o18-20020a1c7512000000b003b492753826sm1634945wmc.43.2022.10.07.02.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:30:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] CodingGuidelines: mention dynamic C99 initializer elements
Date:   Fri,  7 Oct 2022 11:30:31 +0200
Message-Id: <patch-2.5-343ec223dff-20221007T092505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first use of variables in initializer elements appears to have
been 2b6854c863a (Cleanup variables in cat-file, 2007-04-21) released
with v1.5.2.

Some of those caused portability issues, and e.g. that "cat-file" use
was changed in 66dbfd55e38 (Rewrite dynamic structure initializations
to runtime assignment, 2010-05-14) which went out with v1.7.2.

But curiously 66dbfd55e38 missed some of them, e.g. an archive.c use
added in d5f53d6d6f2 (archive: complain about path specs that don't
match anything, 2009-12-12), and another one in merge-index.c (later
builtin/merge-index.c) in 0077138cd9d (Simplify some instances of
run_command() by using run_command_v_opt()., 2009-06-08).

As far as I can tell there's been no point since 2b6854c863a in 2007
where a compiler that didn't support this has been able to compile
git. Presumably 66dbfd55e38 was an attempt to make headway with wider
portability that ultimately wasn't completed.

In any case, we are thoroughly reliant on this syntax at this point,
so let's update the guidelines, see
https://lore.kernel.org/git/xmqqy1tunjgp.fsf@gitster.g/ for the
initial discussion.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 386ca0a0d22..8afda28cfce 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -213,6 +213,11 @@ For C programs:
    compilers we target have only partial support for it. These are
    considered safe to use:
 
+   . since around 2007 with 2b6854c863a, we have been using
+     initializer elements which are not computable at load time. E.g.:
+
+	const char *args[] = {"constant", variable, NULL};
+
    . since early 2012 with e1327023ea, we have been using an enum
      definition whose last element is followed by a comma.  This, like
      an array initializer that ends with a trailing comma, can be used
-- 
2.38.0.971.ge79ff6d20e7

