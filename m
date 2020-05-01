Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D32C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 09:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5462070B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 09:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdxrDkgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgEAJSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 05:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgEAJSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 05:18:34 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2FC035495
        for <git@vger.kernel.org>; Fri,  1 May 2020 02:18:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z22so3289023lfd.0
        for <git@vger.kernel.org>; Fri, 01 May 2020 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UR56n91scOQJUOOP2Wm3GOJEca4FqIfnGNfrWgdK3h8=;
        b=OdxrDkgxP43uzG6jCkJmCHhUN1bkfa2/EDB5WHPTyaUSCGNDrlLBFdXczHsGmfoW+z
         ugAME1Jij8lHxnX1E066E6tro61WY3fTTl1/f4GNCq9afOAf4wAUKZRGN2raxI5WnBYS
         KpXl15wnVrfsXU35XJg8Gu+8XOtM5vm9/ZFWhr9BHqoP9wBOz/Vzm92VykLNE7dPDlXv
         bWiLik0TkqaU0/VGxdeTXclAr8mUHOQgi6oqNGP7oVDovRnfnCfJgp8vY06IeJxSNNK/
         IvBDsmXCVwiw4I6LuHNELKHY6hApWgK5FDB3wa76QYIZhGWxmDxdM32t3j5Vb3Ax5XlL
         tk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UR56n91scOQJUOOP2Wm3GOJEca4FqIfnGNfrWgdK3h8=;
        b=oH57OlzwHEKC7oMi2RICJdIkRiO5S2an4P+ULyw5Gqy/vFM8kOsbm8gShVyNtt/+PH
         VYKBz5FV/oUyf4W0M1W/2GricV6C/eqINzfUsp2KMF7d4t2NBMZ7tcuRjy/zMCkc8X4N
         XuNRGYofAgvz/cCHkT7IBwEbzAfpodjvNBPhA1FUXV34xe+X9hoJS/FTdKTWToQMzr/P
         cJrFBmTMWe1AdKgJgpQsSd/Q17ot82rrVk9xW5fLPekT9A9Qc0HLsoA0XykoE2aVwefd
         UgRiGceKi477ru9rgI8/RV1YOCzhCDrdzCbmlkoxVytq7S9Kz5ADi323O4k6vCsQaY26
         pYpQ==
X-Gm-Message-State: AGi0PubYueYosnunekBinKTdT2JujWga5e6ycdhBJ6ZovDj744VObpDS
        tc6kJiTzD1W1CScYBZrxdxc=
X-Google-Smtp-Source: APiQypJF+8VjOruRBT0Rv//i9Fao8r1bE7qtFUfDNphHvx/fZU1d0YbU345sHwD8fylE3PXXxjET+w==
X-Received: by 2002:a19:4a15:: with SMTP id x21mr1962185lfa.22.1588324712804;
        Fri, 01 May 2020 02:18:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z9sm2232942lfd.9.2020.05.01.02.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 02:18:32 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        Taylor Blau <me@ttaylorr.com>, Ivan Tham <pickfire@riseup.net>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru> <20200429190013.GG83442@syl.local>
        <87v9likr5a.fsf@osv.gnss.ru> <20200429195745.GC3920@syl.local>
        <87imhihwbw.fsf@osv.gnss.ru> <20200430162753.pg6kpm6jlubotjlk@carbon>
        <xmqqbln8sqcv.fsf@gitster.c.googlers.com>
Date:   Fri, 01 May 2020 12:18:31 +0300
In-Reply-To: <xmqqbln8sqcv.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 30 Apr 2020 12:52:48 -0700")
Message-ID: <87zhas3teg.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Konstantin Khomoutov <kostix@bswap.ru> writes:
>
>> I would speculate that `git checkout -` may have learned about "-"
>> simply from the `cd -` ...
>
> You do not have to speculate.  You only need to read what has been
> already said in the thread ;-).

Should I expect "git checkout ~" to get me to my "home" branch then? ;-)

Actually, that could be a good idea. I mean, to have "home" branch
notion and a short-cut for it.

-- Sergey
