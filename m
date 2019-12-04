Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33348C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 06:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F15024660
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 06:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZENyXQ9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLDGTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:19:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41063 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfLDGTU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 01:19:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so2827765pgk.8
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 22:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=37WXdNaFZD3oIAfv0Ys+NHfcpzDR72pyhtl/bUGd5UM=;
        b=ZENyXQ9rd9rSR4ggOVLX5ZWAot9xd0PR05HX76gtC5jykKwizP0dZ47UfsAyoils6N
         FcrOIu9rw2ecBlEUmDtd47yLGzSO/xFTwY2Z3bEbeJ68u99/bhQF0rLGNVoh58pJLA/j
         Tb0d9b09JPKYrSKipzntwWtGagHC/ExIVOXakzrcQbpk+QODJgLeilJTRA8OlkKkZYc1
         gIx7WR5WC+Q3C6gBVkGlJplapGikwk35gfU3HsGqjYgNuV4c3p3XWciZkx5RpYISvBOI
         iJHKiSjSLgI+mnDl7oci9/kMTBLRVehh4BVFSESdhP0iZyZoFh8w1qMppB1z8vKI//Ub
         VOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=37WXdNaFZD3oIAfv0Ys+NHfcpzDR72pyhtl/bUGd5UM=;
        b=YXbScvOZV/M3YmNR1tANV4yhMMo/Is51wF/sKPbWEPSNwO6cAunSWSXls2hY0L/toC
         C3D3d7QPtE97p8hcH6tvR2zITrF6kuWM88kRkm+Ah0lQEXWKQB0bytBzACR/Uoq/pnF9
         Jx7QpFeIXK4yHOhsA0q6UbfEV7CvOyluJR1vCrgGmpK47ndMapkoZVt0mjW+d24Pj1u8
         KJa1gQw7tA3mZXnjcAlHcGF8Qp85N0p6l3HSNMH2QLwPsrDVyz9PMpc9DzLdL4q9njl1
         6LEIJ224HKXquA2KFymL1BzHXDfjcdkSE8ml9fdZ/HpZaF+MZOcIq2L1+pTqVmhsup/5
         VVpQ==
X-Gm-Message-State: APjAAAU/yuvxzdeJUyScmDmq1vwE9OVcXU7uzwluZSYsNWLT/Oj2WYYZ
        ZBAjw6ntwweKh6XRBilzzY0=
X-Google-Smtp-Source: APXvYqwJVyWz/LxEWVSm5FNs4p3flXsUDd9vt8PGrcab7d8b3o5aX1Dn1J97He36NtOR2ylc+Di2bw==
X-Received: by 2002:a65:46c6:: with SMTP id n6mr1797717pgr.15.1575440360112;
        Tue, 03 Dec 2019 22:19:20 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id f13sm6336400pfa.57.2019.12.03.22.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 22:19:19 -0800 (PST)
Date:   Tue, 3 Dec 2019 22:19:17 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
Message-ID: <20191204061917.GB3381576@generichostname>
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
 <20191202210534.GA49785@generichostname>
 <xmqqy2vt5ppk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy2vt5ppk.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 03, 2019 at 08:38:47AM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > René sent a v2 for the above commit here[2].
> > ...
> > [2]: https://lore.kernel.org/git/a56a4b33-61f8-d3a5-d85f-431c70b8f3e7@web.de/
> 
> That is what has become ed254710 ("test: use test_must_be_empty F
> instead of test_cmp empty F", 2019-11-27), I think.

Hmm, perhaps it was human error on my part but I was pretty sure that I
saw the `PIPE` when I was looking at the branch on GitHub. Maybe there
was some issue related to whatever Elijah was experiencing earlier as
well?

Anyway, double-checking now, that commit looks correct to me. Sorry for
the false alarm.
