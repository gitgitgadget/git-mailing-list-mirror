Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A78C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CE72077B
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 22:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="ZMIbsNNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgAIWjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:39:08 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36545 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIWjH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 17:39:07 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so9006378iog.3
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpbcKMkZwJiI+KL+dnAtEc64aVAskXOnm+XFg5O4cfM=;
        b=ZMIbsNNC5cYYluv5PxMjpiDSOnizB1BwTpcld3JguQJF9ENBvhYonjC4wPvps9HVBF
         lppp/pxI6iS2kmwTErzNOYFbGO4BVFT95NlXmr30UAArbkyjguUHuxhjHMuaKfzGGVcf
         L2UsqUAZRj1H2MhVRGJdr4T/KxGqv50H3WUPMyu/OzXGcSckPfvx7iqI/KVW38Ognbt4
         kmlmdQGWSET0vMstmEibrgp3hUNaIXWPD+Nxam2Gu6uh8QGQNXIrQN1T9IThHfH5EfYu
         PgHnc1kEKv0jLqI7l1PyrnZKTUjDacFo6nXBlIvQ0h/O556GWfOhjBklgxLdwpCwwuVq
         bPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpbcKMkZwJiI+KL+dnAtEc64aVAskXOnm+XFg5O4cfM=;
        b=jAldT3Z1itDLDnumXOxtmSm/2z/Q7VYlIhv21i3KIvDZ17sBINzsYtiHB2029Se/SY
         WKwYFrifPHAamIOLW7c79NU/cvTGQ36cnHutd1TIL7UedZGV7rAZdX3Y4f2E9QHcZemW
         cjrhC/qzfs/PzGB7bo9af9RAgQsSJqcxJOgdJxgDlNpsKCKLuBGtZFXabDOJW7pCR9N/
         aGMdBLoaqhy3gnE/3kxQ+XI9icXCeUrHmgV48uvYoHXaZYOBmVAxL3951tk1uf1A7oGY
         il7l6NJfT6BhPIdMeUbnMOftA+/jtBYpucgodEIkn6fTI9FeLUliavci1drUo4cKUokZ
         jbEQ==
X-Gm-Message-State: APjAAAXaHOou4piTatYLFt8EbaMNMgkUBl0BHM5YYAjmmLEw7dVkqA8U
        AWxKkjYdxWQ4kE7BiVivwI46MHHjivVrO4WeM3O7Qw==
X-Google-Smtp-Source: APXvYqy2tdv663RiJbgv0q1a/6SOxEDpr2CySoN1V8cdMUy+0ycJ2n5kcuAD9oUBsMavi3wwcZufd80KtfvRBrmFzl8=
X-Received: by 2002:a5d:9b17:: with SMTP id y23mr9312848ion.185.1578609547025;
 Thu, 09 Jan 2020 14:39:07 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8smh1t3m.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2001092244250.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001092244250.46@tvgsbejvaqbjf.bet>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 9 Jan 2020 14:38:56 -0800
Message-ID: <CAGyf7-EgDYBZ-=o6g4HV3rywreD=QvRr8R0agr=0UMbq_ib5Hw@mail.gmail.com>
Subject: Re: [git-for-windows] Git for Windows v2.25.0-rc2, was Re: [ANNOUNCE]
 Git v2.25.0-rc2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>,
        git-packagers@googlegroups.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 9, 2020 at 1:47 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Team,
>
> On Wed, 8 Jan 2020, Junio C Hamano wrote:
>
> > A release candidate Git v2.25.0-rc2 is now available for testing
> > at the usual places.  It is comprised of 517 non-merge commits
> > since v2.24.1, contributed by 70 people, 29 of which are new faces.
> >
> > The tarballs are found at:
> >
> >     https://www.kernel.org/pub/software/scm/git/testing/
>
> The corresponding Git for Windows v2.25.0-rc2 can be found here:
>
>         https://github.com/git-for-windows/git/releases/tag/v2.25.0-rc2.windows.1
>
> In addition to rebasing Git for Windows' patches from v2.25.0-rc1 onto
> v2.25.0-rc2, this also includes the "mingw: safeguard better against
> backslashes in file names" fix that I sent upstream in
> https://lore.kernel.org/git/pull.690.git.git.1578576634678.gitgitgadget@gmail.com/

I just wanted to say thank you for the work you've done adding, and
then refining, these backslash checks! The `core.protectNTFS` changes
in 2.24.1 caused some pretty significant fallout with our testing
repositories, multiple of which have invalid trees due to backslashes.
Our Windows tests don't use any of those trees, though, so the checks
were frustratingly rigid (if understandable, I should add).

One further thing we found while trying to make adjustments to our
test suite to account for the 2.24.1 changes was that, for some
actions, we couldn't find a way to make `core.protectNTFS=false`
actually change behavior. For example, using something like `git -c
core.protectNTFS=false fetch /path/on/disk` still failed due to
invalid trees (as has been mentioned on other threads, I believe).

Anyway, thanks again for these early release candidates, and for your
efforts to polish the backslash checks to retain the protections but
loosen the restrictions.

Best regards,
Bryan Turner

>
> Ciao,
> Johannes
>
> --
> You received this message because you are subscribed to the Google Groups "git-for-windows" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to git-for-windows+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/git-for-windows/nycvar.QRO.7.76.6.2001092244250.46%40tvgsbejvaqbjf.bet.
