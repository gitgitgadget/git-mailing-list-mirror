Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D3C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 10:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390839AbiEFKRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 06:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245457AbiEFKRs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 06:17:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143625930D
        for <git@vger.kernel.org>; Fri,  6 May 2022 03:14:06 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id hh4so5523224qtb.10
        for <git@vger.kernel.org>; Fri, 06 May 2022 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2fGW4FMZalJ1+ClsHxPkx32Ax3ECzX9t24SJPkpqvX0=;
        b=ppPcuHKZGcKjDo3BmTGtJYDoF7VjNyVDIEkkcj2Eo2P46qGA3ett1lGvGhE58X2i3D
         IKUsJ0eY1MiqWHfv2EE3kMiVasjeXHwJu/8XGfT0Uy0+RhSx4rsSTtxzFbpffgFU0S5U
         xVOFHr8wxW1FZQGpYflGxuzxC7dP7cZ8R2+AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2fGW4FMZalJ1+ClsHxPkx32Ax3ECzX9t24SJPkpqvX0=;
        b=IakwOCOZWLlBC4I6U4TXK0gYLjDUswI2u4gOCBoJglVnPJv0LMD7s/AQF9itb7j240
         5RZPVcm9eRCARmBBi9YqIETke0HmeCvE2ecppiKc5QhgVdZymLP2iO5yRUinkTuMedng
         hytpdRIYS6U7RazQE2VzLcN91R1ztPJBtOmaWZQwfqXh612v6Tw4iPuR+POFyqCYYOzm
         p5uO5/0s0an3PNn7FqtbsUEqR1dgYgbfr3jPr30yFO9y1jO5lFNlOV46I1o8VqUzYkZw
         CRCsyHQCm2g8HGaGXpfiJodDAwwz0IrOEUWxQMPk8rOnxpD5WtD7Q5fJqG/RFIGsb5eE
         9toA==
X-Gm-Message-State: AOAM530/bgYyBP1KfQexIOOudGaYdEocyViTONdgvQ/1ESz1ugNQyKa6
        mSPySzsABDvgQ18n55Cme6YZ9w==
X-Google-Smtp-Source: ABdhPJwCbbMRTHUO8fLP+GXn1JmoR23tmPyA74kxjZgV1MeDSnVq/h5h7f/LrOjfXOTIwXEaUyXWdA==
X-Received: by 2002:ac8:7d4a:0:b0:2f3:bbe2:f97f with SMTP id h10-20020ac87d4a000000b002f3bbe2f97fmr1886440qtb.355.1651832044801;
        Fri, 06 May 2022 03:14:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3428])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a0a1300b0069fc13ce226sm2177563qka.87.2022.05.06.03.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 03:14:04 -0700 (PDT)
Date:   Fri, 6 May 2022 11:14:02 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] bisect: output state before we are ready to
 compute bisection
Message-ID: <YnT06hCm9zR287aY@chrisdown.name>
References: <cover.1651796862.git.chris@chrisdown.name>
 <11edd3e4dbaac7fada8a3bcd43f4bbd353087637.1651796862.git.chris@chrisdown.name>
 <YnSNWMBRZA0S8X26@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YnSNWMBRZA0S8X26@nand.local>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau writes:
>Could or should these printf()'s be advise() calls instead? That would
>make it easier for users to turn them off if they don't want the extra
>output. At the very least, we should make sure that they are sent to
>stderr to discourage scripting around them.

Ah, I didn't know about advise(); looks like it could be reasonable to use 
here. If nobody objects, I'll change to advise() when the rest of the feedback 
has come in and v3 is sent.

Thanks!
