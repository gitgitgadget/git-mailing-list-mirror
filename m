Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C4FC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 16:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCHQFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 11:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjCHQF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 11:05:26 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E9DBDFC
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 08:03:58 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i4so10696289ils.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 08:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678291437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKE/p2mjMbRmS5DgygbW8NdUetFmHRix5TFD8smEFME=;
        b=WnlNNdRp3lxITfAP3j3oTao1b8IRE+CTSWmVHWACkLHhH9irIbFds7lLXj7y7I9uw+
         iG2UGellbglzhG1DcbsGYLTTgVBWW+XfIDc8VkOl4u4Di56Y/sOOrnzzGDPsuQbFiRIH
         iqTj9OVy6bHl3AeGmYNa+dbXq7nf1MY/tu+Omi02L6ARVuybWjEN+rXuKWpcP9trMR4n
         fXKDl5qgjT0knoOYTZ+Fb+s8E2t/GPRsLTubp7SrqHGwCaWIufBdHsRb8MyCgBC7oseb
         EwcArfmhwDgwjrMXKuxi8gmRQPxGJWTgySN4g5toShGRmuUbM0jUc6AZyepVjp5zk/EE
         onFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKE/p2mjMbRmS5DgygbW8NdUetFmHRix5TFD8smEFME=;
        b=KFWlAEzcms5BTxp3IH9OV11Y/E1MBHB9a7uT6KMNNXsCY+sQ2b9b/SO+tdkjFmzM1w
         OG30XFTamyLJy9KNsZasm2DU6q5aHVdf3qphEZDsrwBc190+SIPCWlw3jzjXLZQ4cuzg
         HcZMgptx1VSXtHWk+UYuqNVQ6uNTEesk999o9VxXT38z/tD9+QTM+Z/aSIDDUDbP6mpU
         bgSt2D7jxbbVut/IahWjhzGfijdUjlxsxu5vBzf2cGoj5UEYSbYHVYvNxXYDHhfFjV1U
         rM+5cWLcNVj+cd/mOWEe6+2qpfL+ADrzYqS7V7MJO+cViIg+0cPrNah59rRiOkJHNL7P
         LpUg==
X-Gm-Message-State: AO0yUKXNDTBmgqtv8/UFVjN8xG9VTLGMNc8Y+wQUGpYvuaqu85cMYYCk
        ZvMgtWURQrSKKhRCHxmWLLVoLA==
X-Google-Smtp-Source: AK7set8iM/V53HtHmmBFdRIOPXJAMqEgQ0NmQjjzAg5wYLLrQJgBt1XvWoFn/3PvDQPa0JxHmAodEw==
X-Received: by 2002:a05:6e02:1d13:b0:317:d91d:93b with SMTP id i19-20020a056e021d1300b00317d91d093bmr16457235ila.13.1678291436702;
        Wed, 08 Mar 2023 08:03:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dj18-20020a0566384b9200b003b015157f47sm5037185jab.9.2023.03.08.08.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 08:03:56 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:03:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Matheus Tavares <matheus.tavb@gmail.com>
Subject: Re: [PATCH 0/2] advice: add diverging advice
Message-ID: <ZAix68A9e6RHz69y@nand.local>
References: <20230308024834.1562386-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308024834.1562386-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

On Tue, Mar 07, 2023 at 08:48:32PM -0600, Felipe Contreras wrote:
> Not all our users are experts in git who understand their configurations
> perfectly, some might be stuck in a simple error:
>
>   Not possible to fast-forward, aborting.
>
> That's not very friendly.
>
> Let's add a bit more advice in case the user doesn't know what's going
> on.

Thanks for improving this case. I think the new advice() is reasonable
and will be helpful for users who might otherwise get stuck here.

I don't think that splitting it into two separate patches was strictly
necessary. If I were queuing, I'd probably squash the two together, but
I leave that one to Junio to figure out ;-).

Thanks,
Taylor
