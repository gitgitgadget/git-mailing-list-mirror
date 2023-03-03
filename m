Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC00C678D4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 08:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCCI3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 03:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCCI27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 03:28:59 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876B944BE
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 00:28:49 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id bl39so505530qkb.10
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 00:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue4aDTLafwiD0a3L+t7RbKzznvh+qbSQNnoAQcENnL8=;
        b=A/c8CZKMIkWcMYHHbZDtsLh3d6Fq2gq7mMihhL+V5MFo3K7Wo48SoRlRVhp5Ohq1ua
         0oygsPYq6X+jEBuZdvpNJgZ07PIkNnvRT/me/GHj+7NlHbcGS07wEONZAaElT+iMwx3G
         FtNTzKCE/jmIvJgPl+BeC8DfPnOZLbD2BdgVzZEoIuTZumtCa00kXeFi/z71HapqA2a2
         9fLkUfNoRgFHYgOwnavrwERyF8p9Ldt1vqg1WQRUX2Ka/Iduqto7sBXjfEVIwJrnJI/B
         Z+0Db7j+1lZ/pHPTLKxDDdmJIiNBF1afzNQrVRH+maZEnf6MsDp2fMUO/anGL8cjiItd
         IHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ue4aDTLafwiD0a3L+t7RbKzznvh+qbSQNnoAQcENnL8=;
        b=kD6dvHLnvYqee2KMsiBYOqE0vtnfGeMOfzZ+z40bZD2S+wWkn+iJb/aHYkHoRvf1G1
         vM8CYAft1cVQbJqqD/+jmHoqlmltaU+w34WYbp6Ynr8xoiR3ru4QJ2eaFR4YZ2OrjeaZ
         lFYtxln2u/sHsyWbyvZCeA5hQDFSK8TZYWjNeQfbb2uWxdC7iKfr6UNHzDmxiHuA4uZh
         J5DJ66I+0rpztqBNsv6DLQv3/nbO1uLLwd5rs18oZaMozQGWO1uzNNBNgXBi0hRLadPK
         RhT8800F60dYw6p//KsW1xP6+m6iAUY4iNipiM9a/sepMiPxAn/te63F2iI2qKVqE/P5
         Bcgg==
X-Gm-Message-State: AO0yUKU9O3S62LsryQaxwpgJ2AyrP76+Fu5EpOQD//gS4oUDuI1ROviV
        ytYNWdZdB2pplK3cTEMlfRN/cSeK+BlyhaZuE0xO5jT7Vhk=
X-Google-Smtp-Source: AK7set+yxsicxxtC70Xe4P9xHt5DB7UEWB6D6gbvlzqsE3tWIZ4cheyDtU9j7dE/p/dgtJnafo/eeo3OuY1hH+zLM7I=
X-Received: by 2002:a37:9a89:0:b0:721:41a:f4f8 with SMTP id
 c131-20020a379a89000000b00721041af4f8mr209238qke.2.1677832128606; Fri, 03 Mar
 2023 00:28:48 -0800 (PST)
MIME-Version: 1.0
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
 <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
From:   demerphq <demerphq@gmail.com>
Date:   Fri, 3 Mar 2023 09:28:37 +0100
Message-ID: <CANgJU+XT3h4b40Nr8uq_j4NyY0ka43vPghN4fJx8B=qcCHoUaA@mail.gmail.com>
Subject: Re: Let us not call it git blame
To:     Dinesh Dharmawardena <dinesh_dh@outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Mar 2023 at 23:21, Dinesh Dharmawardena <dinesh_dh@outlook.com> w=
rote:
>
> Hi
>
> I am writing to you to request that the term blame in git blame be replac=
ed with something that does not sound so blameful. I=E2=80=99m an SRE and w=
e actively try promote a blameless culture as such industry tooling should =
also follow suit imo. Progressively phasing this term out with a better ali=
as would be great.

Just set up an alias that maps `git credit` to `git blame`, and you are don=
e.

$ git config --global alias.credit blame

I dont think there is or ever will be much traction to rename this
command, it is short and self descriptive.

Blameless culture is great, but it is about "not finger pointing", not
about what tools you use. Your company's management and internal
culture keepers are more important for setting this tone than the
tools you use.  If they don't actually practice not finger pointing
then renaming the tool won't dont anything, and if they do actually
practice then the name of the tool won't matter either.

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
