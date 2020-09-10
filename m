Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F8C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A88E20872
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbVLlNAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgIJIiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbgIJIgh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 04:36:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089CC061757
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 01:36:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so4197865pfc.12
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=48B5pjbbRchrgdRDFlu65ENFFh5CQWUbolbfZGAc6Sw=;
        b=LbVLlNAuuBbswrlm6Z2tZeHq3/afTT1lijUXhJzEoxzOjVYvNXSMedQ3uJlgulA4SG
         SYYFm5GBRbj2B3cJGo18YCThq5uitT6KEWPrElmP0okhNxMPqnrbgNnsGt/Ubze12kr3
         tkXFh9KsjC09wKJ2KzHeK32RUD1zvWq1h0eWb69YlJ5IblS78aGz8K5/0jwGEGTMBw/7
         MOB6SOH6ToAhY5R6gr944ihKCSQouAi49kMDo3kNjrFnjDdYOLtt9h4erTsjrKJvsKar
         uqeLR3HhKY4LCf2yKazAcApp3iniUFMBoriwdSz+klseCw/cdrIPDQXOW5jRIwGfBa+9
         +8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=48B5pjbbRchrgdRDFlu65ENFFh5CQWUbolbfZGAc6Sw=;
        b=fjV1UI/LJUf6fpJW+eZkZ/L4I1Lc2MhHHf+Nd1LCYzVV8P+dKsddELliruNpVaOmYS
         yP8262gzVLrMGtuK+/APTMZbiud/6je+uaNZsx3F1bypesPJ6aOV5Ya3HX1+/uuhz1DF
         q2+QC2iPbMvEgad8xiWzweYLGUy5Dhm/m99ouCU8YaIR3eLVLncEv+DxLneyDNVZq0nj
         GToLQQrwXVxDefcEHWx6orzshRyzHw6KOe9RVfmi/FLyLNWKShTP1/f612am3/OLebTT
         OAW0//dPmAt+0Q+5mWryuE1RwK4n2qTX2Z4VT0jQf46N4zx1f5kFsu4QiaLLa3lLmYNi
         k3VQ==
X-Gm-Message-State: AOAM533HdMo1ouJKO3yR6AhnMLbg5/Ugy74KMDWBISuAvs9+h9Hfma+U
        iwBNAZTMaZIz0oZSEGdRZic/OL5nnJQ=
X-Google-Smtp-Source: ABdhPJzfQ0FLe+6BqJ83zjUGlVQV6/ULZwKALdlJfLx/pKJSdHWbSTaMQ10LxShxYqkSFLdnDuDcIw==
X-Received: by 2002:a63:5d09:: with SMTP id r9mr3369391pgb.397.1599726977909;
        Thu, 10 Sep 2020 01:36:17 -0700 (PDT)
Received: from generichostname ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id b20sm5479704pfb.198.2020.09.10.01.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:36:17 -0700 (PDT)
Date:   Thu, 10 Sep 2020 01:36:15 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 0/2] gitk: fix mix of tabs and spaces in indentation
Message-ID: <20200910083615.GA1407716@generichostname>
References: <cover.1599726439.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599726439.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 01:27:40AM -0700, Denton Liu wrote:
> Denton Liu (2):
>   gitk: replace spaces with tabs

Unfortunately, the patch is too big to be sent by email. It can be
retrieved from https://github.com/Denton-L/git.git
submitted/gitk-whitespace~.

If you don't want to pull it, the commit without the body is included
below. It can be fully reproduced by running the vim commands listed on
the gitk file.

-- >8 --

From: Denton Liu <liu.denton@gmail.com>
Date: Wed, 9 Sep 2020 12:10:51 -0700
Subject: [PATCH 1/2] gitk: replace spaces with tabs
To: Git Mailing List <git@vger.kernel.org>,
    Paul Mackerras <paulus@ozlabs.org>

The source code is a mix of tabs and spaces. The indentation style
currently is four spaces per indent level but uses tabs every other
level (at eight spaces). Fix this inconsistent spacing and tabbing by
just using a tab-indent for everything.

This was done mechanically using the following vim commands:

	:set tabstop=8
	:set expandtab
	:retab
	:set tabstop=4
	:set noexpandtab
	:retab!
	:set tabstop=8

A future commit will manually clean up the code style errors introduced
by this patch.

This patch should be empty with `--ignore-all-space`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 gitk | 20408 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 10204 insertions(+), 10204 deletions(-)
