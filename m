Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4E5C32773
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 16:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiHRQ4j convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 18 Aug 2022 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiHRQ4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 12:56:37 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25E7C9903
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:56:36 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3246910dac3so56844347b3.12
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=BVaXlTizWiHAmI8UJj5exogu2iiyjUt5Hr9oyRwsUq0=;
        b=0LcU0dSzFz/76//LBDV/wOKqtN/8y5xQHUkb0QnyvN4ngqqXEnedoFjs3aWFivxRop
         BFrEYuzN09d0IyyoJI+ZeJNcWE7qvI19QsoffzanRmBJkJlsxVqIKxVvDzs2NZbWNFPb
         vHrrmb+Y03+eMa/+6FJnqz4PifjOTEOH2HGD+uYQBOT+aLG1s+eW/oIhGa+gOT4G7he6
         ea8ovnc5mFL3Jy5dlg3gKaLy+H6v10PaYnNE2s224T7YoozpfMY0PaHn5whXiEIHBwrL
         BSjFi4mSz+H+k4dl6d2cPcfAmCcOreB+7sj+SkHjEnjgh/NWQ94aODOzzPemenMsnWlR
         CcPQ==
X-Gm-Message-State: ACgBeo1CXIdZuZ6not8ztfNtZOfJEI/ouPUWv4IiXQ+8NAOgshPcnREa
        ARD95R7GnRwsLPQLOkzwTdY/hVeNc04wBKcmtf4=
X-Google-Smtp-Source: AA6agR6JKqJhYlWRau7G8YZHOef8HeXsOOr9HA8gk0ekN12usMo9QFFyrJQ/6IHzEx8zgCr3grfzeEmA0Z3sX3TtA3g=
X-Received: by 2002:a81:d543:0:b0:325:2240:ce5 with SMTP id
 l3-20020a81d543000000b0032522400ce5mr3689583ywj.210.1660841796092; Thu, 18
 Aug 2022 09:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
 <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com> <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
 <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com> <220818.86ilmp8rzn.gmgdl@evledraar.gmail.com>
In-Reply-To: <220818.86ilmp8rzn.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Aug 2022 12:56:25 -0400
Message-ID: <CAPig+cSerOZbVUH=Twh_yKiZH7wJdUQ+Wk_sp3pL7bR4rR8f2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an argument
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 12:01 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Aug 18 2022, Derrick Stolee wrote:
> > +test_ancestry () {
> > +     args=$1
> > +     expected=$2
>
> Maybe add &&-chaining here (we do it in some cases, but I'm not sure
> when such assignments would ever fail).

Assignment shouldn't fail, but keeping the &&-chain intact here
protects us against the unlikely event of someone inserting &&-chained
code above these assignments and not realizing that the &&-chain is
not intact at the assignment lines.
