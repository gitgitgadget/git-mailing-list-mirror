Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAE5C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D240611C7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351697AbhI3Njc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351647AbhI3NjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A34C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d26so10114564wrb.6
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HaEnrTf+WYDy4A4BLJ+sYMdCPrP7roJKnxUMEepScV8=;
        b=fiSXwQosWLTRPKN5qFxnIrGg+dV2siRIIt/glA9UCwiTf6MjH+uJJ8DoAEprwu4Wva
         6By3lCPAxG7u+QnEkTpeVUAcu939R/K2tRhqkEAFTU9QXot5wClSJY5/bKcWyR1+LJCT
         xhJl/duYfZicW9ya4K81ri7UXtO5hen/R5OZMQfFp6ly0A/lpOigiVQOfxk8SS/xuiTo
         s19z+D3Wtm72wafjTdHp2tAOVTfxNQCgiCA0Q7WA6Uzg0EEkAsdKfVViHCn79WJjrVu8
         ner4DXP2BXP8RB/1IzIiUQ+kfHo81/Jnhp1fW0U+JXgVuvVqFSSwgAghtP0uc5p3j+8Y
         y7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HaEnrTf+WYDy4A4BLJ+sYMdCPrP7roJKnxUMEepScV8=;
        b=tjv+8DapaTVD9uWdPszN4F36uYyWbgqD04pE50BgGc3aOHzjt3V4BUNmTBtanvt+B2
         0yq7KkaE6hCYvnLdU8FcsAwaAg3Dp8CiRV1i8Y0Z5LlirDY6mlPpNZRk19ioizKwzu8E
         aAfUgLJ6B3bmDidbgq6oSFb0eHSJwRMqhdUafUdLUbBkn0gqflBkl2lrLRh0j3lzR7Fn
         7DXqWhdgRCrxuSMyZlhfsTstRJTkP9I+7HlHspuxyrNogiuuXgJGd3dVyZ7FFKJFq6lx
         L7xZeqf3fNTFNiQGSgAktN5MDAUJrpQrzv570QAAJE6t1tx9oN2tBiEOfXtSp0LX8ZaD
         9cdg==
X-Gm-Message-State: AOAM532Vj5/WwwJmgs5vHPq0VndskWOZVlVhEyIb/6TGOYJa2eAHTtdq
        CEnpNeDxo2C1GmBCqhORJN1IfakB7Qr1SczV
X-Google-Smtp-Source: ABdhPJxbXutpdghxXkMmKPr1WN3VO1d8fClbDZ3kxe4D9Z+TO0TpOlZLN9hjsAmku5QUUjbyCtoEIA==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr6164176wrm.95.1633009055130;
        Thu, 30 Sep 2021 06:37:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 09/17] object-file.c: don't set "typep" when returning non-zero
Date:   Thu, 30 Sep 2021 15:37:14 +0200
Message-Id: <patch-v9-09.17-6f0673d38c8-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
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
2.33.0.1374.g05459a61530

