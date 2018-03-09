Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5BC1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 23:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbeCIXHX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 18:07:23 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50966 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932320AbeCIXHW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 18:07:22 -0500
Received: by mail-wm0-f67.google.com with SMTP id w128so6703726wmw.0
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 15:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gCa02zcFyo6/sVkFRA9H18QJdBC1PblXl4YeDiGgMfw=;
        b=Eslh5zbenGqZtvkSzF+7TNHTxs7C93eUJXmTW+3lggyJ3kSsDCsen18nPX3gdbmXkg
         BV/JOSYGkWSDM/EVdyq+Lq6Vb7LmEej3rH8VlCruII1GgOpqnroTSbh6h8hSMoHTe1qQ
         bS7leEppwdHUve9ZjtRzsTHa4wGlBAelWkIYv0ejWd5eo0dMrJPpkv/oIPmtXK+Yu8M7
         YCTxAp6qpSMTdy9RJKMQK1nEnvrya03AgInLzzfbHu8BPpM/TSYiwbTwKobvWxjKLuVc
         Uz9qXtUFoCB3KQlFNu0V5HPNzGJ4Vx4nbGghsOudqTrcjnVmuVZYSEa9Lo2iLDprlOAc
         ocbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gCa02zcFyo6/sVkFRA9H18QJdBC1PblXl4YeDiGgMfw=;
        b=sZ3U6XewwXWLo+smT2aMuCeH/1UvdjJc9riiPbLD59+hxkdvcagrJq6nI3rlhwiHuf
         FOZkt0wXz84gRSH/+nYVFy2+KRD6xblPq4e1hIJ0kMMvNrDIdirQH0IaEG2CXHwXGayY
         IlpRHBYCNCR8dV/7cDHVsem972LYead6GrKDjgdezCZoT4fC9EHx+MWzt+DfD+i115QG
         aKqGUXCLtXvkV+e2G/EvFKJV6RHD2paAqMrC1tE7p0u5DKMrT8VCr4VGJd0x4R9UACSY
         QLmKxYUDHDwX0RD1Wv5wlQ4M9SecSY8ScB16zY4pYCxPvXQ9RCUPFZN8pt4PyZVO2eBF
         NfAw==
X-Gm-Message-State: AElRT7EH0O6tgGlASYGHKjyMyxy9+hV4M2hCFkJLwTeweAeNwZIMyuIA
        eNsabsB0l/W2szuxa7H2O0Y=
X-Google-Smtp-Source: AG47ELtTSzaZsYyYhuM9QHMmVuF9aXoWDWvpHxlIHN0Evv0hcpslPEa9c7hdiU9q+89yCzZmS/Jnpg==
X-Received: by 10.28.186.66 with SMTP id k63mr332631wmf.156.1520636840729;
        Fri, 09 Mar 2018 15:07:20 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j89sm2170801wrj.92.2018.03.09.15.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 15:07:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH/RFC v3 04/12] pack-objects: use bitfield for object_entry::depth
References: <20180303024706.31465-1-pclouds@gmail.com>
        <20180308114232.10508-1-pclouds@gmail.com>
        <20180308114232.10508-5-pclouds@gmail.com>
Date:   Fri, 09 Mar 2018 15:07:19 -0800
In-Reply-To: <20180308114232.10508-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 8 Mar 2018 18:42:24 +0700")
Message-ID: <xmqqbmfw4zmg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +	Maximum value is 4095.
>   ...
> +	if (depth > (1 << OE_DEPTH_BITS))
> +		die(_("delta chain depth %d is greater than maximum limit %d"),
> +		    depth, (1 << OE_DEPTH_BITS));
> +

Do I see an off-by-one here?  Ie.

	if ((1 << OE_DEPATH_BITS) <= depth)
		die("depth that is 4096 or deeper is too much");

