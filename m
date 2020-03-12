Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91841C1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 13:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637FB20663
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 13:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoXyRPFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCLNIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:08:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44071 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLNIp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 09:08:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id a10so6318247ljp.11
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jE+SfQqkyC3gNMMp78ViuMks3tuGSTPzBNJlCxfmY+k=;
        b=IoXyRPFnrxjt7hhmGhyz8YUsADCaY0dDgsbNivbaOfgGUWjiwtcdpfAEi3UEGb2tJW
         vsu9f1iRuK5Oqsmf+xBeRKDd+Xuy5ZovMyf4w8GN2RqRfVMhzewxsLBv8ZygFsVhh35A
         RnHmcX8wYF/EK3cVgTNCJyVn7hjZVelFtMkEajHxsI2mxX9OjtFDVce5ba3+FqXGV+KK
         q5DJIdNGJtDseYvkQCetsDeQLkPx+pA2Kbo03aJluPS7jRHm4k7XEoYvrqckjH8b9T8b
         TdP+W8BPsmGpAG9wMoWZO6Jdn5DaAaznWk0+UMKaf1Hp2U3zAqrJgZiHTv5Uo+lIOBAm
         Gp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=jE+SfQqkyC3gNMMp78ViuMks3tuGSTPzBNJlCxfmY+k=;
        b=Ta/5rYPQznuGh2KcT32fec6kr3RXSTNjvHfARilJk0ks2uBjJDbbViHu0E4l5qkQI7
         ZDCdTTqTEQs5/8kIHfEZnVU621s7RVfVmORzs+aWm2CQjNcffNFZR4qgt6OCrKixynC9
         MXdh8vyNWMsQovRwGdEyuSK8A9/QEMWqazLTVPn9yZduEHh3lYaE3VMCWc75D4Cq9be3
         g5s8RqrIJKCdraky1dPj0zLlyoMdIcPjdF04G4VPQHifW+UYAhOJCjLjHugcv4LSe7xQ
         JrC0MwFO2qzXTEFbHAY/b7iwFSMA11qmrRUhdwPEoVRx29sbnadSuNckyL9O0KSqQw85
         N/jA==
X-Gm-Message-State: ANhLgQ3c5tzM+6WlAbTSx5xA3/Eh70gP0h0SnPHq/SF1+Anuz2QYB/4J
        wBv3yOPVVqlqsXtjl2YX+/I=
X-Google-Smtp-Source: ADFU+vvQt81XXqH/CkdbClJrO9YIA9LO0/TNRGE+olO2WdatTch/Lf1UgeH6OC29QFxN+Z8UeV4Q+A==
X-Received: by 2002:a2e:9ac5:: with SMTP id p5mr5246440ljj.200.1584018523810;
        Thu, 12 Mar 2020 06:08:43 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id w14sm25174686ljo.80.2020.03.12.06.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 06:08:43 -0700 (PDT)
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
        <868sk54vj9.fsf@gmail.com>
Date:   Thu, 12 Mar 2020 14:08:41 +0100
In-Reply-To: <868sk54vj9.fsf@gmail.com> (Jakub Narebski's message of "Thu, 12
        Mar 2020 13:17:30 +0100")
Message-ID: <8636ad4t5y.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:
> Christian Couder <christian.couder@gmail.com> writes:
>> On Wed, Mar 11, 2020 at 10:30 PM Jakub Narebski <jnareb@gmail.com> wrote:
[...]
>>>> I think it's interesting and worth adding it anyway. Can you add it to
>>>> SoC-2020-Ideas.md?
>>>
>>> All right, I'll do it.
>>
>> Great, thanks!
>
> Added with some modifications in commit 6b5edec6557
> https://github.com/git/git.github.io/commit/6b5edec6557930888441c626f9272=
dc2be0c769e

And it failed to build.  Was it caused by accidentally deleting two
trailing empty lines at the end of the file?

page_build_id=3D168669405

--=20
Jakub Nar=C4=99bski
