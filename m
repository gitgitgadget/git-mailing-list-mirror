Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AADC55193
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FF620772
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN+LnNcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCTBlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:41:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36518 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgCTBlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 21:41:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id i13so2416475pfe.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 18:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z4e2lpJRnKKKktCpaQ40yOlZCnbWc8gw0IDDf07aLQo=;
        b=gN+LnNcKO5QlfqgK8Epn1Z2SklHCJID1uRKCwf23Z29/trb5BDGGHYxdGhfO+Kmw3+
         CGDOF3qnXwCqYlugrU9EAg4AF2z9ieTAGmiw2+60HVA/TPe2T1OBxe2GVwAQuwYqCLW/
         6XxVv6AhAc1Du8lkMvfa6mkZTv+glEh3JztS/h/R8yDWyyF8aE24ZvaZC8JnUvDkc0IP
         xcyRDVAOk7F9bA5cRGktfKrigJyfUASM5fi9wUwH3T3JuVhiCIgkMoFN8ZTAZyUXNRS9
         XVEdyqRn93JNgYrSxszB2iByAWvSwPC48CF0FwBsaLbO6QyrMVcxK62SOF14UEdjIIyI
         kR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z4e2lpJRnKKKktCpaQ40yOlZCnbWc8gw0IDDf07aLQo=;
        b=nCGt27VRBZk09MBWuxlmhW4QH63qiI6wZdZKSVswHdiK/BDqe9NPo+XFt6L+agbk9N
         nqWDn18bylXWuAijK+vEn5oZVyOTELRxOg/txL8Ou6YQsbz4szN9ZyyfMXuxCCb0knSF
         F8Oxodnd74ux0f96XvElrG84Dp1hG+oEfLHo5j7SFGs8Q+NttVX9rhDTo37O2WiSZXOR
         Zff9eMizgyZzzYmcwmOwu+k6otukoTDSqF2aWCCgvIc4DQyGikd+kD0dy02RMNX2eavk
         5lf2zNeQ+Xt8eog6wX0bAhhpiBq+h7enxcfxttrYl+A0BeUntXmvr4fC7MtpcoBVFR0L
         bwZw==
X-Gm-Message-State: ANhLgQ2fA+MvG0Xoi+TMVWGeG7cfvVy9cbjsIoTw9dAJrevKq2eggOMA
        aKoNeqcXIIquY9tDmziufto=
X-Google-Smtp-Source: ADFU+vuE0ERziYQcIu5XWBu1qlsfvvf+IHe//nrHFTNt8ltfpYe7dWPdjlMjRcRaC01YgbOKbo/01Q==
X-Received: by 2002:a62:1a03:: with SMTP id a3mr7068428pfa.171.1584668504908;
        Thu, 19 Mar 2020 18:41:44 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id c190sm3561891pfa.66.2020.03.19.18.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:41:44 -0700 (PDT)
Date:   Fri, 20 Mar 2020 08:41:42 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 5/6] t7063: use POSIX find(1) syntax
Message-ID: <20200320014142.GF1858@danh.dev>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <215801b02aceeed1e0f6313679c567a914ad5dd8.1584625896.git.congdanhqx@gmail.com>
 <20200319161200.GF3513282@coredump.intra.peff.net>
 <xmqqsgi4c7o6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsgi4c7o6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-19 15:16:09-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Mar 19, 2020 at 09:00:06PM +0700, Đoàn Trần Công Danh wrote:
> >
> >> Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
> >> update feature, 2016-08-03), we started to use ls as a trick to update
> >> directory's mtime.
> >> 
> >> However, `-ls` flag isn't required by POSIX's find(1), and
> >> busybox(1) doesn't implement it.
> >> 
> >> Use an equivalence `-exec ls -dils {} +` instead.
> >
> > Makes sense. I wonder if we need all of "-dils", but it's not clear to

From the original commit message, I think whichever flags that call
stat(2) would be do it. It's `-d` (to check is_directory), and `-i`
for inode number.

This make make wonder, will it be enough to just use:

	find . -type d >/dev/null

> > me which syscalls actually trigger the FreeBSD lazy-update behavior. I
> > guess probably it's stat()ing the directory, so "ls -ld" would be
> > sufficient (and that's implied by the examples in 6b7728db81).
> >
> > But I doubt the extra options would create a portability problem, so I
> > think it's fine either way.
> 
> Thanks.  I too wondered if -dils is really needed (POSIX of course
> have all of them, but we have to deal with non-POSIX systems, too,
> and I am not sure how things like "-i" works there).

I think "-i" asks for stat(2) to get inode number,
which will ask FreeBSD sync mtime.
> 
> s/equivalence/equivalent/; perhaps?

Will do, I've never correctly used -ence and -ent pairs of words.

-- 
Danh
