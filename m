Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471B0C3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194E8246AC
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582908465;
	bh=fYfTMiQC9678OSj6+X2hIpHExmZIavRp6Yw4+h5rIb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v9ronwWBrQhEmdawd8jvKw6MBL4xhTa+RG671ctJ0XWipD4hNmG6YjtzlP+IbIWyI
	 FcAHsh8OrAqYRZ5AhAIu/9SlzKwZaNTYXEhjP0rRu7+DRPrx3+A9dITgz7y6HuSbry
	 3UQkQQkgameW9mutEJObEiovsVMF6l19T2Uq6fiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgB1Qro (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:47:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41423 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgB1Qrn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 11:47:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id u26so3885450ljd.8
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 08:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKbOKXD0wohdwyUXdQV08MFaEBdwSs+VDSt0Qc8etFM=;
        b=bZ2Ee11SnGm6xDaLZguG7M2U3LLzClivbV+loRVXo6vaFgr9dBp9TJYhUrb6I6LWtk
         zMl3pBPvTdbrShFtAgirKBVD07/uI8PiL3+eFvdYe1/vGcwmRhDe4eP8kp9AA9Vc1e/B
         Khuk/uvfvfqgE72cJ9rbjJF2C+CV2EAvpHekQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKbOKXD0wohdwyUXdQV08MFaEBdwSs+VDSt0Qc8etFM=;
        b=aXtP2R0H+xkrSN4jBJto6vFG8ly7YoDvWh+Angzjy/IIhNqHIAhltjZAlg+2UkVTeJ
         FmNYG83yAzuIz3fXDQYUohLWrh5SMkVHWlc3/n7gDxA+F7INJ42Ud8tqKPZByGGYB2m4
         qyPNXkRQsix1AyPD60tcYRiXJUjg0lgAk9kCq6OW/G4wnETErK2mW7AKLqEJaYtIba0T
         8vY62ok/7TVrufXR5fVQVtHriMFs96TeL5+ZdUYLbP/kR8QIMy9YSHCaiMreQbMpyVrZ
         y8YLdL8yyDKpPfhft+PAcKMmUFIPSz03ejhncmM0L7Tvl8el7O9W9DIJXwu5O+8Y2JXP
         I3Sg==
X-Gm-Message-State: ANhLgQ3OYnZRshDGyZlZ2nSp5kswYlrCbHFTLJ1j6KUkAObNIYZ65cRR
        CldTbqumFb8FUzeJYz+E5O2Z0x5tTxs=
X-Google-Smtp-Source: ADFU+vvqIujZEXfEQD1yzkUs/InkB1s8Leez1Sge1Tuh1Lmrva9iNNoLq56+KV3HeiDP5MtZnzy5qg==
X-Received: by 2002:a2e:3608:: with SMTP id d8mr3446244lja.152.1582908460881;
        Fri, 28 Feb 2020 08:47:40 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r10sm7005766ljk.9.2020.02.28.08.47.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 08:47:40 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id e18so4017477ljn.12
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 08:47:40 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr3606611ljj.265.1582908459750;
 Fri, 28 Feb 2020 08:47:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgg8ctNmHbKjy-yYnz07L3m8=1et_q2FJHKM9mZKXzGAA@mail.gmail.com>
In-Reply-To: <CAHk-=wgg8ctNmHbKjy-yYnz07L3m8=1et_q2FJHKM9mZKXzGAA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Feb 2020 08:47:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whg3uip_N1EjLEzaZNMvS8v+5u2GGueE9Wm2xnY87D+-A@mail.gmail.com>
Message-ID: <CAHk-=whg3uip_N1EjLEzaZNMvS8v+5u2GGueE9Wm2xnY87D+-A@mail.gmail.com>
Subject: Re: Signed commit regression?
To:     Junio Hamano C <gitster@pobox.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 8:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I suspect it's due to this commit:
>
>   72b006f4bf ("gpg-interface: prefer check_signature() for GPG verification")
>
> but as mentioned I don't have the ability to really dig deeper right now.

Never mind - I did a mindless "just revert that and test", and it
indeed is that commit.

Please revert it in upstream git. The "No signature" message really is
horribly wrong. It's both technically entirely wrong, but it's wrong
from a UI standpoint too since you really need to show what the
missing key was:

With the revert, I get the proper output:

  commit bfeb4f9977348daaaf7283ff365d81f7ee95940a
  merged tag 'zonefs-5.6-rc4'
  gpg: Signature made Fri 28 Feb 2020 12:03:36 AM PST
  gpg:                using EDDSA key 913EFF2D612BE1C00CC97738DDA1CDD2C5DA1876
  gpg: Can't check signature: No public key
  Merge: 45d0b75b98bf 0dda2ddb7ded
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   10 minutes ago

      Merge tag 'zonefs-5.6-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs

      Pull zonefs fixes from Damien Le Moal:
       "Two fixes in here:
       ....

which is useful.

                    Linus
