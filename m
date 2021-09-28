Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050AAC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB8961247
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhI1CUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbhI1CUr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F95C06176D
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r11-20020a1c440b000000b0030cf0f01fbaso969406wma.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d564A1KdVdLFXzWwd5C0iHFxsjimTsWNt6g1L+VMLRg=;
        b=kNts406AnEVYFkvd1mlt00DI8foPV0VwSN5b76iSYCmKNIzxGg1iFqXLEJocLmqctS
         uuvGax1F7jblrOAU6AGopzNXtiAkUCh7NYMt+7iPFOu3JhSqV+FxB8Tsm1GOgu4du/fi
         L0b5JtuRHgDW5RhEFycdklGVrc6z/UGheD2DQIv5PeXFvdU8BnlLW1GfpbQBnE3i7kFf
         1XhSe/CEuHRzrPbrxEpFjALI/05XxT/WV6PibDkq3hS7f8T+utr/4wRdQO8scFg1XCkr
         ONMUCK7bQAxY3UCcmzMi6aVVnGhDevsTqwZN50U7uqX1k5zgA/3D4xDWpDeBvRS3/JK5
         P6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d564A1KdVdLFXzWwd5C0iHFxsjimTsWNt6g1L+VMLRg=;
        b=vJ1OZ6u1gJerZRC+WHVwHO+LpjrjcLGSLSge3C2wD4GtXGoV1dxEOXA2m2oNzojN5q
         19KTqRlOl3//tgC/xTQFj6sFoIoDy0zY/fGAKIGdE7gruZ+tSMiq8nhnHPWd1U2RP3o4
         RWuCT17nMis2T/sR0YwP4tI+f0vFMv17RMOSzZr6TinsJQGjWqzeoY8lrJHkNbE5dVj/
         3G5vgSGOUrfBsRDSfrXyyrPuifSAfBRGLXNU5EpaKa0LDaGS5hfP2KgWxgU43+wBJpL1
         LySyoIZbcF0aId1UsgGiexKQExgY7a0+WVgC7PmdZQl2rIVyq+zPrMnnyg/Kf4nf+0Dp
         Lafw==
X-Gm-Message-State: AOAM531s6+qZnHfGQW2Htkq8f/2D/7gHrHq57BG2PKzdtNUSf/odwuts
        ilC24pXJpJvqyNR0pXQ1NnIOKiBu83SFwQ==
X-Google-Smtp-Source: ABdhPJxJNBCrLikC57VMS9aKSQBWS5iUhT2gmAHHhpb1AjIC19DjNwInpPxbK7ItTV4Imj3BS0wpOA==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr2185260wml.9.1632795547019;
        Mon, 27 Sep 2021 19:19:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 09/17] object-file.c: don't set "typep" when returning non-zero
Date:   Tue, 28 Sep 2021 04:18:50 +0200
Message-Id: <patch-v8-09.17-3e1df3594df-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
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
2.33.0.1327.g9926af6cb02

