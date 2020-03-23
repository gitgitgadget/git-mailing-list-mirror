Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6844CC3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E38206C3
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McpCjDPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCWPEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:04:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41673 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCWPEx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 11:04:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so6013751plr.8
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uO/2ZMnEMwcQ8yDda+vL+O0Ws3tkGw8vfRGmUcSop7I=;
        b=McpCjDPbGBkw1V6GV3r4dFST+0NyqZrNkDUx4/INXMUIHXZbV/+pXnOA1inhgSHoXz
         F1Yd8nD+q+JQtKTtvLNIqqQmHY2lr+qKW//2tgOMKNsB72AcT/faymeKtEImERIMlIix
         iQq4X2kiZVMtx93kWKVhZBeFTVWEMlU/vKfu4bEhewgwKK728QfcFcGeeyoH+SJCESS5
         HOa1GXPqMwgzprMx8E7JAnfFMwZQMv5P4p7JMKcJenlBnZxxm/Em5irdV8zFOPzK+woC
         PqBI21bKf84A/ho1qNN8lrSYHTOE2E8p4AmhRr+djtbsyEg8VmPVbL+2xZdMb/4f6Ta/
         NQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uO/2ZMnEMwcQ8yDda+vL+O0Ws3tkGw8vfRGmUcSop7I=;
        b=E5/h8TCH69qouhiDiZcKKs8AroA+nUdB5avkBRIJiv54CIB5A7C5RxYkfpUGrgA0iw
         aoZwJLBwgEKLUGInnn6G0pd4MpXxSpzwt4HsR79JGHQYip+d0EI56WAnU60x5nMr+cBP
         9pCvMgcIvTUEJaBc4upw5PQsTLTn9L1meRh9d3kCB/9XhDJCcewdaWp4UAiqNitQTkMM
         ijI1bxHWxyF+mlVsp9DCUskNvQTWJf/k7LHQqIFj2CVQKlT940+yaGIUxbGRuW+6Cy5I
         rrF2Ye2i7VbAPRGv/d7f0N2Rix8j/g2f6mMFssqlh8aZ9PRjHenjl/WP80INqClKKULE
         /xoA==
X-Gm-Message-State: ANhLgQ29/3tpbSHmg/3/3T5Cbw2xH3qk4jJmV+y5QcfZ8ZipOWIquO/y
        MKGgaazbNry4IKZ+cLby7BEZY1BE
X-Google-Smtp-Source: ADFU+vumwjdPP2UdFFZZqM4S2OJo+nTKO/D3UOA7aeXbuqzOS/8qrsDo67uICMUrseUfqMsqPx76Yw==
X-Received: by 2002:a17:90a:362a:: with SMTP id s39mr26398808pjb.28.1584975892054;
        Mon, 23 Mar 2020 08:04:52 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id z26sm11642187pgc.5.2020.03.23.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:04:51 -0700 (PDT)
Date:   Mon, 23 Mar 2020 22:04:49 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
Message-ID: <20200323150449.GC11801@danh.dev>
References: <cover.1584838148.git.congdanhqx@gmail.com>
 <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-23 14:58:13+0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Sun, 22 Mar 2020, Đoàn Trần Công Danh wrote:
> 
> > POSIX's diff(1) requires output in normal diff format.
> > However, busybox's diff's output is written in unified format.
> >
> > POSIX requires no option for normal-diff format.
> >
> > A hint in test-lib-functions::test_cmp said `diff -u` isn't available
> > everywhere.
> >
> > Workaround this problem by assuming `diff(1)` output is unified
> > if we couldn't make anything from normal-diff format.
> >
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  t/t4124-apply-ws-rule.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> > index 971a5a7512..075b1912be 100755
> > --- a/t/t4124-apply-ws-rule.sh
> > +++ b/t/t4124-apply-ws-rule.sh
> > @@ -52,6 +52,12 @@ test_fix () {
> >
> >  	# find touched lines
> >  	$DIFF file target | sed -n -e "s/^> //p" >fixed
> > +	# busybox's diff(1) output unified format
> > +	if ! test -s fixed; then
> > +		$DIFF file target |
> > +		grep -v '^+++ target' |
> > +		sed -e "/^+/s/+//" >fixed
> > +	fi
> 
> In my patches (which are too unpolished to contribute, I have not found
> time to clean them up in several years), I do this differently:
> 
> -- snip --
> commit cb2f3a28dbf40b92d3d9ca0f3177cd5afb7c4196
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Wed Jul 5 22:21:57 2017 +0200
> 
>     t4124: avoid using "normal" diff mode
> 
>     Everybody and their dogs, cats and other pets settled on using unified
>     diffs. It is a really quaint holdover from a long-gone era that GNU diff
>     outputs "normal" diff by default.
> 
>     Yet, t4124 relied on that mode.
> 
>     This mode is so out of fashion in the meantime, though, that e.g.
>     BusyBox' diff decided not even to bother to support it. It only supports
>     unified diffs.
> 
>     So let's just switch away from "normal" diffs and use unified diffs, as
>     we really are only interested in the `+` lines.
> 
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> index 971a5a7512ac..133557b99333 100755
> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -51,7 +51,7 @@ test_fix () {
>         apply_patch --whitespace=fix || return 1
> 
>         # find touched lines
> -       $DIFF file target | sed -n -e "s/^> //p" >fixed
> +       $DIFF -u file target | sed -n -e "3,\$s/^+//p" >fixed
> 
>         # the changed lines are all expected to change
>         fixed_cnt=$(wc -l <fixed)
> -- snap --
> 
> Food for thought?

A comment in test-lib-functions::test_cmp mentions that
there _is_ a diff out there that doesn't understand "-u".
I don't know which one is it.

If we choose to use "diff -u" here, we've made a certain assumption,
should we flip the switch in test_cmp, too?

-- 
Danh
