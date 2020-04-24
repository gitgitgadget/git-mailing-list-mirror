Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8BBC2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CBD2087E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni26gG5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgDXAHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgDXAHL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:07:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D1C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:07:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so3242462pju.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j0ELr/7jtZA2f5MwTj756Z0GrCuqnCXqgWf6TctZ5Do=;
        b=ni26gG5bBJtFcVNT9k77kXUZTK45/V+oiT2WLFdL7NeqHaHBZoZ/PepVaCKhlgqdzt
         BJerSI+HExVPiOna3OhiytwITORStLSc9fwE+4qCaUiFYh510EUCCYVnHwzH37WCjWNa
         /t3EMV6tk4+IM/vWxB26kDFBQni6XnY12qxZQ3X0n6cPhEUDh/UwsWywFGA65dfkbZy7
         Wdj/ZhhwVWarIKhSToif2ixibuDOyHNltR99CP8TSE9q2YJMLZD0bFVPh6GprzVri8Ze
         mWzopg6zHH3RUZjP+vuZn/Y6uj+Lx7eq1CFheLmKL7vAvmxgr+bk5l8t2vUk2cGC+uN9
         75AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0ELr/7jtZA2f5MwTj756Z0GrCuqnCXqgWf6TctZ5Do=;
        b=uXGwBGSBoHTqgSJCClKBRchN5QU1Zyt23Q/foJR0XMgfvdNxhlP/Vg5q+ZkAHT+Vop
         qqGgCESq7PGJsMPb1AQqWHvT1+zuONlyT3vfSEl7yk3qhX9YXhPKbHZzTDTtW7juSyG2
         V2KnOYr3rLpX7ewatUfHlQQikWdC5iAFOqQg4ZO6BapnxwafavaXV8+m/kM5J5rPnOk1
         K3r4Oisd/rcYWfMSZ8diVuCqs9M/TYAkOcRiykPnmOH+uqzsnTZ/mxEbgSrmfZwNlx25
         SvrncjFVd8Et9Z8AO+X5rRivzSPDRYsrj+rzLiH4gd7QxdDubY2Si28MzWmsDaMBcyuN
         l1ng==
X-Gm-Message-State: AGi0PuYgFPvJz7LKZbHkTeE98+vRfa1v5/68w/4fHMaoTvUWUXRbwPJ2
        FCalr7NZWrIoWe67E/kZqBE=
X-Google-Smtp-Source: APiQypICRhZBlQn8a36ALILtyGRnEb0bkXqmuMqGNxCWutv/xLCPOxt2hjJKdXoZCEaEtluvxxvcJQ==
X-Received: by 2002:a17:90a:bf84:: with SMTP id d4mr3455864pjs.82.1587686830396;
        Thu, 23 Apr 2020 17:07:10 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id b13sm3748574pfo.67.2020.04.23.17.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:07:09 -0700 (PDT)
Date:   Fri, 24 Apr 2020 07:07:07 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/2] date.c: skip fractional second part of ISO-8601
Message-ID: <20200424000707.GB1949@danh.dev>
References: <cover.1586856398.git.congdanhqx@gmail.com>
 <cover.1587559135.git.congdanhqx@gmail.com>
 <c6d42785bb762f691b00c48b57c73a1933fadbc3.1587559135.git.congdanhqx@gmail.com>
 <xmqqk127jvrh.fsf@gitster.c.googlers.com>
 <20200423011812.GA1930@danh.dev>
 <xmqqmu72gfxu.fsf@gitster.c.googlers.com>
 <1861c472-7756-d433-9185-d83c03d72b9b@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1861c472-7756-d433-9185-d83c03d72b9b@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-23 21:41:49+0100, Philip Oakley <philipoakley@iee.email> wrote:
> On 23/04/2020 20:28, Junio C Hamano wrote:
> > Danh Doan <congdanhqx@gmail.com> writes:
> Would is_hhmmss() and is_yyyymmdd() be more obvious abbreviations for
> most readers?
> 
> Now that I type them, they do feel that bit too long... , as naming is
> hard, maybe stick with the yms and hms, though I do keep wanting to type
> ytd for the former..

Not sure if I interpret your opinion correctly,
Did you mean s/yms/ymd/ and s/ytd/ymd/?

Even that, I couldn't grasp the meaning of the last phase?

-- 
Danh
