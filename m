Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D98C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D222075C
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVfgBy75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfLFUQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:16:08 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35541 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFUQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 15:16:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id w23so3204295pjd.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 12:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PA9RcFV4ckgHj7Am4nFj/uTlBzaD3s4YTGvBQNOr2Vg=;
        b=uVfgBy75H8wemPWOx/gC2b5SwFW7lSoxAsDdpxnuUvvVEvRCPkcA2n7Pux8NBFZUce
         xNZ2IGt2a0L8bcOitI3j3cdZQHdQU0510Rrfm55ixcw3r9yXmE3hGbb+2YgZDxFqhmN0
         e+zgaFJxklXYjdq5MX6g+KsTfhDmLOY5UfpBLsXboio2ZCUa6a6lKQUSj2eRKu1DGK/Z
         yvlqqn2oulG+hJzzCdG46BrTqBkppCVSKRMOJ8gXWgnhsZ7PxsDuXLnWrxkp+/ovyJnO
         QGFZtq+6f0Iu7v9WmSq/PjsdJqtvF3aV4auikmIoDGX2NQj6/iIzvPWb8TM2W0z+feq4
         R46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PA9RcFV4ckgHj7Am4nFj/uTlBzaD3s4YTGvBQNOr2Vg=;
        b=Niqv56v//6o4fRC1Cx1r6IZa77BMrRQ9ylmV9FMTUJY13JnQFKT+npIy91/I6VUlNY
         p5Cm8e3yU+mqgJilrRmrCksM43VKBHFQ9ZBy7aNc7Mr7XXoX8/7fMmhYrA8Z5nLP9F6t
         s+lxNLIIFAnfhwL1h8Yx2iQqDZ801z2SxHv3MstRdIN419Oo3tGsTurll0cbXnPAZf3M
         +K0MpBAKw/lbOrBoGayPifWDsMXjqUyRQ8yxyzGdVpruWSedklOpNAvWsy343+6yEVb8
         jGF0zMjIzDE5Oq0etZE9YJtpv1Ivlo8F2ipze70DBjA5FmGkgvBvYvh2jp1Fh8frLtDv
         E1yA==
X-Gm-Message-State: APjAAAWkw0kNkmWI/0k4pVntF2n/ESh1xsp8Gwn3KuGrolVc9O4sBmZO
        y9c+Nr3T9WWo+Hll0HeD5UzB/Fco
X-Google-Smtp-Source: APXvYqwsrG1vjBByOqbTuhNn10eE5icjyeRSpEWONWcmeuKyP6c9qG/PHwtkHYXfNmYYZwCcMJJAMg==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr17091327plr.16.1575663367492;
        Fri, 06 Dec 2019 12:16:07 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id b65sm16967307pgc.18.2019.12.06.12.16.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 12:16:07 -0800 (PST)
Date:   Fri, 6 Dec 2019 12:16:31 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] range-diff: clear `other_arg` at end of function
Message-ID: <a2bb9b74184a1c09b416d70c14945e336f6e717f.1575663345.git.liu.denton@gmail.com>
References: <cover.1575663345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575663345.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were leaking memory by not clearing `other_arg` after we were done
using it. Clear it after we've finished using it.

Note that this isn't strictly necessary since the memory will be
reclaimed once the command exits. However, since we are releasing the
strbufs, we should also clear `other_arg` for consistency.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/range-diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 98acf3533e..d8a4670629 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -84,6 +84,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	res = show_range_diff(range1.buf, range2.buf, creation_factor,
 			      simple_color < 1, &diffopt, &other_arg);
 
+	argv_array_clear(&other_arg);
 	strbuf_release(&range1);
 	strbuf_release(&range2);
 
-- 
2.24.0.612.g9b7bad38f5

