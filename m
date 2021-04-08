Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B9C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9913661106
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhDHXmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXmS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:42:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76E7C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:42:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g35so2498261pgg.9
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oCjngr6Q7UKkA2L32vGCgnqIhCjR9sj3SoDIBUOSb9s=;
        b=rac9TzpYpmqDFIhC6aVX7D2cHPkZfpbToOrbnY/OoMwIJjdnUNXIbK8j/U7QYHn2YC
         ynH0dK6QxpFtHOMvp6Z7saYP2UK/3ygkg/ihMwQFhHfN/pqfDa1F1uq+y3pcy7U/vFZb
         5fOO7DbvDYyj2zEm8XaBJxyUzTH6lhWNoj62WQJox1T+jToiU+dN4IyKUU2vJ3JFsHzN
         RDfAnx4aop7cuhfN2C+z6PWnkuO/IWiTLcYBprPRx42TbVy1Z69NWu/B8XJsMiRM1sD0
         5zhDTaU6g5yU7Hw/DRn0BMVkxKj208MdoewQfwJ2KyM7XfoZ3vj8e6+JuoKs2pXM273/
         t1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oCjngr6Q7UKkA2L32vGCgnqIhCjR9sj3SoDIBUOSb9s=;
        b=OY5tYXbctwzVEUkEgK7db1HnOBnTVsa56XasgeSHm2HDMriQPLEV5Z+T/UR7+hgriI
         lAE4Hso00xfYwQ0nS1t2kShWC0cRfaoa3/eMXizTMZ7hj/RGgJTkhwb2bFidmxBQPnCN
         srkIdjgd47gc0l+OEc2BPqmHZpKb4xNtzPlShizjI7gjy3NqqjJ2GAG+PQIW404rPEW3
         aLjKUdG3UrAF0Ytdll8F/fZTeZdCFlB137zHD7zKgy2kH4NL0nxp1KAqZ8wTUMWIyzxa
         WIaOKkAJvwsJB8iZDuB+UwSgWPG5yc48ACGmdSjM71ppVNHw74xVfFeHcT7KD4eeC7f7
         b1Hw==
X-Gm-Message-State: AOAM530Kcn5NkUdlIt1PtTh8OHrEWjSV+XVy+tk9zaJYm3/UPBNKQVg9
        xIjjEauS2ql4h6fgK+YtAdSUoQ==
X-Google-Smtp-Source: ABdhPJzmxXlFLvg60glFx9KIuUZkJFnS0gqBY2kLG7sPjV7RrwCTXLTM7noUnG/SeZarHx96PcgF6Q==
X-Received: by 2002:a05:6a00:2345:b029:20b:c007:f9a4 with SMTP id j5-20020a056a002345b029020bc007f9a4mr9757324pfj.42.1617925326026;
        Thu, 08 Apr 2021 16:42:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:34d1:6a8d:be3e:615f])
        by smtp.gmail.com with ESMTPSA id gd12sm396183pjb.48.2021.04.08.16.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:42:05 -0700 (PDT)
Date:   Thu, 8 Apr 2021 16:41:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v13 4/5] bugreport: add uname info
Message-ID: <YG+Ux3UKJDa4yWUr@google.com>
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-5-emilyshaffer@google.com>
 <87mtu8ifmj.fsf@evledraar.gmail.com>
 <xmqqv98wquqp.fsf@gitster.g>
 <87h7kgieyh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7kgieyh.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 12:33:42AM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Apr 09 2021, Junio C Hamano wrote:
> > By the way, what's this sudden interest in re-reviewing an age old
> > topic?
> 
> The thread got bumped by SZEDER in [1] and I'd read an April date
> without noticing the year, so I see this has long-since landed,
> nevermind :)
> 
> 1. https://lore.kernel.org/git/20200416211807.60811-2-emilyshaffer@google.com/

Phew, you scared me :)

 - Emily
