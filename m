Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADD1C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1545208A3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKq3cOeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfKTVSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43745 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id b1so347335pgq.10
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9JcjKWIXUSWNVVmoQmQ1LIzYLPl7lzPnh8XZSuGo5sI=;
        b=RKq3cOeu1dMBNfwRhWrhs3p2AOFzB8FwYnt8KeUHtECK+ZUwtpQYr5pNKm3Kf97yDI
         Y+MmfYPeO8S6IbCVOvuKrUqD87vecYVbVlqcldzdawJpX/KzckPL4FrEWcDVWcvhi61c
         A1kubda8rryhoStSAJHqanPU/58yaw8UXb9uAoYEKYTB5QK3/6OA91ISfCgFUBE/OyMs
         6tDx+pucqZBg+J2CICSwQjGawjrKT8B21idBYdn7VeILtvE7AZTJ2r7UDO/xukrUSVyv
         xWjbAbGEbbQ7hEAOzgCFw+H4nhedd9Pmz4DOkcFA+fEtlX6qxiN4Mst7LAvlfTIZmumn
         dkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9JcjKWIXUSWNVVmoQmQ1LIzYLPl7lzPnh8XZSuGo5sI=;
        b=cxTwVPXZ+qa+vmb8YGaXWlnj7pry6QGWlA3dahmH8+1KMjh7xhJwMbxeLh9OzxTPBy
         dLlcBZ8pRlMBHPABhon9ZBW4edHYmqSh6me16r2VtFp8ORhrMUpEHT7FO+O42RuK9qux
         GH8Vzohe2XkGjZPqkeOxtobZ+IX+aAEoKvHo0DHkko1uQrE5lqmSb58BfUpoQy7l2as4
         0qGZ1ulH33Xdw7G4BCYqAhAKaCwkTMDCmBOCO9geFDQ1RBhoWwfz3Mo/eaV25Fw1SqMn
         Zj2+VARWmDmYwWkPQtcWEhCtzZ81M+B/gu3jcqoao/W1Xp2E333v7TpXHY0GkwD3gGAH
         EQIg==
X-Gm-Message-State: APjAAAVM8wB4es1HOzEUPpmyG9Iia4DGLHjF/gcE3CVwhY5DWAy+02i7
        xg+51JLY2hTztoV6jOpTFfSV334X
X-Google-Smtp-Source: APXvYqxrRC68qDN1D/CruQen2PJwKpcQjdSj6O1UCIZBSxvsOPDF57sUKivYwA1wA6G1+LWu7lYrXw==
X-Received: by 2002:aa7:93ce:: with SMTP id y14mr5653231pff.138.1574284716051;
        Wed, 20 Nov 2019 13:18:36 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id i2sm154627pgt.34.2019.11.20.13.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:35 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:33 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/10] t3206: remove spaces after redirect operators
Message-ID: <85fcacf3f90454900bbc7983fee4cba82ac02651.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove the
one instance of this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3206-range-diff.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 0579cd9969..87c6c029db 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -8,7 +8,7 @@ test_description='range-diff tests'
 # harm than good.  We need some real history.
 
 test_expect_success 'setup' '
-	git fast-import < "$TEST_DIRECTORY"/t3206/history.export &&
+	git fast-import <"$TEST_DIRECTORY"/t3206/history.export &&
 	test_oid_cache <<-EOF
 	# topic
 	t1 sha1:4de457d
-- 
2.24.0.450.g7a9a4598a9

