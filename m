Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5931F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbeHMVo4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:44:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45139 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbeHMVo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:44:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so15121494wrv.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lfX2ChDmWFcW4+v7sYw+bS9HXPUgT/7xtVKJ8UeHsW0=;
        b=qAJf5oZY0q6OCUQwb6tX9dwx6XXVPR+YhuWseffofSf7IW47DKXC9eTAu++oF64Sgk
         gAXy9cPj7hrYCJ5qpOXk5/DbaE6zV4M/8qYUGXKvGoCHp9dFwKI5sKq55+oz9rmKsyZP
         jfmuFLyfaNg4BPavkzGZt1Vt6PvVXK1IZAJqx8G+gZN1qz1Zr3TALGBng/jjKFhJldUG
         zoyKzoLSGb+adGWbSarHrHfmZBos9ll5umuN/6FkUm75DKVjKZMcgZex7D28oC7oTO/V
         8bGTA7B9VuIz9tA7bKkj5i5ZojdlGra+/JimPwlDuFRX3irO20b2xR13jovvjtZTl/sT
         FVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lfX2ChDmWFcW4+v7sYw+bS9HXPUgT/7xtVKJ8UeHsW0=;
        b=NPi9Yccxg41kby0cyWO83GmxdQUCBp7DQ2Q++yWPVP4SnYdOz6HQtNHBHh9TDyVEbH
         Y5ivsVz12vIDi4QiL2l/HJ1MCTy8i2P7qaItmTSIEWq7t/WgWC58C87aiWq7PZXn+SX8
         MEQ9X9TqRVxqp3KJ7+d5Q7sPCKzsUDHJP3K4ZokfFsH9ddiP8xNMEM5rDF27MFug9Vr5
         LHreYPj8xPVUAHanzKD2AGrBMVrNeoz7HWepwDIUQEmSSwcSPmy9pd4gCzekFcpNE+G5
         5a79LJwRvcXUBNLkOxF6Njc1WNS3nbqh2kIx+Hqic0MBsK1nnM3WFj/HwM3sdfD4pFRA
         wnWw==
X-Gm-Message-State: AOUpUlFYokQpAjpn+kzthTgkdC2Wv35OPzfxzokuruHSC7wiWb9GaVX3
        iW4GDDH1CYanjTsazdavWTQ=
X-Google-Smtp-Source: AA+uWPy3mfgRaHQkTJyjWdU+ZHPyYARjhu+Wx8hhzTrGHxSDvPV8p9qtOB+M2ccvQE+Ptby/cJKmCA==
X-Received: by 2002:a5d:41c1:: with SMTP id e1-v6mr11298965wrq.25.1534186885534;
        Mon, 13 Aug 2018 12:01:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t198-v6sm18306079wmd.16.2018.08.13.12.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:01:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, peartben@gmail.com,
        peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 0/5] Speed up unpack_trees()
References: <20180804053723.4695-1-pclouds@gmail.com>
        <20180812081551.27927-1-pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 12:01:24 -0700
In-Reply-To: <20180812081551.27927-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 12 Aug 2018 10:15:46 +0200")
Message-ID: <xmqqeff25bwb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v4 has a bunch of changes
>
> - 1/5 is a new one to show indented tracing. This way it's less
>   misleading to read nested time measurements
> - 3/5 now has the switch/restore cache_bottom logic. Junio suggested a
>   check instead in his final note, but I think this is safer (yeah I'm
>   scared too)
> - the old 4/4 is dropped because
>   - it assumes n-way logic
>   - the visible time saving is not worth the tradeoff
>   - Elijah gave me an idea to avoid add_index_entry() that I think
>     does not have n-way logic assumptions and gives better saving.
>     But it requires some more changes so I'm going to do it later
> - 5/5 is also new and should help reduce cache_tree_update() cost.
>   I wrote somewhere I was not going to work on this part, but it turns
>   out just a couple lines, might as well do it now.

The last step feels a bit scary, but other than that I did not spot
anything iffy in the series.  Nicely done.

Thanks.
