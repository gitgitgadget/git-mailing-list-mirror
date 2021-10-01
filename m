Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5807AC4332F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFA061A81
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352989AbhJAJTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352944AbhJAJSy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8269DC0613EE
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m14-20020a05600c3b0e00b0030d4dffd04fso955205wms.3
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGq+Fn5V7JiiyfwcgQoial0GWCkXEXr+dmufABdvoos=;
        b=LWhugktxJLCoONLZvJ0E7OutrMAWccAED3TFIeEjZ/NWlxUKeBXlyPUhilnoKmB/8F
         8hxB0i+wc8N6xCxjgK3Za7gxrrDmNfvDov9Ec6aw/7Lc56GV6bA4cKGik96EQL5OVsFu
         M36hsK6bdoCywOM7T7xrG9efj2pSHlmeQMnmc0j+coCsHzslHIYGum1Ibp2nPEW1rFYZ
         gVanap3CZD6Y/ayRn/fQIQbkzusrxy8FbLZYo9+jx/TobJB6qh2Jy2kkQoKLoc16XpGc
         42I3h8QnlT9VVufdPjtk+pVyD27Qe+Wobt0wMZ1b7rjhvq1V4sS9LHY0VET1Smt9bb4n
         4Q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGq+Fn5V7JiiyfwcgQoial0GWCkXEXr+dmufABdvoos=;
        b=KugEese++/PgzAAmy86L+XwS6vbbl4LLSbniuklokwMVrGi2Qz0lU/8StKa9Fmh+MU
         Ep7Iq4PJC7sbY49gFbEsbFg6qWpl0T6b1+FxV0th4gc+vTGVIkflE/p2LIiMaW5BqGt9
         aqPuNrKLTZ/2zGp8BbIbB2Uoj4rK9l29QAqZVmzyAJl3IEuntGDunki3pujw4UGXvuI1
         9QdwTOdLEITHKZBD9sfPtNC53ogXdF3Iy0HaC6R2JxYvX1r7AHk9JHXucG3W3CSA3Pu1
         dpfgZkCiWfY6JoD/hmkYKnqaWrSFrLL0Ae2uCZksvZY5XjFD99zD5fO4NFGJv1jE0Or1
         as9w==
X-Gm-Message-State: AOAM533Ga/L3zk6HsMaVQLUW7UkMshOXMQrjBMmlTBxHwo0+JtZBXUcz
        VSUVUprZPVpWb/5VzdWi5QX1q6mzySgU1Q==
X-Google-Smtp-Source: ABdhPJwrB1epjMZ7cmUoocsjyWOfxZ6YHFukQQNQAGviyKkEJsLxRlnMVnzL+cutkHiw1xfbQtzAoQ==
X-Received: by 2002:a1c:7508:: with SMTP id o8mr3433010wmc.104.1633079825771;
        Fri, 01 Oct 2021 02:17:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:17:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 09/17] object-file.c: don't set "typep" when returning non-zero
Date:   Fri,  1 Oct 2021 11:16:45 +0200
Message-Id: <patch-v10-09.17-85a91f43634-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the loose_object_info() function returns an error stop faking up
the "oi->typep" to OBJ_BAD. Let the return value of the function
itself suffice. This code cleanup simplifies subsequent changes.

That we set this at all is a relic from the past. Before
052fe5eaca9 (sha1_loose_object_info: make type lookup optional,
2013-07-12) we would always return the type_from_string(type) via the
parse_sha1_header() function, or -1 (i.e. OBJ_BAD) if we couldn't
parse it.

Then in a combination of 46f034483eb (sha1_file: support reading from
a loose object of unknown type, 2015-05-03) and
b3ea7dd32d6 (sha1_loose_object_info: handle errors from
unpack_sha1_rest, 2017-10-05) our API drifted even further towards
conflating the two again.

Having read the code paths involved carefully I think this is OK. We
are just about to return -1, and we have only one caller:
do_oid_object_info_extended(). That function will in turn go on to
return -1 when we return -1 here.

This might be introducing a subtle bug where a caller of
oid_object_info_extended() would inspect its "typep" and expect a
meaningful value if the function returned -1.

Such a problem would not occur for its simpler oid_object_info()
sister function. That one always returns the "enum object_type", which
in the case of -1 would be the OBJ_BAD.

Having read the code for all the callers of these functions I don't
believe any such bug is being introduced here, and in any case we'd
likely already have such a bug for the "sizep" member (although
blindly checking "typep" first would be a more common case).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index be4f94ecf3b..766ba88b851 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1525,8 +1525,6 @@ static int loose_object_info(struct repository *r,
 		git_inflate_end(&stream);
 
 	munmap(map, mapsize);
-	if (status && oi->typep)
-		*oi->typep = status;
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
-- 
2.33.0.1375.g5eed55aa1b5

