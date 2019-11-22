Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C657BC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9B12071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoJ1RetG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKVTAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36031 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVTAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so3755075pgh.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T95xFhHsh+zcKjxBMztB6pLSroRFp3u6GpR6QAI0pds=;
        b=CoJ1RetGBT+h3ROLubDDbqZ4fOV6m1TSj01D4pGl9evFFiTga7+REHBzQzXIFQl++m
         nasdU7wT8HHIvTgnbeN0GCaoPJj8Cq/pZ2hcyjqTasRvtig6JOLYdAMSVZ8KqwcOND/B
         As4WizIUighPuQXLIY736bdlu7tDKOfqONYilL0Qdpjixi8FvOhOUq2gk4+d5hz9WWw5
         q78KWlSVmR1XzHUmgFLAJSVo8IQYphOvq39faMXj4rwmqPQRpklizYv0BnBgER9DmxHM
         5KFOKcrfIE9jJ1hZjuO50El+3SVfXNkbLKe4DR0njnpQJjzV/bSxmPNbOQf7QV4qpfMC
         fDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T95xFhHsh+zcKjxBMztB6pLSroRFp3u6GpR6QAI0pds=;
        b=NW/sMG5YG5GsILJBKMECQki0uTnV7mX21BeW8uB8W6eb0B57PXdB8H+M4ORxSqC7Wl
         qcbaQc+ArzfAol5Pi5GzyU14muXUO1/RBCS8PlLkPdsih/XNF8nEn/+HfRzC/T3D69Nx
         rrxEJDOcjCJX3xAS9epkog8T+LuEZyGCrripD/APCiiaOnRicrGObcvgkq3A2D6OphEa
         R/xE/zBRjiUHw/PqpmOlfPG/CYcFTBFrPWeZyi0zxTZUSjKnAuxdYz5OKuabhBgxONJQ
         TqvcyZyhTPRN81bdKeorhBnseu8fnPa8W2wexTDgYEga/I0HfWgqd4oPFEGKsOrGjZAs
         TazA==
X-Gm-Message-State: APjAAAWbOAx/DlocRm6tyCm1p8kd85vLXy4IZOVCNdlJJJhYK+dphDQ0
        VrWV2iO3NeVdBhJWxG7xWrB1ADVD
X-Google-Smtp-Source: APXvYqwvQ7ydbsVOJwUUfuyJfzphHwIkgCGJdQoiEkXtffGs6G8bNgtJAeTDMVrPMSHQ1HCjFvzNZQ==
X-Received: by 2002:a63:5551:: with SMTP id f17mr17069806pgm.287.1574449198824;
        Fri, 22 Nov 2019 10:59:58 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id c6sm8555934pfj.59.2019.11.22.10.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:59:58 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:59:56 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 06/22] t3600: use test_line_count() where possible
Message-ID: <658db8866e2bf8daf6cf8d75c785f10fd016bdfb.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we have a helper function that can test the number of lines in a
file that gives better debugging information on failure, use
test_line_count() to test the number of lines.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 8c8cca5bfb..f6e659b7e9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -113,9 +113,10 @@ test_expect_success '"rm" command printed' '
 	echo frotz >test-file &&
 	git add test-file &&
 	git commit -m "add file for rm test" &&
-	git rm test-file >rm-output &&
-	test $(grep "^rm " rm-output | wc -l) = 1 &&
-	rm -f test-file rm-output &&
+	git rm test-file >rm-output.raw &&
+	grep "^rm " rm-output.raw >rm-output &&
+	test_line_count = 1 rm-output &&
+	rm -f test-file rm-output.raw rm-output &&
 	git commit -m "remove file from rm test"
 '
 
-- 
2.24.0.497.g17aadd8971

