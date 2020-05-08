Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E39C35280
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF38A208DB
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFV0RP2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEHBeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 21:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgEHBeI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 21:34:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CAEC05BD09
        for <git@vger.kernel.org>; Thu,  7 May 2020 18:34:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f6so113361pgm.1
        for <git@vger.kernel.org>; Thu, 07 May 2020 18:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LDQRZLKg8TBCKjk0/4YHQzcdArs/myIYsvQCNp1Bzi0=;
        b=XFV0RP2QHsuJtYpV4sXM0pcITcX2NScj9Y+urSJs5N3n+OqqoJW7zMg1G7eGL6mHVM
         mLrV+mluwDAtdx9vJpXoPAuN/U0mJcOFX6aCEYeVGwKrpnKGiuwvc6PkJqOYbVnTWLT7
         0kZlp+knRG0XvP4ccNWq3cpVcOdLhng9O0aHMqu7AWuYfaX6bM8d+76ji+g3i2nCGsqM
         8lkwLISawiHSxJXxSVYsMG5fuMTvWIiDkC9H5iwM4l5CHXz1vQZkoTGw2X28s61IuslY
         bLt41wRZXnqtjOrxPrwILe61fAGMkl02wgFk1nU9qVOoGG3nTZ1J2nBhmkNC4lF/2FSR
         ZoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LDQRZLKg8TBCKjk0/4YHQzcdArs/myIYsvQCNp1Bzi0=;
        b=EJxBixw1Cw7I7MY0ZtVIwTmI/hxD9Rfti4Hq4N5r+hVGOQwV2YcbsBHFNdVv8A7THB
         JJtU4pgs0F6TRWIn/k4WgD9nRAWIJu3dDkV/EupsW2n1y6oEJ/lHUhE9R/WFTUVnIiKY
         /txu696hEmJoTtfbb+OFTcmTYZZc42Dbrce4Wq+IyGoy83zVrUWWLpSBKQNQXxIGkKLS
         xudM8qbB24yhP0dN37drCEKUlJgbwPrFnmwSyAmgGYT0ft1JW5dXZMvZI2bixdoLbkqv
         KMDwo0/c1ba0CKxSRhLfF4vatwyo93V3+wFYYRh4rAqVmXGmLBvAdY0wCOnq9VU69ANo
         GwhA==
X-Gm-Message-State: AGi0PubY2HdFuCX3TFJFB+IvJhL9LueRUHxohNGVYaXCBxv6iggQFjJl
        /ieaHK35i1TO7z7H2nMzgXc=
X-Google-Smtp-Source: APiQypKMDXs0f4JkzPx61He0mKeJKZN5cpI6W0YDp5Zks51irEvxP86LVu38/bxHuFofn3w6Ebl5JA==
X-Received: by 2002:a65:63d1:: with SMTP id n17mr91967pgv.109.1588901648041;
        Thu, 07 May 2020 18:34:08 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id w75sm32352pfc.156.2020.05.07.18.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 18:34:07 -0700 (PDT)
Date:   Fri, 8 May 2020 08:34:05 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] bugreport: collect list of populated hooks
Message-ID: <20200508013405.GA2111@danh.dev>
References: <20200430012425.209122-1-emilyshaffer@google.com>
 <20200508005357.223058-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200508005357.223058-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-07 17:53:57-0700, Emily Shaffer <emilyshaffer@google.com> wrote:
> +test_expect_success 'indicates populated hooks' '
> +	test_when_finished rm git-bugreport-hooks.txt &&
> +	test_when_finished rm -fr .git/hooks &&
> +	rm -fr .git/hooks &&
> +	mkdir .git/hooks &&
> +	for hook in applypatch-msg prepare-commit-msg.sample
> +	do
> +		write_script ".git/hooks/$hook" <<-\EOF || return 1
> +		echo "hook $hook exists"
> +		EOF
> +	done &&
> +	git bugreport -s hooks &&
> +	grep applypatch-msg git-bugreport-hooks.txt &&
> +	! grep prepare-commit-msg git-bugreport-hooks.txt

Hi Emily,

I think this is a bit more correct test.
---------8<----------
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Fri, 8 May 2020 08:26:53 +0700
Subject: [PATCH] fixup! bugreport: collect list of populated hooks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use an exact match to check for populated hooks

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t0091-bugreport.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 9450cc02e3..789e8f1ac7 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -67,8 +67,13 @@ test_expect_success 'indicates populated hooks' '
 		EOF
 	done &&
 	git bugreport -s hooks &&
-	grep applypatch-msg git-bugreport-hooks.txt &&
-	! grep prepare-commit-msg git-bugreport-hooks.txt
+	cat <<-\EOF >expected &&
+	applypatch-msg
+
+	EOF
+	awk -F "]\\n" -v RS="[" "/applypatch-msg/{print \$2}" \
+		git-bugreport-hooks.txt >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.26.2.672.g232c24e857


-- 
Danh
