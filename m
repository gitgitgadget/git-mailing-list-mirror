Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEC0C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 17:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDGRUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 13:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDGRUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 13:20:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB311B769
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 10:20:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z8so943182lfb.12
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680888013; x=1683480013;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHjJSaIhtqJHcECKWn8y6xOFyRn+Xl7g6qIcNmWzngU=;
        b=OipPcrsY9vJeqKFJPfEzM0QcWAyRcmqYIJslXV7zYAU0xkvUNN0j7f9JTjU8N1kzPH
         KWruu8PRcprax/QB2W2FXLov8ZUZycnhxbBR13P0DYVUZl3CaNwtrA2fDQTsl5jrWg0x
         u1eDlUPmiz41GFyV+59kZSW6piS+ju/gq5Jitie5fcfqK3RVKLLsfepxuFG095xqeDya
         duxbrDLzBZvnv4C6pRtdE7idc8S8P8+fGTjH7PXrgP+WNAWMt4xpoPKZVdfZhTXWEr7s
         u3YuJScdZFEjxFvXn09rw9FO5eDGSlaq9oRP5Hcjk86WgfinozYa6frtwNyTL9VGRHiJ
         dvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680888013; x=1683480013;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KHjJSaIhtqJHcECKWn8y6xOFyRn+Xl7g6qIcNmWzngU=;
        b=RDN9mcSJje/uYLaamTUmIkk/yofGNRoT3Um1TWdj1O+GTFjlKnemNIS8q983j6mN0N
         H73BfYLAxqyGA2nhif3gHheP3M0n5CjcSBpPFyiMA/p2V5PYmnOW6BAu0aC4Sw6EzTDv
         Vg8gTSNbhVnsK6qI9vda7G263lrbNHXz0zn9jGJZiTN1EEC4z2B6Ew9wGHKm96lSszU1
         ZH4dcF+is8xvnXQegeXXln8Aw06czpHC8cgbAWHVtbOO9iLzBouje02q+EFQnMqlo8m+
         QGHlnV/OTJwE1r5i6Q3hcpPf0Y8bji7gyD8aIBnDtlaJCOFDXiDQEkfiusJHbf9aaxaF
         KBDg==
X-Gm-Message-State: AAQBX9eDQyzV0ysdfqgzPWaGq59TfOFo7Cpbs7jr+lJTHiXwODNwitAE
        zViqrTHa9QRJHEtMv/naZrXJsV7LCV8=
X-Google-Smtp-Source: AKy350brTcbzkE6YornxUvOMsnS0/JIiHE5dIAWAX1/tYoXGmDS6LI27kk+QtENakaOXI3TZNAYS7w==
X-Received: by 2002:ac2:43c3:0:b0:4e0:2b8f:6004 with SMTP id u3-20020ac243c3000000b004e02b8f6004mr787107lfl.4.1680888013346;
        Fri, 07 Apr 2023 10:20:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q10-20020ac2510a000000b004ec5229092dsm720438lfb.34.2023.04.07.10.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:20:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        Git List <git@vger.kernel.org>
Subject: Re: git revert with partial commit.
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
        <87edp0ak45.fsf@vps.thesusis.net>
        <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
        <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
        <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
        <CAPx1Gvcz6f3AQJYfq7Sih0bL6pAi5mHZj8rj=kd7kRDWKLZEzw@mail.gmail.com>
        <87lej7zhpt.fsf@osv.gnss.ru> <xmqq4jpv1pcj.fsf@gitster.g>
        <877curzb9u.fsf@osv.gnss.ru>
        <CAMP44s2od_=3p8+GF7tSBqQ0KsDaa4qVKXS66BS7L7BJadA_Xw@mail.gmail.com>
        <87wn2qg7du.fsf@osv.gnss.ru>
        <CAMP44s32nLHCZmWQ3V5sBL6WZA9qqWXi86c+=Bxt+GQ8fPmFfQ@mail.gmail.com>
Date:   Fri, 07 Apr 2023 20:20:11 +0300
Message-ID: <87mt3jbodw.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Apr 5, 2023 at 1:39 AM Sergey Organov <sorganov@gmail.com>
> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> > If the user wants to do it, the tool should help him do it, not
>> > pontificate about what is heretic.
>> > The user is still going to do it, like with a rebase plugin on
>> > Mercurial, or with `git filter-branch` and then merge the result.
>> > All the tool is achieving is being annoying by not helping the
>> > user.
>> Yep, and I'm worried by such trends in Git as well. Looks like
>> growing influence of software development culture where the user is
>> not considered to be intelligent enough to make proper decisions by
>> himself, and needs to be thoroughly guided by the tool (designers)
>> all the time.
>
> Which ironically goes against the philosophy of the original author of
> Git:
>
>> No project is more important than the users of the project.
>> -- Linus Torvalds

I rather bother about too much care for the users in the aforementioned
cases, similar to the way overly cautious mother cares about her
children, all this being absolutely well-intentioned.

The problem with such care is that it's inefficient to drive nails in
with a hand hammer in a soft wrapping, though it's admittedly less
dangerous for ones fingers.

Overall, when using a tool, I prefer to feel myself a grown-up human
being responsible for my own actions, rather than a child under intense
guidance and excessive protection. I'm thankful for proper safety
measures, but I want potentially unsafe action to be performed
nevertheless when I actually mean it, instead of lengthy display of
rhetorics about why I should not have had even attempted it in the first
place.

-- 
Sergey Organov
