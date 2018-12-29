Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D244A1F405
	for <e@80x24.org>; Sat, 29 Dec 2018 19:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeL2Tow (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 14:44:52 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53851 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbeL2Tow (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 14:44:52 -0500
Received: by mail-yb1-f201.google.com with SMTP id 201so8839059ybd.20
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w5VZD26n3XTq42lDrnEakZoUJuswe2Gti0qRnN36YXM=;
        b=r2XEPFtuh3A3DjQ+rt9i/cQOPhImgbOmhi67HyDc8g+qhHWT+lnsFPSxce/VgHx59S
         No60v00a7JpoztjJihTIRpct5Hl5+LTTpZXh8Gfn6FDJfdJd2Vr0pi8thiMTIyrMYhxK
         Sv61/68aLzfG768Pl+H9bMsbg2Xh/3hP5LEq6qUYBglqoEZ2bgESOl4xY+F2Zs5xf7IZ
         rYEx+AgA+Jn5VZQ857qlEN06DndjR31A2vFuxXINwETOMH2lCqimV39Yiu6lLPEUe0X1
         XK8nKdmc9jHgjcl3+OlWqwHILj01PHXsroovC+/lK8w60edYExsmWKY6hAhEuyNcH+fA
         figw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w5VZD26n3XTq42lDrnEakZoUJuswe2Gti0qRnN36YXM=;
        b=CnC3jyKw6onU+0hKkPqf4tpzL6XBx/HZzew19MUklDlfyewb2EWRHfdMEYAIb3R2nk
         ERqrdZlc9YBzlaFS8JqSazMy7xteV9oSwUvvCn/nM38zolZH/O/zDbuF7yGuESMj36wE
         7qrR4l/GNg/7LTKtAW6X+aiWNPQR2ZgGq1GB0pG6zQciSybtcl04zIRqFTqdSo7t2mCY
         vHGClXvPf0olzpoW/irYlPdC/Jeewo2hPbphaESxw32N97RRy7kyq3MNFavkEAOxw71m
         Zjpt0LOktXwlN1VtbkB/EpJxUwJrst5nZkRsx5HQ+xCqVt5yjX0QM/sBjEpfxadeXTz3
         qF9Q==
X-Gm-Message-State: AJcUukfOxiofYvYae/xallky7ZRTWaNB9Jdp9oNyjySho30ekWlr/iQL
        hYv9Z8l7jCKQCxkCE9zLy5aywthdIHxDWqi4vec=
X-Google-Smtp-Source: ALg8bN588Hp72pspkzBViId8UQ2pHLNTO/XWL6Q5h/L3A3CGr/6C0mTkKyieUHoB9UJvHWgntHvfYVAjXmTnOGkTWY4=
X-Received: by 2002:a25:d42:: with SMTP id 63mr9958881ybn.78.1546112691721;
 Sat, 29 Dec 2018 11:44:51 -0800 (PST)
Date:   Sat, 29 Dec 2018 11:44:45 -0800
In-Reply-To: <20181228014720.206443-1-masayasuzuki@google.com>
Message-Id: <20181229194447.157763-1-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20181228014720.206443-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH v2 0/2] Show HTTP headers of failed requests with GIT_CURL_VERBOSE
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When GIT_CURL_VERBOSE is set, libcurl produces request/response headers
to stderr. However, if the response is an error response and
CURLOPT_FAILONERROR is set, libcurl stops parsing the response, and it
won't dump the headers. Showing HTTP response headers is useful for
debugging, especially for non-OK responses.

To this end, the caller of libcurl needs to handle HTTP request failures by
themselves. The first patch makes git prepared to handle those failures. The
second patch actually unsets CURLOPT_FAILONERROR.

Masaya Suzuki (2):
  Change how HTTP response body is returned
  Unset CURLOPT_FAILONERROR

 http.c                       | 103 +++++++++++++++++++----------------
 http.h                       |   1 -
 remote-curl.c                |  30 ++++++++--
 t/lib-httpd/apache.conf      |   1 +
 t/t5581-http-curl-verbose.sh |  28 ++++++++++
 5 files changed, 110 insertions(+), 53 deletions(-)
 create mode 100755 t/t5581-http-curl-verbose.sh

-- 
2.20.1.415.g653613c723-goog

