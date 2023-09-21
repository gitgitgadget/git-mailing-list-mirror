Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5DBE7D0AA
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 21:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjIUVU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjIUVT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 17:19:26 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C63166C
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 13:46:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59b5484fbe6so17615347b3.1
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695329177; x=1695933977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbdftIVkS/8lc8VNXHtzx1+gKFf9dCK5GyRfd/Z9t50=;
        b=w4l4UGboa3A8bry4TcHUQ62lNATNTKXwP5TneV4un1MAn3jnZjUMd0W0U5BHHOxTqI
         SIuFnjZRhf/AX4/W8EHsgpSIVkH6+ckYmO7785e02Tk4g7iJAkP66LhS8R08bEIlsf5E
         iNptKOlLe3sOi9O7k6Vymf9rBoFvhTA78qoqaTiah+yzKOv3AWtmrpJRZ12TXrwZa3C3
         m4ugAgorRmvRzd9yMAymAcyAoAPuRMfPyJ97tac1seivJx2XGcyozErdOEm5EsYtikHb
         KwYQpjMljR53O5ksoSzH5TSWh3ivUQxZZBcWg7oiyV3WhEW+q/5nRr5ZmTENz6utgt0P
         g1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695329177; x=1695933977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbdftIVkS/8lc8VNXHtzx1+gKFf9dCK5GyRfd/Z9t50=;
        b=XAKZ4fc98v56kAlqO7pBG4zbY3uMZX0udAkgiYJsUUbaReMTvZK4QAF2UVLbM02bhQ
         w70UJ05bE6V3TVYQOMQf4cyeYBaXkdwXFyLwhwpNyihS93zOmOnejm6aFbzDRVxRCA2N
         dW88P2b+QQT8CZ8HhLyqsSZbNe58cgQp4WRv942NziDUUoWiyCrza9onksTsFWolRana
         RfsxEW4wix7s6Bwn3pR020u8792rq+9Ghq9GpvUVYcY5AXho6yaDJbFTiKHw4mZYm8My
         LQopKgCrSoct9b24smUw58Pxvko/t20Rl4KXSRGtjM1900kfUgHI78iKCMVqCf3F5GD6
         IykA==
X-Gm-Message-State: AOJu0YySdP4kNKPXQfxUD5MHNRXxvdBt0rsBU5zctRzCW7Nn2pXB1BWy
        bhW89gew6CgExm+EUZP1BpBKkg==
X-Google-Smtp-Source: AGHT+IHHX6iHp9qAPkXrqgXeM1sp43BV5UrS4FCoK3LaaSfepjYOYdJ9Bm5gXrvWtSPo+/AHTm7Atw==
X-Received: by 2002:a81:bf43:0:b0:57a:cf8:5b4 with SMTP id s3-20020a81bf43000000b0057a0cf805b4mr5797636ywk.51.1695329176931;
        Thu, 21 Sep 2023 13:46:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a128-20020a0df186000000b0057736c436f1sm517276ywf.141.2023.09.21.13.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 13:46:16 -0700 (PDT)
Date:   Thu, 21 Sep 2023 16:46:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org,
        Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: Git in Outreachy? (December, 2023)
Message-ID: <ZQyrllWhLDebWCG0@nand.local>
References: <ZNwhVOggObU7aVTr@nand.local>
 <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
 <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com>
 <ZOZSo7vJztHcvb4W@nand.local>
 <435a2aa3-59f8-d2bc-f653-4f93d86b9c31@gmail.com>
 <ZO4wxU1ilpa6/3EW@nand.local>
 <CAP8UFD2CGf8efBHquS=LJP8uQ5ivuDryqGz96PZ81oDtrNgNXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2CGf8efBHquS=LJP8uQ5ivuDryqGz96PZ81oDtrNgNXw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 10:38:45PM +0200, Christian Couder wrote:
> By the way, Kaartic, do you still want to be an org admin? And Taylor
> are you Ok with Kaartic being an org admin?

Sorry that this dropped off of my queue. FWIW, no issues from me.

Thanks,
Taylor
