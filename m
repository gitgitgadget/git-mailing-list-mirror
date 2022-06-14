Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015A3C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 02:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354400AbiFNCtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 22:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352311AbiFNCtK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 22:49:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04515B8A5
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 19:26:41 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p31so4444376qvp.5
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 19:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E1l/WaRVRqDQ1LPCO66tjhqcYGiinQw9jmFtobNHB+Y=;
        b=lBsKIU5h370PgZT16vNDEIn39BP9QhY0ypOCJMwlXv/U8mSGB7+M2QwPSfcbHl1mVq
         kAiLXELGSQhHRMsj5bavVIMsaEvo8m8lTh2dZRe0kDeXZMuwJBY4UcUNliVXt9/WwDad
         Qp6hwz/+Ua4sEdzWSF3A7WVha7DLo2h9DBYpMJrTbHg3OFCWi+CNGvHCZFGADGINYWQm
         SWmj1y4I2k7vvM0fy80ZEjzvrDLufqdyNtwniNvqX6VPHpmZNDdrb2PPNTBtNsb53LD/
         qIlbZeLUdgr4YSFsUwNKP1iP/k7UEWOi4NI0g1HHoF/isU+WpOeVUEZo3EYYEFsOeKD1
         CzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E1l/WaRVRqDQ1LPCO66tjhqcYGiinQw9jmFtobNHB+Y=;
        b=1xrNl4zNVDL10++E+UsMIPfvm1VIeFWSjv2CswHfiG2gRjtQFlZbZ84TpUWLSQkmVi
         FiPR8Qdsb/c0pIqA0guYvtpIdZTQ5X3EcP1xwkLcxtykhSUkrGhlPf++s0avpn9Y54fM
         vCOpQaBMlMBcTbnN0QiYayW572+GHZTXovKB2n817CzfdLHuaOrvW5dE1T/r8rJl6c6L
         nZtsGMQVBwJpcOJ5sFL39DRqPed569GmL+ySYH/qDmt5d/udzfnM6e5rWg7e8HOgZoCD
         P3+1hOIX1rPD5ZIf2byOhPXreYGTg6h1uiLWUNmRB3VBP97PHYdmIY7RBsD/LLtOFev0
         FxJg==
X-Gm-Message-State: AJIora+OkEI8dXRMDxfktfm7gAbWRwlle47z/yuzNYLEHzhh35wZdnnz
        d1+BPpBHWCVaRbcTNxlzfmWVOg==
X-Google-Smtp-Source: AGRyM1sJG65LRGySDigIblF6wl2nipDjYdRTH6l1qWobshW5BqPagshHZbwX5FAANyHOj4WrqvI8qA==
X-Received: by 2002:ad4:5141:0:b0:464:5020:28b3 with SMTP id g1-20020ad45141000000b00464502028b3mr1783101qvq.31.1655173598270;
        Mon, 13 Jun 2022 19:26:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ff24-20020a05622a4d9800b003051190886dsm6044617qtb.75.2022.06.13.19.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 19:26:37 -0700 (PDT)
Date:   Mon, 13 Jun 2022 22:26:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Subject: Re: [PATCH] remote: handle negative refspecs in git remote show
Message-ID: <Yqfx3P8qUpQ7Y0ux@nand.local>
References: <20220614003251.16765-1-jacob.e.keller@intel.com>
 <Yqfec9yvT3LKomNK@nand.local>
 <CA+P7+xrgWVh_GPMiziiMnsrESH_Z+HzB+D2un8FWSs0dpcDFdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xrgWVh_GPMiziiMnsrESH_Z+HzB+D2un8FWSs0dpcDFdA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 06:56:55PM -0700, Jacob Keller wrote:
> > > +test_expect_success 'show with negative refspecs' '
> > > +     test_when_finished "git -C test config --fixed-value --unset remote.origin.fetch ^refs/heads/main" &&
> > > +     (
> > > +             cd test &&
> > > +             git config --add remote.origin.fetch ^refs/heads/main &&
> >
> > Doing "git config --unset" outside of the subshell could be avoided by
> > ditching the subshell altogether, perhaps with something like:
> >
> >     test_config -C test remote.origin.fetch ^refs/heads/main &&
>
> We need "--add" semantics here which test_config doesn't seem to
> support at the moment.

Makes sense, thanks for explaining. This patch looks good to me.

Thanks,
Taylor
