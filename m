Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CBAC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 19:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbiAETRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 14:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243408AbiAETRu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 14:17:50 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FF4C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 11:17:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j21so398482edt.9
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaPg2Sqg4ajVTdbI8NNV4s2+jbSI8yKLwMG854OKx8s=;
        b=WmJ5xOQrxb7D6cUrC6N/aNmJqd6OdTHAfBRrNYpD0ZlODFY4oHpNCCvrgXo7qDiNS/
         u9aeel8adDMaRXF0lDI0eyyqa230xNlZkzhMkOehhtP+GXE20sh7TeNEjabXDMzrO93w
         wiRJDcQQHsT8o7LpVCXw7oOFdMuAuTXZ6mOFshqqInN5p6p2AkI98fd39jK1vwr6mEB6
         3rL2EbnlthOzazWNoiT0FiZd2OtRNo0kXL6CWrIU4HEfAM9iJkQ6isqdROpyRV4gR/pW
         p54lBFrgukQ3dkQoMI1tIMynZxGnPP4Uto3lcerlhLOAw63BvXcYNSMJNvLJRY/bjz+Z
         dMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaPg2Sqg4ajVTdbI8NNV4s2+jbSI8yKLwMG854OKx8s=;
        b=SlWN530lO3tdFiloT6I7DkomHd92NnQKvrENit2FaTxSm51Tm4aLt51V1Q0UwQOy9i
         5aQOVl+rcvAGVk5yET74z2HKpLv2UZ+STDM8i+BU0B2fKpYxnyOXJgJt3QyiPp0J++5F
         /NXrNmQh+8j0cKMjIPTHvX7el3uEneM/9Psx9TkcrD7c7tdWexORubBqcAr4VN9YVwu2
         eNEFXbdbC/gj90+idwrA3uKAQhn3ceY/7jgakQUUuNYqbkM2evRcHsOASA51jJSWWs1y
         +NeH81UqevGfqgdZnctP093VIngq8TBgvYdqAm8F4OkJaWbvy1ccdQPetYbNVBJmEU5p
         CAyw==
X-Gm-Message-State: AOAM530VRHmDOUzybWwPmeu9A+Tc5TTtq8DDeSlD1WOsZzB5ymhxABoS
        VxCXja3Rm3Y/MgchQnu5cypOXuFzGe2aG2/zMUE=
X-Google-Smtp-Source: ABdhPJzF+mi4Ptyic64ubHRVihG+HEK+BwycOYvCSEWbWpx1tlpmo4ntpVqB9k/WXAadnq3hutmruB3A5884kwt8Hiw=
X-Received: by 2002:a17:907:60c8:: with SMTP id hv8mr43351194ejc.192.1641410269074;
 Wed, 05 Jan 2022 11:17:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com>
 <ed528125-a2bb-9445-80c5-8c2994ef0d56@ramsayjones.plus.com>
In-Reply-To: <ed528125-a2bb-9445-80c5-8c2994ef0d56@ramsayjones.plus.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 11:17:38 -0800
Message-ID: <CABPp-BGL8OeGY_tDXYbMELBnvzZgR445xiK8nGnn_Fo2cn3AAw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] merge-tree: provide an easy way to access which
 files have conflicts
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 11:09 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> On 05/01/2022 17:27, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Callers of `git merge-tree --real` might want an easy way to determine
> > which files conflicted.  While they could potentially use the --messages
> > option and parse the resulting messages written to that file, those
> > messages are not meant to be machine readable.  Provide a simpler
> > mechanism of having the user specify --unmerged-list=$FILENAME, and then
>
> s/unmerged-list/conflicted-list/

Indeed.  I had noticed after v1 that I had a mixture of using both
"unmerged" and "conflicted" to refer to the same thing, and tried to
fix it by always using the latter term.  Unfortunately, I missed
updating this commit message.  Thanks for pointing it out; will fix.
