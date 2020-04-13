Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA4EC2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AC72072D
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="FQ1sorux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgDMQAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731188AbgDMQAy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 12:00:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C290C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:00:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t40so3954926pjb.3
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u9/8J28a3XgxnTrJi2ALAtM+VvJxe4UQKfWjNAY2PHw=;
        b=FQ1soruxZEat2z6qkmT2f78R9AY31MuN0Y3ckiYSEj2nl6CNVTkWyzqQugdfrt8s2q
         YF7P9/UGnIKaTY69VbQsb51qWAlwGKjD8HZLroCAA5mGaWAfgj2n2IDEKmZ2lf4+QZ4M
         O1kOWx6uXZQWShjoHu6RIy58BkTct32b8u63Pg5D+y3385vpxIqho7BiOH5DwRuQ46NP
         NsTsNIcGAttILeuRbLL/ec7h2Cer6Ih6IRbPucuufCLMIi5mL9mhKYx3jGk3ss/uJH1U
         3Z9YDNr1wdU7LrbKFHNmcSApcKrNq/XXU/HB9diK/9HPmoGW7+m1ojjkT6Hv0h+ChtiH
         hL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u9/8J28a3XgxnTrJi2ALAtM+VvJxe4UQKfWjNAY2PHw=;
        b=mCJBExKzLG/1tngMeHbVbNhmRzBbJHqRiSBgjAF8/1M0li34VZRwTpNFjihMW0zwGY
         JjBqmribVff6H9sf/hck6FOFRr+F0F5bkbfkLiaI9li2kxekAgYeP8sa8AXGD/jh7CKt
         kVJLdoQV7jd/lMDrGL/hZUuUjthESJLpWQl8LTwSgegrPnHeID0LXVDF681eExopD2Zm
         ScqxMi1geBXp6mj11bO2BgU9US3G8VZ39FEEfqmKk+8ODLg8dMfWSfxPh4fBCvSClWS0
         D6E1ZJhMZyoK7KCt0uLlwVUSr3wHGLMak1XQDjFb8A8nY+IDy66IBAm/G1e+/4x8CVHC
         Yaaw==
X-Gm-Message-State: AGi0PuYANn4Vy1RjoNFZMw+j9mdnD3EjiKxNl4xyZjfvM/ld1BJ5fjDS
        J3FeD/5QwvJDCZUsPienum+tWA==
X-Google-Smtp-Source: APiQypJAg3+Q4XHV7eKWqBdwITTammK45VV4eXRxCGF/G4ePwu2JwdrHU455XkwYTeTGcSJ/NftYuQ==
X-Received: by 2002:a17:90b:3849:: with SMTP id nl9mr21757916pjb.86.1586793653393;
        Mon, 13 Apr 2020 09:00:53 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l30sm7315596pgu.29.2020.04.13.09.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:00:52 -0700 (PDT)
Date:   Mon, 13 Apr 2020 10:00:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git@vger.kernel.org, Jeff.Hostetler@microsoft.com
Subject: Re: Git pull stuck when Trace2 target set to Unix Stream Socket
Message-ID: <20200413160051.GB59601@syl.local>
References: <CAL3xRKceuniEOq+PqN15FC4-mxsWJd4+e2fu1Ku9q_+8JmR9pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL3xRKceuniEOq+PqN15FC4-mxsWJd4+e2fu1Ku9q_+8JmR9pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 02:05:00PM +0200, Son Luong Ngoc wrote:
> Hey folks,
>
> I am trying to write a simple git trace2 event collector and I notice
> that when git doing git pull with trace events being sent to a unix
> stream socket, the entire operation halted.
>
> Reproduce as follow:
> ```
> cd git/git
> git config trace2.eventTarget af_unix:stream:/tmp/git_trace.sock
> git config trace2.eventBrief false
> (rm /tmp/git_trace.sock | ) &&  nc -lkU /tmp/git_trace.sock

I doubt that this is important (for a reason that I'll point out below),
but it looks like your invocation here is malformed with the trailing
pipe character.

Did you mean to redirect the output of rm away? If so, '2>&1 >/dev/null'
will do what you want.

> # In a different terminal
> git pull # Pull stuck and never complete
> ```

Odd. From my memory, trace2 will give up trying to connect to the socket
(disabling itself and optionally printing a warning) if 'socket(2)' or
'connect(2)' set the error bit. My guess above is that you don't have a
listening socket (because your shell is waiting for you to close the
'|'), so there's no connection to be made.

> This does not happen when you set eventBrief to true
> ```
> git config trace2.eventBrief true
> ```

Odd. What version of Git are you using? Your description makes it
sound like it may be a bug, so I'd be curious to hear Jeff's
interpretation of things, too.

> Worth to note that if eventTarget is a file instead of a socket,
> everything works fine.
>
> Cheers,
> Son Luong.

Thanks,
Taylor
