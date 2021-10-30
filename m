Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC74EC433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45ED60720
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhJ3VpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhJ3VpO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:45:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59FC061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 14:42:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z11so9143663plg.8
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sideYTV4xqWlZyFo1zBDAAHG6RaSFZz2hFv2L39QBV8=;
        b=AeitO16vPz+mcaMHxd2QxdjXvyb0+bkbhupd+2+xeBK8CcBrPUBiShmZbOhrFlolOR
         oqMCeZFOFJvff8ViP3bWsJqT/XoqO3br15NOnl0OG4iUEFz0UPg4otGLb+OgV5xLLPWt
         QcQ6YE9ZI7efdjIU/xX9VPaQMW9DmxZsZiUNsru7qflaDMvAIkC3dt17vzQc5Wx5G6j8
         IWp1vuBUaEC4UM+nEFopLHrIevlbBXO0DB07D/t1lXPBuqKodlrAGkm0ZNtmY0MT8QE0
         J3oGKvfi0M7yRIkK9dBlx1U7+R/R4Jhz8QR+IQPX7ruevxcbwc2voE+WLwL1Db2rM8ga
         HS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sideYTV4xqWlZyFo1zBDAAHG6RaSFZz2hFv2L39QBV8=;
        b=OX+mMP92cfwvD9SyKENpjP466ryjFft1ssCjsuzrd/D7r45GUPoNBVptuHTcIF//76
         L5L4A5PZci14H3CqNN/AcReHKNjrDgPnc7UqgNX69Xd34k7Y66yjoodbA+6yZA2dW1mW
         oTA33tScXYx0Mr6FdIZ4XCw5SRtKcM7pCWQAXIhEyGMYNxrG6gs/i9DZ13HqLS8SISbP
         pStbDA+HR68XAfZ57ksqawPTb0unz+nFGeCaXEyEd6Ku+P4MVCWi5y78CEroQIOILuyD
         MUdhdbFHe2Z5d5wdbOjhupq6tXY8ZrOkdLloWtUx1xa+UkqblULH+HA1tuoQIdWSWr5/
         OmUw==
X-Gm-Message-State: AOAM532cpapw7mhZRyHXSFSRJyYL/3ZNhaGQAq2WvndblXVUsXfO8EI8
        +2hJ3v+zkDkzC7ipfOJsrd5eEt12GEw=
X-Google-Smtp-Source: ABdhPJyjEZuMyPZzqcQHptwG/Ymc8fgykfuGYiL8GVMD9Ven/tKUy4FBH2B3iQg9EMRExjruMqPd0Q==
X-Received: by 2002:a17:90a:f182:: with SMTP id bv2mr2894826pjb.139.1635630163484;
        Sat, 30 Oct 2021 14:42:43 -0700 (PDT)
Received: from smtpclient.apple ([2001:420:c0c8:1005::34])
        by smtp.gmail.com with ESMTPSA id s25sm10356187pfm.138.2021.10.30.14.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Oct 2021 14:42:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: git apply --intent-to-add deletes other files from the index
From:   Ryan Hodges <rphodges@gmail.com>
In-Reply-To: <20211030203916.zopggbajumvb4z3f@gmail.com>
Date:   Sat, 30 Oct 2021 14:42:42 -0700
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C09B3C5C-86D1-47B4-B4BC-9D0355596A1D@gmail.com>
References: <0DB10E05-094D-4382-AD1F-657878B06A80@cisco.com>
 <20211030203916.zopggbajumvb4z3f@gmail.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you. I was hoping to be the one that fixed this because it was a =
level of logic that matched my current knowledge level.  I appreciate =
you jumping in with a fix and also confirming this was unexpected =
behavior.  I was kind of surprised no one has reported this before.

Cheers,
Ryan






> On Oct 30, 2021, at 1:39 PM, Johannes Altmanninger <aclopte@gmail.com> =
wrote:
>=20
> On Tue, Oct 26, 2021 at 03:11:36PM +0000, Ryan Hodges (rhodges) wrote:
>> Hi all,
>>=20
>> I=E2=80=99ve got a quick question about =E2=80=98git apply =
=E2=80=93intent-to-add=E2=80=99.  If I=E2=80=99ve got a patch that just =
adds one file to the tree:
>>=20
>> [sjc-ads-2565:t.git]$ git diff
>> diff --git a/c.c b/c.c
>> new file mode 100644
>> index 0000000..9daeafb
>> --- /dev/null
>> +++ b/c.c
>> @@ -0,0 +1 @@
>> +test
>>=20
>> and I apply that patch with =E2=80=93intent-to-add:
>>=20
>> [sjc-ads-2565:t.git]$ git apply --intent-to-add c.diff
>>=20
>> The newly added file is tracked but other files in the tree get =
marked as deleted:
>>=20
>> [sjc-ads-2565:t.git]$ git status
>> On branch master
>> Changes to be committed:
>>  (use =E2=80=9Cgit restore =E2=80=93staged <file>=E2=80=A6=E2=80=9D =
to unstage)
>>                deleted:    a.c
>=20
> Yep, looks like a bug to me.
> git apply should never change the status of files that are not =
mentioned in
> the input patch.
>=20
>>                deleted:    b.c
>>=20
>> Changes not staged for commit:
>>  (use =E2=80=9Cgit add <file>=E2=80=A6=E2=80=9D to update what will =
be committed)
>>  (use =E2=80=9Cgit restore <file>=E2=80=A6=E2=80=9D to discard =
changes in working directory)
>>                new file:   c.c
>>=20
>> It looks like Git created a new index with only the newly added file =
in the patch.
>=20
> Seems so.
>=20
>> However, I=E2=80=99d like Git to just add one entry to the index =
corresponding
>> to the newly added file in the patch.  Is this a bug or am I =
completely
>> misinterpreting the goal of =E2=80=98intent-to-add=E2=80=99.
>=20
> Yeah, I think your "git apply --intent-to-add c.diff" should behave =
exactly like
>=20
> 	echo test > c.c && git add --intent-to-add c.c

