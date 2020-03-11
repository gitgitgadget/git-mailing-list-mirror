Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E4EC0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 21:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469802074F
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 21:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsDINxSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgCKVaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:30:19 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42002 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCKVaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 17:30:19 -0400
Received: by mail-lj1-f174.google.com with SMTP id q19so3995120ljp.9
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1/S0u10BXd7FdMdVpb3hUv+i4D3yoeyK8wH0gapIxnQ=;
        b=XsDINxStXeA8UvAL/ldBxzC4/+xHUDE1JByrkRVortM4Z8liAVwELMg36/C8ZjanqX
         TXrasBhvAx5yV2E0b3peDPUbsmiijS5LWt8XmqZXnCaX5XZKI0f4ZEtbrpSiIImB6wgi
         AVQUXW1Ra6JpkfmQeKeXUeBWQ1p6Vo4mRMt53523+8GJoc0UF6UFSc9It+r+lRoI6dh1
         +zQBM2KQ3TQRvw7FaCzh2Suyf8kIa4MbxF7kOULNQCvXjUz00sxya+ihlnqAglBgWVp2
         0Ro3FVOy9HhwB3ezPj3DS4j54PIkXxVa1v3dX6xXHUi06eYEjH1DosrC+E8z8hZUPDqN
         /Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=1/S0u10BXd7FdMdVpb3hUv+i4D3yoeyK8wH0gapIxnQ=;
        b=OcGXd00CZMRk5iHR+zfEQlFlSsUU+62x9e0lcNEGbCu2oVV7TEMDIwewNYAxc881/3
         l0CvuDT2AlVmsiJGEsQ9OG9Fh7Y49f4PriEb/R0sk2v4UI4PJsaZAD5gwBa/Pvsu6xhU
         gJfVpOFzQaIR6wmiOX47taesvJ/NPRCoOluQXYbzpfnxV88ljjqMyS+gV26d/qRrfmFG
         sNle1T2N0/p0TkkF/GVYXgvq8WJNlAldcIl16ly0uW4B7h4Qymx0rPiWYfZzWEIBcuuU
         BaBXzfvJX4uoOrGYoOy/qEb194Z0pu5iWXebo8bgrrzYkKtruSupgzL3DkkIx26N4cyN
         DKUg==
X-Gm-Message-State: ANhLgQ1sSV3BdTW4CAA7HGYdIO+zXrM6oldeXwVoWKFQxk4Ic8+LsLko
        qcP3EcLSr9HTDrGO6gjCuWg=
X-Google-Smtp-Source: ADFU+vtNk7lsZhPoqQ3lsfLCwKoOy2vv0cwp/0bcsy8181uDnmM8bS5mrsZTdKJn2VdA0Tya73BJfw==
X-Received: by 2002:a2e:87d7:: with SMTP id v23mr3011901ljj.10.1583962217220;
        Wed, 11 Mar 2020 14:30:17 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id t14sm18177961ljo.56.2020.03.11.14.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 14:30:16 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <CAP8UFD31+sK5zyLLgkOvJ4fj=PC3FTa9nXcpPeM-fWm9ByoKjQ@mail.gmail.com>
Date:   Wed, 11 Mar 2020 22:30:13 +0100
In-Reply-To: <CAP8UFD31+sK5zyLLgkOvJ4fj=PC3FTa9nXcpPeM-fWm9ByoKjQ@mail.gmail.com>
        (Christian Couder's message of "Wed, 11 Mar 2020 21:29:28 +0100")
Message-ID: <86eety4m1m.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder <christian.couder@gmail.com> writes:
> On Tue, Mar 10, 2020 at 3:50 PM Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> Here below is a possible proposal for a more difficult Google Summer of
>> Code 2020 project.
>>
>> A few questions:
>> - is it too late to propose a new project idea for GSoC 2020?
>
> I don't think so. Students have until March 16 to submit a proposal,
> so they could still submit one based on this even if it's late.

If I understand Google Summer of Code 2020 Timeline correctly
https://developers.google.com/open-source/gsoc/timeline
March 16 is the date when students might start to submit
proposals, and the deadline is March 20.

>> - is it too difficult of a project for GSoC?
>
> I guess it depends on how much you as a mentor would help the student
> getting started.
>
> I think it's interesting and worth adding it anyway. Can you add it to
> SoC-2020-Ideas.md?

All right, I'll do it.


P.S. I wonder if Derrick Stolee would agree to be co-mentor (if he is
not too busy with working on Scalar).

Best,
--=20
Jakub Nar=C4=99bski
