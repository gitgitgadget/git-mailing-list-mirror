Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38727C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 12:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1639D206C3
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 12:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo1ORZuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHJMby (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgHJMby (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 08:31:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D13C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 05:31:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ep8so4952873pjb.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q4A/s01DSAl+OvlBzvirRhV68y0k3OK3GORN+mGoXq4=;
        b=Yo1ORZuN9UHjBmgaGMurdLNKQA096pX/PbxJrTXjmbF35s/mlKqcl72Zj2EfEs36nj
         xuqP9rxpGUs1uT50k2HeGriuhM7+jweqkD7BVd8lxzppeNparVs50fJPtLOGiX/soWVS
         HGliffMwOwGSf/p8sEcx3n1jzeb90OavjoXrNx5rNK4qvi5Zodih/pBuheJFeel1KT0L
         ufdwc//P4JZbPoQhYEKiDZA2mmMjNY3YUTB8za3QLVKsjOtrE6VZH+/Y7aaZarC+mod5
         8KF8IWmpU+Fjaly8/BY/QAGbb/k4Ii+lNpJR2y2eL8S3N6hrpi5ejNCC5E83qFI5Ud0O
         kqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q4A/s01DSAl+OvlBzvirRhV68y0k3OK3GORN+mGoXq4=;
        b=j/9IRWNDlhueLKooQL4gZS2uwC+lu8PCXdSz+Wl+/mckIFZhld8ll2nSJJCgcJ82PK
         XE+sAX/fIi53diCU7LkYH6eJWbMqZgmXuqLPJmbnpQXGG1kWKeCfjKQ06iNAQe0XYzWb
         tYpI1ragJq53TLyfMo9uOrndKMxW66SI6Lk6JURkxjfkQUhmL9d22RKTFX6ovocUNMhF
         MuYZh88ECAul/fKiMycGkk0N6zI7flUGtYEJxsYhgxJQVMKfFzIBTnaAqQBxH2GJAZhR
         meFvnbnmeb1N0BG7oe2w+YsT+vpDqbosT1iAZK8qwSpIdBmOSnEoaWH6X1VTRcmyBlFz
         CDrQ==
X-Gm-Message-State: AOAM530SqaqQa9cAHGalBmLPiVv5O3S8aNOrPwQcMTylgnBDWL0qV6kE
        RkXXIz6ntLryn1IqOToIHkM=
X-Google-Smtp-Source: ABdhPJzGkaOlUG1oAX+bTwAvvgq5Z5uSm7w8qLOOIaET12M14scGhGWSQdg5vDCWuZ7f/Y6kArWuGw==
X-Received: by 2002:a17:90a:c208:: with SMTP id e8mr26363063pjt.73.1597062711001;
        Mon, 10 Aug 2020 05:31:51 -0700 (PDT)
Received: from localhost ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id c143sm3931894pfb.84.2020.08.10.05.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:31:50 -0700 (PDT)
Date:   Mon, 10 Aug 2020 19:31:48 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] extend --abbrev support to diff-patch format
Message-ID: <20200810123148.GB17119@danh.dev>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <xmqqd03zej8w.fsf@gitster.c.googlers.com>
 <20200810100038.GB37030@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810100038.GB37030@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-10 06:00:38-0400, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 09, 2020 at 12:01:35PM -0700, Junio C Hamano wrote:
> 
> > Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> > 
> > > Đoàn Trần Công Danh (2):
> > >   revision: differentiate if --no-abbrev asked explicitly
> > >   diff: extend --abbrev support to diff-patch format
> > 
> > It was not clear, at least to me at all, what these patches are
> > trying to achieve (i.e. what end-users appreciate) until I saw the
> > code change X-<.
> > 
> > The changes to fill_metainfo() make sense to me.  It just needs log
> > messages that explain the intent better.  They do not even make it
> > clear that they want to make the abbreviation length of the object
> > names on the "index $from..$to $mode" lines configurable.
> 
> After reading the original including cover letter, I'm still confused
> using why --full-index is not the solution for most cases. Perhaps that
> would be worth touching on, as well.

At that time, I'm not really sure what should be written there.
The commit message was inspired by --abbrev documentation.

Reading both of your two's emails, I think this one could be used:
I'll resend this serie if this serie is deemed useful with this
explaination.

	diff: index-line: make object name's abbrev length configurable

	There are some projects that want to archive and track only
	released version of other software projects. They also want
	to backport some changes into those versions unsupported by
	upstream. Most of git hosting services support some method to
	download patches without cloning the full (potentially large)
	repository and/or fiddling with git partial-clone or
	sparse-checkout.

	Most of those git hosting services generate those patches with
	git-format-patch(1) or something alike. Due to its large
	amount of objects, their object names' abbreviation in the
	index-line is usually long but not full.

	A lot of those patches couldn't be applied cleanly to old
	versions of said software, thus requires some changes from
	developer and they needs to be regenerated from their trimmed
	tree. Because the archive tree has significantly fewer
	objects, the abbreviation in the index line is usually shorter
	than the original patch. Thus, it generates some noise when
	said developers try to compare the new patch with the original
	patch if there's an exact file-hunk match.

	Make the object name's abbreviation length configurable to
	lower those noise.

	<Below is the  note in 2/2, I don't know if it's worth put
	into commit message>

	To preserve backward compatibility with old script that specify
	both --full-index and --abbrev, always shows full object id
	if --full-index is specified.


-- 
Danh
