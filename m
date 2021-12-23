Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCFCC433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 17:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbhLWRLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349401AbhLWRL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 12:11:29 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE5C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 09:11:29 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id 30so11001840uag.13
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8bjJQO5iLYR24cRB/xi1iTcs1R1vpYwzpTAensSBsRc=;
        b=NStKSZdoVWR18uUsVBnvN45khmzrqpR4dq5HaKqwbuWwYEd4ksIzgnU6GW0zOjKiQ9
         pZdIJkLQGsis1jR5N1CtZ7+xKwpCQBCXeV12Ek/CA1I7mlXM1dcH63DkSzsKnW6lRvZ1
         SaVogTiuINOxJGjSfnNOL+7TLTPxRr+3Kg0C9MSDmaYu8mCA6dUaKsbSVyMIR6jaX59a
         z1wiGRsUhJksr40tBzuMvEGaQwca37UO5s5lNS4mDPlgXGj4ahti7EhMc5URkG2sGpY5
         Z85jUvKceK3vcOKN3b0iN9I6H6ZF1KF7fmHvJ79+VikIHfmJ+rkkgbA1PrBtDkyvgd4s
         bqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8bjJQO5iLYR24cRB/xi1iTcs1R1vpYwzpTAensSBsRc=;
        b=Up+y+oEizjKZ+SLCrQySWPK6lGNPM+EVmzbdSOJoxzhLmERXx0MiQSPDJu8wERy33/
         fXDDbxKBK8P0BFz1+QRz09IyyApclapofFIqEwyJizTlDcEVDXPlKkB4zU1CZcqPXzvq
         C0Bd8Bg631wHn976I7S6/a3XJWAyPdkjVVd3B6X+OQKulTUydTSdv0T+VWwF00Y5Bhsh
         ApOmfoetavg43sqm6oH3X3BAmVMGVBTo1Vxv4RVpsf9OCYioYIypaJ1DpeJGCCun1dlZ
         vc4nUTDZZ/DV0E874WbYSFnggffEKFwWr39BnbaXpkWMLE4uwC0CtNzsmYORhrujMKZB
         FpXg==
X-Gm-Message-State: AOAM532u0kaeWBG+vTznMOiJkhRTnblyt9PgjccNfb0BGyXbfHBr9pq7
        4K5YC4GmrwaDJpuCfgErefFKkROQyZXppfuL3YhjxA==
X-Google-Smtp-Source: ABdhPJztToQY6IxGjC2L6g5gQY3tfFXo7l2kGyIfg5slRscGUgUun4vdMj12muHhLM3xc3I+Ft7uEqjAsd3UI7mincw=
X-Received: by 2002:a67:f305:: with SMTP id p5mr1054769vsf.8.1640279488139;
 Thu, 23 Dec 2021 09:11:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <072ff09c-9174-e769-7ebb-4bb248199337@gmail.com> <CAFQ2z_PmwLKC2Y39yj2Cqk=FMGC4gJTgZUEFOmgC=wE2KmdTfQ@mail.gmail.com>
 <569fded7-48d7-6f48-47fb-b78c403214fc@gmail.com>
In-Reply-To: <569fded7-48d7-6f48-47fb-b78c403214fc@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 23 Dec 2021 18:11:16 +0100
Message-ID: <CAFQ2z_NPqRseabyFynnNe_0Yh9rYeL9js7B-ddL3YjxSXyJeuw@mail.gmail.com>
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 7:17 PM Derrick Stolee <stolee@gmail.com> wrote:
> Some of these changes are definitely going to have a lot of lines,
> but when it's the same kind of change it is easy to verify. I'm
> getting lost in this diff because it's doing too many things at once.

I took some of your advice in the last version of the patch. PTAL.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
