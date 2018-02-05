Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D461F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBEUwx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:52:53 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:44834 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeBEUww (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:52:52 -0500
Received: by mail-yw0-f195.google.com with SMTP id x62so19375282ywg.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u24qPZ0YhjWyU526cpgb+drkWF6iCsxCSxl6rZwYPo8=;
        b=camegQQ3tonjhO5XgiwEdrfGwxdx7tnwaTq59QqBtOEsIYXN1qcIwO7qyf0vvQtrg1
         vcWNHkLEej7mqvTCrr7aK6NzRRO3dmiTfyOPbwknftakJy/hJeDW2Or0HEKJWcHoIPy6
         MgfNY7ysU34fCb9CnciVKD+dmR4jZpjiBAbmE9HGrc3vs6bIY/WDjOfCa0tzdPOUOj/e
         AdEz7CI51EnAOFgit37nyHFj4zZ0+wUu+cZ6UAnJZeoL7xn3yfWSUpq5BtU/TGi1e7dg
         xKY/MlWjs0v+xkMXpCIcnehgfJasVpow26Ex4egInH4H71UDJRgD6bciOA1ZDzHO852c
         ETRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u24qPZ0YhjWyU526cpgb+drkWF6iCsxCSxl6rZwYPo8=;
        b=XJRB50+LNHpjgLEvgxKOuGrAsy9JvrzimnVUIdfRpG8WEsuqhRV6iRXuWkEVGbkDEH
         Na3MGUjyiiwtLX5bmR0Pape6CaHGiwHZ3f9Kus8Xz1gQuoFSvcaNuHJaw8gesq/R+DkW
         mkoA1U904hXMfQgC/+g6seZ//jRJ6l+z+tsVgxENp0t4xuBw0Fr8xLN1bHaiSTUQgVFm
         UV0JHfMrC0xlnLAb+5ob9RwMSZjcLd42I3QTDcDB/As9dkAlk+9+HwmrWxJj61i3aSDy
         0mUIwY5uSEeRMVvUXXa3LEC9Nk4dlfULCuLXKy2RPNCBjG9OnVMReAaQ/Hpjo3lFqhfo
         TP2g==
X-Gm-Message-State: APf1xPDrjDgEoAcI7BXriZfgCbSnzpcBCcpNd3IhGiPZAhsPgoFSgap1
        zU2VkoxSys2o0JKFD97jkfd5y5wDaQQFiGnbbDsYPg==
X-Google-Smtp-Source: AH8x227EGGDcwM7ggVrCD4ZPOb0RVjJwgxwMreO3D9UIF+dXMwwbZF40AKdLdATz4fsgdDEeLPnWFyjgp+OWehf8bgk=
X-Received: by 10.37.12.130 with SMTP id 124mr66058ybm.39.1517863971247; Mon,
 05 Feb 2018 12:52:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 12:52:50 -0800 (PST)
In-Reply-To: <20180130232533.25846-28-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-28-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 12:52:50 -0800
Message-ID: <CAGZ79kYsYkKVgF-Bwe3HNFraaYC0DWruXE92E4x8b0oJd_Bg6w@mail.gmail.com>
Subject: Re: [PATCH v7 27/31] merge-recursive: fix overwriting dirty files
 involved in renames
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> This fixes an issue that existed before my directory rename detection
> patches that affects both normal renames and renames implied by
> directory rename detection.  Additional codepaths that only affect
> overwriting of directy files that are involved in directory rename
> detection will be added in a subsequent commit.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

So this fixes bugs in the current rename detection with
overwriting untracked files? Then this is an additional
selling point of this series, maybe worth covering in the
cover letter!
