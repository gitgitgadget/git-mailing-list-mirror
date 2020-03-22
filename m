Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BB0C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C804120767
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeTCfUEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgCVAhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:37:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45418 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgCVAhH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:37:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id j10so5483100pfi.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ga/Al7FsBRFTmA/PccU/T2pA0sb4340aLL/25q0XbHQ=;
        b=jeTCfUEL7j4pvffrtsgjYYEEZ8qtnrEzCS5EmUr6KpOjxvlmKpCeiHpkwZBNt6cHCU
         VB6SR4GoAyzgv+/crSg51UpBZSyXmCTzmRBNbqcEnSjfmRTQlmZrdko24gc1Tzbdbhfi
         vNAzDiPi2L8FNHdnaRMcvLpYz4OUpCs+KA6bU0vAUnYYVKRN52dP1tKf+d1weXYf36AU
         00zyGn41Ufs4hLan3hpNddPS2GEOyTMhU/tbz+GLvmiW3Vid8NoGJdu23SGZRAQLNMTE
         /872ucWsyY/0RqJtcZzq9AdV527hCNsCAzA5sNcd8qwtrp6zyfoR9i0JCRgO/HYzEZde
         BShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ga/Al7FsBRFTmA/PccU/T2pA0sb4340aLL/25q0XbHQ=;
        b=RE2K9vHwjkA71fcZVkz/RRd7Zy4TdidUSOISa35EjrxlqWoM4pFkekdZi9B5vz4S5U
         JYrU20i19IT4WLj5VO/M1gKbeLfs8bd9Vr1aCwpCk6B1DzzhaU5SGbaYn6t0Xg0dGCLo
         SQjUQTqwApxxiHvBx4yALBfbKFZ7bOxDr8iEOf5CzZEeo6aJBCjzU7k1VvcYhUeLATsg
         96L/NFR55UIthRo1pHKSzLnYbN3cTYBCJf77Jgjdsrsxh4WvQ/fk1TcKrL0R83cj+Lpn
         YFH2XgUcitEfaZJ0mdAtoEoi+xs5b7F6NUjl3xVh6SrT/kstoTK5dDZ0H6py5SwlAeWE
         sg+A==
X-Gm-Message-State: ANhLgQ1IhirvCfeDBYiyfoHKTkxkzjl6RZep5VlshbcVQkuVcKVOArzV
        DKxMdAzFDcnWO4i9VUTsadg=
X-Google-Smtp-Source: ADFU+vveaV8S0xGNpO1Ke162oYdjfkFckf60IB/9CCtvmt/0u9hWV484wm238mnwHrEx1J4ySIEqyw==
X-Received: by 2002:a63:9210:: with SMTP id o16mr15985947pgd.442.1584837426352;
        Sat, 21 Mar 2020 17:37:06 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id w17sm9212185pfi.59.2020.03.21.17.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 17:37:05 -0700 (PDT)
Date:   Sun, 22 Mar 2020 07:37:03 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Ed Maste <emaste@freebsd.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/6] t7063: use POSIX find(1) syntax
Message-ID: <20200322003703.GA11801@danh.dev>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <215801b02aceeed1e0f6313679c567a914ad5dd8.1584625896.git.congdanhqx@gmail.com>
 <20200319161200.GF3513282@coredump.intra.peff.net>
 <xmqqsgi4c7o6.fsf@gitster.c.googlers.com>
 <20200320014142.GF1858@danh.dev>
 <20200320053730.GE499858@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320053730.GE499858@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-20 01:37:30-0400, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 20, 2020 at 08:41:42AM +0700, Danh Doan wrote:
> 
> > On 2020-03-19 15:16:09-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > > Jeff King <peff@peff.net> writes:
> > > 
> > > > On Thu, Mar 19, 2020 at 09:00:06PM +0700, Đoàn Trần Công Danh wrote:
> > > >
> > > >> Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
> > > >> update feature, 2016-08-03), we started to use ls as a trick to update
> > > >> directory's mtime.
> > > >> 
> > > >> However, `-ls` flag isn't required by POSIX's find(1), and
> > > >> busybox(1) doesn't implement it.
> > > >> 
> > > >> Use an equivalence `-exec ls -dils {} +` instead.
> > > >
> > > > Makes sense. I wonder if we need all of "-dils", but it's not clear to
> > 
> > From the original commit message, I think whichever flags that call
> > stat(2) would be do it. It's `-d` (to check is_directory), and `-i`
> > for inode number.
> > 
> > This make make wonder, will it be enough to just use:
> > 
> > 	find . -type d >/dev/null
> 
> Perhaps we can get a friendly FreeBSD developer (cc'd) to run a quick
> test for us.
> 
> Ed, the question is whether:
> 
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index 190ae149cf..6791c6b95a 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -18,7 +18,7 @@ GIT_FORCE_UNTRACKED_CACHE=true
>  export GIT_FORCE_UNTRACKED_CACHE
>  
>  sync_mtime () {
> -	find . -type d -ls >/dev/null
> +	find . -type d >/dev/null
>  }
>  
>  avoid_racy() {
> 
> lets t7063 consistently pass on FreeBSD.

I've tried myself with a FreeBSD VM which stays on top of an HDD,
t7063 consistently pass for 1000 run.

I guess it should be fine

I'll resend with this while waiting for Ed's response.

-- 
Danh
