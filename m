Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB0AC43215
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9901B2068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyAFGbTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKZBSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38017 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id c13so8304980pfp.5
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dxh2jaW1UxAziQYQjHScRCLmQiudoN4gja7P1jegEhY=;
        b=ZyAFGbTKLYom51/mqkON7EbcGao7UPLmilGW3uG0nwQm5DU0+kX8kAX0eKVra74JqZ
         5STzd7fajKqGxPmZY3wfduJVIM3XC+Ied56PRKzIxq+ND41ii+Z9aFBx7JpxhckwxiCI
         ZNBM4ZNvsz3rZz7qlLjjfbHTppTnFFdyDgP1HBBpXzWa/CVkX291+TxjOo3AZ2ukXI+r
         W6AcJdGF8EZoXcPgn3NroeCgr97gf2LqvLpahTuWgRjpoOfmTWzewyyPH51IfUUKH5Al
         XGwF0qnteRHycwYVcg8n3l/JW3Af73WNEdrI5GBwtlPSROF+cT8cAVOsM8yCmbISLlnp
         gO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dxh2jaW1UxAziQYQjHScRCLmQiudoN4gja7P1jegEhY=;
        b=ctGZpISSKdb5Ga4RhYxe2VB5YvknfQHlDJeIs/BxOFy9tRByYZ2xJdHnVnQsrkAvQD
         9ThqA4lIcqyuUOXdYxil+hL9L5i1jO1dg8bu//AvIQWSxT/Gl3IVKLUM/tqnBQ+F+5Hi
         td1R5cZteRtLt/3ZkDRi9EIkEmKrrSewuxl+hKpAmHoBsSQwUtT0kh5PJ4SLZ5jrQ/nP
         AF7fHAtALgJfn5Jc2fo+UU8z6qpEoGv5SPw6mmCmzCLmIqbewAMdSV7IdO/zZkZYVDtZ
         fOSpjOMAgOKRMkCcKlKlqEjZC12KB6JitrIHYWMBkT1/eLohVQvA2BhQaIHy5D15EH9V
         wl+g==
X-Gm-Message-State: APjAAAVt7/GVs45D1a9yL6g/EyKIM3HZEXS7AdygILmEH1R5i/AfVhdI
        Kb0IJ4TYNHUW6/wYOSjgnKbTSwer
X-Google-Smtp-Source: APXvYqy1dcMmLXHbNxbJx2yF2G62Wba1wAdl+/5mY+jDVm64fBmJXoMcxrNXmT68b9eWAfvhg2zI1w==
X-Received: by 2002:a63:1b1b:: with SMTP id b27mr33010266pgb.402.1574731080727;
        Mon, 25 Nov 2019 17:18:00 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id k13sm9845091pgl.69.2019.11.25.17.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:00 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:17:58 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 06/27] t3600: use test_line_count() where possible
Message-ID: <d541a8d4d4b8fc224fe1967ce5717d70c0f2b55f.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
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
2.24.0.504.g3cd56eb17d

