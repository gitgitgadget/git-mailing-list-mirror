Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A56C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 02:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774FC20752
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 02:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsLmFdb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCTCUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 22:20:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36130 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgCTCUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 22:20:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id z72so2305768pgz.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 19:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NycIDDd0DreX0TKVifgxAFSck2f5SH9Ox5D3/yFEh2s=;
        b=CsLmFdb9P/cRKPJfV+HASIG5FikPxUjpqzHA5bLQSUmpWHyXHZBYS1EPa7ZgCzgNuG
         YijpJglbkLQv2kxlmfaCfduRDrxjMnrV91OgjEpKS2qNhV2+q3y5v/DEQjJWflklrL4i
         gLzwd5dMbOC6anBDmehShKLX1vMcjmyPYXzYUZtNgCs3JL8gcvSmAFnvB8ZN4cEEf7gy
         /JV4P7S2eWwnKHpsxVvS/QadmIXqc8eTYIJD+Ye/cL/M2JX0oxfn+nnhwSs5To99Q/rM
         BOKTDO9rh33hA3N0JonvxBs7Z/F7xxSzGbWVQw0E81sjlWWZsgeOehi41kHsEchjB9CZ
         HXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NycIDDd0DreX0TKVifgxAFSck2f5SH9Ox5D3/yFEh2s=;
        b=eywkHT+OZWYclQxg6O9zKMi3/lHXhyn+DoweLZor05aHICwoORK8AWzLVaQTwWvYMD
         xaTtXR+oRMCQBIRCe12M3YRWdhvd+jxKAnKCsQVZKzL4Xolf8PUnDXq/p58hyX9oD78Q
         PX9H3bIxBm2Gc57EVtp6ygPPmlYDpDc+Vlc708N2arhO3GYBrZfdfkYWJkjZD0Phxcgg
         M0QR5bRCILxDHjbs0lcMG3H1d5ETkM4m+UiQ5IWPJtFJP+TahhpQh+dY4eyGSiTK8SfD
         s0FALuqEqZKUPtjPM67jjtWBUYBQVSbr9t2XS1CUttFLTu3yReo5jWAf7ZGsf+oljbOI
         YWHQ==
X-Gm-Message-State: ANhLgQ34+i5JOjg7XYnfVg0YKRT1KWLBROPXP036YqYvfXvrzCLrQc5h
        zzqH/Th/G958DGAFCDoX6kbqt6XCwxY=
X-Google-Smtp-Source: ADFU+vvXm3KYFwVM9brkcmBnGH6YadgedZAPUoQU726EziKQ/nNfazUi2HkYtq4lSIbLxxcAhFMlaA==
X-Received: by 2002:a63:3103:: with SMTP id x3mr6289678pgx.209.1584670806546;
        Thu, 19 Mar 2020 19:20:06 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id u3sm3648222pfb.36.2020.03.19.19.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:20:05 -0700 (PDT)
Date:   Fri, 20 Mar 2020 09:20:02 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 5/6] t7063: use POSIX find(1) syntax
Message-ID: <20200320022002.GA13597@danh.dev>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <215801b02aceeed1e0f6313679c567a914ad5dd8.1584625896.git.congdanhqx@gmail.com>
 <20200319161200.GF3513282@coredump.intra.peff.net>
 <xmqqsgi4c7o6.fsf@gitster.c.googlers.com>
 <20200320014142.GF1858@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320014142.GF1858@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-20 08:41:42+0700, Danh Doan <congdanhqx@gmail.com> wrote:
> On 2020-03-19 15:16:09-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Thu, Mar 19, 2020 at 09:00:06PM +0700, Đoàn Trần Công Danh wrote:
> > >
> > >> Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
> > >> update feature, 2016-08-03), we started to use ls as a trick to update
> > >> directory's mtime.
> > >> 
> > >> However, `-ls` flag isn't required by POSIX's find(1), and
> > >> busybox(1) doesn't implement it.
> > >> 
> > >> Use an equivalence `-exec ls -dils {} +` instead.
> > >
> > > Makes sense. I wonder if we need all of "-dils", but it's not clear to
> 
> From the original commit message, I think whichever flags that call
> stat(2) would be do it. It's `-d` (to check is_directory), and `-i`
> for inode number.
> 
> This make make wonder, will it be enough to just use:
> 
> 	find . -type d >/dev/null

From the conversation in: xmqqmvktakvt.fsf@gitster.mtv.corp.google.com
I think

	find . -type d

would trigger enough lstat(2), and `-ls` was added for separated stat(2).

I guess either `-exec ls -d` or `-exec ls -i` will be enough.

> 
> > > me which syscalls actually trigger the FreeBSD lazy-update behavior. I
> > > guess probably it's stat()ing the directory, so "ls -ld" would be
> > > sufficient (and that's implied by the examples in 6b7728db81).
> > >
> > > But I doubt the extra options would create a portability problem, so I
> > > think it's fine either way.
> > 
> > Thanks.  I too wondered if -dils is really needed (POSIX of course
> > have all of them, but we have to deal with non-POSIX systems, too,
> > and I am not sure how things like "-i" works there).
> 
> I think "-i" asks for stat(2) to get inode number,
> which will ask FreeBSD sync mtime.
> > 
> > s/equivalence/equivalent/; perhaps?
> 
> Will do, I've never correctly used -ence and -ent pairs of words.

-- 
Danh
