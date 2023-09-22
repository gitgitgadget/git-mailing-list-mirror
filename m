Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EEFE6FE57
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 15:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjIVPjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 11:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjIVPjo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 11:39:44 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A6D1BC
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 08:39:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d81b42a3108so2660272276.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1695397176; x=1696001976; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyMOBxNgtLheX3z87Rfk0N06UV3b6+qFr+Wq9nx/xjM=;
        b=bGrHS/SW8I0Te+uAu8OtYLPeVv/kVc8qqq3B5+gVt9FD2pmANOZnf1rnOHyLgHL/m3
         41TjcKLJG/G0aAX00+bx7yfjRaiuS+qB2fYimsFkYUNS20irYjVDNL7QrMRajaP/7XVN
         CPilO39Vha9Jk7Ru+dU1mbTxp8RJh2GETqC6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397176; x=1696001976;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyMOBxNgtLheX3z87Rfk0N06UV3b6+qFr+Wq9nx/xjM=;
        b=P5ROdrLxelYvcUCI4PArm4rcURA8A847Uk978wsUM2v171loBRZa3VyunofCkqx3oL
         8XDO/h+duN1XHLlliBODSjQY5i7vrdtcz+anFx3Yrr0gwmkkP/qM5C8ftPXK0XL+gl+W
         Lu2rUtmf3zb8ZabpSUl9TKYRhWVsbYXCenuzyUN7/df7YwetwmHp9MIPg5RcMpQb9774
         LyHVvHdvsOBCodBRDB9fdMpC2zKjXtkhzT0UHL4dTx6T4+CPyX3r7iRVA8l8vJxZKHJ/
         W7HoONbtKh1Rroce6w3hVnJQyd3uu5rceRICGqPVnSrAvI+mHsuNBQPoTZ+BoLrhmwLm
         uP1g==
X-Gm-Message-State: AOJu0Ywkn4Sc8gxErkSf43Po9IUEsULlj57v7bmUIgdxCp4MmDzGowPg
        nU1VWBxkzPTSRr1jK0EhjqeyvRWzyYZJGN1jbQBQaA==
X-Google-Smtp-Source: AGHT+IGaiTynrGS1Rit9HH/FP64xkYj/B6RYBeeeaKQPb+7IyXMjUbYyXZNUlVrZwgGZ5qf5ahkhUQ==
X-Received: by 2002:a25:d288:0:b0:d85:8786:c70a with SMTP id j130-20020a25d288000000b00d858786c70amr8620071ybg.59.1695397176564;
        Fri, 22 Sep 2023 08:39:36 -0700 (PDT)
Received: from localhost (cpe-142-105-146-128.nycap.res.rr.com. [142.105.146.128])
        by smtp.gmail.com with ESMTPSA id i17-20020ae9ee11000000b00767d8e12ce3sm1490544qkg.49.2023.09.22.08.39.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 08:39:36 -0700 (PDT)
Date:   Fri, 22 Sep 2023 11:39:34 -0400
From:   Ben Boeckel <ben.boeckel@kitware.com>
To:     git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <ZQ21NsLmp+xQU5g+@farprobe>
References: <ZNffWAgldUZdpQcr@farprobe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNffWAgldUZdpQcr@farprobe>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2023 at 15:36:56 -0400, Ben Boeckel wrote:
> I found an issue where `git describe` doesn't find a "closer" tag than
> another tag as the correct one to base the description off of. I have a
> reproducer, but I'll first give details of the real world issue.

Bump. Can anyone provide guidance as to what the best solution to this
might be?

Thanks,

--Ben
