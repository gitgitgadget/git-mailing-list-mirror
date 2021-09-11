Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4051C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA34760F9D
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhIKJfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhIKJfj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F88C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d6so6249162wrc.11
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8pt+G5pzLtv9GhUBS+vmAHDy6Qb/ewLMSpN+2mMW0uU=;
        b=BmSVKCQcgcdFNRDhahKyfxbC/74Z+v6I52DCQ+Gvy4K+KDwAdRGuaUC1cZqYLQnSGG
         D7XhFxvi9hGZDMrLbtd0C7DvuICpEvD6UqLcHnKcGvrCGPRCyzxrh/x0o5JJ5PuD1CEx
         r75yPcfcGTDQ4N0t/MdAC7tanv1I0BRZHSfzzn15W/9FZpFTHomfn2ACDzWyAXdZLzSA
         iQNsB0Z8QlSjPp/xCBys+f42miPgGNlEzCY09+hisRmvOZDCddXNiDLoIKAK56f9I5ic
         HUJKQjb0cwH9JFCL4CU4KpQ8asffDdYErcZ1IWBD+FFPJNcBGH9uzehzGvqcZB1WfqRE
         Lwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8pt+G5pzLtv9GhUBS+vmAHDy6Qb/ewLMSpN+2mMW0uU=;
        b=QgGBgQdTRD7EeuBbqAl+pL7EQL5w6Cx5arRkDvkcGDC8rd6Z2hh5c4RO7w2H0qQ7pG
         EhSSjgChjhpK2gJFHOopw7cDEE3QDuR1SACmFXq/GwhRAG02ZyszqwvrnXtzBD995ezO
         7GCxbxC0luvScnBFGCb56jpm7W8ufasLaKAX7hIkcdEp1DY2TI4F/6ggSpRGSVv6jwuJ
         8pqSDp+F18aBLNOT+hifcnAGt4YaOKVCbcc8uonyRHt7IT5Y0p/lbUH+kw3pWYnwn8Pt
         iciVXzH7vtQJyntR4Z2C3RPSP7S3j0XLcGcGbCW5VMwe5g64fDcOj/QtL11kwLWCK0uB
         1Uzg==
X-Gm-Message-State: AOAM5306/0NmdeDPqmoFCQVQ4JyoW9mQj8BbdtYEIqZrUZwH8WKuKv+S
        FdC9JgVHTYN7N7mQuxFgMxZX5IBx1vDJCA==
X-Google-Smtp-Source: ABdhPJzWqmko4VPkoGJQtjEAAGAg4isFpbe5IMvsDLZCXh5SUt/zTCjPlh9kWxHbA8wpr4AAUE7KGg==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr2211394wrx.431.1631352865369;
        Sat, 11 Sep 2021 02:34:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] post-v2.33 "drop support for ancient curl" follow-up
Date:   Sat, 11 Sep 2021 11:34:14 +0200
Message-Id: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the already-integrated topic for dropping
support for older curl versions submitted before the v2.33 release[1].

See
https://lore.kernel.org/git/cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com/
for v2.

This has relatively minor changes against v2. This addresses Jeff
King's comments about the INSTALL phrasing, I split up the more
general improvements into another commit.

The CURL_SOCKOPT_OK is now defined in terms of LIBCURL_VERSION_NUM
like everything else.

I did not re-arrange the macros as suggested by Junio in
http://lore.kernel.org/git/xmqqr1dwtlt1.fsf@gitster.g

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

Range-diff against v2:
 1:  ac11cf8cfd1 !  1:  7b771aa70ef INSTALL: don't mention the "curl" executable at all
    @@ INSTALL: Issues of note:
      	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
     -	  the curl version >= 7.34.0, for git-imap-send.  You might also
     -	  want the "curl" executable for debugging purposes. If you do not
    --	  use http:// or https:// repositories, and do not want to put
    --	  patches into an IMAP mailbox, you do not have to have them
    --	  (use NO_CURL).
    -+	  the curl version >= 7.34.0, for git-imap-send.
    -+
    -+	  If you do not use http:// or https:// repositories, and do
    -+	  not want to put patches into an IMAP mailbox, you do not
    -+	  have to have them (use NO_CURL).
    - 
    - 	- "expat" library; git-http-push uses it for remote lock
    - 	  management over DAV.  Similar to "curl" above, this is optional
    ++	  the curl version >= 7.34.0, for git-imap-send. If you do not
    + 	  use http:// or https:// repositories, and do not want to put
    + 	  patches into an IMAP mailbox, you do not have to have them
    + 	  (use NO_CURL).
 -:  ----------- >  2:  3b0119958a3 INSTALL: reword and copy-edit the "libcurl" section
 2:  4b653cee2d3 !  3:  dce6520a5c9 INSTALL: mention that we need libcurl 7.19.4 or newer to build
    @@ Commit message
     
      ## INSTALL ##
     @@ INSTALL: Issues of note:
    - 	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
    - 	  the curl version >= 7.34.0, for git-imap-send.
    + 	  not need that functionality, use NO_CURL to build without
    + 	  it.
      
    -+	  Git version "7.19.4" of "libcurl" or later to build. This
    -+	  version requirement may be bumped in the future.
    ++	  Git requires version "7.19.4" or later of "libcurl", to
    ++	  build (without NO_CURL). This version requirement may be
    ++	  bumped in the future.
     +
    - 	  If you do not use http:// or https:// repositories, and do
    - 	  not want to put patches into an IMAP mailbox, you do not
    - 	  have to have them (use NO_CURL).
    + 	- "expat" library; git-http-push uses it for remote lock
    + 	  management over DAV.  Similar to "curl" above, this is optional
    + 	  (with NO_EXPAT).
 3:  76c2aa6e78d =  4:  98cdb7c35a9 Makefile: drop support for curl < 7.9.8 (again)
 4:  e73a9ff1780 =  5:  7919debfd89 http: drop support for curl < 7.18.0 (again)
 5:  2567b888c3d =  6:  67bc1992762 http: correct version check for CURL_HTTP_VERSION_2
 6:  397d54a1352 =  7:  db7d6029dda http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
 7:  8e57a8409c5 =  8:  e2e53cbfba1 http: centralize the accounting of libcurl dependencies
 8:  465ab33ebda !  9:  4bdec34a545 http: don't hardcode the value of CURL_SOCKOPT_OK
    @@ git-curl-compat.h
      
     +/**
     + * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
    -+ *
    -+ * This should be safe as CURL_SOCKOPT_OK has always been a macro, not
    -+ * an enum field (checked on curl version 7.78.0, released on July 19,
    -+ * 2021). Even if that were to change the value of "0" for "OK" is
    -+ * unlikely to change.
     + */
    -+#ifndef CURL_SOCKOPT_OK
    ++#if LIBCURL_VERSION_NUM < 0x071505
     +#define CURL_SOCKOPT_OK 0
     +#endif
     +
-- 
2.33.0.984.gea2c3555113

