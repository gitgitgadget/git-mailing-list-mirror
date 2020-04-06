Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F0CC2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5A0206F5
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6yMvouE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDFNtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:49:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54228 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgDFNtb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 09:49:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id d77so14750276wmd.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G9PLU/rM4l6WoTfEJX926DPsBdUKBWeROMebMkwWKGo=;
        b=m6yMvouEXSOva5mzj0QXpTnkQYJwfN8Oryo1iqhxXkaN0daVOfzAKGWY/xogd2tLBg
         1EYVgQor1HlFgWwemtHQjzCz66wTYiGG4JTh5QyhrteEuJ9SuG6iQ8shyI/yQFZdESUF
         zGXkv8UCFWTyW+YBZ7ibO592hi2uiRPMKMehxlr+Ckc/SyG2z6SLvvDclI8kpXpmIx4Q
         kp/4LCLuaNTw53Lokf5x3fBUYb0RwU4SbvJFhrp6Kk4Fsm2GNvHFYVF2ql4bS3R5QQ1t
         NcPvUuULN7pf0b8gT3CnJTRiqzGGX+kBOyS7ETJJ18JOAXrgELIr003aKzy6nYOPOTdi
         xdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G9PLU/rM4l6WoTfEJX926DPsBdUKBWeROMebMkwWKGo=;
        b=TMKJROP2uti2Y35U+vkMRszoCn78fylPk6lgfBLTgYHQdI48FRAtQ3+WpR/wlS9nSh
         iPvQ1mVJCQYwtTnTClvEeonz72ycWaZeKtNtLJA3Jy69izg3iR3PtK1offk+DJSXuIUp
         tVkuK33z51UGylQQM7ArjfaHTkSkkOLxc8N0QC4bZ+xClYXZi9B4FMZDhkBLUa82qHM7
         etmbXbUMT4/N6d764WJMoSJoofZIoXiYq2Ks/4gV3csjWQOSFU9DzsLM+npLp+JHCwtP
         GPZxfNdLIr7UgERhAfhWP61yREtfAIHj9pivwK2UaTfrHKQ7CHq5RUvpsc03MpqXOdfZ
         7C4A==
X-Gm-Message-State: AGi0Pua5o7oq0gn6U7t2kMv1aqunCPFKLzRQ+lUL8bgqGbZz80cjv0ot
        ijQdegblAdn4ola3Nj/aSKg=
X-Google-Smtp-Source: APiQypJECnpgJBIen6mBzby9bDXsVkwUsqBs/JchCFcmM4Mr7jBLPlYzFgJ5JpyoSJo0dRZHPghPFg==
X-Received: by 2002:a1c:4e11:: with SMTP id g17mr23337819wmh.80.1586180969412;
        Mon, 06 Apr 2020 06:49:29 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id b82sm11983359wmh.1.2020.04.06.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:49:28 -0700 (PDT)
Date:   Mon, 6 Apr 2020 15:49:26 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v5 4/5] doc: be more precise on
 (fetch|push).recurseSubmodules
Message-ID: <20200406134926.fid74suincbqlibu@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Mon, 06 Apr 2020 15:49:06 +0200
References: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
 <20200405201633.704987-5-damien.olivier.robert+git@gmail.com>
 <xmqqk12twq7x.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk12twq7x.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Sun 05 Apr 2020 at 14:57:22 (-0700) :
> Why did you lose quotes around on-demand on this line?  Shouldn't it
> be typeset the same way as the other one in the sentence "Defaults
> to ..."?

Yes it should, sorry it's my mistake, I'll send a new version.
