Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C54C3F68F
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 18:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9B322527
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 18:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkU7QEj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgATSXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:23:09 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33188 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgATSXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 13:23:09 -0500
Received: by mail-wr1-f54.google.com with SMTP id b6so528223wrq.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PMdko31fjMtxsO4T4j7UDm5laPBzWHBAnfbQp1mbGJ8=;
        b=fkU7QEj5aYNDm2WwQ7VGBBXFCiv2tVso4hMk/BupXnVFiB7GJ5uIADZ1A+aA2Z2rG1
         Qt6BZOC97ENfh72rg/YjjbDJ7+empMEx4thdCiAFaxJWyubfkbqGs2rvVFdtOw32eEXY
         Z+YfzQZctw5yeHBPw7bPlSqnPueaKpNVWzrF6tqeZcpBwvke4BlkQa+iXo/pp9u/98db
         XilCb19nPnzaNEu05/0J0zC9X7TFdIYWz69nXTvf7hWwyQJytniQUCQMokIoeTDu65o2
         iHF6+b2OR90+j71nBbjlUI3bba2PpqIPAhe5mT+nUeYO8E7u4+sR7czvzo5llmS2eLal
         KOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PMdko31fjMtxsO4T4j7UDm5laPBzWHBAnfbQp1mbGJ8=;
        b=PVPlwZ0Q+THG01h3Fcv7UyxnJWpo0wno/197VKyBgug+k3I3kQ5/BmFrJ8g/oSfoGF
         p4AQ4fAovvfqguNkpQ/13OXWvzuvbi+2SJDDB08fWQJawo/TZ01wze4td31Gp0OlTXu/
         yi3pmx+PA0t0u6DfWjdpkUmACJASSTwYGvPeMatnYmiXqSxfBN/5y9MlCmAApMZpTTkZ
         jXjpc/1xJCd+6CvQ0hr40zrxq1bXZCMQi1LdFAZyy4hShCTvk6sRHKvdRFLmcSe8kMFe
         dGGzACmmQE14CpY1ROWay4vjZd+DM7G1fMTWVqxt52RnLVmDb0e6l0kG83EPEkqOQdi4
         hNrA==
X-Gm-Message-State: APjAAAXbhIQAJ8RxK9FVng3J4lt4yL2o3BHpLvO897xzrOtr9VsIJnl0
        HgrOOu2Es70pQgJlLvSZhZX4BnOiG4yo1VutcFlEHoTyt7g=
X-Google-Smtp-Source: APXvYqzjvQYAbdM6iN1JuJIoM0t9N+kL5KHcS347zbOCRAoQIOIDgh23phlNuDQW0QPmxjMctkCnK52AZh9dnKCrvss=
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr835178wru.6.1579544586308;
 Mon, 20 Jan 2020 10:23:06 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_OhNHauK_W1wL7WcOJnm2vCUGXLfYn_ZmLnt2rez+_TDw@mail.gmail.com>
 <xmqq4kx4z8n3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4kx4z8n3.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 20 Jan 2020 19:22:54 +0100
Message-ID: <CAFQ2z_PxumPGpgnTERcu3S+zdTj9PcVMKK9SjYxSDe3qW9q3jA@mail.gmail.com>
Subject: Re: reftable progress
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 9, 2020 at 9:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > Hi folks,
> >
> > I have some alpha-quality code for Reftable support in Git at
> >
> >  https://github.com/hanwen/git/tree/reftable
> >
> > I'd be curious for some feedback, both on the library
> > (https://github.com/google/reftable) and the glue code in Git.
>
> If you are asking for feedback, sendign it over to this list with
> [RFC PATCH n/3]  as the subject prefix would have better chance.

Thanks, I'll look into that when I am done with my current TODO list.

In the meantime, I've updated the code at the above URL. The major
missing item is currently reflogs; hopefully I'll get to that next
week.

I asked around, and it looks like we have slight preference for the
BSD license (https://developers.google.com/open-source/licenses/bsd).
According to the FSF, this is OK to combine with GPL software, so
would you be OK with that license?

thanks,

> I have a feeling that the patch to show-ref is done at the wrong
> level.  The show_ref() function is given as the callback function
> to head_ref() and for_each_ref(), and the way these functions call
> the callback function is part of the ref API.  "In the reftable
> format, ... are stored in the reference database too," is perfectly
> fine (that is the implementation detail of the ref API backend) but
> "and are produced when iterating over the refs" is not.  Hide that
> inside the ref API backend you are writing for reftable and this
> change will become unnecessary.

The API is a little surprising here, because it means that an iterator
should always dereference a symref, regardless of storage format.
Since it is not specific to the ref backend, this behavior should not
be in the ref backend code. But I've modified it now, and it seems to
work.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
