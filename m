Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FFBC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254A520704
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffK255rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgDWQ0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729422AbgDWQ0I (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 12:26:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F9C09B041
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 09:26:08 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k22so4797103eds.6
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dohRjSv0rjqKuZ+x53VaZqD3Em5Igx1YxeNde9pSRwc=;
        b=ffK255rMAhTNAEb4s1wOMd87qWJ8Gsqhftdz/zlaBw+kBROKmdDG8jX/UC/5tuj/Az
         Ua8xmAe/F0ZlG+3S/TNwIDiQIYbqkhEUYBgGe6ugg7o47Vu/Q/pvKgQsgVXJxdj/wAMY
         Rg6ndny5a2XYYMRkpsjLM6uStD4QF3WcKBR93uDybFqmg4olq5FGHNkFycTlR4fz8ke3
         Y6bo+Q7G9XzPfS8l7QWmdI2D3ffn7tNJru3tqYFR/jbqT8iycb94TAc1ZBfSjt3esZPV
         1f2DPtJ9IQavEwLJ+GdmRgHkt8c6EmGsfz99PmUMt5TqitVCFYURe0j1t7FmSSJPrVoQ
         iotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dohRjSv0rjqKuZ+x53VaZqD3Em5Igx1YxeNde9pSRwc=;
        b=NW5Jt3KWNuWXdwidYK7zeUd2MyrFM3joDW0nzwH68Tf8PaOAO/XcFD9691N6kk/TKT
         zT09Kv71ibnlTAxW2fufSQcywus0Cuums5uEg0LFL88/jLB3zFRRDALvmtzIBjKivZSZ
         VottT7XHz951SI7Dr7CmnvMG+hjIsenejj1KaTRAXcS7I5ik69sRXKeyxiAdIk1oIYbZ
         4zzCCk/QNX36SozS0pWy5BFN27pXymDTG3SJNv6oenBUTfQTHzAfAU7QWR6Ywu/L3H3g
         210eTmUQ4MQ3kxm1FE8xilFwzAM+orfvCIkP0VG7tQbPV8vRcoebaZwfx2gJ5hIfQuF5
         lCpQ==
X-Gm-Message-State: AGi0PuYQ9wwQLc4qbtg/i1zFrmdir8WrxNzjLzKzinS7GYfM7K55H5OR
        jqcZUCsPn37AQb/zfat+GMincina/WTo1ZLkp9fDgK8smAg=
X-Google-Smtp-Source: APiQypLkLiYTvYYd2ZC8wyalK+6NYIvQUHWe9pkIqiY+hxim86mHWMZnNMMuHjyZUdYImehA5MlxhrIj2af303D5bro=
X-Received: by 2002:a50:bb25:: with SMTP id y34mr3284058ede.237.1587659166718;
 Thu, 23 Apr 2020 09:26:06 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Apr 2020 18:25:55 +0200
Message-ID: <CAP8UFD14Wx=QvuMM92RT=Zd=R_FiPQ=FRUVYmzzuaPPteMPVEQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 62
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Raymond <esr@thyrsus.com>,
        Philip Oakley <philipoakley@iee.email>,
        Edward Thomson <ethomson@edwardthomson.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Kyle Meyer <kyle@kyleam.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 62nd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/04/23/edition-62/

Thanks a lot to Eric S. Raymond, Junio Hamano and Philip Oakley who
helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/430
