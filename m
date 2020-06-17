Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54310C433E1
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D7821475
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS6Nd1/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgFQH1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgFQH1w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 03:27:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B2FC061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 00:27:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n23so1599106ljh.7
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NuK4R83Ig2ERGKLbG5Fr3VLtqyy/fMxexDSuVnkVdCM=;
        b=bS6Nd1/wg+nVR2x78tmUrs3bmKymXkYjKQxCCAoAXG0VzUw0MjfTB2q0W7e0ZJyqK1
         QaxX2eqMEtqrxAkFPp55cZZO02U6xlrV58mi8hYJ4rUhqzB03g2JR/VCbLsWb2KIdGA4
         rjCyBqFOepyj9JFiDE8FolpTFX3v2kT9XOZvslm7C6Cbjbwrf4eM9EcM29A9ugD48PDF
         2EXBse3sYHHBu1l4XsRstPu9NkQIHXs4dDZBxvJtNZmmKZqAyz9fNq2aSc/pxU9z5cy7
         yCIkfL8Fj4A5zp5FE6Ib9Cf0IjY50Fy9SpCWkkalAVFgMt7ZQqhFgmemXGwkUSLbUpe/
         Racg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=NuK4R83Ig2ERGKLbG5Fr3VLtqyy/fMxexDSuVnkVdCM=;
        b=uh73syyhmXXakAyVv2atiHQQIj/kSyVQtuPYunlAyhwVcbTKxqNmf8y5k0C6XtGUJg
         vVAv8dG6/TU3gOWyy2x/82hjsG0kkPDQcHXsbaqHDVQe3tZHNvciYMFEwatKYvrGwt3x
         /mSNScEJAA6PWsq7eb8jo8q20+MlOXRnsSoU4u1yDitRUraedc5QWNt2F7+itevYXq5U
         TsHOzau+fyIqVmyEoyMMEAMRLqRU3vXkyTrR4xXCF5EKz57jFi5ROf9rP2sWFmmYxuH9
         XXqPtWt3ythaeajxRTSHjwyE4jz/C4hRhmHzglofYkXlFyEOuMjXLBrxQRYMTGivMuAG
         SWKg==
X-Gm-Message-State: AOAM531NkE1/OMVfS6WO4+YCPuk0ytEtNktcrIqy1boRRFIjEvH+lg1q
        6UtNR8nfpJBdxqhuxBBMuaU=
X-Google-Smtp-Source: ABdhPJy4BuAKgM5hgDFWnM/+9Wn16Ijo+5WSSwiqemYFrs3ZX2ZKupazMp5Utj75a2hkcViNi7GOdg==
X-Received: by 2002:a2e:7016:: with SMTP id l22mr3563658ljc.284.1592378869765;
        Wed, 17 Jun 2020 00:27:49 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u26sm3620286lfq.72.2020.06.17.00.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 00:27:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Alex Smith <alexsmith@gmail.com>,
        "sergio.a.vianna@gmail.com" <sergio.a.vianna@gmail.com>,
        "don@goodman-wilson.com" <don@goodman-wilson.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "simon@bocoup.com" <simon@bocoup.com>
Subject: Re: Rename offensive terminology (master)
References: <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
        <20200616100424.39718-1-alexsmith@gmail.com>
        <1109121592306913@mail.yandex.ru>
Date:   Wed, 17 Jun 2020 10:27:48 +0300
In-Reply-To: <1109121592306913@mail.yandex.ru> (Konstantin Tokarev's message
        of "Tue, 16 Jun 2020 14:29:49 +0300")
Message-ID: <87lfkm9mob.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Tokarev <annulen@yandex.ru> writes:

> 16.06.2020, 13:31, "Alex Smith" <alexsmith@gmail.com>:
>> Whether or not any patch would be accepted, the damage is already done.
>> From now on, people will judge you if you dare to use the name
>> "master" anywhere
>> and this is incredibly sad. These people are literally bullying us into
>> submission in the name of political correctness where no harm was actually
>> done.
>>
>> This sickens me.
>
> I guess their next move might be to force sound engineers to rename
> master channel and derived term "mastering" into something more
> politically correct.

There is even better target:

$ cd src/linux
$ find . -name '*.[ch]' | xargs grep -i '(master)\|(slave)' | wc -l
40506

... and then they'll finally be on the right track to win the war
against it.

-- Sergey
