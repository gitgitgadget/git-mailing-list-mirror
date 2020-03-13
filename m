Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C7FC10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 10:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B3820746
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 10:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcPRdonB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCMK7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:59:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40119 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMK7J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 06:59:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so7462518lfe.7
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ck7KTVtAc8pc/nYFIudwCE7I2zoxlNrf8VD/aWKYSLM=;
        b=XcPRdonBgplyrlhdt0JvLl0ZXf11z4n2QDVKnGAzRBfAa651QwzJ+h+BPm0I1Uit/p
         P4bE53XZZvRlHzrC1ReCLo9A97zZkFPU8KR7OX4jWN5nKELh8ikmXtKbXL/4Q1CkFPCk
         930YQtdPYXa0pjq/MoElalvDxW4mAd7QSVPacjG6niUp1pD8CBOmD6g448r2HXJsEpFf
         vZUPt9aQmt4Wy+CCkxr6sXGSjcJpUjESuWGvg+FnnzjUGXpoKTBDauHV/9OhLAVMmIZK
         B4x0wa+QE9aBEwusDDmaIBF3ui2KUEBeqnC9ASa7+lMU0M5rrxmS/YvyJ1bgR3FqW7nT
         r2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ck7KTVtAc8pc/nYFIudwCE7I2zoxlNrf8VD/aWKYSLM=;
        b=Ejub4GPwjPlxrmPqNoO11tYWCTxvSuvxQFbKPm8XSdg5VCaNipAd0bm2mGz74vm7wa
         VTjC5YTUS/WpTEtdrSdYtxKRQEqF0bo2zgBi5Dwi1Ukz91JkXgwiQe2kQ1hgscvcNE64
         ASMld+LZ8Hzi6YU6G/MpqT2BXuflwWgsiLpzsPB0/4/Gq1kGXlAOinZvs+WQDRVbKHj+
         cLL+sV/fFlgVp/HqoTZJTf9RRmM21jwRioeXtHXB3YUHAZZtZtFA2lfU7DLu+uI1Qa02
         5Qz4r9goW4Pq7v9Ypkc4TlfNRZhQr5KrWl7BV79utPj38Kszj4ydRBk1l8sRHZfVcNcP
         khMQ==
X-Gm-Message-State: ANhLgQ1X+xhQIBA20Laf9FSJm+/MoSbVaRBg5HQGp9IRz81F+Gqfb7Qw
        ebAReUjviLVl8QTl2aQgYdFjFokKjpo=
X-Google-Smtp-Source: ADFU+vvIELn06zg7Zqn36fNdidZ1VAg6ibYp4QZFY0zWtiznv9Exxhzz8/eegsIZdyH6i55kwEqZWQ==
X-Received: by 2002:ac2:563b:: with SMTP id b27mr2305013lff.180.1584097147868;
        Fri, 13 Mar 2020 03:59:07 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id t78sm13067676lff.27.2020.03.13.03.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 03:59:07 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <CAP8UFD31+sK5zyLLgkOvJ4fj=PC3FTa9nXcpPeM-fWm9ByoKjQ@mail.gmail.com>
        <86eety4m1m.fsf@gmail.com>
        <CAP8UFD0cLrxic6tjGC5UQjX1pNHBzZhVyoddWbhETReFaLK4nw@mail.gmail.com>
        <868sk54vj9.fsf@gmail.com> <8636ad4t5y.fsf@gmail.com>
Date:   Fri, 13 Mar 2020 11:59:05 +0100
In-Reply-To: <8636ad4t5y.fsf@gmail.com> (Jakub Narebski's message of "Thu, 12
        Mar 2020 14:08:41 +0100")
Message-ID: <86o8t034hy.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Christian Couder <christian.couder@gmail.com> writes:
>>> On Wed, Mar 11, 2020 at 10:30 PM Jakub Narebski <jnareb@gmail.com> wrot=
e:
> [...]
>>>>> I think it's interesting and worth adding it anyway. Can you add it to
>>>>> SoC-2020-Ideas.md?
>>>>
>>>> All right, I'll do it.
>>>
>>> Great, thanks!
>>
>> Added with some modifications in commit 6b5edec6557
>> https://github.com/git/git.github.io/commit/6b5edec6557930888441c626f927=
2dc2be0c769e
>
> And it failed to build.  Was it caused by accidentally deleting two
> trailing empty lines at the end of the file?
>
> page_build_id=3D168669405

Fixed now (somehow).

https://git.github.io/SoC-2020-Ideas/#commit-graph-labeling-for-speeding-up=
-git-commands

--=20
Jakub Nar=C4=99bski
