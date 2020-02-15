Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BCEC35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9608C2073A
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BgnN8Bd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgBOAKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:10:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44873 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgBOAKk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 19:10:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so4301069plo.11
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 16:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yksVEJVTGsk5YP3yWTxS1lfHWIpjQnaYmORYYU4CLoI=;
        b=BgnN8Bd2KapBJOeMx4oV3A5o5jwbCfpYuNA2nC0yiA26+8KzqgTFYI4PTV51G7x4+U
         1tRyjRVUX4j/fzqmdsEqv0MwrFdLnPpH/e8SALYvG4kNMxt5iPARfJSf/guNyYBMhsRY
         eUhrqAoCSP2YJChiJ4WornC7a69/cGCWjakdunzYOaWQdwVOEnVohM/IwAaWPw8MHKoV
         qhNEgMRMzSmEA80kM85mAF/+jxQMY6I0FRb4Jfipluow/IpOoW35hbHMsPrw6Ivh9vAv
         562gsuEhyQc6tKpjcQj6KQIEuTXYdo/sFlZEyYR/4+PVDObjv62FZJQrVH/nRzG+8om1
         Kctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yksVEJVTGsk5YP3yWTxS1lfHWIpjQnaYmORYYU4CLoI=;
        b=oHWhjATS7gDA+zGwqpwtDwj+tDv9iYP+Ugguk53EtungP7TzaZmfm4P3sD3DuzoLQL
         XwGRjYQo8WTFS2KRE+v9AnJ+8MVcArTIV2N3lAkSQFKVyTqTzzNeKxNAD+vjKsSf8LjS
         Y94A1yYtI6xbPHG/Y8nOSvFTuxUd+JNNNO1CiuyGXh04hKEWLEkk1cadKfdqucqZm/s6
         QFPx4rH0hWIqAb0S0X8Tv2lKjufHWP3gid9brFUYpgSRUZ0l5kLAzAgeZy8c+YUxYTyf
         EZoZ6gG5UqMcZM4WxGQtzwr3eEqZ2Sn3YSOXKwA+A6OvCaj3WP+xy2KFFfyDhUaX50v0
         dTvg==
X-Gm-Message-State: APjAAAWkbq/66rppMSD1gm/6GlwtPvqpICOETQPtZLzqZg+6qIp7cieo
        pCoTxtfSyYY1316xLc532LkjjQ==
X-Google-Smtp-Source: APXvYqy8SJ9/JBUVamW7ELC9dmjEQ9Obw33ALii+VZDpti9mWiuD0zsVkuNXHJayaZDa4TIDuyqvOQ==
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr5588790pls.262.1581725438024;
        Fri, 14 Feb 2020 16:10:38 -0800 (PST)
Received: from localhost ([2600:100f:b02c:92d4:11e2:3a54:273f:b5fe])
        by smtp.gmail.com with ESMTPSA id x132sm8251150pfc.148.2020.02.14.16.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:10:37 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:10:36 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/15] pack-bitmap: factor out type iterator
 initialization
Message-ID: <20200215001036.GD11400@syl.local>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182208.GA150965@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182208.GA150965@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, Feb 14, 2020 at 01:22:08PM -0500, Jeff King wrote:
> When count_object_type() wants to iterate over the bitmap of all objects
> of a certain type, we have to pair up OBJ_COMMIT with bitmap->commits,
> and so forth. Since we're about to add more code to iterate over these
> bitmaps, let's pull the initialization into its own function.
>
> We can also use this to simplify traverse_bitmap_commit_list(). It
> accomplishes the same thing by manually passing the object type and the
> bitmap to show_objects_for_type(), but using our helper we just need the
> object type.
>
> Note there's one small code change here: previously we'd simply return
> zero when counting an unknown object type, and now we'll BUG(). This
> shouldn't matter in practice, as all of the callers pass in only usual
> commit/tree/blob/tag types.

This all makes sense, as does the refactoring below.

On a relaid note: since you sent 'v2' before I had popped enough items
off of my TODO list to look at your 'v1', I'll start my review in this
thread instead of in v1.

> Signed-off-by: Jeff King <peff@peff.net>

Thanks,
Taylor
