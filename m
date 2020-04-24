Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73865C2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 07:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AA920700
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 07:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGA/ymzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgDXHUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgDXHUw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 03:20:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0402BC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 00:20:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z1so2704277pfn.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 00:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9qtLG8z8zR82CgNdLWz9IOBVhVg/YhG/5tqvUnEDzoc=;
        b=QGA/ymzjEO9iy0ZOZ58IYYcb7Xq7TM/XyRjIphlV0Zey5Wmm9hZ9rpiwTi+u19ogd0
         ChUqKPn1vCEFD6T5CIAayXatSkLhV2FSeBU05ImMe8SK4roF5OUuiiJe6f4nlYy2MsvK
         EMwRheXZGBwxBC7JQhq8WecghWxLBM5FKpkUnfosWbPPTwJgwa0q+9ejNF89IWVNwCwP
         am/quyKd7fh1vPCchbPsUv/Gm8lq1xQ2EJSZQGBG7WS6KMS7YG8npfEc+adcIeTalPJY
         iKQsRdxwp4yTNS0XbZXR+HZv26q8jrs5WB4TmEO+emzEmNMgtLLMAY8/lYlLy9D2aHRw
         lauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qtLG8z8zR82CgNdLWz9IOBVhVg/YhG/5tqvUnEDzoc=;
        b=e/Cf3qxSg0ByiO/cIWZvtm9i5vcsTmviVGK9pgC1ehsCL1EAlrk1faBBh+xGYYOkRT
         0juJVKb5bJQTv8ULb1kLGSot8oX5Gwsxrb6arfuitMRCJXPsbupssVJLliF/dT7xq+RL
         DQh/tUpV5Y8/DyhN03bYp1Seps7wUGnrclaREWxtlL3A27gZmkODFW8RmPXqOV//yap5
         dWlFZ0PMpO/alIpO4/1Zkn22LeucvUEK+CNEzlrRPjt9pvmUi8WYiSAASHV7qPp73tVQ
         Mb8EoBmZw89yfiMwNlBcxYKUYEWr43xZ9gdujpJ1dbD5joEzqvukCcRWA6b7DRwRZTO6
         oo7A==
X-Gm-Message-State: AGi0PuZoB3sx/NElgmfeJ2roqj2jDlMPHfKTPMlyJnt4B7xg27VS60Gy
        POUQvtF9Of2cF9pvGeIWWog=
X-Google-Smtp-Source: APiQypJVc6njPxxVM26ZZ7imPyX/UqIYpySCMX2pmha2ViML3uWHKhQvN6w1rbmQX35EmMmmdTYRAw==
X-Received: by 2002:a62:ed14:: with SMTP id u20mr8247507pfh.69.1587712851325;
        Fri, 24 Apr 2020 00:20:51 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id ml24sm4014082pjb.48.2020.04.24.00.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 00:20:50 -0700 (PDT)
Date:   Fri, 24 Apr 2020 00:20:49 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     lars.fricke@googlemail.com
Cc:     git@vger.kernel.org
Subject: Re: p4merge no longer working after upgrade to 2.26.0
Message-ID: <20200424072049.GC44448@Carlos-MBP>
References: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
 <20200424064805.GB44448@Carlos-MBP>
 <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 08:57:27AM +0200, Lars Fricke wrote:
> 
> git mergetool --tool-help indeed does NOT list p4merge.

but does show if you run :

  $ PATH=$PATH:/opt/perforce/bin

> So support was discontinued?

no; something else might be broken (hopefully only in your setup)
it seems to work at least on mine :

  $ git version
  git version 2.26.2.266.ge870325ee8
  $ git config --list | grep p4
  merge.tool=p4merge

Carlo
