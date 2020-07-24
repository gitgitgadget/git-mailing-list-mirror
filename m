Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C7DC433E4
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 13:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE2120656
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 13:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2G0tnU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXN6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgGXN6t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 09:58:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED8C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 06:58:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f1so7861025wro.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4HXGpzuohWroqKaIH9kR65g4+83S1QiModreBEukc1s=;
        b=F2G0tnU9RtNg+7CvxzUjT/WWP0B+7cYTLlAd0tuxXEsSsEdOS4w6H3voK6WINKFTZc
         2e7sPfcpCkxo7pFN5dbqzJTsI47WSBT+/Zex2qOkeh2+D7fAJ+J9j3n2NGMJ/VifMlJ4
         aYBYFyP67kD1384u9thH0R50EdFrrjZzt3n/r/gx+0I+fQ8e/M/mgcwHeaG+1IclhM6t
         AdZRSD1SkZG9mRWosAB2R8AUyQfPSTUeed3J3Kg7UAXkZg52wIBpo1uL1/QxF7xICcVt
         nnek71RnPc+4fYjq5eopqHs87SBnWD/2/hsvqsXvzcEc8ZOXrOt/hlxWHfnigNJA9Md3
         SaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4HXGpzuohWroqKaIH9kR65g4+83S1QiModreBEukc1s=;
        b=eIoEsaOObdo2t3NG73vvQ4/fGSp/6iDBGMQl3sDXtyoeSh4I33xZjYtQT0H4ee7gjp
         rCz0MaJEjns4T0F5rv4x+GX4vnEJBQOvK/UIJYqFzUD6XagGjl3fEz9wG8zQmhpFBfim
         1z2HKGedZEYMNcursqS7+46RYWJlu7xrgP6SSIVG6xYQW1+QfUiyWLR9hqDSZdbVZvHe
         0LfqErapDcW8VCEKJuOBiDJEuI0X1RwFjvv/J3MSgTNVIAkTSyfLWZSg6vRpOPE+Mf0R
         QAEqmflpneyI5XF/vVlzVqUMA4/zwkEDYcNVoswdL+ORNBW94Hwxa1uNrQUhpu15Gj7F
         hZ+g==
X-Gm-Message-State: AOAM532exxoPNu4zvnUgeSYKzKtoYG3gu8RTsdswJpOdXQFWtq+Ztmqs
        FbaXzpTTd6ZUa/zfa74zpcI=
X-Google-Smtp-Source: ABdhPJx6IdXFJtttCdM0WXDR9zodPcLd9njEDiMIAqyOmnWXi0U2/ZEcq1/rIfc4NKUZnx3mj3bUBw==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr8523210wrr.353.1595599128520;
        Fri, 24 Jul 2020 06:58:48 -0700 (PDT)
Received: from szeder.dev (62-165-238-20.pool.digikabel.hu. [62.165.238.20])
        by smtp.gmail.com with ESMTPSA id 1sm7134869wmf.21.2020.07.24.06.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 06:58:47 -0700 (PDT)
Date:   Fri, 24 Jul 2020 15:58:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] ci: use absolute PYTHON_PATH in the Linux jobs
Message-ID: <20200724135845.GN11341@szeder.dev>
References: <xmqqsgdk7gkq.fsf@gitster.c.googlers.com>
 <20200723213848.30032-1-szeder.dev@gmail.com>
 <xmqqwo2toobn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwo2toobn.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 03:31:56PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> > Junio, I see that you picked up the first/RFC version and applied it
> > on top of v2.26.2.  This patch won't work on v2.26.2, because its 'git
> > p4' is not compatible with python3 yet.
> 
> Thanks.  Which means that we do not need to touch maint track 

Yeah, that system Git is v2.21.x, as far as I remember, but apparently
'git p4' doesn't use any shiny new features since then, because all
its test succeeded even with that old version.

> (not
> that we'd be merging the SHA-256 topic down to the maint track
> anyway).

It might be worth applying the final SHA-256 topic on top of this,
though, so Travis CI builds of that branch on its own can succeed.

