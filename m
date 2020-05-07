Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE82C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 04:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C23C2075E
	for <git@archiver.kernel.org>; Thu,  7 May 2020 04:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDLzrQzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgEGEkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 00:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725763AbgEGEkg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 00:40:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AFDC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 21:40:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so3351963pjz.1
        for <git@vger.kernel.org>; Wed, 06 May 2020 21:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qizs6zrSmtmNqM7DxGqO8TFmauF8nla5YgELBs28O/o=;
        b=SDLzrQzu0aXJw4NblALmbHAxD8WHfe8zDW9GMBHflbSP/INwao3PDbpQ3/zMUKsnCT
         zXnTePpffsUKF+0oPQp+b9hf8FLi9ZQq7BBkp8qgk1yI8bLycpPinU+vrZIJdwVzLtt1
         7WxiLCFYfD5do5y66d1/iLRBJ8p7fdc9uj1AFbV5agLsaQXFtyBvPXCsKqfg/1A6OSp+
         Kg4ggQNUlVZdC6qc18KuFSAj7GLHcDnaHK3jMjPXjGMwuHlAj4lqaUZut01/8pjtTPQP
         V/J6+acObOmhnq226Ykxd899x4rTglnAvRrgV3vrpvnXK90sNVudaEMDYFAaToRcNB2s
         6FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qizs6zrSmtmNqM7DxGqO8TFmauF8nla5YgELBs28O/o=;
        b=RYnRob1lqh9MkQ9Mje2yfSY75xqrAEBdoXZrpzf/+fzRvFFD6TnTnRCZN3rKdMoqM5
         ReSl0aGEeK8/gyxRmhvOKvvjIUxbA3s+3T8haev/cAMSvN+OjacH57g5hPWbX8GpCBmn
         Zk+qy4J/TAMW33kTeN05wYIPugXJ82QlrXzmNzwxlkgQq+OOBKzGL2HoinlSc4NamQHE
         QM6vzHWSFLr2Btzqn1w5TsU/FJNl9T+HqNUUFzEl2tZWZv3BCtHTG0IkHHmWWRyA9l/6
         0YzvHbai/Va6k4O1nWEprM+aMDUb6P1w3POcuUxJQjEn9YgDmL7eJBrYJALd56k1qHZ9
         fdrQ==
X-Gm-Message-State: AGi0PuaeUY1V8uf7eEArW2HjxlvDkXbk4gKuP4W/eKcfc1UfWc5nOu47
        HJXAlr56ZJV90mHws/TRxjs=
X-Google-Smtp-Source: APiQypK19fcnm3EsYLdwqB5AOu+DrPFbkdsUaDYBtrmyM+xNlhCSQwfu46vBY6Ij5H1nilYm0ZDlNg==
X-Received: by 2002:a17:902:82c1:: with SMTP id u1mr11791264plz.10.1588826435500;
        Wed, 06 May 2020 21:40:35 -0700 (PDT)
Received: from konoha ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id g40sm6205502pje.38.2020.05.06.21.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 21:40:34 -0700 (PDT)
Date:   Thu, 7 May 2020 10:10:28 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     chrisitan.couder@gmail.com, liu.denton@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
Message-ID: <20200507044028.GA5168@konoha>
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
 <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
 <20200506181239.GA5683@konoha>
 <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05 11:22, Junio C Hamano wrote: 
> Ah, I misread those examples that suggested that you are supposed to
> check for N+1 when you expect N arguments.   They are *not* using
> parse_options() and that is where that funny numbering comes from.
> 
> This one uses "argc = parse_options(...)" so we should check for N
> when we want N args.  Thanks.

No worries. BTW, should I include the `path == NULL` check in the
if-statement? I think the `argc` check would suffice but I would still
love to hear a final verdict from you and Christian :)
