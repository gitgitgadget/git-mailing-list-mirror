Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B0BC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95F4206DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf+8/HzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgGGWIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgGGWIU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 18:08:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16145C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 15:08:19 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u12so33003950qth.12
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhXg8JvGtG6taWedmcWy1zky+etyMqqGVZVoTekpSow=;
        b=Zf+8/HzJo7mePls+/El9Pnxk8AGDQxmZ0AHkBov/tTB3sK5Eb4immKjg0rSVZdm6Wr
         hqqLxE6CDZ7yExu0cXtzvbLg5IC3hi8VkXmJo+/QM7tCbDisV0EWQwbEL19XF2F5qBdn
         qPIEG3Q1OTclwNDHTmh6x69h52RvNBZHgKoCAIJ90rEPXodHsB8rEnAssl44OyAg8u86
         X6pvUCyVnUe6JvxfzlgrhSELLLa4seoPpTsaKGYQ8kXB/10jdgJXWJcuys+OX03Fq+ry
         VV/6IJWvWhjSwPHD7tlPIf6Z/Lct1sJIbk+0O0KXjANN8zEzSYuO2xB/BpJuJ48bZPxg
         QAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhXg8JvGtG6taWedmcWy1zky+etyMqqGVZVoTekpSow=;
        b=J8HhmD9krTAqDVflpzDJNqUEX5wcWc3NuTJJPOTxEr9T11m90wV19bgjNr8eKqPUMQ
         ECg4y3SG3YCUb388LxH3qhtWClx8dSzDT/qEvfL1hdM7anvaqRYyO3m6E4SFU7zt0Jex
         Iem4K21nm/eCFc5qo2uJQ9ByuMikn1nY4WTN7ziWjXFkA35Er6KT5ijdObAOhORUV4fg
         b3Lrh4LRkorPzHAejF+8rpAsQqTkKj1GdhfP1yLnKtp6ZFqFQJdjhJU0UTV3KbJ3w6nU
         aXjG0Cxz+j3kbvC5tvJLDIZn3zhUIZx9iNdF/HyDCXge/RsTEhqYs4BFQXvUCz9llN54
         bdig==
X-Gm-Message-State: AOAM531HN5npwuUY/+cTM5kLGJKxVNOrCVNFuGSTsVbiYYXI1OKXc0Z7
        VF4Y4j9XWd7MAReqM+L1kkfbYJKutdc=
X-Google-Smtp-Source: ABdhPJyPNLV/icXOTMS1uxtI2QX8TAPq58FWc5ISKrMvpdOkYWy0vufJEHLtHbO0fK7inSr9nL0mog==
X-Received: by 2002:ac8:1809:: with SMTP id q9mr51099973qtj.107.1594159698024;
        Tue, 07 Jul 2020 15:08:18 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id 73sm25775455qkk.38.2020.07.07.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:08:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9400: don't use test_must_fail with cvs
Date:   Tue,  7 Jul 2020 18:08:07 -0400
Message-Id: <4ca5e1f9c06ed509fc3165c550d0d665dd5b69c0.1594159495.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <xmqq7dvf3uwc.fsf@gitster.c.googlers.com>
References: <xmqq7dvf3uwc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are using `test_must_fail cvs` to test that the cvs command fails as
expected. However, test_must_fail() is used to ensure that commands fail
in an expected way, not due to something like a segv. Since we are not
in the business of verifying the sanity of the external world, replace
`test_must_fail cvs` with `! cvs` and assume that the cvs command does
not die unexpectedly.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Hi Junio,

Thanks for pointing this out. It seems like the CI systems we use don't
cover cvs. Is this something that we want to address or is it fine to
leave it as a blindspot since no one really uses cvs anymore?

 t/t9400-git-cvsserver-server.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index a5e5dca753..4a46f31c41 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -603,7 +603,7 @@ test_expect_success 'cvs server does not run with vanilla git-shell' '
 		cd cvswork &&
 		CVS_SERVER=$WORKDIR/remote-cvs &&
 		export CVS_SERVER &&
-		test_must_fail cvs log merge
+		! cvs log merge
 	)
 '
 
-- 
2.27.0.383.g050319c2ae

