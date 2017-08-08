Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548E720899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbdHHWlT (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:41:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34080 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbdHHWlS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:41:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id t86so4361478pfe.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nT8qBUi3BBJQwQ2nN5c0o76ZrMIlptIQByMrJvQaHXs=;
        b=cgUVxo4xDiH/53+aI/7uDGfuXRbRrGXtoU8DtGw1rBrDdYdsbEci9Nr0jFARgI6sd1
         KbI1t9MsaYfbPr3ULH85kk/lX6AIP5Gjs2QUgIBfaJ/8j5C/w4w2yg7VziksctZ7pAJX
         ghLlAnKi0vSPsqW22z8OExsqRVZGEYqV8wfvdodVx2LoPmMeUz9o9h0XdEmX44d0PA1Z
         N2cNXp/+pO3eux8V03stODdlb1fP8UoklQWlukUw3E2sjudwMQZsB8tHXBUzjEXpGAxD
         zhdznr/p0IxoXTh62FLSi1qyaeOIowGJyeUv5i8l7C5XNHgB80FTxA4iiWwmZeema6PK
         8pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nT8qBUi3BBJQwQ2nN5c0o76ZrMIlptIQByMrJvQaHXs=;
        b=arww7LrKBfQSilJKLbtnJ2jEOWLeNuWhFWvkXzDiACdRCuwF89iKagJewyrb9MJz8E
         tQ4OzOESUlyGj2HnSU6kYrqEW7m+O9RJ/tdVKXA+Wp6qisHQVmv2xvacFh+l6LBEx1Wc
         9kBARnYPK1KDPUTgc+lKlE0EtmikD8LQq+/aBNDuDqalX/mXEBKCWOn2A/tZlloPz6hw
         pwYc70EtGampzHDia+d825GLWAshIovZB10ljhPCZjwTUVmZjA0s6f/pBRztup3fdVjN
         yI9GUK4fNGWak32Bp4e8wpKayYuv2hcvxW9xIxRCicB0PGhMVcvh4IKuRymLX6IwhGSI
         QEHw==
X-Gm-Message-State: AHYfb5j77co0Pv/VCjEwMSHZYqUzKqrMo1FYXjvP9BQkzPSLAGRwCAZO
        OK0qhb+0PCe+Ew==
X-Received: by 10.99.160.25 with SMTP id r25mr5513976pge.6.1502232077722;
        Tue, 08 Aug 2017 15:41:17 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:d173:771d:dd07:d344])
        by smtp.gmail.com with ESMTPSA id y22sm4466226pfi.159.2017.08.08.15.41.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 15:41:16 -0700 (PDT)
Date:   Tue, 8 Aug 2017 15:41:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] sha1_file: avoid comparison if no packed hash matches
 the first byte
Message-ID: <20170808224114.GD169894@aiede.mtv.corp.google.com>
References: <0c1f898c-46c4-033d-001b-114b17d7d36f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c1f898c-46c4-033d-001b-114b17d7d36f@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe wrote:

> find_pack_entry_one() uses the fan-out table of pack indexes to find out
> which entries match the first byte of the searched hash and does a
> binary search on this subset of the main index table.
>
> If there are no matching entries then lo and hi will have the same
> value.  The binary search still starts and compares the hash of the
> following entry (which has a non-matching first byte, so won't cause any
> trouble), or whatever comes after the sorted list of entries.
>
> The probability of that stray comparison matching by mistake is low, but
> let's not take any chances and check when entering the binary search
> loop if we're actually done already.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  sha1_file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for a clear explanation.

Sanity checking: is this correct in the sha1[0] == 0 case?  In that
case, we have lo = 0, hi = the 0th offset from the fanout table.  The
offsets in the fanout table are defined as "the number of objects in
the corresponding pack, the first byte of whose object name is less
than or equal to N."  So hi == lo would mean there are no objects with
id starting with 0, as hoped.

Or in other words, the [lo, hi) interval we're trying to search is
indeed a half-open interval.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
