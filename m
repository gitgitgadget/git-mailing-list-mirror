Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42236C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCC02067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596054237;
	bh=Gmo8Tn78SnYg/fUFQOx0AZL4uisVFdyjSkmA4za8h/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0y3iQ8rcr90mFMqksy76ssQtYQsShcdV/MuCWjMZ9Bn2TxGHH8Hu8DxwQOGJDPVhb
	 7e88LpzKvk/KE1wTyHUyjganFih+1y9/2Eiu0lUprVBFVycewF7nyoXtDNg4cDcw8Y
	 CY4ODBDbcqm6uXE3z2FfGpUT2ZyivFiTesX+agoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgG2UX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2UXz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:23:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A149C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:23:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b25so26461575ljp.6
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZ4cmYgtUBc0ROVtR7fJR9q1klZksKDeh948YsyTBYg=;
        b=OlRAv9Z5vo8aoHYX6oyhgUBKFQ6DgDWgeT/F2FWAsBSkPfOR9PHX8cZOwkjVaSu+IA
         oxKpHcB9HtjJcBCabLpTxmb5M24/CnQYDAodtJ3xP22zk2oId+uMROM4EgVjjPlpHpvQ
         UtAt7jjUrZFUfqucXGRwGcaB3iKMH4go+oVpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZ4cmYgtUBc0ROVtR7fJR9q1klZksKDeh948YsyTBYg=;
        b=Mlj5f6w79jHcTrlIv4coEbaG619P0jHIlcbdvpd/4kqsSPWdoEOI7tDkTRUt+j3BND
         0zlAIReU4wPfA6PW7HTLVZ/hvjuS08beN/NIj11eo9jAP2nbTuDLtbRMxQ0xbgoJGkl3
         cQSBXfKZ1uKO7fHtZdMxc72yc2maKw11zDGopmgnAtjW+mfQ51p6u1eVH+ObDOolpzDY
         dR1/YqCzAGjVCLAxQlzNp5H3hgPL4aNfxMunFYs+henJUB1BJ+2Ea8p9nlryeQAcIUrR
         HtFp7YDo7HUVQkKIIeKYNV3ID+n/vvu4rYBjOc3JPN9iLAkjQNu1GXQVxB6DxKcObPVb
         QRBQ==
X-Gm-Message-State: AOAM532S95WximnSt4Z2FA0XIdJJsQgptzf4bIByV5/AQkvFyWGTiIsi
        yQWK3vguWPHe2ResuZQiV5hvLCJYnDw=
X-Google-Smtp-Source: ABdhPJyEhAPa/ZxpN0lIp4bTY8Tv2LV/oHI0mCrMohyks7lAigBQvsRKH2U/XXc4VWrj5XiKQeYxgA==
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr95084ljp.76.1596054230911;
        Wed, 29 Jul 2020 13:23:50 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d6sm583388lja.77.2020.07.29.13.23.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 13:23:50 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id s9so13770011lfs.4
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:23:50 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr17820196lfo.31.1596054229745;
 Wed, 29 Jul 2020 13:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqime69jfc.fsf@gitster.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 13:23:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
Message-ID: <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
Subject: Re: Avoiding 'master' nomenclature
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 1:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> The intent was to stop treating 'master' as some kind of 'special'
> word, since it is no longer special after init.defaultBranchName was
> invented.

I understand it happened.

I just think it's simplistic and wrong, and outright stupid, exactly
because it effectively does the exact opposite of what you should do
if you feel that "master" is a bad default.

Yes, the old code hid "master" not because of any language worries,
but simply because it was the default branch and thus useless noise.

So the patch does something doubly wrong:

 (a) it doesn't hide the (to some) offensive terminology, quite the reverse

 (b) it now adds back the useless noise

and while I understand why that happened, I can't but feel that it was
incredibly pointless and badly done.

What *should* have happened is to hide *both* the new
defaultBranchName, _and_ if that wasn't set, "master".

Even if you don't want to treat "master" specially, there's two actual
reasons to do so:

 (a) the technical one: it's the old default one in a lot of existing
repositories, so if there is no defaultBranchName, it effectively
_was_ that

 (b) the non-technical one: if the aim is to get rid of "master"
terminology, THAT IS EXACTLY what the code did before it was removed.

So really. Both from a technical _and_ a terminology angle, that
commit was just wrong.

             Linus
