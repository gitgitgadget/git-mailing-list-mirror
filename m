Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2312C433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C4964F17
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 17:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhCOR4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhCOR4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 13:56:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C3C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 10:56:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g4so20920873pgj.0
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qQK13U+sgfsB6XJAHkDJYDD9aE4XBJyqw6aBj1A5rSk=;
        b=JOvjSybdOquHpGRBuAlk1CWoX7XY18cwtdHX4w+pdx8UIuW90rH86M+u6eT35r9M9A
         nv6WYhinJusP5kYO+ZOq3B5pS5lt+BVpxaQHJwcO2a0GfvGQjQFp53rvxn1sol3/l3O5
         fjJFyD2whnjJ+9Qr+9dTsIEf8yjwHKGVTzKJA7AnWIBRNvNBD3maxYyb3JSRNb6SB5IG
         q77LOOn41cY2flAgzF/rqxqqfEOo10RbV3xlg4jr6QJW35uX146tpXeWndf4JwIuswlK
         cJBtJLMeKLmoPJ4ErQ4/dqp9CQG1mRbr/yXx8G+awagUuQf9z8TRqWnSkIriIV7Xj/Vo
         u0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qQK13U+sgfsB6XJAHkDJYDD9aE4XBJyqw6aBj1A5rSk=;
        b=lAFUYyKcJvnqI6RnIB5jzuFxlzf5UaaL3vGWjwOE646nydeUHpuaTuUoI6az+1Qe2e
         C62FHAdHjtNMw9BuX8xwYQHQmyqrrtGZ5t3AexPU2gQrIiJhGB7loM5qjfq217tIlASO
         QuHQtDVw9nCDgUnZfEJSaUhuHkhEcjaGZ2tSjXdU2ljptoxbuf94WmwbxbcSinE3+DRH
         HeeTmHHUmVvptCr2ggT89TTFbJw/kia8fkaQeBX+zcJTB/jNKM0iSLm3+3Dr6nxvzOZl
         R5rZHRDPU0RzHqa0hDxgfAr2WzBSk1SV5XrUWtw99LkGgmP2wvAujEQ5zNYup87JHH/J
         BOew==
X-Gm-Message-State: AOAM533Ar9nu6MSfURxX0mvGwYDRSLGgwZbEFVUvZINPiGsUBF6pkN5I
        vOw6JoeYHbFtiE5sIPvMJFpWVo1UBh4=
X-Google-Smtp-Source: ABdhPJwlOYjUN9g0ShB7KNAu1pQK7RCTi0lWos1jQYlpNhH6E2fKK4cnnBzoBceFW7BuM2M7yISf3Q==
X-Received: by 2002:a63:d601:: with SMTP id q1mr243269pgg.417.1615830968864;
        Mon, 15 Mar 2021 10:56:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a882:1728:d98:a765])
        by smtp.gmail.com with ESMTPSA id k10sm13768455pfk.49.2021.03.15.10.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:56:08 -0700 (PDT)
Date:   Mon, 15 Mar 2021 10:56:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
Message-ID: <YE+ftT2WaKDzc+45@google.com>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Drew DeVault wrote:

> c05186cc38ca4605bff1f275619d7d0faeaf2fa5 introduced ssh+git, and
> 07c7782cc8e1f37c7255dfc69c5d0e3f4d4d728c admitted this was a mistake. I
> argue that it was not a mistake.
>
> The main use-case for the git-specific protocol is to disambiguate with
> other version control systems which also use SSH (or HTTPS), such as
> Mercurial, or simply downloading a tarball over HTTP.

Following the trail of links, I reach
https://public-inbox.org/git/CA+55aFyWqK0bu2V1SYagrYCBGpj0=2orobK2vT-KRkqpq=kgtw@mail.gmail.com/,
but that email mostly just makes assertions rather than explaining the
rationale.  So it's probably worth talking it through now.

> Some things that are affected by this include package manager source
> lists and configurations for CI tooling (the latter being my main
> interest in this).

The original idea of URI schemes like svn+https is that we can treat
these version control URLs as part of the general category of uniform
resource identifiers --- in other words, you might be able to type
them in a browser's URL bar, browse the content of a repository, use
an <img> tag to point to a file within a version control repository,
and so on.

_That_ idea, at least, does not work all that well.  There's not an
equivalent to a fragment identifier to refer to a particular file
within a repository.  Further, if I have an https URL referring to a
Git repository, I'm better off viewing it without a "git+" prefix
because then I can see the content of the repository using a web based
repository browser.

In other words, a "Git URL" is not a URI at all; it's simply the
identifier that Git uses to clone a repository.  A package manager or
CI tool is perfectly within its rights to provide its own naming
scheme for sources, such as "git::https://example.com/path/to/repo" or
even the same with "git+" prefix; or it can use an https URL and infer
from the content it gets there what version control system it uses.

The missing piece is an HTTP header to unambiguously mark that URL as
being usable by Git.  I'm not aware of a standard way to do that; e.g.
golang's "go get" tool[*] uses a custom 'meta name="go-import"' HTML
element.

Thanks and hope that helps,
Jonathan

[*] https://golang.org/cmd/go/#hdr-Remote_import_paths
