Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C0C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 16:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31569206C9
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 16:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFPQVSlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgI3Qvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Qvh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 12:51:37 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6AEC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 09:51:37 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id w11so1270700vsw.13
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XjnpsWM5svKmgZp61dgLCzXBfbAjt8ljFGWRPAgrldg=;
        b=oFPQVSlc4OazrmOUREn9JtgaaIT9axJA+sHqRvBCLTztxMfMf+AKj7RuiIRK7giVZi
         amEV8ByoLkbY0i4YcyoSqob33dZVcBR1xOGHrDtPtg1BNdKQOBZAYIDArvpuX7+JYFcu
         A3QZOpV5mz09lx/WkzgrdJi0zlosPkzf9WpUPvYZPTIjbJEaIIvC74E/o5/eeVpKz/at
         WhSaBuCaHJkzmFLbU5ytu1HE+Bc0wExJdiCnEhS+zkjjko0m8k5AgUBbp9Tu1XB0rVVN
         bmbUsfxHeKa6O/AifWu8eqw4DFupwM22uC7mO1EttBXyhLY/jyU1c9bI0jgDNICboyTA
         2bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XjnpsWM5svKmgZp61dgLCzXBfbAjt8ljFGWRPAgrldg=;
        b=aVXqYOa7BrxHL7QeOYxipsE+uT+l+sXqiiMPLBuqN4GnSRFoPcNTg7tyQXyPDpzTpO
         +XkuPnlR7agP2y0tMV1vDK5IBGc3/Tdm74yiazbVn+k/QOPMkb/IVqgIYmP68XRxQKf6
         WlCRHw4q47AIASBDljkNZed7Sz91weS2FJN3WCNep3nG3ud/JO3yTMnBgKJPmjeXEi3p
         inuM+NQXx0mcOojrUkgxlFlduzErTqYuwKk8XtWpWPFqq2ItnMNJOSGVsA7BUdighIWI
         dTxtdaO/UlF9IpcDmAvCT/uktqNU2RYJt5prB5T7K/8rdceomRqMsvxV5EoUQnV9PXmG
         bd+A==
X-Gm-Message-State: AOAM531WeCKTb8koyjSna3WGkcDiYN7ExFoBcdfp/5aDkFhpDMKSGH4u
        m+T/vhgHXvQK1sTBWDDlgSZ/QVtsGes70G78T7xCOA==
X-Google-Smtp-Source: ABdhPJz5HQcGFNdfSz+qSf4vYNfn83IFOtOVYHfvk98ESvk6kXO30dekLTXMirW02MXrqU3YkPBFEh5QoouPHCI71Ic=
X-Received: by 2002:a67:fe81:: with SMTP id b1mr2433735vsr.5.1601484696724;
 Wed, 30 Sep 2020 09:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <eaf4629b-d8c4-0ddc-8c85-6600399a8229@ramsayjones.plus.com>
In-Reply-To: <eaf4629b-d8c4-0ddc-8c85-6600399a8229@ramsayjones.plus.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 30 Sep 2020 18:51:24 +0200
Message-ID: <CAFQ2z_PNT0g2yAbMkWEQW3UjbMbzALfkAfLDzpiUZjOE0b29vw@mail.gmail.com>
Subject: Re: [PATCH] reftable: fix some sparse warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 12:47 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Han-Wen Nienhuys,
>
> If you need to re-roll your 'hn/reftable' branch, could you please squash=
 this
> into the relevant patches.
>

Thanks for the heads-up. I fixed some of these issues in the source at
google/reftable. I've seen a Helped-By footer used to acknowledge
these types of contributions, but I'm not sure on which of the 13
commits I should put that; suggestions?

> This patch is based on top of 'seen' and removes 20 sparse warnings (19 o=
f the

Could you tell me how I can run these checks myself?

> Just for your information, you may want to look at the following 27 symbo=
ls:

>   > reftable/merged.o   - reftable_merged_table_hash_id
>   > reftable/merged.o   - reftable_merged_table_max_update_index
>   > reftable/merged.o   - reftable_merged_table_min_update_index
>   > reftable/merged.o   - reftable_merged_table_seek_log_at
>   > reftable/publicbasics.o     - reftable_error_to_errno
>   > reftable/publicbasics.o     - reftable_set_alloc
>   > reftable/reader.o   - reftable_reader_seek_log_at
>  > reftable/stack.o    - reftable_addition_close
>   > reftable/stack.o    - reftable_stack_auto_compact

These functions are part of the public API. We'll need to get the
reftable glue code into seen. Perhaps some need unittest coverage too.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
