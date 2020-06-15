Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF14BC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5FD20707
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6h+zATK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgFOMCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgFOMCe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:02:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1765FC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:02:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gl26so17095819ejb.11
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PiMLhnGOUXicoKRZ1k0wreuAnulWjWJg2uPDUQONRck=;
        b=X6h+zATKCp1xfa4wTlenWhTnPkKCmxl4jHW9WzU2M+R9EAWjqnh38YPzH6Bt2m+D5G
         hnDMAavz7+EVBZn/CLGPqTPrHB7SfaLvGs5qqKfK94sGWPJ9KSxS8Pz6eCCt3on0Tr8F
         nmi8dnpuDh9vtGGw8TW9zEufu8UqptLhWcGCMmwf5/h1x9dhtKvYalE2cHNrvsT9toUN
         41qcW2j+V11iwgmngojMzwnmZbGLZ3t0/yqoPK6x48cPuvqmkxHmWGBSu4H4rVUg5FOM
         BMIUz4VUWTqjQEiSNga+i/pGY4D4hlPnJiThQMBj8K18ifEdIpCgVqGA/oAsLUBUFgUp
         LAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PiMLhnGOUXicoKRZ1k0wreuAnulWjWJg2uPDUQONRck=;
        b=Z7lSNCtBuFhVyhZXegLGqKLFxOcY09a24I8lf/El1UOGleSAAiGGBqTNh6cVY/RMd7
         PFCZOPdkognlqTa89nhyUrh38wgrIgNsOoDrxsj9rns3gzjvzhwL71SaLy1DJMcQWxfr
         Moogb4YWnUEBFFF4C3uhvPnQNJ4ZPoRvbDsSmGK6BheI78WdVb4r/kixGyfEXJC4oFez
         4TlZt7lF+1g1j0/pPTdB44eKNfyG/PJjfgmMTcimzhqRGJvpg28VL311xm7mOq1weJUZ
         TeMrhMKT1F37d9096WtvhLaYzJ8vcplas2qol0SkBpbB32aJjfcrBbrOrf+MsiZKNLRR
         S5vQ==
X-Gm-Message-State: AOAM530M2TxXLgegA7qXDT9mc34ouEI2Si0NgXRNqc7A/t7jMzyHU3Mg
        TXIF6HOQxeYhalhiO4WwkqhIFAJuTfG60teeo+g=
X-Google-Smtp-Source: ABdhPJwGpBvRMnCbtUKz8SDuVtDMggJoRZhN34sG0B2AuSTSlPfEPlY0sJz5lklErWDWVn3XdZumNBcOCZVz03TKoro=
X-Received: by 2002:a17:907:685:: with SMTP id wn5mr26633147ejb.283.1592222551748;
 Mon, 15 Jun 2020 05:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com> <20200505104849.13602-3-alban.gruin@gmail.com>
 <CAP8UFD1aT4dmuNkEz95eDFTE7sY+4eK_TwbTD-Vw8U7KyyZ-DA@mail.gmail.com> <2158eec0-9332-fe10-3636-95550a66f05d@gmail.com>
In-Reply-To: <2158eec0-9332-fe10-3636-95550a66f05d@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Jun 2020 14:02:19 +0200
Message-ID: <CAP8UFD05hdVHsPYPF71xsyU+MOexj7AaSQuezMzy_7GqkOGHMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/6] stash: remove the second index in stash_working_tree()
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 13, 2020 at 8:00 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> Le 13/06/2020 =C3=A0 10:52, Christian Couder a =C3=A9crit :
> > On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wro=
te:

> >> The call to reset_tree() becomes useless:
> >
> > Your patch doesn't remove any call to reset_tree(), but actually adds
> > one. So the above is difficult to understand.
> >
> > Do you want to say that in a later patch it will be possible to remove
> > the call to reset_tree()? Or do you want to say that the call to
> > write_index_as_tree() becomes useless?
> >
>
> No, I meant that with this commit, reset_tree() does not need to be
> called at the beginning of stash_working_tree(), because it is only
> called by do_create_stash(), which sets the index at `i_tree', and
> save_untracked_files() does not change the main index.  But it will
> become useful again down the line, when save_untracked_file() will be
> rewritten to use the "main" index, so I did not remove it.
>
> I hope it makes more sense now.

Yeah, it makes more sense with an explanation like the above. Instead
of "down the line" though, you might want to say something like "in a
later commit", as I think it will make it clearer for reviewers that
the commit when it will become useful again should be part of the same
series.

Thanks,
Christian.
