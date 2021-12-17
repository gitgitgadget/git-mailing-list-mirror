Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21DFC433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhLQA0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhLQA0h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5E1C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j9so1059021wrc.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RP7Bd3gweCXiNlsCOAZqw/XcH4BcUlQKC7EwcuM8BpU=;
        b=Nb1tr1hebAkwZY2wvk1+5/LOSahwSMYEqUbSC8aptWIYgr3os6sfCKAUKLPl5M2ntH
         ntUIDfmPYotHF9j6CyJKW1nhbv0N+498kdNuv1o/u0ZE9ZzhYmZdgpxvS6SK7vNK1tgz
         e4E/li0JfQjBYiNMXS9sg7oyqyHtmiwpzdh6pEOYoEAvKhZicM3A0n7lJR8oemZGWa62
         6lRULFH8+ASa6PHbcml8gn8zzSRwmGnWiSe56y3WJciLDp4q6CZzn0S7Kj4e2laDA3fa
         l8B2Wv8K10FE1e1EEztOkEn+HUQoxJd3fR7uYjPU+3EdW+FcIIpffdbU6w1nEopXrhOS
         VrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RP7Bd3gweCXiNlsCOAZqw/XcH4BcUlQKC7EwcuM8BpU=;
        b=CnS79j3uGA9lGFca8MuwRrD34E/GiypX0+gQHTYulZtxvbr051MC0y7/gr7l56zykc
         7SHlzaWv8dP+ubBbn06RRkiKAaiArcMVB8DsuNRmRWDN22ASCFgUHCVbKPXn9ep9hhws
         UKdKeiFu0en5EmF0BNBDmQJPbkLPbjwONhx1VqiKHhiRRj4jxuD6GLoCzrNlYMR9Kb6A
         PvHArrQCxfGOcEVEi5Jwno6y/Ijo0gJ9DUi129/buEREBbwJowI2ydEYaFVMVnuDokpa
         +ni2GIbkbcEzfdXeqvXWHk44Ld145z4eAUAvm9BTxosCXyhLLdGjcIBQF5b5Kyn7P24s
         qH8Q==
X-Gm-Message-State: AOAM533oXvtB+/SYcyxe64oQnsv7IWz/m12xuXcqJKLNWlxKxRdy+BZp
        JmasU7tFSeqBOkDxIb79zV/nhyKs4wDEpg==
X-Google-Smtp-Source: ABdhPJwUr+XaIEs7UBjMNvoiKrODvGnVlVew/stLTicPLSzXy2kNUSR18yXdfZLlCsWAUj+PKI9X/Q==
X-Received: by 2002:a5d:5984:: with SMTP id n4mr334000wri.458.1639700794853;
        Thu, 16 Dec 2021 16:26:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/11] Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
Date:   Fri, 17 Dec 2021 01:26:20 +0100
Message-Id: <patch-04.11-5baff22f5af-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
2021-06-29) we don't need to guard the clobbering of $@ with this sort
of "mv $@+ $@" pattern in these cases where we're merely generating a
file that'll be used as a dependency for other files, as in this case
for GIT-PERL-HEADER.

We have had a hard dependency on .DELETE_ON_ERROR since
7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
2021-06-29), so this is a pure cleanup as a follow-up to that
commit. Support for the ".DELETE_ON_ERROR" target itself is much older
than any GNU make version we support, it was added to GNU make in
1994.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index cad9795ec0a..bd8cb7c463d 100644
--- a/Makefile
+++ b/Makefile
@@ -2359,8 +2359,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
 	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
 	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
-	    $< >$@+ && \
-	mv $@+ $@
+	    $< >$@
 
 .PHONY: perllibdir
 perllibdir:
-- 
2.34.1.1119.g7a3fc8778ee

