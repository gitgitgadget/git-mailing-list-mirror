Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49330C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDQQVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjDQQVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:21:45 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A314ECE
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:44 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-552ae3e2cbeso51653697b3.13
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681748504; x=1684340504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0tjD8fJ4duzoRbvGU6aeLVt/I2P5X7oejW+G8zPthA=;
        b=EL0q01xrLEuZoenI6OMv8guS6RyKPG1ijP8dSkTxduz425CXLl05C7620216zUWWUU
         l7jFHqywSUzDRl219XE31/sz83ZQ6oydLYYQ5cTEBRJXHjKsMLZeW08fMMQxqvynRbJ8
         x2bN/J2Bd5axR9GD72OZrcRp26mmRKIt6RTr5Xsq64Ie3oFyJH5LQ7oWCZQnoB6QPAgX
         cCX+qYrZrY8JdbAsNzFQE6omz4MWUKjtiURXIJ4cCoQsr3W0fTisUeYJPfjTmjdukpJE
         raEbz4jDKUjZIFx5ksKZn77Spn9SL83XVzTCjw9miUg6ZZiA4BymoiD8Gl2mNNIjlWQS
         ZprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748504; x=1684340504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0tjD8fJ4duzoRbvGU6aeLVt/I2P5X7oejW+G8zPthA=;
        b=DMQToz36Lur0nR55LHNfVYcDuph1hfrG1hHUz8QD662TprW5x7pieFgyExlkVgyRSc
         3jccF3Vp8ItKEFiXgadf/KkvY50NpoTgsmWGPIYEp5tmCOMCHcV9E05yv4SZyN0ti0Wm
         SDEsSHX9RplWr8TKXa+lx0rhbJoIyhfBBTZf+yCkhIaLUMnRcL1TveZK0mMy9zJvh6Bp
         NRcQ5AD0xFrJAsL2Z4UVL+WKplnwBz3wlDek2buWKMlmRIH9hixLnSBmy8LXbE3R5QzX
         3zKo5OpZPY5wsVeYLJNO5VBfoYqtBuDGJ2Lse2j3NfMVuvWSKVmk2FJuanOZkpLevusb
         AC6g==
X-Gm-Message-State: AAQBX9eP+AD+2iT6Yh6XRIbxb/P4AvzqtQ7OnbknDLNpE8e6yhJtiq2q
        /wcjtKYX1BcscPBFZHs/9ISIbFtPj4F+3lrT2NDsMVzI/Ok=
X-Google-Smtp-Source: AKy350aUplnMO48mvC/ndkn3QOKUFQ+7gm6dzx1aDdZelPpWKBEnH2C7kxHMKdJb7AqFpp9gGkyMys0PdwR/jC1GAXY=
X-Received: by 2002:a81:ad41:0:b0:54f:bb6b:bf6d with SMTP id
 l1-20020a81ad41000000b0054fbb6bbf6dmr9713639ywk.2.1681748503869; Mon, 17 Apr
 2023 09:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <AS8P194MB1575B12A6A11E3CBC6537C26E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
 <643d407765bc7_751a29453@chronos.notmuch> <AS8P194MB157593E9D310D6B03A1E0577E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
 <AS8P194MB157539251684168156C0EC99E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P194MB157539251684168156C0EC99E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 17 Apr 2023 11:21:32 -0500
Message-ID: <CAMP44s3JmrLuh7_JCSPmQajVMfYQ5xZ2VRZoB=eYO7xdwqqavA@mail.gmail.com>
Subject: Re: Bug/Weird behaviour with git pull
To:     =?UTF-8?Q?Berat_=C3=96zdemir?= <Berat_Oezdemir@deichmann.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Berat,

Your email contains HTML, the rules of verg.kernel.org explain very
clearly that you must send only plain text:

    All email sent to there must be TEXT/PLAIN.

http://vger.kernel.org/majordomo-info.html

On Mon, Apr 17, 2023 at 9:02=E2=80=AFAM Berat =C3=96zdemir
<Berat_Oezdemir@deichmann.com> wrote:

> what you're writing is the expected behaviour of git pull. In my case ori=
gin/f1 equals local f1 so git pull should not change anything at all

I think you misunderstand the purpose of `git pull` (as most people
do): it's *not* meant to update your local branches.

The purpose of `git pull` is to integrate pull requests.

It's irrelevant if your local "f1" equals "origin/f1", because the
command is essentially the equivalent of doing:

    git fetch origin
    git merge origin/f1

If you are following a feature branch workflow (and it seems you are),
then `git pull` should only be used by the mainter to integrate pull
requests (usually into "master").

If what you want instead is to update your local branches, I suggest
to do something like:

    git fetch origin
    git switch f1
    git merge origin/f1
    git switch f2
    git merge origin/f2
    ...

Cheers.

--=20
Felipe Contreras
