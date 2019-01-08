Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 524B41F803
	for <e@80x24.org>; Tue,  8 Jan 2019 02:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfAHCr5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 21:47:57 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:52201 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfAHCr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 21:47:57 -0500
Received: by mail-it1-f201.google.com with SMTP id b14so2185696itd.1
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 18:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SDwSqFWnDtyw1KVIhn5atw4YOYrrcYPovzhKhh0hnjA=;
        b=SrXNLqkwoHjHrs2kYNbXg7hZHJJNRJp0b7H43Tfey+od490E1NUoqBCx8RpaTHlgkA
         G42z3jnYDz9JtwgGkENWm2P2PSdPV9gRWKrE377HDuCHq7658d+BeroPKProfRHDmv1S
         4f0LiFGa8j+VnjA2B2W3YNRAxPb8wtMeQHqWQR3JS/+62Jpdb464jqdH7KVESGcF1n2P
         nJVPybuifKrAONk88OReP1YKjPIosn9U1HCgE2HeD+n23FEAmR3Nel2WTAGxONnHH9B0
         RfyVBTLcYexGumNaJNBrq3kThyaseLldZOX1ldBm2t9t3zuDMNN+7m/iF0ly27KeTlBS
         dJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SDwSqFWnDtyw1KVIhn5atw4YOYrrcYPovzhKhh0hnjA=;
        b=jmrngdpMmc/N15ENBS64PvJYiDnmsAS9dpOTjmfTE1b/7o+W6J3ADrbaB7mXN7jOSo
         5mv3LLwW30hJZXGBn90e9upTIaRW+h3X1TU+23otFVmMDHP+XT0GNukKUwROr5yP4E6A
         0mCdc3n3/x9dlGGkmJOrCpKZjavdy87cJkPV38o6oC8+WMYkZntc1q8R5dKKkZQFH5WR
         fPTPDNKz36NE3f93x7nJXVEDiBeSDSlF2NRIWpLVAKd05/63cElOEpw2LqRebxo1Wo4J
         B2N+Lr1Qq9qz21jIHfPpMCJb5qjbl/uboAm++awURmU0o0R2GiSdNZQklYx3LS3ucqqK
         Dy0A==
X-Gm-Message-State: AJcUukfOLabw76yBDb/8+bITo7tE8JG9tdsWF67CgaHPgSW0ToAYrnSl
        /vsyGe1uhb+UME9V6QtsDewUacs/vuRo6i7i47s=
X-Google-Smtp-Source: ALg8bN6bJhwgDFNfP4P+9mfjF8gq0R1xDd0pa3fSbxphdCQCpiC0UakU43oTxpQULK/J/Qz1MBc+5wuWomTB2rby7lM=
X-Received: by 2002:a24:4ac4:: with SMTP id k187mr213125itb.8.1546915676235;
 Mon, 07 Jan 2019 18:47:56 -0800 (PST)
Date:   Mon,  7 Jan 2019 18:47:36 -0800
In-Reply-To: <20181229194447.157763-1-masayasuzuki@google.com>
Message-Id: <20190108024741.62176-1-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20181229194447.157763-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 0/5] Show HTTP headers of failed requests with GIT_CURL_VERBOSE
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diff from v2[1]:

*   Remove http_resonse_dest

    This was introduced to have a filename for freopen. Jeff King proposed [2]
    using fflush and ftruncate and this makes this struct not needed.

*   Unset CURLOPT_FAILONERROR only when it's necessary.

    Previously, CURLOPT_FAILONERROR was unset for everything. This patch series
    does so only when it's necessary. This is from the observation in [3] that
    pointed out there are other possible code paths that hit http.c.

*   Split the patches for easier review

[1]: https://public-inbox.org/git/20181229194447.157763-1-masayasuzuki@google.com/
[2]: https://public-inbox.org/git/20190104101149.GA26185@sigill.intra.peff.net/
[3]: https://public-inbox.org/git/20190104104907.GC26185@sigill.intra.peff.net/

Masaya Suzuki (5):
  http: support file handles for HTTP_KEEP_ERROR
  http: enable keep_error for HTTP requests
  remote-curl: define struct for CURLOPT_WRITEFUNCTION
  remote-curl: unset CURLOPT_FAILONERROR
  test: test GIT_CURL_VERBOSE=1 shows an error

 http.c                       | 27 +++++++++++++--------------
 http.h                       |  1 -
 remote-curl.c                | 29 ++++++++++++++++++++++++-----
 t/lib-httpd/apache.conf      |  1 +
 t/t5581-http-curl-verbose.sh | 28 ++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 20 deletions(-)
 create mode 100755 t/t5581-http-curl-verbose.sh

-- 
2.20.1.97.g81188d93c3-goog

