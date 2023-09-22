Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F25E7D0CD
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 06:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjIVGUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 02:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjIVGUF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 02:20:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED1819B
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 23:19:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-530ab2d9e89so2070030a12.2
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695363597; x=1695968397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rftpORx1dDnm58QcCbqUWr2NzAq9xldV+EMQyiAqjNY=;
        b=fbcHxZMoBKbf44tYRjAR2mtBI3PK+LuIMzJoUQVoNZPxuuqfks8y18cdMV2Be9shvS
         xW+Yhz2ZX8Dx5VZV6qS5ANF3J4BB9GOocJtR6v695iMlHwX7awvyHtDWWVuGzavzeoTB
         SnoxRLD35rfqak6Su4vLXfhUIWzVy8ivPrQYIDdK6D1ZzF6kacHkk3jcnQ4HXOmLB3t8
         IswkdT3qLkErT4l2MIrhq7n9smQem42drTPKnJB6CKimtY9MPrdLjy6JA8Kj6eLbrYG5
         o+nQTSTX83aUjqlEr9PehzPEVwA3GEky1PopB8u6AzybQiSTbp/Bu64UHCTpu8t8jD3v
         oq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695363597; x=1695968397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rftpORx1dDnm58QcCbqUWr2NzAq9xldV+EMQyiAqjNY=;
        b=ki80cKDjwtAHmnJ2XQ+L/p6i3d1okLK2edjwxsSAnLSyhZwZiYq+ULWUehbSE3UWxR
         rZnGXvZAouE39bP8o7y0OxkThNuiYyQN6zGaU3FvFMVVYsYoE9VSzsWX9id1iaptQS67
         aXvyo+9qz1ipoqeKvN76yJWuHo+C18S94ZgHFtu0Beztqb2q7KCb0aGvXJnJW1lXjhEF
         6hExPZpC6mK7j1TQ2/gzyN5s07646VjnH16RmA4YVjjPlExhe1/uujIQgzITuuqf121z
         NifuXxUxu9ojSyGyFWSNKOoECDTxVZ14pJgsNo4CaYQ/ak0ksQu/lyxyIH6MTu952a2Z
         /EYw==
X-Gm-Message-State: AOJu0YwtqRqg1jSdW927o4+5JGfmKJi3b5MYeUL2M0FZ1hxacjJ9W1oy
        e2HgCYmiAvDjuBsjQKaMd69V4mETBd6dS619Jbc=
X-Google-Smtp-Source: AGHT+IGINHhg3Ep4goBceP9nXSqeNhhhbY/i7Fk7GMtyTmMuRQguPpks1U45ejxXLsDabE4zs1NAyHa3wGDlXtMIUpA=
X-Received: by 2002:a05:6402:1a26:b0:522:3849:48d8 with SMTP id
 be6-20020a0564021a2600b00522384948d8mr6551116edb.9.1695363596874; Thu, 21 Sep
 2023 23:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZNwhVOggObU7aVTr@nand.local> <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
 <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com> <ZOZSo7vJztHcvb4W@nand.local>
 <435a2aa3-59f8-d2bc-f653-4f93d86b9c31@gmail.com> <ZO4wxU1ilpa6/3EW@nand.local>
 <CAP8UFD2CGf8efBHquS=LJP8uQ5ivuDryqGz96PZ81oDtrNgNXw@mail.gmail.com> <ZQyrllWhLDebWCG0@nand.local>
In-Reply-To: <ZQyrllWhLDebWCG0@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 22 Sep 2023 08:19:43 +0200
Message-ID: <CAP8UFD3i5ewCoaZOh09TtfuefEtWL4+z8P0_Z9DWdYCrShYheQ@mail.gmail.com>
Subject: Re: Git in Outreachy? (December, 2023)
To:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Sep 21, 2023 at 10:46=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Tue, Aug 29, 2023 at 10:38:45PM +0200, Christian Couder wrote:
> > By the way, Kaartic, do you still want to be an org admin? And Taylor
> > are you Ok with Kaartic being an org admin?
>
> Sorry that this dropped off of my queue. FWIW, no issues from me.

Taylor, thanks for your answer!

Kaartic, if you want to be org admin, just ask on the Outreachy web
site and we will accept your request.

Thanks,
Christian.
