Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD7BC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E80E60F26
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbhIMPiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbhIMPiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54577C09B058
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g128so2438117wma.5
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZ/+kpNmLEAdzn+0fJUmZppskaw6lyFYMUSGqmE0nvA=;
        b=nJwBdmb2HHJ994fF3Jn5KKWAC52XtdU4PDF7k+GFDpyznwvR9MTZMhDx8y7fDBd3bI
         9zwdW52feyUwW48tfNKD1AcSKxtYGhGtHKQioTfVZJ3fnhvl9B3waiMTxEcR+VRb0JWm
         y9elW92BHM0v8rBEFuGY4HIPxqGupO8Km6Mtm9lVs+rfHCYhUQcNig6/rpf6uIEeqmiI
         AqqdVxnL9iPUh/N82pp7yYx8TUjDSs6nWZ7UOBNuTZ5CmW+upFt5CEkukYcAIGV+WuDl
         g/iUvzuu0XHecal8F8vj3NPXZbzByCrAhAJYJNTPglwUD9Jy8XW/Or6sevg7sJ1EYi+f
         NPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZ/+kpNmLEAdzn+0fJUmZppskaw6lyFYMUSGqmE0nvA=;
        b=geyTVURImZyN3W20jYpkEbesnXqcIAPsxjyWN8tZy2tBioL1BW0uOngida/BWxRmyY
         k8ys8CUeaZ1M41SaXrAhLP3vRyniFAswXKPzvtgcs8B2hqLNtP42f/crou+e9L+Tgor/
         8SXW4iW+2NK3e/I61//IPn7KuEossQdhXUCDSFMhkzcQLdV/a/aixk/xbEZxWAQr3INg
         badOF5wySSdgOQD0aaluPpkMHC42BYj/r+QU/WmncDgr0SjLj5GPUJwtVQn7Mv4QzhY2
         lzK9pY3IZdAQLH5g+ASy5ZH1jjzlIowtuvw7SdC6i1Rrb8TnnSCcP593hYn4ySA9fHON
         insQ==
X-Gm-Message-State: AOAM531mXblNW8XL4pCDXWYuoOaCxdsYqIvsBT9xIFx54cfg188sVlad
        G1+B0HYWCtc51Ynj0+01VqsuRnxczDcWVA==
X-Google-Smtp-Source: ABdhPJzuGysdmOkuJXadWjYKmQgg9u/+bo9zFuDUtYmYJ9K12dn4WQAkl1mwTIxy0HzQrAlyl8vXyg==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr11601737wmj.149.1631544693175;
        Mon, 13 Sep 2021 07:51:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/9] post-v2.33 "drop support for ancient curl" follow-up
Date:   Mon, 13 Sep 2021 16:51:20 +0200
Message-Id: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the already-integrated topic for dropping
support for older curl versions submitted before the v2.33 release[1].

See
https://lore.kernel.org/git/cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com
[1] for v3.

This is a hopefully final re-roll with a small grammar improvement in
3/8. See range-diff, pointed out/requested at
https://lore.kernel.org/git/YTzBUFY4p6obEqF+@coredump.intra.peff.net/

Ævar Arnfjörð Bjarmason (9):
  INSTALL: don't mention the "curl" executable at all
  INSTALL: reword and copy-edit the "libcurl" section
  INSTALL: mention that we need libcurl 7.19.4 or newer to build
  Makefile: drop support for curl < 7.9.8 (again)
  http: drop support for curl < 7.18.0 (again)
  http: correct version check for CURL_HTTP_VERSION_2
  http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
  http: centralize the accounting of libcurl dependencies
  http: don't hardcode the value of CURL_SOCKOPT_OK

 INSTALL           |  15 +++---
 Makefile          |  11 +---
 git-curl-compat.h | 128 ++++++++++++++++++++++++++++++++++++++++++++++
 http.c            |  35 ++++++-------
 imap-send.c       |   2 +-
 5 files changed, 157 insertions(+), 34 deletions(-)
 create mode 100644 git-curl-compat.h

Range-diff against v3:
 -:  ----------- >  1:  7b771aa70ef INSTALL: don't mention the "curl" executable at all
 1:  3b0119958a3 =  2:  2f3a09c98d2 INSTALL: reword and copy-edit the "libcurl" section
 2:  dce6520a5c9 !  3:  59c86f14cef INSTALL: mention that we need libcurl 7.19.4 or newer to build
    @@ INSTALL: Issues of note:
      	  not need that functionality, use NO_CURL to build without
      	  it.
      
    -+	  Git requires version "7.19.4" or later of "libcurl", to
    -+	  build (without NO_CURL). This version requirement may be
    -+	  bumped in the future.
    ++	  Git requires version "7.19.4" or later of "libcurl" to build
    ++	  without NO_CURL. This version requirement may be bumped in
    ++	  the future.
     +
      	- "expat" library; git-http-push uses it for remote lock
      	  management over DAV.  Similar to "curl" above, this is optional
 3:  98cdb7c35a9 =  4:  6edd01ad125 Makefile: drop support for curl < 7.9.8 (again)
 4:  7919debfd89 =  5:  73ad0d4cb28 http: drop support for curl < 7.18.0 (again)
 5:  67bc1992762 =  6:  f4d1de8a112 http: correct version check for CURL_HTTP_VERSION_2
 6:  db7d6029dda =  7:  7aa5149c395 http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
 7:  e2e53cbfba1 =  8:  9890e4b662a http: centralize the accounting of libcurl dependencies
 8:  4bdec34a545 =  9:  846b466fdd5 http: don't hardcode the value of CURL_SOCKOPT_OK
-- 
2.33.0.1013.ge8323766266

