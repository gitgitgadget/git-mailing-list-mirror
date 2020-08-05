Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113CAC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29AE22CAF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1/dd40A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHEVv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgHEVvx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:51:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259FC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:51:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so7781917wma.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tx+R+LPXT+fwJZibIA4ZN5AmqEODGGIiyerNaCjUIyQ=;
        b=s1/dd40Axp6mD8oa1SsxZa4ODrpuwEnX1sNPjrg6QPSztA736Cv1+ARFlG62itAG0v
         Z6/0mxEEjKJPD+2Yw7vp99StWQGjjKrwMkmsKVia72E5BIUDi8MbYYbNaY1+sycf2PXk
         cZcROPw5LGuoX18wXXTHqJ7lO8M24qlPv9xLaUbA6FCIirdayIzDwovr9tGWvyaJRJgi
         u+ZyJFTr/ALD5WotCej8lSYJKqscs51k6PJtb/C2TJrVm8uy4uRZ0RAu69hKU7DlsmBy
         lDf4GPPpGaMn2/jMwNK+5mNdOAdewtwj/FI0ZQKb10T3Va93DzCpCa60LgZNWsARl/1W
         T3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tx+R+LPXT+fwJZibIA4ZN5AmqEODGGIiyerNaCjUIyQ=;
        b=EBmDqAsL5uKn/A1XlnZL3PVVTKghmIA8YURrGWlelNhkrfC/MFrUmvlKk2pV9Xt2F9
         dZmD5/iuHjgyQlod5UX9/OcvJSgIWpCegoHZsNomEXOgPYtbjRFkU0uQVMKuaQgTRPDI
         5/YJ4y3x5TReKxeI3wXpqHV3qNtXS26olW1ngRoQQfdAXljdbvEgwfZ5W7KRHv62Hs9D
         vIVB4bzob1TAyht+KhNADLzw0GuQERmdjFSLUESLTCK9RrJAEL2xsGwMduphfTevHzcQ
         9el9bVteUFI1CNa73IpO7KQhXQa7VUjhk23GNV0TLp6BDaYelx4L96Q6jgwPjeMCbnPV
         8oZg==
X-Gm-Message-State: AOAM5335b25ejTSStqZzn97YKPgJqj6edOBLfcgatetOsspg3n05Ax4A
        6sXftY5oJTvas/X1iq4II7H+lcCY
X-Google-Smtp-Source: ABdhPJxRyjvBcoACN7TIT5ZA9RbQUwx1TnFadEdDQvy/MsRj1efSC42J98RxIIvhhEOncQ06toyi6A==
X-Received: by 2002:a1c:6002:: with SMTP id u2mr4933447wmb.170.1596664311260;
        Wed, 05 Aug 2020 14:51:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm4355834wmb.12.2020.08.05.14.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:51:50 -0700 (PDT)
Message-Id: <65fee332a3819fcaaf557d4c29e414350e62c5db.1596664306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 21:51:39 +0000
Subject: [PATCH v2 3/9] ref-filter: modify error messages in
 `grab_objectname()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

As we plan to use `grab_objectname()` for `tree` and `parent` atom,
it's better to parameterize the error messages in the function
`grab_objectname()` where "objectname" is hard coded.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d078f893ff..4183ee2797 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -372,11 +372,11 @@ static int objectname_atom_parser(const struct ref_format *format, struct used_a
 		atom->u.objectname.option = O_LENGTH;
 		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
 		    atom->u.objectname.length == 0)
-			return strbuf_addf_ret(err, -1, _("positive value expected objectname:short=%s"), arg);
+			return strbuf_addf_ret(err, -1, _("positive value expected '%s' in %%(%s)"), arg, atom->name);
 		if (atom->u.objectname.length < MINIMUM_ABBREV)
 			atom->u.objectname.length = MINIMUM_ABBREV;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(objectname) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized argument '%s' in %%(%s)"), arg, atom->name);
 	return 0;
 }
 
-- 
gitgitgadget

