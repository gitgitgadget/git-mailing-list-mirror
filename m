Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC3A1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756274AbeAROQH (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:16:07 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35155 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755690AbeAROQG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:16:06 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so23279394wme.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=+HXtZNPpmpKizw/hi1TwpQH56gXTjPWw+VFa/b2jyhw=;
        b=Q1U/vW40WmULIfGPSmnAuJ/Cq0WTaPEaTniEElQ/j4748hH+YfIOS6wKdeztZgzGhQ
         QKoIb/Nm2BTMyuDZKeTjSMRHljx1s/8L94UPXbuSA6pgxwVPDq3aNvSIzrdgnX461fxR
         jFAyg1T1BTBhdPZaT0WBdTVNYuTjjHT/abATOiVnsVU275+QcAdZTykOAwxQyo+z7zPN
         0unXZRXnfg73FaEKzONoKGEjMSsHeOuQEUyyHkVmlrVxlL++g7uGEbytSYcglqMOkRPv
         aZQBUoxS2hivO2wMxd13HKGqu0on1f2UG49F+o6unbYiawdGdwUcuUFVK1qTOzA3WGXd
         iJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=+HXtZNPpmpKizw/hi1TwpQH56gXTjPWw+VFa/b2jyhw=;
        b=kWhIUB9rx9fPMOiG6mQ0wnwpw9Dv89tCFRpyrAxuQ8TSa+Cj/UCu6snIZzqRu4MQ99
         fHlIzLrZUC3C7Ppfv4ylbTr/Gx/kUSmwPVXxQ27zqOCYy/2IDq8Tm8fAfb4xAo1E2TRB
         MkhhqDl2tKjeWu4pr7F61TOiagPsyqVyXIdzdupU9aqDW0kRVLOEIev9bFexdMeLVZJb
         GFPTyZXVKYfQLqi8MCWrR6xzL9KlS+4j5gRs52hKuMPEq1QGegzHlb+gCb/u16PV4pus
         vV8OsHAg53A4AO0H1O5BAKGH5B9zG9LhOvTX6VDKkYJ/tgXGbDyRUJSD4rKrUPfEvT58
         8F3Q==
X-Gm-Message-State: AKwxytfFpp7jAm0ff1uWf+Gxj/v1atJcxmeU0dKH+ct3Qcq9yP+jV5EW
        9+52IEEplMQ649HDGOfvqvo=
X-Google-Smtp-Source: ACJfBotyWwUO6pe1l+5038vPs5Hc9Iq6R3hudH4hGr51EQ0VnuIRE9xAT5XqDKUuofhkMVFQj3YVgA==
X-Received: by 10.28.27.16 with SMTP id b16mr368586wmb.44.1516284965560;
        Thu, 18 Jan 2018 06:16:05 -0800 (PST)
Received: from localhost.localdomain (x590c3640.dyn.telefonica.de. [89.12.54.64])
        by smtp.gmail.com with ESMTPSA id p128sm10302267wmb.23.2018.01.18.06.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jan 2018 06:16:05 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, peff@peff.net,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] packfile: use get_be64() for large offsets
Date:   Thu, 18 Jan 2018 15:15:22 +0100
Message-Id: <20180118141522.18294-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.71.gef94d5d36
In-Reply-To: <20180118110419.210006-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

> The pack-index version 2 format uses two 4-byte integers in network-
> byte order to represent one 8-byte value. The current implementation
> has several code clones for stitching these integers together.
> 
> Use get_be64() to create an 8-byte integer from two 4-byte integers
> represented this way.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  pack-revindex.c | 6 ++----
>  packfile.c      | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/pack-revindex.c b/pack-revindex.c
> index 1b7ebd8d7e..ff5f62c033 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -134,10 +134,8 @@ static void create_pack_revindex(struct packed_git *p)
>  			if (!(off & 0x80000000)) {
>  				p->revindex[i].offset = off;
>  			} else {
> -				p->revindex[i].offset =
> -					((uint64_t)ntohl(*off_64++)) << 32;
> -				p->revindex[i].offset |=
> -					ntohl(*off_64++);
> +				p->revindex[i].offset = get_be64(off_64);
> +				off_64 += 2;
>  			}
>  			p->revindex[i].nr = i;
>  		}
> diff --git a/packfile.c b/packfile.c
> index 4a5fe7ab18..228ed0d59a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1702,8 +1702,7 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
>  			return off;
>  		index += p->num_objects * 4 + (off & 0x7fffffff) * 8;
>  		check_pack_index_ptr(p, index);
> -		return (((uint64_t)ntohl(*((uint32_t *)(index + 0)))) << 32) |
> -				   ntohl(*((uint32_t *)(index + 4)));
> +		return get_be64(index);
>  	}
>  }
>  
> -- 
> 2.15.0
> 

This patch can't be applied to 'maint' currently at 3013dff86 (Prepare
for 2.15.2, 2017-12-06), as it is in case of 'ds/use-get-be64',
because 'maint' doesn't have get_be64() yet (b2e39d006 (bswap: add 64
bit endianness helper get_be64, 2017-09-22)).


Gábor

