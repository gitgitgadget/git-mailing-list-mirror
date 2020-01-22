Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5CCC2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 19:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0492624656
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 19:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyVwqAKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAVTZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:25:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46954 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgAVTZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 14:25:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so183839pll.13
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 11:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=op9LzUQbG4OHWV4vZbhwiiBFORXlamCgs+ON5YJUxhU=;
        b=tyVwqAKkSzx9mWidwY4+2F0/V0EZFYtjstik/JY5S7xJj5SrYdWbaoVLGKQnDhwTiu
         idZh24mYO5a8dMy1LY0LdU9Rp85z1rwhje8H0NWnCoG+QmUzmfrtP6+LJc05TvJKz0NA
         wooyfomBLetEeg7CamxmLxAPNP0/xybZgZn5FctrCX5Zf4kK8Q01kA0GFaTxkYDaICO+
         7u7quukSm18z+PUcxLUQYIGjWYvHRfJg0aLhBVUPN0O0C3mPrvjfZa30S0icnIxwb6EU
         qoYHYin6reT2b3fK5z5/WnfaRJOGT+TiKZf5JOryD5x6pZfCyqCEhZhO3LERgg1zBfwK
         dE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=op9LzUQbG4OHWV4vZbhwiiBFORXlamCgs+ON5YJUxhU=;
        b=sSRFbqzm6euj17lgalN4Mz621XV11JqWGAHPd5ZKkK801MkVBJBJ9/yP3ExZuMOwMF
         QT3+KhthxhuMvNn+LZ1Iv33wXdw6p8FnrC/iRDctvLoXkLBmTLpmu9eyWSr9dwlcFQrT
         Xkz6nVQUV3AfIEkR2X8vUfUCNWX8SQ3oid5rRhz3QNpPkHfvpdcgeEEwwmjwPrh1vKpn
         aBTwhYX2kDqpqBmnMoKN849Gt9vUvgsxuhFygIZebjY6KTsTKhJkh3begpG2gTxcHNUc
         kTV24oxCcURbiOOcSVeyzu5HGGWBeFGwCQp0lI0oKBPqEuN2V+fPFLyksY3fFnrnZ3Jn
         mcHg==
X-Gm-Message-State: APjAAAUC3iLv+MMvve1yKaWB9hRtVhiHc78G31P4zXw5mzhLqW6Kfkzd
        2g48ldI6nrUmW4YkavuxgHSNZA==
X-Google-Smtp-Source: APXvYqwIhm7FzpCjpZZ22rDDTcJXFqY2cLXLKlFDZQuqwVEMiV+rHne6y+LZCyW/FdV8TmsG8M7oHA==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id b44mr88368pjc.9.1579721122908;
        Wed, 22 Jan 2020 11:25:22 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a15sm49197905pfh.169.2020.01.22.11.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 11:25:22 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:25:18 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/5] Documentation for common user misconceptions
Message-ID: <20200122192518.GO181522@google.com>
References: <20200122034543.18927-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122034543.18927-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 22, 2020 at 03:45:38AM +0000, brian m. carlson wrote:
> This is v5 of a series improving the documentation to cover common user
> misconceptions.

Thanks - it makes me happy to see these kinds of clarifications come
through.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
