Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A4CD80C2
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjJJMuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjJJMuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:50:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7DFA
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:50:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso1466680166b.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696942207; x=1697547007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X23xmVLg386DGq6XElp/WRehWkUZVbmW3ZsuQTbM6VU=;
        b=bw6SGAAPwJ3EbNO+MSWqRk7Asx3PlQLQmIErhAKPctFQzLOEsjMhnWU0nFGeb00dYO
         5b2VKrvKGAvp5kUZHoKIR3+MHHxeyunQB4rf9eZFRvYb5d0Z1yiw8x6PizhLQ2nx8xRe
         7xxDFbelsEfdsZGkF6dNMS3wpzyAtuWrFVHkC0S//iR9EBrPbpovfVu+k5lLm3BAZjz5
         Pb18DZbIXj+tQfpaaf8Xy27yrB3aNrrO8QOFsKFmaQPXd6j39l8TXzjou+/m6qfqXC/P
         3rj8yQWtP1b8TDNBhIP3r6JcjJjMNvZ2x9FhRdlFQNJrFlQRdVqWG4O2EKImxsLetEO1
         sGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942207; x=1697547007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X23xmVLg386DGq6XElp/WRehWkUZVbmW3ZsuQTbM6VU=;
        b=b99myYWWtU5WKDXT+GsJDObm6q+DwN2Ype7ewemBk1bpmTs+43WvNTrTA6Q6uud0iZ
         +a+/bwVRm5Db9oDkWqFMa1+FOyCqA180Rwvd+EjGNL8jhHVgtmoQIWJ4iZ8jBGDvepuf
         UviM+V6TDgocVAR/Pl97kI58Tzxc+tlFx9SBxVIHnFRbWQJ5VCwUG09RCAkbSYwESJYq
         9AWG9Em0OqeasmXSJyu+UtZkG0Ucd6fX04vh0DWSKVWMDUT2YsgvpN2m5tqVJkzLWkEM
         YdrsOUupTed0iUymAtbJOCQd3+XqOsj3kWtbGq2uvazkcvfJvYtu4rTvO1rQdMlOwG8k
         XWyg==
X-Gm-Message-State: AOJu0YxEqmjzxMbRPVMWtSgYG6dx5kJgVo8LL2Tp8q9gJXyoeJYshPd0
        uUDARpBOO35Nox0Ud7bR9VZMSXdf4JjLwK2ES20=
X-Google-Smtp-Source: AGHT+IEGmZezdmweZWrJ+dbECgdt0u5f5Ht8xxGqCxNYom3str5/S5P5U+xkYdEaXvCB3zAhuNOJdVkgeTF2O4So35I=
X-Received: by 2002:a17:907:8b8c:b0:9a9:f0e6:904e with SMTP id
 tb12-20020a1709078b8c00b009a9f0e6904emr13059908ejc.16.1696942207227; Tue, 10
 Oct 2023 05:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-13-christian.couder@gmail.com>
 <f0e75d47-c277-9fbb-7bcd-53e4e5686f3c@gmx.de>
In-Reply-To: <f0e75d47-c277-9fbb-7bcd-53e4e5686f3c@gmx.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Oct 2023 14:49:55 +0200
Message-ID: <CAP8UFD0EUF2s+X4adBmRxk-GWKeqH1C6rBd-Xgqv1XHNYWB_gA@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] replay: disallow revision specific options and pathspecs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Sep 7, 2023 at 1:03=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> As pointed out elsewhere in this mail thread, I consider this patch to do
> more harm than good. After switching the command to plumbingmanipulators
> it should be possible to just forego all command-line validation and leav=
e
> that job to the caller.
>
> Therefore I would love to see this patch dropped.

Ok, I have dropped this patch in version 5.
