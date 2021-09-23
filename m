Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FAC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE52061038
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 20:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbhIWUXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbhIWUXY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 16:23:24 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389CEC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 13:21:52 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d18so9648788iof.13
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zqXmICBmFnbergIwF5Fh7oDVPFMwdcOdBWwpYl/21II=;
        b=tA4ibDiM+tOS1FU8oYcpi0/NcQalH+hfGzHpTfFDK8mUH6C+rNJZv1zjf9NZy6tMD+
         UDk5eoxIvlI2nZyzeoYd0MtO6Td7SM893rZIl+yVYA+7OpruopnJG4nUUWMCDmnZOYF/
         sJ7PWy1tqxbSgCkij1FChr4PSl4IdgEaX49vm2g4ZFbScydqP8GsAPSFJ9hTFt+q6T5V
         +1xJVyfu14YUpmbcrmsRwXHcnHGCAge6OgkAsMpgiXcXZCLKjOe9TpeRDVQPRuYb1sbu
         3UXx8vpP841n2AdkrOwkVtYKq8XG59WpMIYoIoRdnYNJ6lUaXTzXQLrVXGSIwyRo/AWg
         YtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zqXmICBmFnbergIwF5Fh7oDVPFMwdcOdBWwpYl/21II=;
        b=z+nMU4dAQQChJaEThWO5TpX81L9NuSqWiD0NFNyyNtqQ1IrYGgltc2PwoQWbXb8ESF
         8WFhcRxoDqyFZS2ml2MNtduxOVDVEB/XL0Wzlle64A0QcTS/jxFVOGZmUmBkvoz22Rja
         2NzpdxmtWADA03cxns2xtJtdOgjpcmv0vj/vNRjFgr+8KSUa7by0NbnO7N8G7kML8mB6
         T8wC0S8Vc8cy7JgidUdRjaj4FWp2RryCAwhz+yH2WPS7Ffl8t9JFjSPWiSfeZpqvVqQl
         dYEra2hQ4ShcfoLEo+3vdkcqg8hiVTCWCKGZueZbX7ccJ7EG0d59Ks8y61X1nCMQWeMh
         aiaQ==
X-Gm-Message-State: AOAM533upttnVs3IYhECdqFO5ORTPxPmKymWTuckmpKBBQer9uBuFhz8
        sMQHNw0HwPT1kaYXt4u7Vp/gJQ==
X-Google-Smtp-Source: ABdhPJwTIgl8NJJArO0SZArx+zpL6nI2BUPo1Fzz3RclCruFcg/UMWIZ60RkzRwDekChM+8XJxQG4g==
X-Received: by 2002:a02:2302:: with SMTP id u2mr5836696jau.32.1632428511642;
        Thu, 23 Sep 2021 13:21:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a11sm3152238ilk.18.2021.09.23.13.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:21:51 -0700 (PDT)
Date:   Thu, 23 Sep 2021 16:21:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Wong <e@80x24.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] doc/technical: update note about core.multiPackIndex
Message-ID: <YUzh3tahQnoumQ6V@nand.local>
References: <20210922221342.6867-1-e@80x24.org>
 <9ebb4c34-8cdd-3120-ff9a-0e47099c3cf6@gmail.com>
 <YUy9HzRgHU2zvI4P@nand.local>
 <20210923201252.GA25980@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923201252.GA25980@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 08:12:52PM +0000, Eric Wong wrote:
> Subject: [PATCH] doc/technical: update note about core.multiPackIndex
>
> MIDX files are used by default since commit d0fa539bc569
> (doc/technical: remove outdated MIDX default note, 2021-09-22)
>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---

Thanks; this version looks good to me.

Thanks,
Taylor
