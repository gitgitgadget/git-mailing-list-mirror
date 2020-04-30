Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD10C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC2520873
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 16:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EnOpbkIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD3QVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbgD3QVz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 12:21:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D12CC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 09:21:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r4so2974441pgg.4
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8EHg1Mr9BqKBS7ffn64P4Y547XcOqsas8IRwGyskcxc=;
        b=EnOpbkIkgFWKGIrwaY2p3YEFxxu9VgnViss32Xym4/buYBS7X/mwh3pJmrdzkxgbWy
         TjN4DQIhFZ27QPJF0wgLd7J6mTPgcoyTVl4aflImdxHAmGj0JtLXAdPmW+iIM2eGYHIb
         X8n6qsNS4HWYR4l81VM3lW1V5fyvUEVcQuH1AvZdjnQDR+aXrGkz/4UwlrGBSGRSQQ7v
         tq+JRQ/SQ2+zOZPmCTv97TsYTbqJqA+MhHHHzguN5wHOupNkPDiA7zf8luXNkCBvI/kp
         Wl828fAYAXoZHM5+ey/IGvvdKjtv7+xsRy4qUiGZT8KkR0UgUxL/CDeVwAJ9cluQu+PI
         ehyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8EHg1Mr9BqKBS7ffn64P4Y547XcOqsas8IRwGyskcxc=;
        b=DWbfXeO4017r/ii5Eb0oNi/fCL3YIsB/we2kDMWfLYSeqWU8mb+gp+ZXH+q6EvVpIz
         i2/xezniTnWHQlIEp2PMPDQtPNufUAU7KBne1vCmdEACVr8ygwcHTVFGwfByT+UDIDcQ
         eZKnqCteSIqtrYOdbfx444xsx27Jazc8ngljWpRFeKy3D33ErevO866LMC6OS9jpFFom
         h3XALE8qHCjA23b2Hhfwp7QCNr7SXq5yKfWVYCChKkPtL7srBozaH+UbssKjh0Uo0XSv
         wnMyVE6AYPCIPbfirn4sQi6FZVF/iM+KeI7N7yVNvHRmMhQze03DAKOHyhkSp5CvGzFa
         BEhw==
X-Gm-Message-State: AGi0PuYunNe1+njVbWZ0MyqOF+aOXdgrAb3VI5dBK4LROcE5sgZ0T7V6
        Cje52w3TQDxe6XjwhlqJSRE0cNp4uR/K7hss
X-Google-Smtp-Source: APiQypKEQhrcD0gihhQVLFyZ+bK0InfL5aZ+oc96TyABx8wYFx6L7kqJ5bmNfiRs7+DTtcyytCAx/g==
X-Received: by 2002:a63:790a:: with SMTP id u10mr1952266pgc.126.1588263713929;
        Thu, 30 Apr 2020 09:21:53 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 30sm229881pgp.38.2020.04.30.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:21:53 -0700 (PDT)
Date:   Thu, 30 Apr 2020 10:21:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Robert Simpson <no-reply@MailScreen.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] switch: fix errors and comments related to -c and -C
Message-ID: <20200430162151.GB30682@syl.local>
References: <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
 <75c9cf6ce95e753f50ce9b8b86b2c3ded5d8d38d.1588247662.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75c9cf6ce95e753f50ce9b8b86b2c3ded5d8d38d.1588247662.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 07:54:57AM -0400, Denton Liu wrote:
> In d787d311db (checkout: split part of it to new command 'switch',
> 2019-03-29), the `git switch` command was created by extracting the
> common functionality of cmd_checkout() in checkout_main(). However, in
> b7b5fce270 (switch: better names for -b and -B, 2019-03-29), the branch
> creation and force creation options for 'switch' were changed to -c and
> -C, respectively. As a result of this, error messages and comments that
> previously referred to `-b` and `-B` became invalid for `git switch`.
>
> For error messages that refer to `-b` and `-B`, use a format string
> instead so that `-c` and `-C` can be printed when `git switch` is
> invoked.
>
> Reported-by: Robert Simpson
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Notes:
>     Robert, is the email listed above correct? If not, please let me know
>     which email to use. (I hope that this reaches you somehow.)

Nicely done. This revision looks great to me, thanks.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
