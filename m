Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138BCC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 22:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjBBWMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjBBWMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 17:12:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE64646BF
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 14:12:13 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso3169536pjb.4
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exjEFaNWExpf2zo0CK468vKaj7eBx7ip6BBsRdm6meE=;
        b=Rt4/g0b+PC00V0ZSgxOPa4hrwzvr3bRXV4yEoNvDTVdl262tKMXadYq3jc6Nvx51PF
         8TSeBS/qu7tg5V6eZySUTNHND/MMsm4595bWUeXDJJXWY6ccy0GDS677qIGoyBdQCyYD
         vGvje6ByfS6dJYkw5Z87DInq5/fqGE58lEcEL1wq8AyjFvEC7aLNq+EjygAcweuTArPC
         VjtkME53jRHQ1f3M7ZnqitcMogtc3QZMLm0IXchOGzTUis8MvCT7UTpk31QtT2Oa5dhH
         dBTDCRayRcYLJN4I8YIyU4q+qHT1ApoRVF62PTbthc0GtVxjjuj1h3bz0gCP2o3DNRpd
         Bp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exjEFaNWExpf2zo0CK468vKaj7eBx7ip6BBsRdm6meE=;
        b=08pVrayY+FbxJdU4TAgr/b8nDc6HlpSv6c8cN/24/u/QLJ052DkH2WCkiwUS+AxSse
         pFI/R8b53ryAiS7PBOcT22Yzim4ujBnNIhzYFn8ZOw2DTCqsvxEnJEVO+Ke63C9H8dz2
         EbVzqjPCUqAO+1VfYDgLdDcyMfY7+BWFZ9LEdZYOagVIA1Cme3ivAPf/ZDdyX6/eev+Y
         lkZ/isIENDBTfkvhc1Hj8M/UsFUHPwfUPp8uyBDW0VPn7N/n/Jq9d8mEveh1k7AO8iVc
         zotiqdWqXuDp7MWK0sOnWrSiC+Ngy/WT7xso029SQuloBDZwMfdpbugFJdOFJRr7lOzH
         JASA==
X-Gm-Message-State: AO0yUKWG4Ja5EDioa6PRw+RCeX8In4SAx0bebFXA0hasOgE7PpG24V/6
        Dxy/rDhqopFdFS2+IBMjJ5U=
X-Google-Smtp-Source: AK7set+bJc5c7ghRiZdPo/0qfFkucuJk3soXiRlbmAZLQjxbOk9tgNy9R5OBjawqOqQ0E27jMfI+Lw==
X-Received: by 2002:a05:6a21:338a:b0:bc:6e88:7f58 with SMTP id yy10-20020a056a21338a00b000bc6e887f58mr10259298pzb.51.1675375932942;
        Thu, 02 Feb 2023 14:12:12 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a000bce00b00593b72f6680sm179420pfu.86.2023.02.02.14.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:12:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v6 19/19] push: free_refs() the "local_refs" in
 set_refspecs()
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
        <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
        <patch-v6-19.19-67076dfba6d-20230202T094704Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 14:12:11 -0800
In-Reply-To: <patch-v6-19.19-67076dfba6d-20230202T094704Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 10:52:50
        +0100")
Message-ID: <xmqqfsbnson8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak that's been with us since this code was added in
> ca02465b413 (push: use remote.$name.push as a refmap, 2013-12-03).
>
> The "remote = remote_get(...)" added in the same commit would seem to
> leak based only on the context here, but that function is a wrapper
> for sticking the remotes we fetch into "the_repository->remote_state".
>
> See fd3cb0501e1 (remote: move static variables into per-repository
> struct, 2021-11-17) for the addition of code in repository.c that
> free's the "remote" allocated here.

As I noted in my review of the previous step, the "if !local_heads"
change we saw in the previous step goes better in this step, whose
focus is on fixing the local_refs leak.

