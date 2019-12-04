Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458E8C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 06:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D842465A
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 06:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxfuxRSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLDGOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:14:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47088 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfLDGOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 01:14:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so2700255pll.13
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 22:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/o51qDwoRcM7DjUBIBpMdEnepqrxhR9+Pv0h06zHX5A=;
        b=VxfuxRSjLz8/bWanu0zXJZrJq1OsO7APJ7F0k2Jfb1j7cxMxMCE+6pKowq4L772Q6H
         Mh2nwsmNKp9JexLKAYTSBYNOPFbvLkKsqMmn4xo4bLs/2nuEWvSh/j7Q/DvQX4KBlDvr
         rjQTIsExVeAYy7Nu/LzhD8B+dsDMBfZNNDEoloKYkwmxfimf4+rIEkxRdnHoXnNgXT+t
         wb7AjgZTs6FhUAt71uryn85IqA9y9L1MVCM1+S9bW8lD1nR2e06Z6LjPPeidDcNHwXIL
         Wd/qbul6AFaxjNfADodqcAc3zwQtfN61jyeXvW0AKYAOn1VJdw6vYpXZh2sVShgH+ba5
         tDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/o51qDwoRcM7DjUBIBpMdEnepqrxhR9+Pv0h06zHX5A=;
        b=bTLAcCbn6n5jpw7NLPK9JjdbSqIvbx2LQJTN4mxAdmHzblXkrPY3hPhlI60q+TmI1I
         CMDA+nA2JyY5KwNHoLBaEQ3m2rWNd2XH5UtW5hM/Bg53bYOvE6LvZWtSyniED7onu6k1
         hr/j0cU5vE6zR2fZj6e1YNFjujVC1wOAVwubTLFpbGz4gQsuuDuSOQfti9HwOTu5Bvpk
         0FJ4WDvAGtblf3C/b2bRBccyPx6FvoIg/7Zhi1lzzgeavNhp6l499WYwbPbGZrXtI4ZC
         /bzK14EUVl8nCWM2jY0FrB4fVI9u8nZqdlaSsSCYvPHC9LzHRfOOjGgAu9KZ8qMsVS/6
         rtXw==
X-Gm-Message-State: APjAAAVSL7YWvq9SwwNm59XW0nJ09pwYERQQJp+26bjyfZsH1c+U+o7G
        LATQHfEwqUZGT0C9bcn96e8=
X-Google-Smtp-Source: APXvYqz0PD0ZDs+BEHAAxZy7Gk6aUjiGvivRVh/iW/LtX4mRuHBOG2C1c0yvvee2mqfYfApX9nVoTA==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr1727905plb.253.1575440050163;
        Tue, 03 Dec 2019 22:14:10 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id e27sm6454462pfj.129.2019.12.03.22.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 22:14:09 -0800 (PST)
Date:   Tue, 3 Dec 2019 22:14:07 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene <seraphire@gmail.com>
Cc:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] Python3 support for t9800 tests. Basic P4/Python3
 support
Message-ID: <20191204061407.GA3381576@generichostname>
References: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
 <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <02b3843e9f21105a945335d0b1d78251ddcc8cee.1575313336.git.gitgitgadget@gmail.com>
 <20191203001854.GA59841@generichostname>
 <5c299c98-dda4-768d-7307-666bde85715d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c299c98-dda4-768d-7307-666bde85715d@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 03, 2019 at 11:03:31AM -0500, Ben Keene wrote:
> So my last question would be, should I open a different PR on gitgitgadget?
> I can cherry-pick my changes into another branch and restart my submission?

You can reuse the same PR. Just force-push to overwrite your old commits
and then you'll be able to `/submit` again to send another revision.
