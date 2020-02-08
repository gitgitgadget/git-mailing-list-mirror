Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E6FC35242
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 23:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458622082E
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 23:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uhjyt6yQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBHXcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 18:32:51 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50205 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgBHXcv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 18:32:51 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so2528845pjb.0
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 15:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9e87K3wcrDCRg5d57w1kG4M6mdScyY5V21dDBdjMxv8=;
        b=uhjyt6yQuL+pRCrYnQcTF9Shqi2UdKhsCuHKaQfWi3mlgHbDPzQzBXz1H80FzIP1Gl
         6YsS1GjNvp0C16W4TVBs2FUNYFF5k6HzQqwXjE4RaLPMFO3054ScwnKjycwQe6X5j5Bi
         uXBUM7dcUBisPPFY+1Y/SxcVU8pmPGClCupnpBfKhkX89p1iXrJC6Wzko+AunFmW0hbr
         f7IGHIMJNpwOhpbeMvSFX7Qnps0lQoy4t/2I0MstRPjhkn38F9zyjnbDgfWgqs2HREfl
         BHY1c3v0HP8eRUUbjLuB0h47ixUsMkWjX3tPyFtg2rN0F9+S9unCm59geClZHFIMjOuI
         F/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9e87K3wcrDCRg5d57w1kG4M6mdScyY5V21dDBdjMxv8=;
        b=H4qu6/HNS5yuS1Y/WuwM0Gk11T4KIM0duOCYp08LMBirV0BFmeK8G1X5XcY+zD/L32
         eAiZxdFNG6/p/OPFWcwS0d7mORwUyjjH5yZfK0lboUgNLj4ovxKD7b6esw7R9LTx/0TO
         RgfzhtIyDmFeepD0Yw54TVVUmBhJD4sg/IrwbjbQ6OxuKuwrcNfXZq1VWEe2dYbwJHHB
         WQmfLf8/ajcrOMyIdT0LcOdTv8Kwu6FmA3Ht8TU/Av658Pr7exqrNhFs7ePvJ5UWld/m
         Gfa+M8e8Lt2ZizI7I4glnK//Ey/G+pSnl70gvvHhrLosM3f18rXZtJkNyxdQPyrHcyNA
         c3HA==
X-Gm-Message-State: APjAAAVPV9M5J35/yhmbs61Zy2vZWhJv7VJ57bN1UIMId5T1ggEooL+N
        gWY+NirucPnVijbKRDt99IJVZQ==
X-Google-Smtp-Source: APXvYqxcQaTwPoIH3Dh9pHG5DwbzEKOP7RwtFCvldJUdniNqT/8W3+/zORDB6Qdjs2N1h2LMBNwMgA==
X-Received: by 2002:a17:902:8682:: with SMTP id g2mr5751782plo.336.1581204768917;
        Sat, 08 Feb 2020 15:32:48 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:dc02:8cc6:46f8:4fa])
        by smtp.gmail.com with ESMTPSA id x65sm7707972pfb.171.2020.02.08.15.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 15:32:48 -0800 (PST)
Date:   Sat, 8 Feb 2020 15:32:47 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Finn Bryant <finnbryant@gmail.com>
Subject: Re: [PATCH v4 00/15] Harden the sparse-checkout builtin
Message-ID: <20200208233247.GD33529@syl.local>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
 <CABPp-BHoEgYXgzxjweWDR2BZPhLdW9wcbWzwo6N+HF2kste3WA@mail.gmail.com>
 <f28beb17-50dc-ff53-46bf-35010d48d23d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f28beb17-50dc-ff53-46bf-35010d48d23d@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On Mon, Feb 03, 2020 at 09:09:54AM -0500, Derrick Stolee wrote:
> On 1/31/2020 3:36 PM, Elijah Newren wrote:
> > On Fri, Jan 31, 2020 at 12:16 PM Derrick Stolee via GitGitGadget
> >> Update in V3:
> >>
> >>  * Input now uses Peff's recommended pattern: unquote C-style strings over
> >>    stdin and otherwise do not un-escape input.
> >
> > ...and updates in V4 are?  (I looked over the range-diff which
> > definitely helps, but a summary would still be nice.)
>
> Sorry! I definitely should have double-checked before sending.
>
> Updates in V4:
>
> * Special-character checking now considers all glob characters
>   ( '[', '*', '\\', '?' ) See Patches 8 and 13.
>
> * Patch 10 is is now split into two (Patches 10 and 11), to properly
>   escape patterns and to unquote C-style strings.
>
> * The file/directory path bug reported in [1] is fixed in Patch 15.

Thanks for including these. I haven't been super active in the earlier
rounds of review on this series, but I gave a thorough look to what you
have in v4, and it all looks good to me.

Please consider this:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> Thanks,
> -Stolee
>
> [1] https://lore.kernel.org/git/CADSBhNbbO=aq-Oo2MpzDMN2VAX4m6f9Jb-eCtVVX1NfWKE9zJw@mail.gmail.com/

Thanks,
Taylor
