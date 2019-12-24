Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F027C2D0D2
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F4920706
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGeI0zKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfLXLFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:49 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:39546 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfLXLFt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:49 -0500
Received: by mail-io1-f43.google.com with SMTP id c16so17418288ioh.6
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1NrtFRR/iK3TmiS7ADi7L6WIGP2wLQkO1u0SGMxhCDA=;
        b=GGeI0zKI4qNkVPCupDM/20FM5zcSTxbSCs1FcVPM3ENw4/x2QxwEomwCnb4tl/E1Aq
         NmVXV8IwtpkD+fYLxWHomuJe4KeC8IlcI4l+pdcKztV2ksUdlYXR40iA46y62oUWo7g2
         aK+VzJJ1YWhI9hqxseWp4iQpKWSPDUWtrzfBa97BWt0XtkrzvGXjG9hcdzjoYbq8NgE0
         vgqALZx1Gn8lDBNuK23s8Qowm7foI7RByC6ykT+lVQkF/e23P9kPd8FA7qzyv0vgS62+
         FjqNPCTsdd1DbToU7h2gHP1HIf+urdd1FjsZFmvp7cZg1qbMowYdBOPVNBgJxRErz3x1
         GzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=1NrtFRR/iK3TmiS7ADi7L6WIGP2wLQkO1u0SGMxhCDA=;
        b=CZrWCOrG3QQderv/ArqT2vM/v+/GPcEM8SVUBGCDkvygemPfU7S/aMZbxQpUTjxme9
         0XKmDHx8nY+hbd6N7O4hpsSrHn8cqk38yzFxFi0TdJT6B4jg4xdCICSB/IC6IYg+P78a
         n0jRAyMLJkLh63ZobADSQ4OiTCXEM0KhY34zfzlamqFcgtrdomYEGu6dzptRZSRTaM1F
         qsDrtQrUaKHN16rS5NnOuM5SLSYKABLm6kpX1c7eWtja4rufdVNNMEGD0gYZPlOZEtSk
         PgY/qhs+ZOnvctVkKHIohbT6V8ECqe6KyGHyH/9z1WlUcBYMfRi3Ziml94wXPDklNCzP
         bYtw==
X-Gm-Message-State: APjAAAXJGe96h1iQccAMwNALYJ3iHdth8Ahgu2NMGist3+nYspDm4F3H
        hgrd6sgNpaf2JjjZhMLec9EVkqrJiUretU+IhRNQWLec
X-Google-Smtp-Source: APXvYqxIBqKaK9VmhTS8on9q3xcE7L4HMs0VbAnL92f5vHMYfM4HcHKtlsrlHyqPQCxBzAgj01IH8elYtd60WJotj1E=
X-Received: by 2002:a6b:7310:: with SMTP id e16mr23538187ioh.107.1577185548316;
 Tue, 24 Dec 2019 03:05:48 -0800 (PST)
MIME-Version: 1.0
References: <CAN7CjDAu8-q6BR7sT4w_AccciGyk81AON+wyMjce+YJ_nc3WgA@mail.gmail.com>
 <CAN7CjDD5RGXvLC5DJH-f_+JkiPTjVQ_ghq_cVB-P7E_2nDEj8w@mail.gmail.com>
In-Reply-To: <CAN7CjDD5RGXvLC5DJH-f_+JkiPTjVQ_ghq_cVB-P7E_2nDEj8w@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 24 Dec 2019 12:05:37 +0100
Message-ID: <CAN7CjDCb0CoT=dB_ThxVrR18AhuBBZjc3=kWoPSVYgKk0vqA1Q@mail.gmail.com>
Subject: [Outreachy] New Outreachy post.
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,
you can find my new entry here:

https://mirucam.gitlab.io/outreachy_blog/post/week3/

Merry Christmas!

Kind regards,
Miriam

El mar., 17 dic. 2019 a las 16:30, Miriam R. (<mirucam@gmail.com>) escribi=
=C3=B3:
>
> Dear all,
> this is my new entry for this week:
> https://mirucam.gitlab.io/outreachy_blog/post/my-week2-post/
>
> I hope you find it interesting!
>
> Kind regards,
> Miriam.
>
> El mar., 10 dic. 2019 a las 10:46, Miriam R. (<mirucam@gmail.com>) escrib=
i=C3=B3:
> >
> > Dear all,
> > as an Outreachy intern I have to post on an experience blog during my
> > internship. This is my new entry with the first week in Git project:
> >
> > https://mirucam.gitlab.io/outreachy_blog/post/week1/
> >
> > in case you find it interesting for reading.
> > Comments, advice or insight about the topics I am writing are always we=
lcome:).
> >
> > Thank you,
> > Miriam.
