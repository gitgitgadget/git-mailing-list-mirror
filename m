Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E04C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F46161019
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbhG3JfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 05:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhG3JfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 05:35:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D1C0613CF
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p5so10473037wro.7
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+svhJdTJWXbq8oKAs8+k2KGDh4gvZWJRLLHxCfYklU=;
        b=sZbLjtfp/dLpmYFPZ/WDYVmEb4PJpmCofHGcoDQcjGsfC1yP4DusFITQlQhiU+gtj1
         u31loTcfNhSlQE6vzVFCMwcWVZQmGcCYuxTkywp8nX6QDF/ZxEzlNP/T96OreFa/NiUZ
         rX5j/YhwAnPNyYuNnVT+o5DAnctvVryyccS65R2bq9KFNb2U7ThJKqSbMPUA8b6IfqWV
         63Djddewe7SYGVjBgWEJ3k6p3u7hy4E2HHImIj7q7ND/J7nqULhm0rFHyQBiG8CWOw6H
         ZfFDcZiyXuASVthLOTkJ0c13+oZXQ/3rlKifNGgN1kyoDrz0ngBn+6zS1C7gj6ZY8hTK
         dyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+svhJdTJWXbq8oKAs8+k2KGDh4gvZWJRLLHxCfYklU=;
        b=ke8J2JdftAKCpdbxSvLWogCxBEcd3/IDoegnKv5C9ozeHAkdq4m/zVSLKYJQQWhzh3
         Xa+cJ+wzHoe0b1uxJmlHsYgzyBEJTPynWsSBXqnCC3m+bBkTcGL8knu/cOyyybuY90Jq
         jQR3Wi0M+HFRrhEUosMiCM+amh7/g9CH13Uqcw9eU1Pz0FVB3izgfTO62LaB+w5MyohK
         Z1guAis9mKlkMa8p0auADEMq45HsA8dOyhEEuLWsNda/EcueU2yht05fojcb27pfBo5y
         G6SbeuH8VXMFEzMmtKF4WuNi/esVPLlg2wu0tHYufLE10opE2fBwyUrTuTyU5J0oAHvJ
         IK4w==
X-Gm-Message-State: AOAM533bGEEPNUbGY0D90wgOKR/fTqquOxpAz9RCU2248O57boWgBJIy
        VMz6/IMNLb6eDsDE4ZSMWq5S7gCP+2OBvA==
X-Google-Smtp-Source: ABdhPJz8caEuV4mvz3/9QW+4LIDFCojlkdTIOP3l6ErjL32GKuuTCjUeUfT+WBO8dCSv9OZBWdLTyw==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr2085806wrw.268.1627637701134;
        Fri, 30 Jul 2021 02:35:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm1089903wru.94.2021.07.30.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:35:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/7] drop support for ancient curl, improve version checks
Date:   Fri, 30 Jul 2021 11:31:52 +0200
Message-Id: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g516d52f3d85
In-Reply-To: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should address the feedback on v2, except that I did not update
the INSTALL document as Bagas Sanjaya suggested. We did not have
existing discussion of the generally supported minimal support minimal
version there, that would make sense as a follow-up patch.

There's minor commit message changes here, and two new patches, one is
another missed ifdef we could remove because the version comparion was
wrong, and the last commit entirely gets rid of LIBCURL_VERSION_NUM
checks in the codebase in favor of checking specific defined macros.

Jeff King (3):
  http: drop support for curl < 7.11.1
  http: drop support for curl < 7.16.0
  http: drop support for curl < 7.19.4

Ævar Arnfjörð Bjarmason (4):
  http: drop support for curl < 7.19.3 and <= 7.16.4 (or <7.17.0)
    (again)
  http: drop support for curl < 7.18.0 (again)
  http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
  http: centralize the accounting of libcurl dependencies

 git-curl-compat.h | 119 ++++++++++++++++++++++++++
 http-push.c       |  29 +------
 http-walker.c     |  14 +--
 http.c            | 212 ++++++----------------------------------------
 http.h            |  46 ----------
 imap-send.c       |  10 +--
 remote-curl.c     |  11 +--
 7 files changed, 153 insertions(+), 288 deletions(-)
 create mode 100644 git-curl-compat.h

Range-diff against v2:
1:  dcbb6f95652 ! 1:  6bd41764a54 http: drop support for curl < 7.11.1
    @@ Commit message
         Drop support for this ancient version of curl and simplify the code by
         allowing us get rid of some "#ifdef"'s.
     
    -    Git will not build with vanilla curl older than 7.11.1 due to (at
    -    least) two issues:
    -
    -      - our use of CURLOPT_POSTFIELDSIZE in 37ee680d9b
    -        (http.postbuffer: allow full range of ssize_t values,
    -        2017-04-11). This field was introduced in curl 7.11.1.
    -
    -      - our use of CURLPROTO_* outside any #ifdef in aeae4db174
    -        (http: create function to get curl allowed protocols,
    -        2016-12-14). These were introduced in curl 7.19.4.
    +    Git will not build with vanilla curl older than 7.11.1 due our use of
    +    CURLOPT_POSTFIELDSIZE in 37ee680d9b
    +    (http.postbuffer: allow full range of ssize_t values,
    +    2017-04-11). This field was introduced in curl 7.11.1.
     
         We could solve these compilation problems with more #ifdefs,
         but it's not worth the trouble. Version 7.11.1 came out in
    -    March of 2004, over 13 years ago. Let's declare that too old
    +    March of 2004, over 17 years ago. Let's declare that too old
         and drop any existing ifdefs that go further back. One
         obvious benefit is that we'll have fewer conditional bits
         cluttering the code.
2:  1c9f3bc031b = 2:  fb308258e2b http: drop support for curl < 7.16.0
3:  faae88b7fec = 3:  9fcd3a3e486 http: drop support for curl < 7.19.4
4:  9a30e92520c ! 4:  230b968382f http: drop support for curl < 7.19.3 and < 7.16.4 (again)
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    http: drop support for curl < 7.19.3 and < 7.16.4 (again)
    +    http: drop support for curl < 7.19.3 and <= 7.16.4 (or <7.17.0) (again)
     
         Remove the conditional use of CURLAUTH_DIGEST_IE and
         CURLOPT_USE_SSL. These two have been split from earlier simpler checks
         against LIBCURL_VERSION_NUM for ease of review.
     
    -    The CURLAUTH_DIGEST_IE flag was added in n 7.19.3[1], and
    -    CURLOPT_USE_SSL in 7.16.4[2], as noted in [2] it was then renamed from
    -    the older CURLOPT_FTP_SSL.
    +    The CURLAUTH_DIGEST_IE flag was added in 7.19.3[1], and
    +    CURLOPT_USE_SSL in 7.16.4[2] or 7.17.0[3], depending on the source. As
    +    noted in [2] it was then renamed around that time from the older
    +    CURLOPT_FTP_SSL.
     
         1. https://curl.se/libcurl/c/CURLOPT_HTTPAUTH.html
         2. https://curl.se/libcurl/c/CURLOPT_USE_SSL.html
    +    3. https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
-:  ----------- > 5:  b857a9ef7b1 http: drop support for curl < 7.18.0 (again)
5:  64e510b4a6b = 6:  95e42b17ce8 http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
-:  ----------- > 7:  93a2775d0ee http: centralize the accounting of libcurl dependencies
-- 
2.32.0.1069.g516d52f3d85

