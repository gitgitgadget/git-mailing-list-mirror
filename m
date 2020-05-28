Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2828C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAD2206F1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ+SjXBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbgE1Myy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 08:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389899AbgE1Myx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 08:54:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A0C05BD1E;
        Thu, 28 May 2020 05:54:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p21so13430268pgm.13;
        Thu, 28 May 2020 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=mVodxXDgXuSh5nuG79Fm5YEjLeD1kZZwfX36BHBYFQk=;
        b=VQ+SjXBYZQ1CFul5nfQHFBuKJLFtpANs1Uk+d1bljglbbGfuff0X6SRaN0pN0XVKVX
         +tkEKqAJZecksEPHCrOZwqG75fJrWWifJISIsXnuc/cBSRjC7AcQqcXYlWJ7HRRx0J9b
         oBN/y04FMXGsmg3yCEIDCMSeRrdPXqRxcLj21SvFuNdGtG/BnyHBz3pDRXThyOVvebgT
         iwiovgcCp3Ot1nweFWOR7qHUOUyy6m6IRYjwPsOr0f5yd8fGWU4fbO7gT3hix8/mtqni
         pCUY8La7/xWMMVv3bwj1uuO4eTLp6q3qNbbPR1d5YvummhXXPnELvPP57zpiXv2MCLLP
         JfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=mVodxXDgXuSh5nuG79Fm5YEjLeD1kZZwfX36BHBYFQk=;
        b=Dbo9g/b17a6H7uKITlrc6ddL1ynqMPPG1xFDTSEmQuEjpX3TOe9aRi8YnELl/Cpowp
         TF973UJSAyhv5NQgkThZjO+KMx161zJ+esz+9kBJuX8Bi0bJ5XNXqoP2XBnR+05J+bT4
         OKvRX2M2bN9FhB75eeNDCMndOc0B87GFe7uS8407xgDvfjwZ2Bljbx7/yrJqxUlD6LF/
         GdxF6Szx0nVNn0OcaQP+gOZlnrZebhTzFt1k5ENTckLLwjNe2kZtqoTBytFwmPQtCjPO
         2iy2Zi5Lqm6RjEiSo9mNHvDU/8+GMO/d6RQVYwJtDUCqxHq2g7oynmjD/JNAVrFQlx5O
         0ODA==
X-Gm-Message-State: AOAM531sFkhyWsuv3oRB2ulEytDyKm1HBvwZwHLQcL0fn50d3pHyIgL2
        PcCqe+8KBT+3TCsSerzda6U=
X-Google-Smtp-Source: ABdhPJyR1nvk7v4YL0toZCvxXtDHuRZamAs3zZ2j8VvJTJ9RzDvI/8CPL82qjvs5AwhoHfARyOwaJg==
X-Received: by 2002:a62:1d4c:: with SMTP id d73mr2863848pfd.226.1590670492671;
        Thu, 28 May 2020 05:54:52 -0700 (PDT)
Received: from [100.78.168.153] ([106.198.22.96])
        by smtp.gmail.com with ESMTPSA id h21sm5402460pjz.6.2020.05.28.05.54.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 05:54:52 -0700 (PDT)
Date:   Thu, 28 May 2020 18:24:45 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqa71tmika.fsf@gitster.c.googlers.com>
References: <xmqqtv02mt2m.fsf@gitster.c.googlers.com> <e66ea483-5e7f-4ebd-5ba8-91227efa454a@gmail.com> <xmqqa71tmika.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [ANNOUNCE] Git v2.27.0-rc2
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <DA3387FB-670A-4A36-9017-6D1372F9DBC2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27 May 2020 22:17:01 GMT+05:30, Junio C Hamano <gitster@pobox=2Ecom> wr=
ote:
>Kaartic Sivaraam <kaartic=2Esivaraam@gmail=2Ecom> writes:
>
>> Hi Junio,
>>
>> On 27-05-2020 00:17, Junio C Hamano wrote:
>>> Shourya Shukla (4):
>>>        submodule--helper=2Ec: Rename 'cb_foreach' to 'foreach_cb'
>>>        gitfaq: files in =2Egitignore are tracked
>>>        gitfaq: fetching and pulling a repository
>>>        submodule: port subcommand 'set-url' from shell to C
>>
>> This is the only place where the `set-url` conversion from Shell to C
>> is mentioned=2E I wonder if it's enough or if it needs a little bit
>more
>> attention may be in the "Performance, Internal Implementation,
>> Development Support etc=2E" as it is a conversion of a submodule
>> sub-command?
>
>I'm not sure if it is worth the bits=2E  It may matter _only_ if/when
>new implementaiton of set-url hurts the end-users by being buggy ;-)

OK=2E That makes sense=2E The converted version has gone through reviews a=
nd presumably it does pass our CI test cases=2E I think I was just trying t=
o overcautious to ensure we're not bitten by a worst case scenario wherein =
a bug slipped through the reviews and the tests=2E I believe it's pretty un=
likely, though :-)

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity and =
possible "typso"=2E
