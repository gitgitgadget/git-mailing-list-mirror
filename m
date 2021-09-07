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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E6EC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFF060F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbhIGK7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbhIGK7r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314A6C0617AE
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so3018699wrb.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APCotmmvl/QuUQPDEWeqTOs86uPhFRGzdbGzhIi4Mok=;
        b=SyhaYBAKFN0jj8jpGz78vWhMfZ+nWYIG//TR6sW19AvaXc8kdPa32YvG6LV8Mm0G71
         rC2FEYXntzfvWDDov3W5zTkTolfvuVyx4LeEWjvj8VQ81PSYA03zmvdOwgeZDAOs3PA3
         AY63BzyZ/sRrURclJ1/y0RH5Lb91l2fH0W183a0S5EGHuKNK7RunCprDHMyE5siCMa5e
         BraRTAH8KZIALYu+RiEt76CcrS3gqsBHhtmJZTYtpk6troiS4a7KzuLXhmwsK3KRC/Qr
         YHEoDxfBEzAlBA5EOzC2LTiecedx160EnfFLXgHnJRMf6v1Ig70Nl0Z3k5F+e006z/eH
         JCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APCotmmvl/QuUQPDEWeqTOs86uPhFRGzdbGzhIi4Mok=;
        b=n9hIcJ1dWv4h7eUczj5/OATRPpWK8TTs1aYAzQkE+Zbq03dnt64gPRR1TptT2XaNti
         CyObwS0/cfJ8zQ7c9RjsXtcFN4Urlyb4ZDy0ypMrIFyExmxARnJddW5r9kb+/eLpJolf
         WqWagnUEyFh1WOXTzM8BD4lp0s6dZQDleJd2uTNDzQuj7kqscO3ONDz+JfBGt7dH5W5T
         Hm70hlkhaY9XS3VmtwqPpoBpRwO0QymSRmPGP/Id3aF6AhQSVMg+jipSaVeEj1dUuyTH
         tNhXLKBMDeG7pQUG6MU1zpEZo3q51uKe9AsrQo0xzSfCZVBjKIxPgpDGUXOYjdJPmpnT
         z6Ew==
X-Gm-Message-State: AOAM530St8bGP9wD6pZm4Xty0NrWsKZuXMJwCL0uRCJla8EWnmptSiIC
        YCOS8RAN4OzJCcypFl+9eZAmWrjdDvtH+g==
X-Google-Smtp-Source: ABdhPJwurOIxFUA/yZ7Fo7BfFWI156dJMwKwUsPh2Ld1vFerWj69/56XZgnt62wjCUZTkcwF5HzgCg==
X-Received: by 2002:adf:ea4d:: with SMTP id j13mr17970987wrn.86.1631012311500;
        Tue, 07 Sep 2021 03:58:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 08/22] object-file.c: don't set "typep" when returning non-zero
Date:   Tue,  7 Sep 2021 12:58:03 +0200
Message-Id: <patch-v6-08.22-38e4266772d-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
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
index a8be8994814..bda3497d5ca 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1503,8 +1503,6 @@ static int loose_object_info(struct repository *r,
 		git_inflate_end(&stream);
 
 	munmap(map, mapsize);
-	if (status && oi->typep)
-		*oi->typep = status;
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
-- 
2.33.0.815.g21c7aaf6073

