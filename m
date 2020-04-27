Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D82C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 00:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586B12070A
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 00:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LutGTb51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgD0Aqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 20:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgD0Aqq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Apr 2020 20:46:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E1EC061A0F
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 17:46:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fu13so6116383pjb.5
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 17:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EQcWh9H36n2vn++z4X9xl7WSWAwW3w9i5eCKsgA4BB8=;
        b=LutGTb51kWM/8j6r5n0PW0vt9sknRVUXa3pVJSq9gpeABKLPpUTjkVm4jBUlZvENmd
         uuAXThLZF6lBwFlV/4F19DZth4petmcd6G6Icgx6ulzWryqdZCafGz0gpbne4DOu3duV
         kZ70PyRe+IFOvXrOyPaWNKc1WoKnytyO//5OcOxCBCy/+cnSfVZRan3ZnLKF7HNoP2Jc
         aqdCYF8J03noSR7SlDA6U9igBztBh6KQeKU8fMTTBjKnqk8iT5tl+vEhCHSaXjmd68Ct
         K2zwWHbTu+HtCprF2ZFL6ZE2bsvvGjsCRWFEz4HbHAlg8lnYw++GpLWgCO+ZDq00dMaR
         FZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EQcWh9H36n2vn++z4X9xl7WSWAwW3w9i5eCKsgA4BB8=;
        b=qr0xPCX3HH8Wxk3tzVuPsnKYSbdKX+aoycNcWnkyi71YrL0MAOoKU9oOsdMvuvaq3O
         MVrxfJRlx8XDSxx/MmcKf4O1VBE3Z5u6SelB0uMTpYG4yuv00/JGViv0qKZj9bWPdW6g
         ixT5yfNB/pe17oh/hQj1Mpi3AwaLc7DCaM6P5eL6FdIX23n6k1Zucj+mvYi/gTuUBGGJ
         5qnwtHoERUyD8rfYAO2PYFrYV1fH7d90GG+nn8P/oWLSm9DBsYzLsy3J317/7wIzvJr5
         D2OC5dphLrQ2CLrHA/O88L+hIXNrf52V7xQKZ1lldiT58F5Dfkd2XCiJlyqZlFgkhaD6
         a0+g==
X-Gm-Message-State: AGi0PuZDAG6WXqNOirVE2PSzc2eFoQaOIVJPLPGIznwlRLJcEcENIXF7
        fHUhY4MZZYCPSKdOaXoaY+QZnb0R
X-Google-Smtp-Source: APiQypLdUlKtTHHxieQKG8ArMIIaJjmwtfjihIsUjQmMawrNHM/RnATE5Sk9FBwfTHNzRAcVHfaB8g==
X-Received: by 2002:a17:90b:3598:: with SMTP id mm24mr21905183pjb.132.1587948403255;
        Sun, 26 Apr 2020 17:46:43 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id a16sm10743599pff.41.2020.04.26.17.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 17:46:42 -0700 (PDT)
Date:   Sun, 26 Apr 2020 17:46:40 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, Dirk <dirk@ed4u.de>
Subject: Re: [PATCH] git-credential-store: skip empty lines and comments from
 store
Message-ID: <20200427004640.GA28818@Carlos-MBP>
References: <20200426234750.40418-1-carenas@gmail.com>
 <CAPig+cR8HKcbNxxw65ERz0iHvnO5aC6RXvF9NjvFTySXpcHCSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR8HKcbNxxw65ERz0iHvnO5aC6RXvF9NjvFTySXpcHCSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 26, 2020 at 08:19:35PM -0400, Eric Sunshine wrote:
> [Cc:+Dirk -- so he knows his bug report[1] wasn't ignored]
> On Sun, Apr 26, 2020 at 7:48 PM Carlo Marcelo Arenas Belón
> <carenas@gmail.com> wrote:
> > diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> > @@ -120,4 +120,21 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
> > +test_expect_success 'get: allow for empty lines or comments in store file' '
> > +       echo "#this is a comment" >"$HOME/.git-credentials" &&
> > +       echo "" >>"$HOME/.git-credentials" &&
> > +       echo "https://user:pass@example.com" >>"$HOME/.git-credentials" &&
> > +       echo "    " >>"$HOME/.git-credentials" &&
> 
> Is there a reason you don't use a here-doc for the above (which would
> be less noisy)? For instance:

because I didn't knew it existed ;), thanks for your help and will include
for next version.

Carlo
