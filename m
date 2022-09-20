Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4AEECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 03:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiITDU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiITDUt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 23:20:49 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB3C57203
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 20:20:40 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id z9so1164777qvn.9
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 20:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=S1mxqcwFJ1ax6fq6DWYv8h2uxTqrb5NmXWx97ycrQqU=;
        b=l822yjRFR159H8DQSHfCeNcGZME1vNE5QwCZI4/fdPjdwXFCh3zUm+FTUW1rPjBRM0
         envKm2NogKLqgkueAR8NBooQa4fQIMg6IJj79bTtRcynWArbpOJEhAcngTVzoGgSacgr
         FOe80gItYVESSkK5MifDa9av9irDR8z88RUYqdDz/VQ4HSknLNj7gwUK2RLJW6XedTxS
         BkjKPXXK6FSpXgs4VNq2XolAWdfqw6WgnEMqmh7vZ6oL4jpZMEZ/UHAIkb4ibj8rgWWJ
         N+OHeAoU1n+817bX2X4G/C6r8uwAuHbyHi7dgTQYZYlnCaObbKBST0Yk2wnxnoV/dPS7
         7owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S1mxqcwFJ1ax6fq6DWYv8h2uxTqrb5NmXWx97ycrQqU=;
        b=dBpAkPko+dnVDBd+WUECOtPH9XMSxlP+iQRx1FUl44LUnovRe3c+NJLmbDxixsuJYK
         5wQ04JY5KsfbOhQ6Mm1s3yvmymR9Iz9x8z5l1kYlzLcCOHCE57g10GMRKc25V05UIit/
         ldx6XfK7fo8dVopYcHi1QWT0HZKku+VNsvfufBW45afxHYHRTiB4kj/UXCTTqvJHLy6m
         2my/bxGl/XqglTUY59n6o4wU6Ll2B04TM3fKd07c1kBjG61xWZ5LhL08jle2cmBGM2lp
         hZqf2NHHT1SMi+Nm0UU7WClSe3wGBPzj85cuOn82BP3XAyrt71EhcWCDDMvn3rPHTHdI
         tNkQ==
X-Gm-Message-State: ACrzQf25LUy3VnseLhmf/DMNkOFqtvcbKl0tlPpitJhd5gUZZOScxPfS
        9il3bM9G2KGRJmwVf31FvAd9FynYdMI=
X-Google-Smtp-Source: AMsMyM4QsU0J1zyWqh67sf/3pRFI7HayjetQyIA0HbFI2yGA0T8+7sa9q3xkxbZ3opVeVfP9RWt6Kg==
X-Received: by 2002:ad4:5ca2:0:b0:4aa:9d05:2424 with SMTP id q2-20020ad45ca2000000b004aa9d052424mr17033426qvh.71.1663644039520;
        Mon, 19 Sep 2022 20:20:39 -0700 (PDT)
Received: from gmail.com (207-237-203-247.s3058.c3-0.arm-cbr1.chi-arm.il.cable.rcncustomer.com. [207.237.203.247])
        by smtp.gmail.com with ESMTPSA id y8-20020a05620a44c800b006ce16588056sm186703qkp.89.2022.09.19.20.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:20:39 -0700 (PDT)
Date:   Mon, 19 Sep 2022 22:20:17 -0500
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: avoid dropping fixup commit that targets self
 via commit-ish
Message-ID: <YykxcU+UYzZgK+AT@gmail.com>
References: <YyZWDkZWAkS7q+Wf@gmail.com>
 <20220918121053.880225-1-aclopte@gmail.com>
 <xmqqh714dv7n.fsf@gitster.g>
 <xmqqpmfrcpq8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpmfrcpq8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 09:07:27AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > ...  But use of _by_name() that does
> > not limit the input to hexadecimal _is_ a problem ...
> 
> Ah, no, sorry, this was wrong.  The original used "rev-parse -q --verify"
> without restricting the "single word" to "sha1 prefix".
> 

Yeah, I've sent a v2 that removes the false verdicts from the commit message.

Even if we restricted it to SHAs it would still be ambiguous.. I guess it
doesn't matter in practice.

Thanks
