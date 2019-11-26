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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C79CC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78202068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+Yn8GEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKZBSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33032 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBSG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so3571605pgk.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7VPx+FtrqEcEOfcK3GddzAjZhHm6Shlg+PLWPLbqfs=;
        b=X+Yn8GEPRkpp3OO2yvXSFKZQJR8pM0lFWVxAHiDtD2Vt18d1H0SMppOmaHyMi1mf9y
         rwkvhRd3pPwWpTt6EV92oqVkGmS0y/cGaAb6eB/DUU5abllITw86YzjXcvezFf65o+sW
         xfCr1oGTGPjMlUL/PZVlFBjTL7k+i/tBzV7F/Ss3eimPnoMEk6VIKJoSGXZYZWC2suiU
         7iSF0e+ZGcabsQgxLiCXdrp6fP1WlgrhH8lqdr7k1OKgXZqhff8e4oO+oJX+UK8v7Zar
         PJpSgoMkqN2EIr6rjxYCikBf07O7fFim0kYHFkc/cykvArah94Qm7Sxgn0En7V2dqoqP
         8BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7VPx+FtrqEcEOfcK3GddzAjZhHm6Shlg+PLWPLbqfs=;
        b=RFjfOF2LdAyR83iT4l9Raw6h34Bumb4EjOQ/c9aZR+mYsbCbwYttPnQQPsG9gqjF92
         6q5cDfCYYNieFAUx/jGHaeH99WppVufRcR+wl3UyEMIoBDdXic60KerYFxNItq/4dYp2
         Lb3QebAsBe+J+edJtB3pePaUmA/WGYG75rcYc8UHL1xUEZGH09TwYWTcmnkj8j/t3iNc
         UvucJNPYmsJARZAekuw2H5ZeGMCq/aKzdnUTYgx52fxZfdOHbrKF+9hdiFzy6TF880XY
         iwSDqpQWQt1Y/lzecGR8KKC4mcWd7OKcwcmgl972C5emdu9wj62/4Owgf+QaQXKmG9Ht
         C9nw==
X-Gm-Message-State: APjAAAVI4UNAvDVJ+rMgwtufDiAMbC+R8rD853duOiN7CI7/sAXugiqj
        mPrzEouxps+E1gtms7ySvVlSBhs6
X-Google-Smtp-Source: APXvYqwLctoyK+WaQJwg+7TUmhTE8i5ovB/oT07AkZinBwD4KajELS97hM4ZJDB7P8u7yx0o6qdeLg==
X-Received: by 2002:a63:1f09:: with SMTP id f9mr34446682pgf.89.1574731085513;
        Mon, 25 Nov 2019 17:18:05 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id d11sm10677787pfq.72.2019.11.25.17.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:04 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 08/27] t3600: comment on inducing SIGPIPE in `git rm`
Message-ID: <e3db06578df23ee6e2036c18a25e79ae6c4d46e3.1574731022.git.liu.denton@gmail.com>
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

Add a comment about intentionally inducing SIGPIPE since this is unusual
and future developers should be aware. Also, even though we are trying
to refactor git commands out of the upstream of pipes, we cannot do it
here since we rely on it being upstream to induce SIGPIPE. Comment on
that as well so that future developers do not try to change it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0c3bf10edd..0ea858d652 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -251,6 +251,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 		echo "100644 $hash 0	some-file-$i"
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
+	# git command is intentionally placed upstream of pipe to induce SIGPIPE
 	git rm -n "some-file-*" | : &&
 	test_path_is_missing .git/index.lock
 '
-- 
2.24.0.504.g3cd56eb17d

