Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58959C2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171DE20768
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+BLpq1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgDFXrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:47:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42103 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDFXrl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 19:47:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so8388346pfa.9
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 16:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5IeWhIaEE+4Z8ZbWY8NQvuA/LAeAIn+04WFSSNKaUm8=;
        b=m+BLpq1y5U2q1D1M5RKqol8R0cJJcpG5gDtqxxNtOOgpZrwiMXw2zq209nhGxPJ5iB
         T3mC7lZB91VHvUR34bS61Dyz5VmhB7jsEwLrJIFU0UrgC4HEF1DWd3iAqJ7CBRxQZ+GG
         IzArKOy3orTKGouEcKcNx8VvH4I6nXumUjPODbcXv04AIYiYpqopkKBo90GNiONAjVbA
         kw+8DCtSTMYOLP2nExP3P8GSHNS1yY5znSKmVoLuFKHZDGjkBltpclZgBrLlfKERPZ7d
         7fhYbGMB0zya4tkn5XN8Xk3vJCXcdZ498F7FDgCJc77r3Uvu/p+G+DifG++yqGeN5fsD
         B1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5IeWhIaEE+4Z8ZbWY8NQvuA/LAeAIn+04WFSSNKaUm8=;
        b=UQq+FzogcA9sA1vAyOErsqO9FzIkCsHadxdJKi/gqmccM54fL2S2wQibPqdv+yXJct
         Bppsh/iqnSdn6G2VLTpD/7L1Tb4u3oktM2qhm/VadjjKsR3NdpvEpOQdgMerr8ZRK1jc
         Pw1+0q/bP0WGFGzyt7+gUX0EA5ZANJwu9DVWrH2QMWx+88H1d5VIQC9/9f/zw6Wh5qb0
         3gIy4IzeHW2DD0O7wzXVlBbUWBSHan4GzXn9H+ChPDqKNwsfPcyf9YhMegeBXwYrCSFT
         BBCFe5aq1oES2GEEjOYBh7l86Ag2883U2VynuAFXFrWIGeLyrKJ4oSVNCJA7pYmvdla3
         agzA==
X-Gm-Message-State: AGi0PuburuODqf9mKkx81PZWzLjH4MPPP5zMWg2ctnO0UkXfqXS1ZxUV
        Ov3TAbeVGHDMOFca87aNB8I=
X-Google-Smtp-Source: APiQypI+P2070T7Fdq3HJatRsFDjTf3lJC3DFHukUYn8Pvb1WHIpxAqYU4u4VJ9f0LE3hvhF2NBphw==
X-Received: by 2002:a63:de51:: with SMTP id y17mr1613015pgi.70.1586216860611;
        Mon, 06 Apr 2020 16:47:40 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id 144sm12533706pfx.184.2020.04.06.16.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 16:47:40 -0700 (PDT)
Date:   Tue, 7 Apr 2020 06:47:38 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v12 5/5] bugreport: add compiler info
Message-ID: <20200406234738.GA2568@danh.dev>
References: <20200406224526.256074-1-emilyshaffer@google.com>
 <20200406224526.256074-6-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200406224526.256074-6-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-06 15:45:26-0700, Emily Shaffer <emilyshaffer@google.com> wrote:
> Helped-by: Danh Doan <congdanhqx@gmail.com>

If you ever send another version of this series, my Git identity is:

Đoàn Trần Công Danh <congdanhqx@gmail.com>

Thanks,

-- 
Danh
