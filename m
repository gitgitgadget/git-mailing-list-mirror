Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3522C43141
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 04:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7442320659
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 04:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJlIzte4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfLDEow (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:44:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42196 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfLDEow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 23:44:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id l22so2965606pff.9
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 20:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kAAM4rP7Y9pA4vO4uIPTkJqPiYRXWBJBRaIgTB7Cx74=;
        b=HJlIzte44BZaPSbwyTmYAFHPXBmxsCuuzr4eHJZIDBTZ/doI0Q3gL2r3iSFtIVeTC0
         Yfkv+2OQZ8zAV6/K7PNBwBGLFdjnjiSRu+KmF8iwrcmHpdMvFpnXF55qeub1ECYKTaCr
         fVd+1qJ3XnbGe7rEtZA41rWXz6m6kgy0Xi0nz79cOusiS+Oa57SiwPRkQXlnOM5qUs/Z
         B8yvco9n0NrxMLzfSHeR9KrG3fQOz9F8wFZ1QYjDl4zUrxA8fbWFWQku4DAIC7EPW9s1
         Npum/89FAOL+/8S9r4peWnMu7bQXLlxJ8zJpyh/bM3v3XaHFeHBkEkxmPFCWRheemeCu
         itWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kAAM4rP7Y9pA4vO4uIPTkJqPiYRXWBJBRaIgTB7Cx74=;
        b=eTlwuWuwhQ4Z5ooU+EDcEBk+WutzgDLLkHwM8PDbRjVrLB4NhUOxFUwMJEIcefAqH3
         Kc/eGTxP2jFwrCxFhikzj8mNM68bfOdJrCC4LCy3iZARjsc5IpoYH7x058LYrx8cuxOq
         v0tW+LB6DqfmuIDCXHX6G8sN91SkSBw6w+Y5nKVAV3HAwD3h0ZC28cyi/rZE+Q+/ZNlg
         UL0dRR16hX/ja4mz29Lrfokmho5s1t7YINcFDkWNrAI3RG8KULqHgAaC8GIS8KuyaIzf
         opkAxY8UxgrWbH6e4VSppcxWmhMYUOW3eU153i/zb/3wP/5hNWP6JGk/UYaRhLBe1Ojv
         qZrA==
X-Gm-Message-State: APjAAAVwxPUVTIwQhm0+IbuOXRZNXQ4dDwNTQwr2RnqB1mT+W8C1ZfLt
        seNHfgHUxlbWim+3hHUNGck=
X-Google-Smtp-Source: APXvYqyGqhZ0pAL8Q3fURZVJTujguzYBvrTn8B4GW/1vV9Mvp1hAETZV6nHsmiGpq/ceDHcONx2yCA==
X-Received: by 2002:a62:7a11:: with SMTP id v17mr1516671pfc.191.1575434691621;
        Tue, 03 Dec 2019 20:44:51 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id fh2sm4753504pjb.30.2019.12.03.20.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 20:44:51 -0800 (PST)
Date:   Tue, 3 Dec 2019 20:44:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] contrib: git-cpcover: copy cover letter
Message-ID: <20191204044449.GB226135@google.com>
References: <20191203201233.661696-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203201233.661696-1-mst@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Michael S. Tsirkin wrote:

> My flow looks like this:
> 1. git format-patch -v<n> --cover-letter <params> -o <dir>
> 2. vi <dir>/v<n-1>-0000-cover-letter.patch <dir>/v<n>-0000-cover-letter.patch
>
> copy subject and blurb, avoiding patchset stats
>
> 3. add changelog update blurb as appropriate
>
> 4. git send-email <dir>/v<n>-*
>
> The following perl script automates step 2 above.

Neat.  I wonder, should "git format-patch" learn an option for this?
E.g.

	git format-patch -v<n> --cover-letter \
		--last-cover-letter=<dir>/v<n-1>-0000-cover-letter.patch \
		-o <dir>

What would your ideal interface for this flow look like?

[...]
> Any feedback on this? Interest in taking this into contrib/ for now?

I don't know what Junio's preferences are for new contrib/
contributions, but I kind of like it.  If putting it in contrib/, my
main advice would be to put it in a subdirectory there with a README.
That way, we have a good place to document what it was replaced by
once it has graduated to a standard format-patch feature.

Thanks and hope that helps,
Jonathan
