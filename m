Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5B8C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E95823A68
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgLRCa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 21:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgLRCa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 21:30:57 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BDAC0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:30:17 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id q25so603774otn.10
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XoWx7IWQdmFMnKcGWWhLSkyZHkJpY/2Lz/c8xe4onV0=;
        b=CqDISj2D2Tgem0pCrA3X7soOUSCGEHeLR2cyAyU6+qMFqcOZQ3lsLxspjwIxk1K3rS
         491xLwf/HUJZHsNDNcWfesMhk2+hE9mL3YgTu6buYJRYQof1xk+M1eDMZCvl+pKSPxoQ
         wnF2jM7stBvUAKeCJF2rPpylZiyO0VfVyy//ck2ApbRkrbYajJaMVaFdLM2kdz3/kYzm
         Klig0fSscLGI/Btp7ih1W8tQTrGIVX4DcrbmcfwVlnhqXBpR7eCy2d6tjB980VukY25+
         gBCg/c4WuDS4TXdhWZyOeWHgB1+evmgleptAMv1FN476135nz2a3l/sBJA8f+JF3h6Th
         MPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XoWx7IWQdmFMnKcGWWhLSkyZHkJpY/2Lz/c8xe4onV0=;
        b=jrpAB0gk6k/2rgZPSMBjLicGtmTY/+suAntMdPHMxFfXeW5ewcUdRznWH1DxlU1wV6
         Rr9dIwKR25nawqyWSAKNBJzQ8vgE9tz71w6jMDDCD5PU9KrkEItea0u3WNj1nByZnAcD
         zyA5o4INNZXdd4L8FvbuD8WYHmFyAtDKhZDwLD4K/B3Qvcv5665Myyy9Xrq55/aB/RLk
         QnNa7a9V8v2liBvddI5LPxNEzAScNvf/+9zo8azP6UScEMi12f1N9EGWIMHfuAC4xGVh
         iDR5NkV7dU7pdXFlg6t+mo/bG/MlDibboQv4jEOBabgJwhTuhp7kL+IXr+nG8XUcrGcY
         BOUQ==
X-Gm-Message-State: AOAM532rUUFp3aMRwmneJvxVeeD50LBzdsiot6OBqrjhUeVBXPWPwRYo
        dV7HIVR/TCduxClU6U9L4g8=
X-Google-Smtp-Source: ABdhPJxlZtwIieyiDJN0wUMYfNQqz7+5nh2I5q1ZAs/+J7ZXZyo+Fiidn0GEjPR8UpsiN4KD6dhMgw==
X-Received: by 2002:a05:6830:120d:: with SMTP id r13mr1393718otp.351.1608258616728;
        Thu, 17 Dec 2020 18:30:16 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w131sm1503578oif.8.2020.12.17.18.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:30:16 -0800 (PST)
Date:   Thu, 17 Dec 2020 20:30:14 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Seth House <seth@eseth.com>
Message-ID: <5fdc1436b6e44_f2faf2084f@natae.notmuch>
In-Reply-To: <deb42d8a-1ac6-7100-eba9-d75f7c8ba0d8@kdbg.org>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <5fdb1687825e9_d35b620855@natae.notmuch>
 <deb42d8a-1ac6-7100-eba9-d75f7c8ba0d8@kdbg.org>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 17.12.20 um 09:27 schrieb Felipe Contreras:
> > Johannes Sixt wrote:
> >> I'm mostly using WinMerge these days, and it can do what your patch
> >> does all by itself.
> > 
> > Really? Because under Wine it doesn't look like it:
> > 
> >  1. Before: https://snipboard.io/8JA5Oz.jpg
> >  2. After: https://snipboard.io/HUXnOg.jpg
> 
> These show 3 panes, while mine shows only 2. And I think I know why:
> 
> First, I seem to use an older version of WinMerge that does not support
> 3-way diffs.
> 
> Second, I only run the merge tool via Git GUI, and it has its own tool
> drivers and completely bypasses git-mergetool. In particular, it invokes
> WinMerge in a way that it auto-merges the non-conflicted parts, whereas
> (the unpatched) git-mergetool does it differently such that it shows
> many more differences in the same merge situation.

So it makes sense that the users of "git mergetool" get the same
benefits of the users of git-gui (with the proposed patch).

However, I'm trying to parse what git-gui is doing in
git-gui/lib/mergetool.tcl, and I see nothing similar to automerging.

Plus, the arguments passed to the tool are completely different:

  "$merge_tool_path" -e -ub -wl \
    -dl "Theirs File" -dr "Mine File" "$REMOTE" "$LOCAL" "$MERGED"]

	"$merge_tool_path" -u -e -dl Local -dr Remote \
		"$LOCAL" "$REMOTE" "$MERGED"

It's not even gramatically correct.

Cheers.

-- 
Felipe Contreras
