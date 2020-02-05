Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7CFC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06FD2051A
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EHkYebX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgBECfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:35:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41090 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgBECfL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 21:35:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id l3so182122pgi.8
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 18:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/dZLCp2PW7l7/IeLwdafJdk3ml+rdpNt4WOdFxoXJfk=;
        b=EHkYebX8JI402rMquB1Vz97cR9TSr69cJ5+gFvcwCTDXCY2Fex7qxnTwugn1fbEf6F
         Jnzf1zS/Y7Zz83DRGxqoXP3+8ipznTKADMg1D14YFPSmn7DaLU/L31ONQ27Siwpbb7Fj
         xZLFBxKoM36s4AupsI0VCR0O7/HQllYYF4jc/+dOQB8ZUvHGmCbuNYESvgeBW0cGkMem
         Ftq3pd2Wmk6sgt1Z7g2KB4cJzi7yQfhqfC0tki6whOt4W4o2Kd3e0iKxGZIZy29BqBWu
         b/zkhgAfTrw4jVNBrtcp1es13eNhtVKCoePY5LIKTlPb49AkO+ePOWsYl/CbFDYfJjyb
         qGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/dZLCp2PW7l7/IeLwdafJdk3ml+rdpNt4WOdFxoXJfk=;
        b=SmxS9ozFbtKQiBnfe5POr6arvK+g6Hs/CYhBJIKElQpu5H6Q/mAmZVPBX8WpRkAgpF
         xEvANHG/qG4s1fMZ6P8ebwzbwacRdd064bGcTDEbKsEvIpRSnksaaurg6AG6XYksecOQ
         boCTeUl/3xu9XE9bM5QdU49dslW8Q9BCmZcl8k2jmsKgD/RMgN/d4jQADY2JcOVTmwEA
         L1x9s7Jpz/JsZQV6TcF/C4UxGNkZRyzXs18XBIptx2n+C54ObI0KdFrKsm0/VOzKFA+Q
         c5774wMM41ktebsGE+I9SWttaYUT+x9KN5J79C5KAO6hgL5h+arGdnF1jBxQvx9LzCPv
         kx5Q==
X-Gm-Message-State: APjAAAUk+Lw1ivLv6BLDopPk8M3fH2vtngLlFNmKNmYxVXq7UGfoLXmT
        /PxLyn2FpbQaPt0B7Zxzvt7pqw==
X-Google-Smtp-Source: APXvYqyTI5yZqf8nXiz4BtOpAGlWgk3foqngqFIIq7Fau+015rHlWMeJfbgO6PsQN9q5Ox8m/3tYVQ==
X-Received: by 2002:a62:25c6:: with SMTP id l189mr34320234pfl.136.1580870110494;
        Tue, 04 Feb 2020 18:35:10 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:fd92:b4b9:d992:34e6])
        by smtp.gmail.com with ESMTPSA id k3sm25654144pgc.3.2020.02.04.18.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:35:09 -0800 (PST)
Date:   Tue, 4 Feb 2020 18:35:06 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] name-rev: rewrite create_or_update_name()
Message-ID: <20200205023506.GA58070@syl.local>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <b8f6a47e-1cbe-b2c7-cdde-ff2dc28af2b2@web.de>
 <f0e0ab6c-afde-307e-bbf0-823c576d67ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0e0ab6c-afde-307e-bbf0-823c576d67ca@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 09:00:23PM -0500, Derrick Stolee wrote:
> On 2/4/2020 4:14 PM, René Scharfe wrote:
> > This code was moved straight out of name_rev(). As such, we inherited
> > the "goto" to jump from an if into an else-if. We also inherited the
> > fact that "nothing to do -- return NULL" is handled last.
> >
> > Rewrite the function to first handle the "nothing to do" case. Then we
> > can handle the conditional allocation early before going on to populate
> > the struct. No need for goto-ing.
>
> I read this carefully and agree it is functionally equivalent.

As did I. I originally thought that my MUA was wrapping the 'else if'
line oddly, but then I discovered that it's the label's indentation that
was throwing me off.

In any case, this makes good sense. Well done indeed.

> Since you are removing a goto and rearranging if/else blocks, I thought
> this response needed to be explicit, at least more than usual. Good work.
>
> Thanks,
> -Stolee

Thanks,
Taylor
