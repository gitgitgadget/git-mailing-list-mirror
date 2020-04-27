Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C349FC54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 13:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6AC20728
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 13:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McThXS2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgD0NNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726721AbgD0NNP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 09:13:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965CC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 06:13:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t4so6961444plq.12
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d+wzaxthBU6z9NlkoiKRTNl5aYhIaXOQR626mewH9Xk=;
        b=McThXS2IVeBDkUwIoT291Xe6cHfL7yM21BqUaDo/48c/PIJ9XfJSpHk5VugHgYzWcw
         j2fh50NTlVKfvfPINzG06hFShvc/i6du8qAaOpJ3bFTTysXef0gvBDqHL08jkqEGtS1c
         dIgmq10b19OGDPNMlhqm4F8Lc8IR9ZBdYLZ7YdnnG1sTWTAlbT2DYgsRcHbabSXHo7Zq
         IE50H+ZD5kn0lQTKCbXAFVhUqaZNcbXnIKYkxTCYKBs6tVpZGsFPfiU5Fys/Jp7LpuZ7
         bmfV0DvOG1PZmeAuPYgQaHJcRSLT7GqeVRRPkFGlSn4+lhQyqiM7k8Aaw+PkhToSRd1l
         vG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+wzaxthBU6z9NlkoiKRTNl5aYhIaXOQR626mewH9Xk=;
        b=M6deeuKo0yJFcqYppGb4d65QcXlOXE7rcOv2mxz6sgesYBHnlcmbOu04WBP+i6wW15
         tI9RYn6MNIT3DtWLrEsLV6lpC2QdUhcUQIzEjO24vVpkJUyL/VdCqgCCyCHHGYz4xLfE
         RvtBfeYUzlK2VtjvrNmc8Z0d//CkqR8ZrBB3mvuH9EZNbE1SVcIYH+1nJTwv23Q2a+4e
         K9RboA4oNzTui8dCLXR+R8Lt66tet2NzLPL9vEDPTOqsodAQsP59vrjdRafNk1MvKNHF
         dg5E2YtYHqE42rFLXeiEmUvjyn3tISMETFtPSfi09HVp4EVpNp/yHqavyv/2tIpIRaVk
         nXWA==
X-Gm-Message-State: AGi0PubYTwW7sQ/q9lAI1FXqyqpUoeQok4YHKu2eKN6SuCiXQE1fFtqv
        EnUfb1r2tTtJiJ06wlGc1dg=
X-Google-Smtp-Source: APiQypJqwlW90QKZH9Pg+OsCB+VSLu/+ZlRKpKd366jexNpPRWMqysimqaxMp0/MCsLx0ZsxeM9WWg==
X-Received: by 2002:a17:90a:17a6:: with SMTP id q35mr5442203pja.96.1587993194807;
        Mon, 27 Apr 2020 06:13:14 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id q21sm4767806pgl.7.2020.04.27.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 06:13:14 -0700 (PDT)
Date:   Mon, 27 Apr 2020 06:13:12 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Subject: Re: Compilation errors in git.pu/refs/reftable-backend.c
Message-ID: <20200427131312.GB61348@Carlos-MBP>
References: <575af27b-3823-2db5-ad3b-3c6cd7a95faa@web.de>
 <CAFQ2z_O7z2prvnE+v-0nzC3=2mmUBHgFVF+iRqRn-7QyRQxOqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ2z_O7z2prvnE+v-0nzC3=2mmUBHgFVF+iRqRn-7QyRQxOqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 02:05:12PM +0200, Han-Wen Nienhuys wrote:
> 
> I don't understand why Git doesn't enforce this, though.  Couldn't
> -Wdeclaration-after-statement be added to the Makefile if the compiler
> supported it?

not sure if that flag will catch it, but from what I recall, that
specific feature was only available in C99 while git's codebase
targets C89 (need to build with --std=gnu89 as some GNU extensions
are already needed).

see the "For C programs" section in Documentation/CodingGuidelines for
details.

Carlo
