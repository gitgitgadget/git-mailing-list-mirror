Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB1C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2F822CB9
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgLDWVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgLDWVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 17:21:44 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41050C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 14:21:04 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so6736904wrb.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 14:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtG79xzKltXRCSX+EL9NyC19iqVSM0ZrnCNRmy9WQM8=;
        b=O1SgZdL50X5eM4A1qC+BQQDY7C8106jeZZeqaDwoNTZQXlPySWJaccsRnmkO7Wa0tn
         k8pcvr562fbcmAPQ0hFey39BsApF81fVmDrq3lREUuQrhCiAfrlxenSxdDFRZE0Ks1g9
         yuXszbpSMRL5pV1ZzRhu+68IDdIU3faTojiabYUAagWDelqk3V4V+lzpC7urjiwqiMjb
         Yd4dwxvlysi7zXoTjhsdxdWrH1pgrgGEc8ncJzwqkZ8JgPGl73OzpqSqm1FUucok/I3f
         8JyfSw6e6PqueJA6j2tQakKHZV81xE3COzv9eUz7kYLOV/casFU27DfU+9jE++/Hx3Y7
         NE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtG79xzKltXRCSX+EL9NyC19iqVSM0ZrnCNRmy9WQM8=;
        b=F86vudxB3t1QEToLt+e+McGc+Acicbvao5J8HtpkkZOCtmdjsVIUHFaIJjFqS5WfQH
         6akwAFUIVCXf0BgWBkU0stTKyoWrzR2zYNmwRkoIA/TTuDD6ldoWptBFCnGONvcQh/FS
         DgKaBYBsjnlGBeBF+SGNL+XkO6hJWzH/4KdwSByRSXRmHWjVTPQR+FH5fVbKxY5Luo+j
         cZmqERdOA5boQixCr/Eek+kmbSjBHFNPzsA9TbhU8jVDtCGT6rJgB8N7W3c4sW06fV62
         Cw6z6AlI1x23S347STDNjCMNuTzwULpxwSxKbSoH/gkgOVjjCtfj9vCa3yG2Dv2JOnmL
         Tjgw==
X-Gm-Message-State: AOAM533/aGuIv+7OiELPkufmhrHwYAoiQYDg+gmIpyIzN+VKCoEBKa3I
        qj0owH9suWhjX+ctsFi+5MhMLMajnqjZG34j2Q8=
X-Google-Smtp-Source: ABdhPJz0yf9oSl9r0Yl14X9TuKBDW3u4TsQwpxLZUWDTj2so2GyjyjgDTIu2JzOsG+UWD0vhFr9U+8jNEpBGZGKA9h0=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr7406636wrs.100.1607120462988;
 Fri, 04 Dec 2020 14:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
 <X7y5Wxu1eY4k6753@coredump.intra.peff.net> <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
 <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com>
 <xmqqo8jmgyrd.fsf@gitster.c.googlers.com> <CAMP44s3f_cO61YVjvwsiswKQRESznOFn7KTshgv06a=zVRPLug@mail.gmail.com>
In-Reply-To: <CAMP44s3f_cO61YVjvwsiswKQRESznOFn7KTshgv06a=zVRPLug@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 16:20:52 -0600
Message-ID: <CAMP44s33jhx+5m_LmaVi58n0roJH-ZD9z0nU6M5d6_Kd+i=5Dw@mail.gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Tue, Nov 24, 2020 at 6:09 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Nov 24, 2020 at 4:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:

> > > Beauty is in the eye of the beholder.
> >
> > Using "@" is rather "illogical" than "ugly", and at that point it is
> > not so subjective.
>
> I disagree.

This is not an attempt to reignite the discussion, but just something
that might be of interest.

I created a poll [1] in reddit's r/git: Do you know @ is a shortcut for HEAD?

403 people gave a useful response. Of those; 74% didn't know such a
shortcut existed, 80% liked this shortcut.

But more importantly: 59% did like the shortcut, but didn't know it
existed. That is: of the people that liked the shortcut; 74% didn't
know it existed.

This tells us something: putting personal preferences aside; the Git
project doesn't seem to be doing a great job of advertising its
features. Features a good chunk--if not the overwhelming majority--of
users might like.

Other things of interest in the comments: one user didn't even know
what HEAD was, another used "head" (lowercase) (macOS user), and
lastly; the second most voted comment did take a shot at Git's known
unintuitiveness.

That's it. Just putting it here.

Cheers.

[1] https://www.reddit.com/r/git/comments/k15cqm/do_you_know_is_a_shortcut_for_head/

-- 
Felipe Contreras
