Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F69FC433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E1964EE4
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhBETPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 14:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhBETOD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 14:14:03 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4741CC0613D6
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 12:48:52 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 70so6916257qkh.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 12:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MSEstI0OOSZv49BTCgIaLzh/dwIFth+2yLyA7eGroxU=;
        b=ijUTmslN48ykMxMvrH9JPINfLg5t9PDXKoWLwTqsUopM4SyMxkZmoR+dbCtlYxyZFD
         KL9kvqLm8SzSkkYCPgC3wd8421ecalLkiI7wk9AZPfxT8sEV7MafqPGnmXl519nIUDCy
         y/D/PhgJR4SG0iXUOWqinhl6seaXhdJh+H9hGBG9YD51RkgdIK5v5Us7Bns0rIouqpsD
         7XSELFZXrBGqrSxuUlDuuiu/Q6U4I9bC8jOmjrnUKPYi9QlqR/j3vC5cX1f1bLq+sbp2
         zlUbrsklbZ9s5G8QagpgsO7aDe4bbp1h+5eV9Yg1OuGPdJOQbok+O43MwXLJSM8nDCOH
         HDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MSEstI0OOSZv49BTCgIaLzh/dwIFth+2yLyA7eGroxU=;
        b=U8qV+WdMWEGcYFT6sRowaPCh84mh0UrtVT9as5Ne7UVKqVah8HlDt8H9TQvkHImxSh
         0GkgU49IrtWts4ZRLBz6pFz4O0nKaIXjmYSlGuxGsaZYZ5ZrcuibBT6GnYjWnYQojMLi
         H5L6ux5IumrQZWmcoVyqDWpdiKOL3GfGGZh0D1PZy0+gnfsemxjUVSZAxDuUixymiorw
         hv9WFy2/07uUsRjME2o0ZHwRNQw/5DETTiIrW3ZqQ2qtdc6Kiwiobmh84W7b//Y/OZ/M
         a9bp7lJzd7WeNI0pnx0Up5QOHc6+4ZuCVu/DA35AlIiHdjvXnHWYQqebSbt7pgbMZA3U
         K+Dw==
X-Gm-Message-State: AOAM533jWrPDZuG8oESkGmD+9GDELNW7JImnNGNufa7VD03rpt1C7HzF
        eRpPrif+77uhzzhtrkvzGoQCYXELdvXg92S0L3m7rsfDMlnBinJcymKQcSEnpklh/HoTvEwAPFs
        4PfsWlJJqTnHhDNjnZhz4lhuKitMFG8hINc6Y4PJaiEcDLYDUe9PTPOinxnidpjRtVLoHUwf0qh
        aK
X-Google-Smtp-Source: ABdhPJw28pMuEaNVv/ypYwOEvUm1skPRlBevTo+uYTR24p2R9j3qd++SEZYBVoulIWYugzjIKlgo1B6ebWcq22eho+VW
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:b912:: with SMTP id
 u18mr6127865qvf.2.1612558132101; Fri, 05 Feb 2021 12:48:52 -0800 (PST)
Date:   Fri,  5 Feb 2021 12:48:46 -0800
In-Reply-To: <20201208013121.677494-1-jonathantanmy@google.com>
Message-Id: <cover.1612557937.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v8 0/3] Cloning with remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff sent a review (which I don't see in lore.kernel.org/git, but I do
see it in my inbox); here's v8 in response to that.

As you can see from the range-diff, there are just minor changes to v7
(wording in documentation and a memory leak fix).

Jonathan Tan (3):
  ls-refs: report unborn targets of symrefs
  connect, transport: encapsulate arg in struct
  clone: respect remote unborn HEAD

 Documentation/config.txt                |  2 +
 Documentation/config/init.txt           |  2 +-
 Documentation/config/lsrefs.txt         |  9 +++
 Documentation/technical/protocol-v2.txt | 11 +++-
 builtin/clone.c                         | 34 +++++++++---
 builtin/fetch-pack.c                    |  3 +-
 builtin/fetch.c                         | 18 +++---
 builtin/ls-remote.c                     |  9 +--
 connect.c                               | 32 ++++++++++-
 ls-refs.c                               | 74 ++++++++++++++++++++++++-
 ls-refs.h                               |  1 +
 remote.h                                |  4 +-
 serve.c                                 |  2 +-
 t/t5606-clone-options.sh                |  8 ++-
 t/t5701-git-serve.sh                    |  2 +-
 t/t5702-protocol-v2.sh                  | 25 +++++++++
 transport-helper.c                      |  5 +-
 transport-internal.h                    | 10 +---
 transport.c                             | 23 ++++----
 transport.h                             | 29 +++++++---
 20 files changed, 240 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/config/lsrefs.txt

Range-diff against v7:
1:  2d35075369 ! 1:  8b0f55b5e4 ls-refs: report unborn targets of symrefs
    @@ Documentation/config/lsrefs.txt (new)
     +	protocol v2 capability advertisement. "allow" is the same as
     +	"advertise" except that the server will not advertise support for this
     +	feature; this is useful for load-balanced servers that cannot be
    -+	updated automatically (for example), since the administrator could
    ++	updated atomically (for example), since the administrator could
     +	configure "allow", then after a delay, configure "advertise".
     
      ## Documentation/technical/protocol-v2.txt ##
    @@ ls-refs.c
     +
     +static void ensure_config_read(void)
     +{
    -+	char *str = NULL;
    ++	const char *str = NULL;
     +
     +	if (config_read)
     +		return;
     +
    -+	if (repo_config_get_string(the_repository, "lsrefs.unborn", &str)) {
    ++	if (repo_config_get_string_tmp(the_repository, "lsrefs.unborn", &str)) {
     +		/*
     +		 * If there is no such config, advertise and allow it by
     +		 * default.
2:  d4ed13d02e = 2:  f09bd56d5f connect, transport: encapsulate arg in struct
3:  a3e5a0a7c5 = 3:  a5495a42f1 clone: respect remote unborn HEAD
-- 
2.30.0.365.g02bc693789-goog

