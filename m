Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99E91F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 00:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392817AbfJXAUw (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 20:20:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40409 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392153AbfJXAUv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 20:20:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so665916wmj.5
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 17:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nm4fKDCamAc2CE/aAEUJJJtr6Oaaj4FJbItQL7QpgTU=;
        b=rpgyqQ3FQYmysrsVF80rt07GN1XonGUkrDznHB+DRAGkwH4QI+cEVukq8kHtD0TkTy
         G9aR5AYOXtGcjw4mNM6YJGTVbsT242G09Q+Asdd8WfQ4f0z7n1oHH/SzPD6BkaB3ycN0
         8p2VXMQ9g3zF48sAx9xMKzo1A/8k/ccuuZgEUas6kptzehhTyb8GzVo6L6c5R1sx404f
         ZNSvldH5dCjW+xMUBdW6x1ykLAwXqs6+toTLXz0ZEFhQ6carNa1zAVHS8mxpJG/nQXEQ
         4tgnqQt6olv0SElNqup4GynLJFIy+RTny8hte4UDddj4pH+JhuZTnAXwec473jjRA5o+
         lZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nm4fKDCamAc2CE/aAEUJJJtr6Oaaj4FJbItQL7QpgTU=;
        b=pYBDnmigUAm1uLBs6BFQO9056Q9lW9ayKVLX7d5Z2HqrNQ8nagSOxvAmJVYsvaFDMb
         4hAl5VdGNr++rYO9BuFRaXe4eh0FO3mHja3m4UHcdXoc4CM9ACE8JQj3SGfsE+ZoCTUl
         y7ygqrIcY56ngbY+5jAu4k9wcpTSVT5v9tSo1eZpdjLjC3Ce6KFg7VpXoV2+UUsNu7P1
         p/7p0+h79b06PR7HyM9XK6JS15Ifohgd6Tp9fzVGJA/e6ncquTUU2iiPnsXjKj5whLZB
         u1rhiy6pewSdXIhpgRgnEqXRDY6rLnUBzn3VTHVd7Xl1wwLn07Xw8eK12lCSM5RsJmqZ
         2bYg==
X-Gm-Message-State: APjAAAWcXqEJGz4+N7Mg+Sg+nJ8Ry4jCY1XiIMyhAhHjQ4qbApipmz6e
        VB4zesMeIR3vd/3PZplTuBA=
X-Google-Smtp-Source: APXvYqwF57uM87Z8vgy0rTxZfzuW1nAnvXbhhRgktPV6hzNKJOkRtQbLTtU2fZE9L21oV4G6ZtDqrQ==
X-Received: by 2002:a1c:1a4b:: with SMTP id a72mr2187331wma.17.1571876447968;
        Wed, 23 Oct 2019 17:20:47 -0700 (PDT)
Received: from localhost.localdomain (x4db97b71.dyn.telefonica.de. [77.185.123.113])
        by smtp.gmail.com with ESMTPSA id f17sm11797829wrs.66.2019.10.23.17.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 17:20:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] ci: fix GCC install in the Travis CI GCC OSX job
Date:   Thu, 24 Oct 2019 02:20:40 +0200
Message-Id: <20191024002040.17196-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.502.g7008375535
In-Reply-To: <20191023163506.GJ4348@szeder.dev>
References: <20191023163506.GJ4348@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few days ago Travis CI updated their existing OSX images, including
the Homebrew database in the xcode10.1 OSX image that we use.  Since
then installing dependencies in the 'osx-gcc' job fails when it tries
to link gcc@8:

  + brew link gcc@8
  Error: No such keg: /usr/local/Cellar/gcc@8

GCC8 is still installed but not linked to '/usr/local' in the updated
image, as it was before this update, but now we have to link it by
running 'brew link gcc'.  So let's do that then, and fall back to
linking gcc@8 if it doesn't, just to be sure.

Our builds on Azure Pipelines are unaffected by this issue.  The OSX
image over there doesn't contain the gcc@8 package, so we have to
'brew install' it, which already takes care of linking it to
'/usr/local'.  After that the 'brew link gcc' command added by this
patch fails, but the ||-chained fallback 'brew link gcc@8' command
succeeds with an "already linked" warning.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Same patch, updated commit message.

 ci/install-dependencies.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index ce149ed39c..4e64a19112 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -48,6 +48,7 @@ osx-clang|osx-gcc)
 	brew install caskroom/cask/perforce
 	case "$jobname" in
 	osx-gcc)
+		brew link gcc ||
 		brew link gcc@8
 		;;
 	esac
-- 
2.24.0.rc0.502.g7008375535

