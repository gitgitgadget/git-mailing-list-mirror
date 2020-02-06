Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8610C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 23:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855ED20838
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 23:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlXbNUpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgBFX4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:56:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726502AbgBFX4O (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 18:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581033372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJfh0YT8rWujvbqJDDwIkAgSyelUxZb52JKi5817YYw=;
        b=IlXbNUpMiJdaqOPgcc9v7VtefAtZ+pgxxFam8bje9RwiVwn/KqDGjGWQYTBlQuxR7j97vJ
        pgVJxBYQquXaJPeO32OGx88yhgTd9deHZgDz6vBA85i6RhroJiAN11RqYy6X4itghsBhOB
        uuMf7MZBdTfhYyk1tFnXGM6fblrOBRo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-RWVko2IXNDS0j628xi0VTQ-1; Thu, 06 Feb 2020 18:56:08 -0500
X-MC-Unique: RWVko2IXNDS0j628xi0VTQ-1
Received: by mail-qt1-f198.google.com with SMTP id x8so418621qtq.14
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 15:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vJfh0YT8rWujvbqJDDwIkAgSyelUxZb52JKi5817YYw=;
        b=aAcr0mq5T/zj0nbi9hwclFsYRxEk+4k/8TS9AkTNPEinBMMhIWlWM06itLRiMXrInU
         tmjsEXtVGBEPJu4r+PlcVLDN0Vh1LAUIIrVR2lj6En9+KaZrSYh0SLvj2bxFYFne+MkP
         BRvjXGfDQFrJuDOQoMAz1pl1h9cqg2q7SbRSErjuMuavHxKLhQSRGIiV6chGfBy9YoLd
         JF7q8ZhluHYAR2QwWHXt1K/AEY/DFToqYlVGsNO/Z/fqyhsm2NMnYYl1x3bV2drsXo1f
         Uq/LfcT38mYnF8nP+Ppl/f3s8tOrp3QWSeQEV1t2tbJBCQFzp+5AR2sRQ2EMue0QXkDD
         TQpA==
X-Gm-Message-State: APjAAAUqFsX1QdnbkSzSJUIAdRIvzd8eyUFUzFK06voVk0Kdb860i66F
        eUHKfQAsOL88biYQ+oSI4wa2iEUAFsNCs5eFCssn0hkV0rllPBjJmyh3QiHc761Jw0zd++uaRT5
        2bletxbu8Yn8i
X-Received: by 2002:ac8:1c23:: with SMTP id a32mr4975842qtk.119.1581033367332;
        Thu, 06 Feb 2020 15:56:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7mepg6tQi26Ys3xqGcqZGxYLl6NAOfhy/jXh5vkLGbV1Oqz3fzmsgmoh0KLbXkthIOccmGA==
X-Received: by 2002:ac8:1c23:: with SMTP id a32mr4975831qtk.119.1581033367089;
        Thu, 06 Feb 2020 15:56:07 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id l6sm480532qti.10.2020.02.06.15.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 15:56:05 -0800 (PST)
Date:   Thu, 6 Feb 2020 18:56:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: bug? illegal text in commit log
Message-ID: <20200206185551-mutt-send-email-mst@kernel.org>
References: <20200204010524-mutt-send-email-mst@kernel.org>
 <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
 <xmqqd0arfyw8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd0arfyw8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 08:45:11AM -0800, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > Like a Lines: header specifying the number of lines in the commit message?
> 
> The only part of the workflow that can count the number reliably is
> format-patch.  But the output of format-patch is designed to be
> edited further, and expecting users to adjust the number when they
> make such an edit is a bit too much.
> 
> As nobody in the discussion seem to care any e-mail source other
> than format-patch, we may probably be able to teach mailinfo that
> 
>  * the first line that 
>    - begins with "diff " or "Index", or
>    - is "---" (and nothing else on the line)
>    signals that the line no longer is part of the log
> 
>  * but if it finds a line that begins with "diff --git" (or
>    optionally just "diff "), do not blindly assume that is the end
>    of the log, and instead try to find the first "---" line.  If
>    there isn't any "---", then take that "diff" line the beginning
>    of the patch, but if there is, "---" is the end of the message.
> 
> The latter rule is the new one.  And there is no need to change
> format-patch output.

sounds good to me. any takers?

