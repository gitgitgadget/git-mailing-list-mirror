Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FBBC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB552084D
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwUHvxJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfKYOGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:06:12 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:33125 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYOGL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:06:11 -0500
Received: by mail-pf1-f179.google.com with SMTP id c184so7448710pfb.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 06:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KYh7PhjqBLXJrDI7yEwsPCC/mUhytyvoCg/z4aG8bPU=;
        b=lwUHvxJpxIGnNcJNFM+0uuJp++/FS7xKWKgfFimL6Rc9sRC9fC3uZYmvdcoKUM6Osf
         B+J8I4puT/1ZjDJPeDk7neFGaddL1e3STR2KK7Me/Zm+cKhXPXdnZweKARt08fQTbuav
         7Pt8czhat1epUjTPUHsny4oI5R6xZeS1b/3gQCi/r4tqSz/zODoi9WxED/s2VAJb44QI
         tMTgbvkrWYXvflaim2ubLc6AYpP0lwAKEOEITs9Yh6yxR6Nwmn6xkKP1RJpg0CEkTd1X
         QqrGsyh4VnZmc3j9PYLlStJQ9YegxYi8Y5ya6/qGWdDEf7bc3DDkmbWJxKZq7XZ2z09A
         dgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KYh7PhjqBLXJrDI7yEwsPCC/mUhytyvoCg/z4aG8bPU=;
        b=Cf4A7nP3EcAXO/AVNqiaNPqdVk1FoAdOje7hCmk8ZZF3tnE+1OSp33QQKInoc80Tpt
         JBp4UIuuwixy9oT814fKVExWrblNaqErtyBouRIwGHWM0qgcQ1685dWhUGWmGYjoDYl1
         gD1XXKuL9jyPi/QOLUTJebprcGnDq+JsqPpIaLKjx2RKovMtD+WlX2VGDHDgoU/rcvx9
         JYBneT7QOMt9raZ9NgpoKmL07R8vc7N/vjxlGY1pGMPfmbEsUbSOZsFZhb6/ivKMdAUk
         2kyl2mqyGrp6N9pisSpFBqTzKpUiq5qwqaQs6/QLP3RaUxchfP/2PGihdCvwcF9A2SCs
         Aepw==
X-Gm-Message-State: APjAAAVPSdFSE0k3UAH7HS06xmI5xUe9k7KggbGYJFgtC4HcUpqEyAVx
        kqsnnWyo7mnYB1WhgS+A1h0=
X-Google-Smtp-Source: APXvYqwPcZUKWzF75bjkIMvbO65ONvsFw3lkozwXfGcDcOEu205hFT9ja5m9yhNtp9RCzeo9J9MZ1g==
X-Received: by 2002:a63:d550:: with SMTP id v16mr32183459pgi.443.1574690770873;
        Mon, 25 Nov 2019 06:06:10 -0800 (PST)
Received: from localhost ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id g4sm8513839pfh.172.2019.11.25.06.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:06:08 -0800 (PST)
Date:   Mon, 25 Nov 2019 21:06:02 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: rebase comment char (was: Delivery Status Notification (Failure))
Message-ID: <20191125140550.GA23860@danh.dev>
References: <CAHMHMxWhYEMWCPgPp7qX9S_i0-CtS6OBj2TdCVXsyromnwVawQ@mail.gmail.com>
 <5ddbd7b7.1c69fb81.dbdb8.eb94.GMR@mx.google.com>
 <CAHMHMxW2TN9OVeEZ0rKWEsyLo3kkuQOcYxMzd0Ybn0Bit1mk=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHMHMxW2TN9OVeEZ0rKWEsyLo3kkuQOcYxMzd0Ybn0Bit1mk=g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-25 15:36:13+0200, Σταύρος Ντέντος <stdedos@gmail.com> wrote:
> If I do
> git config core.commentChar %
> 
> then, during a rebase operation, squash/fixup comments do not honor
> the core.commentChar setting

Can you give an example?
I couldn't reproduce with both git 2.24.0 and the current development version.

-- 
Danh
