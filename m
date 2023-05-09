Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52922C77B7F
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjEIAoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEIAoK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:44:10 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53416188
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:44:09 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-38ded2d8bcaso2962392b6e.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683593049; x=1686185049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFJ+p8tOTy270hdJxBpEn7dvYHCTDRbvOCibg0nhmTs=;
        b=SL/ln81LDL48a2yQZV1wcinR915RdxiDlIhD8mVWnmDo4fefs3O9hMoaslknFE9AiP
         Hm1zaaPjJ6wMVyuvg9WlKIXX8+J6WRZ6kwqaARr9ACn6KjLGe/xQafhuZt5qvv51OasB
         91s1F5uOoeN+egsZNLWjuq3U4ZbEUzeNIQc4JuKwFptuYsd5ZNc2bgsKXXsAvTa5tNni
         8FugPvk9PHRCsTzKc6kkhXxHBN6RX795A/Iok89olMUlUbI1UmXetKeCpqdP4i69b8i6
         IPir0fM9eCFqAA3E3/68qXX+nSq9O0Axwh+Iu3Kj9Jj5HB2nXq9gyjqE2v2gdX60qVk4
         6Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683593049; x=1686185049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFJ+p8tOTy270hdJxBpEn7dvYHCTDRbvOCibg0nhmTs=;
        b=N5aIXb9eumOu/IkWRe3u1UUvBsMoxU443cb3yFpCDipDWRiBfSt+cn0FqU207VcIfW
         H1mQ8OepvTAWXpg1+IgrzuAQeeyIyZRvqxayVvop44lIF8MxJyw4YcsFmhWXBrHiG9Y7
         sAjlkKBrqEutD5GhHhUYA/1jj0V+rZT0WO5G/SZMkJD/kji3+FNeeN8TpKd4OeBs2iz3
         Fhw9KDtomkMMYQnsPEDnkwT20om84g27g8si4XbdlKPrYXpUXls/ord/0nFbg6/CjKfj
         QlIy0KmRgqu6Zac+b12Kniba4dyz2gisTfgilaIvwjb2NRdzjFa9KcnpsX0MTtp3oq5B
         6GMA==
X-Gm-Message-State: AC+VfDwluvNfGNh1eJReA7ujUX0GEeUFaghx82mnxaxwRmFbHEnbs986
        +C4i7Smm7oz5u8bvdW54kZQsZPxowtc=
X-Google-Smtp-Source: ACHHUZ5w//rKW9p6lNrSRXdUGQD8Upd8dUD8XM0SOSTCZViOEOwf47kguSHbdzsbWHdBC4OlbXGBJg==
X-Received: by 2002:a05:6808:3a8b:b0:388:fff3:61e6 with SMTP id fb11-20020a0568083a8b00b00388fff361e6mr452828oib.38.1683593048831;
        Mon, 08 May 2023 17:44:08 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i1-20020aca0c41000000b003908004b37dsm597407oiy.26.2023.05.08.17.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:44:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 1/4] t4013: add expected failure for "log --patch --no-patch"
Date:   Mon,  8 May 2023 18:44:03 -0600
Message-Id: <20230509004406.1786033-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230509004406.1786033-1-felipe.contreras@gmail.com>
References: <20230509004406.1786033-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

--patch followed by --no-patch is to be a no-op according to the "git
log" manual page. In reality this sequence breaks --raw output
though (and who knows what else?)

Add a test_expected_failure case for the issue.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4013-diff-various.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d19075..f876b0cc8e 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -457,6 +457,17 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+# This should succeed as --patch followed by --no-patch sequence is to
+# be a no-op according to the manual page. In reality it breaks --raw
+# though. Needs to be fixed.
+test_expect_failure '--no-patch cancels --patch only' '
+	git log --raw master >result &&
+	process_diffs result >expected &&
+	git log --patch --no-patch --raw >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log -m matches pure log' '
 	git log master >result &&
 	process_diffs result >expected &&
-- 
2.40.0+fc1

