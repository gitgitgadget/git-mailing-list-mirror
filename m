Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D53C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78630610A0
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 18:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFBSGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 14:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBSGa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 14:06:30 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD1FC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 11:04:46 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id u30so3280815qke.7
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QgrAQ6km9FxyFiYeiH5vdtZ2Jb0aHFyE5MJUiENkjrw=;
        b=bUjhqdl0TPmooB0NtcGLsJmlM+SUaWS31iTaOcmf/6OZ6kGWGB6GPxEOYR2Lsy8ESl
         pu0K86J8hOczjRvcrvd8q1LUGN2RCUMopC0S5iYZRGP+jGjv5P370qOuJahjCcOrBXLr
         QZhPLkyr4MLsjn/H68EXhGKmN4IiwP1ZMODrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QgrAQ6km9FxyFiYeiH5vdtZ2Jb0aHFyE5MJUiENkjrw=;
        b=ZmFZylbtkAPn+g0l2QWpfvYgWb5fKqcIC+WgjBd+qVJHepG7mqEazajvOUCsSMK08F
         yisVIpcx8HyFUZx4VxU3Crg63uxmof/dotlKKp6Ob8Fsca14hqmaAhjpju2Yio+HEdq5
         5rbCACxLyPXELy06p9qYOe9kj5LeODJP9qv9LWPPNDb1L23mDD53rooB/FJDkIT0f5T3
         W5adYLZzmyMFoqKgHDR/ldhBPcuJb3wo/q/ZVWDgZoN6dDo4+GH72Ckg/Mk7Xmyv05AV
         QUQPoYG5fXfIG6UkqlMsjb92mCMtYYCC4/mazVLgkO/cVo50FtvqFu4g4joFnvTekgCb
         /p/Q==
X-Gm-Message-State: AOAM530IkIXCvuAmiB9/SMzSX+4qKEPEGIIKiDpcqVseeyaFcjP9S/CZ
        QUkya/AnuN2GrcFiu7L4Viv6Lnauor/RebC60zs=
X-Google-Smtp-Source: ABdhPJzt2XXq17YoQczsheajeT9SWhS6XY0lrIn1spw7Lu4bCeu6uIUYdaD8NAjvP2zTU/fgo+5ykg==
X-Received: by 2002:a05:620a:c45:: with SMTP id u5mr18916073qki.200.1622657086061;
        Wed, 02 Jun 2021 11:04:46 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id q13sm347110qkn.10.2021.06.02.11.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:04:45 -0700 (PDT)
Date:   Wed, 2 Jun 2021 14:04:43 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: why does git-send-email unwrap headers?
Message-ID: <20210602180443.girwpb2ovwczywmk@nitro.local>
References: <20210602153441.cjmey63x2vudlnk6@nitro.local>
 <YLe3k1CYMhv9LEeh@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLe3k1CYMhv9LEeh@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 12:53:39PM -0400, Taylor Blau wrote:
> On Wed, Jun 02, 2021 at 11:34:41AM -0400, Konstantin Ryabitsev wrote:
> > While it's not *wrong* (the 78-character limit is from a very old RFC), I'm
> > curious if this is intentional or just an oversight.
> 
> My guess is that this dates back to 5012699d98 (send-email: handle
> multiple Cc addresses when reading mbox message, 2009-02-14), which
> unfolds all multi-line headers, probably so that parsing the header can
> be done line-wise without having to keep track of whether you are
> parsing a continuation line or not.

I think you're right, but I believe simply removing the two lines that do the
actual unwrapping will fix this without causing any side-effects.

I.e. when parsing headers, don't "unwrap" them but merely concatenate all
header lines to the proper header. Address parsing routines should still
properly handle this situation, though it's less clear to me if something else
may be affected by this change.

CC'ing Ævar Arnfjörð Bjarmason, who I think is the person most poking at
git-send-email lately.

-- >8 --

diff --git a/git-send-email.perl b/git-send-email.perl
index 25be2ebd2a..4c79122f78 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1654,8 +1654,6 @@ sub process_file {
        while(<$fh>) {
                last if /^\s*$/;
                if (/^\s+\S/ and @header) {
-                   chomp($header[$#header]);
-                   s/^\s+/ /;
                        $header[$#header] .= $_;
            } else {
                        push(@header, $_);

-- >8 --

-K
