Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEF2C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 08:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA1A613C0
	for <git@archiver.kernel.org>; Sat,  8 May 2021 08:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEHIEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHIEa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 04:04:30 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C208FC061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 01:03:28 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so9984115oth.5
        for <git@vger.kernel.org>; Sat, 08 May 2021 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FAvcRNUhO8keJVDwnsb02JDbOk/+Rbxc4Zlkmx3FJ80=;
        b=KEoKU5TsSAy14NPOY39PjE+W7nvdDuYZLY7vZsmN7tfzCBZaw09EYDZGYqH8yB/QUM
         E3nte41k+BEYF6RbqUICT158zmhThJYZ89WnF46TvyHNxac+hVaBtv3WD7oltHKsRITq
         g27QUOVZFgPocjaZGpAUCtF3GSHFZ6aEm6rbqycfspdoSxhN4gzFXkE72MDZ7nHcnzbb
         1H7nHbQfCfGKhyqCJGoea304ZjYv2asnjCd2CVWnnDUboOaVHzt60TZZx+m05oSElKqE
         lxK8h90h1vXPVPhC9SH7qbLBUsh1UUgueI+QzYXLbuGrLXWcAi8ZZo3ZO0TTfPD8u4A2
         oFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FAvcRNUhO8keJVDwnsb02JDbOk/+Rbxc4Zlkmx3FJ80=;
        b=ke/JpnQh7Bnbh7cNF9SoVJnaWFKrCDKiqfC/qvmNKT1y1MVAz4qrsvw5TkT+Vx9NeQ
         6UWPGlouSJodNYsh9Rm5D0jU7HqydhPVLH/jJ6r1FDNldas5Sd2ubAyyBcibFBDvepXn
         stdhb6ih/RED9gDeeN4qIiVVdJP/B0Jo+ZhtUkhmiAAZm7rrLewaCI/8UjDGKnu+n2Zc
         nKVMmNRjSXADc3u63IiAe6P5B5Gp7zhkcUXhfKFgY8yitMOdN54u4WadzajmK0S3nGCO
         05JveVL6RQOlf0YzDFkE8jp3BKFQsn0oOQtzyh3HlUvaCrkc1s7AO8IiZ35k0o9UAlJZ
         cZPg==
X-Gm-Message-State: AOAM531PXY4DJdYhqND7WnxyLtyn06+YpggGyhqBku1mGQtg4ms96h+v
        sZBbc7UpqRNMW9Txl/9h6ik=
X-Google-Smtp-Source: ABdhPJw3dG+H4MakISvOLoKh+8LDaGtgLzqkjHfK1hAObAudhPN5AKAV0VQpK4PIUgVWM0xHUalz0w==
X-Received: by 2002:a05:6830:1497:: with SMTP id s23mr12012338otq.35.1620461008011;
        Sat, 08 May 2021 01:03:28 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 101sm637361otd.33.2021.05.08.01.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 01:03:27 -0700 (PDT)
Date:   Sat, 08 May 2021 03:03:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     dwh@linuxprogrammer.org, git <git@vger.kernel.org>
Message-ID: <609645cb11f72_1fc6d208ee@natae.notmuch>
In-Reply-To: <xmqqim3tvhlr.fsf@gitster.g>
References: <20210508022225.GH3986@localhost>
 <CAP8UFD0vp-zZv=Q1+KWv8PHnxTuspTw2aSCUp8QUic0HOSyq4w@mail.gmail.com>
 <xmqqim3tvhlr.fsf@gitster.g>
Subject: Re: Preserving the ability to have both SHA1 and SHA256 signatures
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> > (Not sure why, but, when using "Reply to all" in Gmail, it doesn't
> > actually reply to you (or Cc you), only to the mailing list. I had to
> > manually add your email back.)
> 
> I am sure why.  DWH, please do not use mail-follow-up-to when
> working with this list.  It is rude and wastes people's time (like
> the practice just did by stealing time from Christian).

I agree with this, but shouldn't this be written in some kind of mail
etiquiette guideline? Along with a rationale.

-- 
Felipe Contreras
