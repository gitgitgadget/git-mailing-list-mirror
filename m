Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD72C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A915760FF2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhFXT0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbhFXT0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68767C061787
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h11so7885098wrx.5
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9hj94EH6QgCwWKEPb6C7fqdkR2njbMaCg6A4qGDygU=;
        b=LKZxh3OftAthQ8OaGtLsHJ7PCHtf+gl+WaLc/EacbfEChBLXinK+pmU9rqGCBqQ9bf
         ysBj78K/zwPGhHNX0QGMqmgicafDrYBOS8+IWG/6jnnfx7HoUuM0pPAVlVXFb/MXHm3A
         CIzeU4H6F4qYSlaSt6a0C6bQvv8lUOS+MTg16v51xMy6awxEv/TmT+djHt2RzCkUNv1L
         jAZ6IXCfdmpgMbZ5K0W5y0T1vWFpUMyyQG6QbLzRn4bSP6fR4oaAiXmYJVNr7ANfmx55
         FMCzdP3AB8GEF9OtRfr0Ojgi0K91umtF4gUd3UZWE1ggVMkdDTUVGmIy54H/E6xzpTeS
         1pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9hj94EH6QgCwWKEPb6C7fqdkR2njbMaCg6A4qGDygU=;
        b=CZDL9MZAwuHiEJO97mT/9OVVbA+2XGOtIZHRr+NNEIT7VCh9Vu+8FCcndZm4RaJsFw
         NCQyRyUieLmWocGqZNy6HlUHZrT8HE6UwSQNWsnSLpXOEe4Nl3KoxWL9CfyeVncG2hvR
         csyKWl6wEhkNhkNNdruytVxvegQ0/6VnbtAMqVRzqasoBF+/s5+f2L5I/KNMOPB/bLBc
         HmgdGcTyHN7F6+gmRXA55w2qQ1orX34qb72+nUMGzlvcFmMr0vSkZ9JHcqa3CvK1azcq
         Tinzi6RGbDTvkc82VdMArxZlF4BTxQ8Q23zH4mwbu8k7gkZ7YC8z8WdtlpWLL0vreFlH
         MNjA==
X-Gm-Message-State: AOAM532uoOrZb5hrZvGsrXCl9RaA5nEfwBTp1PmEjQUssotDT1c9tNu+
        bl/Y6xRBil8cj1X9e8phZv4CRKEsRD0H5Q==
X-Google-Smtp-Source: ABdhPJyrk/OIbAXLVVfwapK67sclWPTWHNypM3pxuxLxXBhC9kUQPa4nuVQn4SuRSnG+4voVppGASA==
X-Received: by 2002:adf:9031:: with SMTP id h46mr6386137wrh.125.1624562651845;
        Thu, 24 Jun 2021 12:24:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/21] object-file.c: don't set "typep" when returning non-zero
Date:   Thu, 24 Jun 2021 21:23:47 +0200
Message-Id: <patch-09.21-54fb9189408-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
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
2.32.0.606.g2e440ee2c94

