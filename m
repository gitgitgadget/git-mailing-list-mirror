Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A40EC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E53206D4
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596055604;
	bh=uK5cb/x4UHpR+3HIQ++tOPgNTEolpwEnG2GpECGWG20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rCNA2hoAT/INkb2Ov5Uw1WQLNYTLpG4GPaB4ZskyU6oI6lF0Reyou8hZdnIT9QAwe
	 xV71tdcIGGb1OgGwg9KetIp0rD4rzjLBDsRhLQlMYtmHYvb77bk7i8WtYSbP61ZI4M
	 jm2jP48qSvrhqnNtmcq0RvDJ9I68AKZZybQRoEo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgG2Uqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG2Uqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:46:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C2FC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:46:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so26512466ljg.13
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uq27HCKPVPmnRsSQeLA4x43d02QniXnb06Ix1mKj0/0=;
        b=hFWgsSFEShtXcylZ+lZukoGid87If7kAXKirvJQfzpXk3dHmX5JJjnhs++8VdsqsE6
         Y7ZADBOh34b7mrLE9nbZ20nom9Di8zZup0OGZDonFYjNotLG3DHLAP7otmyIqeIxy9g3
         /EcN01sH8XfxwIo0DXl41yGbrKZIUSvlF5NGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uq27HCKPVPmnRsSQeLA4x43d02QniXnb06Ix1mKj0/0=;
        b=NlDaHY9uT2RopMO4SBZLjWwEnA8+PZXWaEcgeKcrLmwIvrEXibZhhVcqLZ0J7dKNMc
         CvHutnw8CaDqVCWmqq9OHcgSB9VJJoCXfoZctg+4WkIa3lNQ6tGkc7NefZjqNd0dxS9+
         jwoCTjZqBLLfbLYCQn7BSEVt42VmNdGu25vzH2Ah0nQAaLxah5BSUh/PnaB9gXBvD2tR
         tc/TBvnZdxi2qZFsSCrXErRfvnC40TWS8I44rF5ARNpgA0gQAHvOA12GjCB9SnZaThOR
         ok8CpeaHcSXWbkDhKPkVgb6+VRac8r052PPg78HcOX+V6KHgbDx8SJgi5ojtcuO8qk2m
         ASpw==
X-Gm-Message-State: AOAM531nCaoxOlbsVY2lCyEd1QSlbuapxPriP7Bfa1CqQw0wc6PAqmFH
        jfMgPr+gjxyvM1nsnjrtCNV3K29WRtQ=
X-Google-Smtp-Source: ABdhPJxnS/3HuZWl4cMTf8ig5V1QbNjGqvOxE4rrR/gOtzrBSlqR+oDAIu9IWr7/IhGpoSuOC3+qMg==
X-Received: by 2002:a2e:9dcc:: with SMTP id x12mr65145ljj.261.1596055601555;
        Wed, 29 Jul 2020 13:46:41 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j17sm692597lfr.32.2020.07.29.13.46.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 13:46:40 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f5so26515924ljj.10
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:46:40 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr120028ljj.102.1596055600069;
 Wed, 29 Jul 2020 13:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com> <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <20200729203856.GA519065@google.com>
In-Reply-To: <20200729203856.GA519065@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 13:46:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYOHQ5T-5ozUG6DCfKUyJ14qPoVWqsyHSjQBK450wigA@mail.gmail.com>
Message-ID: <CAHk-=whYOHQ5T-5ozUG6DCfKUyJ14qPoVWqsyHSjQBK450wigA@mail.gmail.com>
Subject: Re: Avoiding 'master' nomenclature
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 1:39 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> What would help in figuring out how to do that is, instead of more
> reminders of how stupid we are, some more information about what would
> be useful for you (both directly in your use of git and indirectly in
> the history you would like to have available to you for pulling).

I've sent the patch. It's "tested" only in the sense that the
test-suite continues to work, but it's really just a revert together
with replacing "master" with using git_default_branch_name() instead.

I would have thought the old behavior was self-explanatory: don't
bother saying that you're merging into the default branch, because the
default branch name is - wait for it - not interesting.

And yes, I was annoyed by this, and sorry for calling it stupid.

But I was annoyed by this because it took me much too long to notice
that my merge messages are now unnecessarily ugly for the last two
days, for a _very_ bad reason.

And I'm annoyed because I agree that "master" isn't a great default
name, and I treat it as historical. So then making that
less-than-great name more visible in the history is actually really
sad, in addition to being just ugly.

            Linus
