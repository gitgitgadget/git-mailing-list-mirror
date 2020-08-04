Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A4DC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA2621744
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="w5+3sCwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHDUOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgHDUOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 16:14:06 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9CC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 13:14:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a19so13689488qvy.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2pqd8vSw/D6TArMMJbdHD7Iu6c6slgFWyFSulkBjTmw=;
        b=w5+3sCwI4HaBw0E3En7OiAt8pym1RrQvrnywL5EhMmJAUpwn0D7AXIYtYzfUCHfUHb
         YZ48XVyGbuuBRLvksOdGqQmgCxbOhRuP9SDFNpV9N8g9QV5oGhwgaASdkQKuZSnqC+EB
         bbGhUMjg7L7alZFnN49M76C0y+DrO2QQvqw6qYZmzXVhcPZSSXExDJ+5ok5utAhIrhpp
         Gbz6CwgpJDZWQEbq8BW1Hz2dmUZoiO95b3+H1dwSAthd1xd7shLDY2RqBQEpP8GswHIK
         y32bjdUbelRmTExkBiuD0KpT6mSk+e0MJhtMCxlOz3N0icQpw2NoYDjY3Dtspkb5Wa08
         w+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2pqd8vSw/D6TArMMJbdHD7Iu6c6slgFWyFSulkBjTmw=;
        b=OGYpcL8RiqTec9KUa6bcKUkFRPr1x7QGKSZn2YqI8JJaR9v9gF61X52/ChsxYeHlms
         nTOau07MpTag2MkNVcShmj5C0XwgzygIVWQPmBAGzuAe5KmHKywSrJK0viSuBdR0tFTS
         NONWYabmK1UMl071bJV6NjXJNdtvU/oV1Ms/nZaCwqQRcFKs2aJng1iGQtoRKsR4UFj9
         W1ZAdbgAabsAJRAnQVTRX7QnOTuvk4NPkYXHL8yi3W9qYJg6Mg60NX8fkhlsmOAvzQMI
         GNw7gV56lPsVxBTTtSRHGaVYEMhL9XWN8L6qJktHZ/psCF3XipA1va4rmazyWENWEQzD
         mxSA==
X-Gm-Message-State: AOAM532yarOn1TiuSWULJm068+Rt8SfbG6JjQte2JQ3fCCoJV4ImxYWu
        8zIT5UUIY013mbq78XMUkPkbGw==
X-Google-Smtp-Source: ABdhPJw51zlbfMt3TbwvjTcuLEyUMS5yloeUGWTOe71gB7x45jvaYW9PAX9zeCP+Efhh8NpppzWPCg==
X-Received: by 2002:ad4:444e:: with SMTP id l14mr69705qvt.111.1596572045350;
        Tue, 04 Aug 2020 13:14:05 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:4176:744b:cf1a:a7e1])
        by smtp.gmail.com with ESMTPSA id c133sm25267902qkb.111.2020.08.04.13.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:14:04 -0700 (PDT)
Date:   Tue, 4 Aug 2020 16:14:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 10/10] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200804201402.GE89277@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <8b670571dc24973cc5e894b866a68236d8fbfa4f.1596480582.git.me@ttaylorr.com>
 <1c2e841b-4b04-30ba-6c94-96f8bf0cf449@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c2e841b-4b04-30ba-6c94-96f8bf0cf449@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 09:03:36AM -0400, Derrick Stolee wrote:
> On 8/3/2020 2:57 PM, Taylor Blau wrote:
> > Introduce a command-line flag and configuration variable to fill in the
> > 'max_new_filters' variable introduced by the previous patch.
> >
> > The command-line option '--max-new-filters' takes precedence over
> > 'graph.maxNewFilters', which is the default value.
>
> commitGraph.maxNewFilters?

Nice catch. There are some other places that I made this typo, but I
fixed those up locally, too.

> > '--no-max-new-filters' can also be provided, which sets the value back
> > to '-1', indicating that an unlimited number of new Bloom filters may be
> > generated. (OPT_INTEGER only allows setting the '--no-' variant back to
> > '0', hence a custom callback was used instead).
>
> Other than the commit message typo above, this is a good patch.

Thanks, and thanks for the good suggestion to write it in the first
place ;).

> Thanks,
> -Stolee

Thanks,
Taylor
