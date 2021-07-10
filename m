Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D401FC11F6A
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977C06135E
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhGJNkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhGJNkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A47EC0613E8
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d2so16560069wrn.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyIFa+yysCsDInB7rQNvnAtkSlqxwlBqPaHoPa/Ivn8=;
        b=IfwwftglxICB+ayKbkY63ruKIQqXPt8vchvzOJO6em9cBA7LG43/8vnOoSFUtfqhdT
         /6wDWKAvqbTe2hdZCsPhzJiNSET+CsgiyU70KgdN7A78Cfg/cuH6ReqHJrDdxnZFsfq1
         CONrdnEiZcmbr3Q9za97SUNSJ3/FHx2X2AVtSzeBp+KpSDmIfDIltfjoZKCeRvrHqAkb
         QQ087MQy3vxpnQDKC6tCFVDhLSzefhKMay+b9EMRUuR7dRkmbFzSi5XrH4PJXM68urYa
         5r1fUT/vghgmgUQCJ21QiXhSCMRdN9K7YzTVvEcxI2kbp4HAwGPm60XA/CyhgVMb2XgK
         pvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyIFa+yysCsDInB7rQNvnAtkSlqxwlBqPaHoPa/Ivn8=;
        b=oBWSc/VGAMKCZT5gUw1UFKOnZ8GXaDROkffL0TBMJ9x3qu3c68FD6iC22AzPDAM2ei
         m3kjo4b+45IPZwTN02785J103Uz8vhRqm/tdNJnq1c+QmlDfHGDeknBFqnF0yuSUgB8T
         7GK47Bir05U4olIyRxe50lBH993FdnTbmQVLb+orl1aK3h+UiayFTt+PkKewa6AMd1YR
         eyVmdU0OYgmaWW7uCTZ2veMxx70N5LjZ20VZD7He5fvd6FRYi0+D/ax8WYBWB6Bf6O/9
         OmJ/PKvVvCaxtNyJ4cF2QmMqYYpngBPIE5jZdws5wWHvrOOPCNf4kiNL8VK0Wjnx15KW
         p9yg==
X-Gm-Message-State: AOAM5339WryEK2CxKuCZsevb0mUSjXDJfCGluF8t4tcGU4LRP2/GMJuW
        AIz59Yq51LQJMgAdUMDV29ErGS5ayg0t7w==
X-Google-Smtp-Source: ABdhPJwj+DkmzPCqtjyN1NwM+Z0kmsCvNNMjZ2BReRxakcDGkzTD53rI9xVJbXzbqYjGuIcScZbpkQ==
X-Received: by 2002:a5d:4089:: with SMTP id o9mr7216100wrp.274.1625924257027;
        Sat, 10 Jul 2021 06:37:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/21] object-file.c: don't set "typep" when returning non-zero
Date:   Sat, 10 Jul 2021 15:37:12 +0200
Message-Id: <patch-09.21-e9520953956-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
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
index f233b440b22..9210e2e6fe4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1480,8 +1480,6 @@ static int loose_object_info(struct repository *r,
 		git_inflate_end(&stream);
 
 	munmap(map, mapsize);
-	if (status && oi->typep)
-		*oi->typep = status;
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
-- 
2.32.0.636.g43e71d69cff

