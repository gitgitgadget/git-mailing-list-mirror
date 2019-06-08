Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB611F462
	for <e@80x24.org>; Sat,  8 Jun 2019 14:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfFHOmo (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 10:42:44 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45276 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfFHOmo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 10:42:44 -0400
Received: by mail-ed1-f54.google.com with SMTP id a14so5011597edv.12
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NkLj0eBoMsp77NIl+hrNX6qG/DDkr4kjfPc5xtrkNUY=;
        b=I97VfjQStLnzH/yVpFcwdi+kHwMjJEtrRbwA9JEhZiFTlkQsG/OuBLdztfFROV8r3D
         RurGr+We1uVrxk8tvCW152q7JXnoM0mYvcIlLbRdh36gy3icRJEHA71cunglKrU2J77M
         DkgHXcAt53XCdNzyX0nqSdzH8jiaxaRKjB3cXmw9BpH6OHMyPN4s7qQXplMElg7guOCY
         13f6eHtZP4ObVSLGy9zCXhH7l/1cSiW1sBy/Pe6IFps68rXSzexcM/4H7TRnLWQJ/odZ
         bq4BzD4LmocnZNEJr+/rXTIOfWGr9TpAd0PPEjAkKMvfpIFu2N0JqLybp1AsPgTrGP1k
         VjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NkLj0eBoMsp77NIl+hrNX6qG/DDkr4kjfPc5xtrkNUY=;
        b=EHl4da01OnJodvGWfYGNWUR3vrDcLw/HBPi79qR/iePevdW1b+sarzI8QDOpaE3tpH
         uA3/xCUPXVHwHH4HVoPzHBYh96HXM+g6GfkjuLyjQ5CO6pQM5eoWjafcvoILdvaobaXk
         YUppV0jcyu7GJ2sQjXeULgxlRYnpnlk7eggitAj6BOu/vrwWBTKrZ1N9AqPXkRV44Ijq
         MqjATDNibNP72GEE+DSS/aITlTJXyvoFM9727o4R/UkA5sT3t7nXGmdW69OeKsmUJhoU
         UBxJ6pvfDq2+04FciYnxzS88+Jh+YFmNhIyqhTcXWtWp5grjlZTC48r6UtVgZIPJc7b3
         jQcA==
X-Gm-Message-State: APjAAAUAik8gSB5njxX5ks1+HNgFjsWuli7eW9cFTALCIBLwA5FgAxxT
        9AlTdIEzyrQT3Qn9ImGYZPr8E2Cm
X-Google-Smtp-Source: APXvYqyQnMywrykniUqmog5KdC66dcOsiTwr5YiKuXW0Ewojxk7qhUg/PDEzRk7IVIkQM/ptkNfd9Q==
X-Received: by 2002:aa7:c819:: with SMTP id a25mr61604211edt.208.1560004962283;
        Sat, 08 Jun 2019 07:42:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm791442edx.67.2019.06.08.07.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 07:42:41 -0700 (PDT)
Date:   Sat, 08 Jun 2019 07:42:41 -0700 (PDT)
X-Google-Original-Date: Sat, 08 Jun 2019 14:42:39 GMT
Message-Id: <pull.142.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Optimize run_diff_files()' rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just another patch from Git for Windows' branch thicket...

Jeff Hostetler (1):
  diffcore-rename: speed up register_rename_src

 diffcore-rename.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-142%2Fdscho%2Fregister_rename_src-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-142/dscho/register_rename_src-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/142
-- 
gitgitgadget
