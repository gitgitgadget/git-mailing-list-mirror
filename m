Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A0C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 13:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B3061351
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 13:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhDCNRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDCNRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 09:17:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5AC0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 06:17:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t20so3641146plr.13
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MAe1qKZFGRG0QrSMe3ZnK40ioe1DhzQ0rsU/65/UQg=;
        b=u367kPJvWG3bGGo2reVlAg0xS7UggAQ6Sx3q9tBfzvegT2SoPpstdOzgQ8oStaHY5X
         JnD7154Jl4Cmf7cai2IAHuuFpIyTjJtLBI/3ECk/Ye35I40XSSouza4TkUX5ZgoDUPQZ
         Eqg+1/UHXCrqoKUmZ2xIdlcbdiEj7XKRYv/BYWua35JYO54zxggPz5mmxx4Xm4ujWpHT
         HB23lsYAu6n8TlixtxUABp0+y6g2eK1qv+ERodGBGqMqeHxwa0+7t6pZlRwQnH5/LdzP
         c9v3Y2/Zt3MOmVUuE0rbWeyVNRW5sLRKXs50SJB+4fBOsiAkgnX+lb0W+UqKCBxWPYZr
         sBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MAe1qKZFGRG0QrSMe3ZnK40ioe1DhzQ0rsU/65/UQg=;
        b=HkIv+T+a8fzKH/C6e1wvAc7e1iRLhbJxwOJjwfqV4lrKIPyf2SZUgWk0RUED7kR881
         WEWjWaXhwZRI6FH3X2Ox0pfx38/ljKGv3LYH+9dJOx9kLWCZQ4zfniAHzUm6xC/+0XNI
         uU+0ziUilz1T8g2hPqe8ok9BsOtn+ZCZiFBXdqfEqZDDKdHCMiUQwfMXuD+Ojc2fU0jY
         IvdvXc8raXd8tr9AtoRVzr1COVJ8ezNvin/kntQyB7gp/2n99sNifbUGgIK4S9yfNEIC
         H8uILom1rGSeQMuy2F2Hr5N8myO/nkQL4fdDOK1n1HnVZvb5POmY6M3lcCGrdtsEYDrF
         Z5Lw==
X-Gm-Message-State: AOAM5339DxHry/XaC2zYNvuy8C0mSgug2bUx5ssehVExGspkcyUK+e5o
        PcUGdt9rHY5cdbVeEONmOCxRkmqHKI2unQ==
X-Google-Smtp-Source: ABdhPJzB50WRc/yTjKWOOgn7ooKIsbblmvr1aOBwXWaXjVxvL1aWmuDFmgDIikKC2LIIzvikImu97Q==
X-Received: by 2002:a17:902:a715:b029:e7:147e:fe90 with SMTP id w21-20020a170902a715b02900e7147efe90mr17077866plq.66.1617455830208;
        Sat, 03 Apr 2021 06:17:10 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id j21sm10059939pfc.114.2021.04.03.06.17.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Apr 2021 06:17:09 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>, gitster@pobox.com,
        avarab@gmail.com, j6t@kdbg.org, phillip.wood123@gmail.com
Subject: [GSoC][PATCH v2 0/1] userdiff: add support for scheme
Date:   Sat,  3 Apr 2021 18:46:11 +0530
Message-Id: <20210403131612.97194-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210327173938.59391-1-raykar.ath@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

This is v2 of the patch I sent to add userdiff support to Scheme. I have
modified my approach to be more inclusive of as many Schemes as possible and
thus added many more forms. Since Ævar suggested we veer on the side of
inclusion when talking about the Gerbil scheme syntax, I felt it made sense to
extend the driver to include common, but non-standard extensions of Scheme,
including the forms of Racket and Guile.

Forms added since last patch:

 - Variants of define such as def, defsyntax etc as suggested by Phillip and the
   other reviewers. - The library form of R6RS, as well as module definitions of
   Racket, Gerbil and Guile. * These forms were added on the recommendation of
   Göran Weinholt, creator of the Akku scheme package manager and the Loko
   Scheme implementation:
   https://groups.google.com/g/comp.lang.scheme/c/Aczn0TNEr5g/m/Jq3AlKvZBgAJ -
   The Racket forms for defining structs and classes.

I have restricted the "def" forms to only certain keywords, so that it does not
over-match to words like "deflate", "deform", "defer" etc.

I have also allowed the use of "/" after a define or def form, as some scheme
code uses it as a convention for defines in a certain context, such as Racket's
"define/public".

I have also fixed some a test case which had a redundant "ChangeMe".

Finally in the word regex, which has been simplified a lot, while retaining the
same functioning after taking into account Junio's suggestions.

Atharva Raykar (1):
  userdiff: add support for Scheme

 Documentation/gitattributes.txt    |  2 ++
 t/t4018-diff-funcname.sh           |  1 +
 t/t4018/scheme-class               |  7 +++++++
 t/t4018/scheme-def                 |  4 ++++
 t/t4018/scheme-def-variant         |  4 ++++
 t/t4018/scheme-define-slash-public |  7 +++++++
 t/t4018/scheme-define-syntax       |  8 ++++++++
 t/t4018/scheme-define-variant      |  4 ++++
 t/t4018/scheme-library             | 11 +++++++++++
 t/t4018/scheme-local-define        |  4 ++++
 t/t4018/scheme-module              |  6 ++++++
 t/t4018/scheme-top-level-define    |  4 ++++
 t/t4018/scheme-user-defined-define |  6 ++++++
 t/t4034-diff-words.sh              |  1 +
 t/t4034/scheme/expect              | 10 ++++++++++
 t/t4034/scheme/post                |  5 +++++
 t/t4034/scheme/pre                 |  5 +++++
 userdiff.c                         |  4 ++++
 18 files changed, 93 insertions(+)
 create mode 100644 t/t4018/scheme-class
 create mode 100644 t/t4018/scheme-def
 create mode 100644 t/t4018/scheme-def-variant
 create mode 100644 t/t4018/scheme-define-slash-public
 create mode 100644 t/t4018/scheme-define-syntax
 create mode 100644 t/t4018/scheme-define-variant
 create mode 100644 t/t4018/scheme-library
 create mode 100644 t/t4018/scheme-local-define
 create mode 100644 t/t4018/scheme-module
 create mode 100644 t/t4018/scheme-top-level-define
 create mode 100644 t/t4018/scheme-user-defined-define
 create mode 100644 t/t4034/scheme/expect
 create mode 100644 t/t4034/scheme/post
 create mode 100644 t/t4034/scheme/pre

-- 
2.31.1

