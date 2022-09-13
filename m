Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91545C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 18:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiIMSWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiIMSV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 14:21:57 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B05E318
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 10:37:12 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id e1so568834uaa.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=qPyNyW3eeG7aCpjuWib9Si3V5FyHjWxcwv2he4GSS3U=;
        b=HTIwWkkHqoVPRGGB72+Q/Zw2XmX7lg9r8s5D83cdZYp1Ul5+Ik+hdEu18PwV9ktd8i
         0zviA/mCWVsDFhU2tg0KtxaQCxiw9H1TX7mQBM/d32NzO8sIZ7B09ADlNpbZQp19zvCX
         Edb7yND2RlnPoSeL74NMhYefKoEAcMxkxJLxPsOznx6vhca394tfNxE471YTVY5GNMuJ
         9JyfIuoVK17ya5NPW8666DItq/tXu/iYAf0KhxAJvwMBbFq2QdXpf3TDde/dVlginSbw
         V8jb0MTikj0J8nHWhxtaI1zAdPp8wYryJsr3HSFLLA7BB8YgtQpFMBfATgqXKT67WzWS
         8f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qPyNyW3eeG7aCpjuWib9Si3V5FyHjWxcwv2he4GSS3U=;
        b=5Nc0zCrMGs4+nh7s7REgIp6iZuWku/W7/CSrU9H4unf1qfe7AQnAjcdU3zWPSbc4R4
         +U8xnURHQSCgsQU8gZEAcuMLGetSPnhwblnuT+/gGjlY3ZN/jIw3TP85ClWpGaUQE7Lq
         8yztvVj7lOWaI+jPjFVRo9cjbMFhcjKkrMU6G7GZCq44zNoUl1HimQ2bUORQgIaYikN1
         4bV/c7iQk1xuoKBvdHP42shHiSYcR0L616WswOvi/c9fODrYptPLsKH5aVfDQ8pJ5QC8
         2KUH1fo5PYq9LkSKqcGF70AqMfADAYWUKgDrUDYMYI88kUonkMCcm54R5gT+v4TYBxf4
         Y9GQ==
X-Gm-Message-State: ACgBeo2jrdJBmI0lQEITTbSuNlj5J6P/B9QXoS0sziwSWHaW0+iEf+2c
        z+IrGwvt+kqG1/4TsRViYjZ/0y00Mm2YA/fVt0TVFbzdJ2Q=
X-Google-Smtp-Source: AA6agR6A/u01rQTD9n7q8f9VV2eZ37EqCTkwN7thFhyWfphWwotD+8zGWYSHxrra2sGDIa+7H7GyBU6SRH7Bg/HdrXs=
X-Received: by 2002:ab0:6cb3:0:b0:3b7:5e89:863b with SMTP id
 j19-20020ab06cb3000000b003b75e89863bmr4802762uaa.42.1663090631952; Tue, 13
 Sep 2022 10:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
 <xmqqbkrjb75g.fsf@gitster.g> <18337ea407a.10c144c52599576.4708941661785569426@elijahpepe.com>
In-Reply-To: <18337ea407a.10c144c52599576.4708941661785569426@elijahpepe.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Sep 2022 19:36:59 +0200
Message-ID: <CAFQ2z_OR8uLe3rs0r09a3fvSQUE2H4WQTquddUwEeahoiRWimA@mail.gmail.com>
Subject: Re: [PATCH] reftable: pass pq_entry by address
To:     Elijah Conners <business@elijahpepe.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2022 at 7:34 PM Elijah Conners <business@elijahpepe.com> wr=
ote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>  > Do we have any hard guidance like "do not pass an data item whose
>  > size is larger than 64 bytes" in our coding guidelines?  If not,
>  > make sure that the reference to 64 bytes does not look like one.
> While we don't have hard guidance like that, putting an object that excee=
ds 64 bytes on the stack is dangerous.

it might be a bit slower, but "dangerous"? How so?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
