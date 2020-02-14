Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55013C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 07:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9632467B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 07:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWlZJqcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgBNH3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:29:46 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:40245 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgBNH3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 02:29:45 -0500
Received: by mail-lj1-f179.google.com with SMTP id n18so9573638ljo.7
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 23:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZYqhKmb+JLa0VIMb7M00fpBdSMF2ax8F36CJOWXwLE=;
        b=hWlZJqcmljSAc6e1Woc/8nnaeUf/VuHwln3jlgBoVNEsZjFAd03vKufJY8QydRtWH3
         oMWTLccIgm4wDOyzXDZPC59yDtCCodC21P6BIb6Escc8FW4vJgtvDKLtazMuMaJ7uqz8
         PVpP2YJRHuub5sIefCa7rflun8wDkLKp3L3UDmQ/VqRqZr5Z8vOIwyw1JhUKlv4teQFL
         O8NanHLmhCZZJ1WBvGXAQGYUo5Iv08Ew4eHruNZ1EAXuST58YB+zUksbmt79wMHQ1UzY
         fE4JBxPK4JDEmMKujN3Fp7Kw3Vfz67WQ4Qe2ezu4uLkYsMVvX9riQsB7+mo+4xXdI8F8
         OcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZYqhKmb+JLa0VIMb7M00fpBdSMF2ax8F36CJOWXwLE=;
        b=C72iYlHw2zLTEMaQnIONwzgJGE/9N0+ThIBxivTzPeV5z1Y6PTDKMYGpyA/O85mcR0
         twsOWxuzIp5RsXdcU0TRNQY9fQZbFOUbR+P6X8+QSKbW19WJnUx8hLU0GaFoWVu/d78K
         c4xppz+I28hsZdKcTQXfEkGxXH622y3RhcQD69JsLIoLO7YBZIFTyiQ2w1w+ug+SKLf4
         ZQhcNI0GS7d6h0bBPCuIhmNcrWHewaeB50tEs/HkSYMsn6kZGqk2xI6bK2WQljKNjN7I
         f6l5ZSRQ8jtZ1ZzRhVDEK3QsAt2tYeRJFvPpLAFkl7JtrWpMQhtcubJVP30HDhb4UWbu
         Hodw==
X-Gm-Message-State: APjAAAXVno6U8FauG4HAebnlEIS4IZIPrsSIx8GbW2XPWoWJg5RYDG+H
        kSC9pnlzBw/DppbFUDuvMUAtumH83odJcmPJq2c=
X-Google-Smtp-Source: APXvYqxLesVrEvBWScftXtuFJolz+jy7XMJtM2cnqN1adyYTUJ9+ubiReKCMPT/RAD2r35vNCEi0rjFImp719JqgwH4=
X-Received: by 2002:a2e:b536:: with SMTP id z22mr1129812ljm.259.1581665383564;
 Thu, 13 Feb 2020 23:29:43 -0800 (PST)
MIME-Version: 1.0
References: <CALH1-Xr_pK02j6_51EnZN=ZrSz6dijt9tn0ANJ21331GzAmBdQ@mail.gmail.com>
 <xmqqy2t6osht.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2t6osht.fsf@gitster-ct.c.googlers.com>
From:   Robear Selwans <rwagih.rw@gmail.com>
Date:   Fri, 14 Feb 2020 09:29:33 +0200
Message-ID: <CALH1-XruJ8UnHTN+xi=NOPtoP-p_F2OCmkLai8kjzsLObg=AvQ@mail.gmail.com>
Subject: Re: [RFC][GSOC] Microproject Suggestion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 3:41 AM Junio C Hamano <gitster@pobox.com> wrote:

> For the feature itself, I'd just do
>     $ git reset --soft HEAD~$n ;# rewind
>     $ git commit --amend
>
> to open an editor, and then to the editor to edit the log message,
> I'd tell it to insert "git log ..@{1}" to the edit buffer to help me
> formulate the log message for the consolidated change, so I do not
> personally see me using it, even if it were available.

Yeah, this makes a lot of sense.

That was actually the only idea that I could come up with till now. I
am open to suggestions, though. I don't really mind if it is too big,
as I am also interested in contributing to git.
