Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C5C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 13:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4A9207E8
	for <git@archiver.kernel.org>; Mon, 18 May 2020 13:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guSxCzto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgERNEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 09:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgERNEY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 09:04:24 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD17C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 06:04:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a13so2644319pls.8
        for <git@vger.kernel.org>; Mon, 18 May 2020 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OQqrS8HuHAi1wxKJTcJC734TyZ4df9xZFrsKmB9g3PQ=;
        b=guSxCztovFoPRv3vsGDLD6dIVwjdPPnc2KqgMxIHD/mOPQNsjhOlCxjB2rMT5p7BpD
         gVpntzq5HaIuu1zFmnPaCQtUOcq+hVer83T6Nj5NCS0wySiR6S1RH1toqzlOKlUPf0Uh
         jbabxlJps9JcrxXx6XwJfCk8fZ4R044Bi0KPgcY1x6MBkidV4/11DXa3FOM1jWJduXb8
         TO/Aw5lBHg4PDLOHF31HH+K5uMpsQIL8YXfSTfG/t4nnKvmHVWmwenyy5AJEDSCfi4r8
         6P6+2PvK9zN+lNSFPC2oq7zlIbXHH2bGH6Y9keZIMl1WqmXo4Pfirm2M0nHfbA8HhMhz
         e3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OQqrS8HuHAi1wxKJTcJC734TyZ4df9xZFrsKmB9g3PQ=;
        b=JtR+/AkwLKvzslHaUg8rm8xX/JxjTHpStfhcbLwKGEGQYsT7xQNvZhTcJYWI2JYDde
         J3thswvdVWv+sngZV2Biak5dybbPlz40Tcm+SMRTQta128K2tRAlQh+e4D4GhwtefTdE
         UIDzMROP9uhPoxbbpKRHMLSgQrEWTpliVCG3po2j96QvY2YbhvOsh7ghYsmCiw0sW5VA
         td6EtfGUvh8XYQrE2bqHfko8aRpdounmU+6ZBWbZAwBToxSDk1Nka6wnneu9myA5pwsD
         r5ulaaB2OT/jBPBL7nDYnZPR7lnMyYTe7GQrMQco7u99AxD/QjqKmVKymjtiHXTu5zBH
         IFEg==
X-Gm-Message-State: AOAM532RYLeDJXJ5HSlCb9IIir2t2ldIUiZwIQN0V4gZkqeSZQP4me7a
        GwI646irUjLt5+8jjAxVfFQ=
X-Google-Smtp-Source: ABdhPJzVe5+SA7QYmFDR660NnizerW0p9O18UKlFmmyJHccoxDjBWwml8ZIW+6n6pTg0MVVz6NgrZg==
X-Received: by 2002:a17:902:9e8d:: with SMTP id e13mr962389plq.234.1589807064125;
        Mon, 18 May 2020 06:04:24 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id go14sm3940278pjb.42.2020.05.18.06.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:04:23 -0700 (PDT)
Date:   Mon, 18 May 2020 20:04:21 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     laurent@spkdev.net, git@vger.kernel.org, gitster@pobox.com,
        phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net
Subject: Re: [PATCH v5] diff: add config option relative
Message-ID: <20200518130421.GA1980@danh.dev>
References: <20200518094021.GA2069@spk-laptop>
 <20200518114630.GA30622@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518114630.GA30622@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On 2020-05-18 17:16:30+0530, Shourya Shukla <shouryashukla.oo@gmail.com> wrote:
> BTW you mention the `no-relative` setting which will override the
> `relative` option. I am not able to see where exactly is the occurence
> of the `no-relative` option in the code? What I mean is that I am not
> able to observe where exactly does the C code identify a `no-relative`
> option from the command line input? Did I miss something out here?

--no-relative is parsed by removing PARSE_OPT_NONE in
prep_parse_options (diff.c:5495)

-- 
Danh
