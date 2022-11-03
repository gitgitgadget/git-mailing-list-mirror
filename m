Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E152C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiKCRH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiKCRG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:06:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF7CBCA4
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v17so4026403edc.8
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEW/4gGrX+iEFxTwmfzkfV0mp35TrWzrKGarHcFnxIU=;
        b=MRC6+17qvEVHP7OfmVHQl3MSUbM/1a1j25hSAmrmuE3NlVAsn2eSLmQswQrVyT6mXi
         cR89Fo2Ejole5MZJtJfkK1DFU8MmrK1RoH6u8JB1+S/ITJuIYVHTtZhL9XBoWZgOoZAh
         IobZA5di4EAxl6t1kE4+IczP/rnG+B9q6uv2BmF4orJBHfSgBQkSg1szBAf0eh5QuznY
         efBbNFL3xJjbt90WeKae7061kjuQnfGDJfwQURAHK0ck+/KcIX94gaAhH4PkQfMsvMdY
         qPjxDpNYHO8vPS9Zh1+9rT3q9T5xieH6FsGw4vldKWF25CdascTOvOiz8PYm4G9aWjLb
         QRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEW/4gGrX+iEFxTwmfzkfV0mp35TrWzrKGarHcFnxIU=;
        b=1VQyO0XK13XR9cAFJEESfgmjLZSl080NfFt0mbHQlHbwOcVSYVVhaE4w4ZcL8ieY1V
         /Zc4nq1S4wOPqRCquZHDWYARVr+MeZ4D2nVPoGpGsaA22LEYq39HvcZ4kZITJcHiUHlC
         lvL0Pl9jTuHuM82mgFaJ5DdLmI/CrkmAN62EMYNSVr39CpFfXBYQmZfHbpzXvNTc2DHz
         hRLKNTotVRvNIesgJd/HEUlA5gnqCe78/0HjOBPlnQIpd61cfUyLYBJ9X8TUFNRAI+MX
         vrif9zspVwSIdnARYkHGtwYHl4L3xmWtdp8VQXdt2E53ulFqMN3VRcUlqlaSxA30RhdS
         q5eA==
X-Gm-Message-State: ACrzQf2ctcAr0RSCLWRMlWVVD+Uzjp1VjLYa9p49Wr083FfA/9AU4Mw6
        1EXt1fjmJbdIHWWucwCqA81vWf/2yAA+bw==
X-Google-Smtp-Source: AMsMyM7o6fTgtDCTjX+AtzBBgYlwxQHUifjkTVduzN7hLMl8HlDc2QcB5nCIAwPlvhKd4cRFHJquuw==
X-Received: by 2002:a05:6402:b56:b0:461:91aa:11b7 with SMTP id bx22-20020a0564020b5600b0046191aa11b7mr32002211edb.220.1667495181620;
        Thu, 03 Nov 2022 10:06:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/17] {reset,merge}: call discard_index() before returning
Date:   Thu,  3 Nov 2022 18:06:01 +0100
Message-Id: <patch-02.17-819fde89a24-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two built-ins both deal with the index, but weren't discarding
it. In subsequent commits we'll add more free()-ing to discard_index()
that we've missed, but let's first call the existing function.

We can doubtless add discard_index() (or its alias discard_cache()) to
a lot more places, but let's just add it here for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 1 +
 builtin/reset.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729d..a6698adbfd3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1794,5 +1794,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
+	discard_index(&the_index);
 	return ret;
 }
diff --git a/builtin/reset.c b/builtin/reset.c
index fdce6f8c856..69f18a248ee 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -481,5 +481,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (!pathspec.nr)
 		remove_branch_state(the_repository, 0);
 
+	discard_index(&the_index);
+
 	return update_ref_status;
 }
-- 
2.38.0.1451.g86b35f4140a

