Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F97CCA47B
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbiFMVaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352982AbiFMV3N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:29:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E7FC1B
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:24:29 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 68so5020868qkk.9
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QLXULHBcBRa10pe8pv1iSnqVjs3tsnIt9GNywQb9RIM=;
        b=vgLam+iipJ8DlXsey3Vdtn0+T0WaJ6kg8MxZCkVqi8KxLOr1siJrvKXvUmhhppc2qX
         pkKsTDsuXVhFZLokQ/LM2TV+uOZEtp9G+o3Dm/SXdlDukZPd/2LXQkqeJeZDsBhtl7CG
         lblZ9xE84cU2RMmR1QUvYndfxPzJAh75HEGohrdypkYFhZ2/d5eyEsIsILhxmZllnKjZ
         iDEyxbPwNxhL3jtpS45ad4rBayT/0iR/l188lLH9LHus0mZpyi2z9uufmcn0URJ0KBbH
         1tOx7IMOTgeLX7BzTSd00O1DQUmR4dZRS1qtkKTzqbyZTZzOw6PX0AwMwere1y/AoE+N
         kU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QLXULHBcBRa10pe8pv1iSnqVjs3tsnIt9GNywQb9RIM=;
        b=R6ln0A9XDl7avrAVWnGT4MvSlmDdGNUKwAcJlOWCOfjfcAqYXxe+6lB+B4YHRWFhgF
         qZueEb74SrCq7acBZKCJmvJVpku2nMJNcsqrG/BZeiApoZfc9nkzzggHKLKEGudentn5
         nhv1P62AWCZLbv/gNEOwGby/DKMoTLL5wNCWEwNUuLDOtKhSxzlg4B9y73SbhHs97IRV
         xIvE8OhYbZ4HebYOoM4yTU5PGf0xbbtNhjaAvzB03pDJOUB01Ohu+JaHl1PdYikBMv8U
         LwIxmWphrNmU15a+whtq2UoVmc3RgxeSGJqhtiDf5JtFKhgbYpqWDXNEGHNk9nJVZo6+
         /22Q==
X-Gm-Message-State: AOAM530rFHYipBZ91Qojy0o+zQMV7Ifnp1vrj+3ukWTNCs+6froGcKMR
        fuKSl9GPUQt7BSG1IqP/rbS2Cg==
X-Google-Smtp-Source: ABdhPJzffPeANEc4eDWXDlnwEy9HVcbCvsaXkR0KSXP9DJ/RUk1R4wumK2UidwxykPfHk6ykmLT86g==
X-Received: by 2002:ae9:d60b:0:b0:6a6:ab28:3c05 with SMTP id r11-20020ae9d60b000000b006a6ab283c05mr1687009qkk.180.1655155468648;
        Mon, 13 Jun 2022 14:24:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t5-20020a05622a148500b00304e90f66f7sm5752948qtx.70.2022.06.13.14.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:24:28 -0700 (PDT)
Date:   Mon, 13 Jun 2022 17:24:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Repository corruption if objects pushed in the middle of repack
Message-ID: <YqerC883GiwHiiZU@nand.local>
References: <20220613203145.wbpi2m3ys3hchw6c@meerkat.local>
 <YqepoUMb3rkKgWqB@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqepoUMb3rkKgWqB@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 05:18:25PM -0400, Taylor Blau wrote:
> Hi Konstantin,
>
> On Mon, Jun 13, 2022 at 04:31:45PM -0400, Konstantin Ryabitsev wrote:
> > As far as I know, the maintenance steps we are running shouldn't result in any
> > missing objects, so I'm curious if it's something we're doing wrong (using
> > unsafe flags) or if git isn't properly accounting for some objects that come
> > in during the repack stage. We're seeing this happen fairly routinely, so it's
> > not just a random fluke.
>
> [...]
>
> So I doubt that repack is doing something weird here, though it would be
> extremely interseting if you were able to pause the `repack` process at
> a specific point, push new objects into the repository, and reliably
> demonstrate the corruption.

A much more likely explanation for what is going on has to do with the
`--unpack-unreachable` option you're using.

In your example, any unreachable object written within the last day is
written loose, and anything else older than that is simply discarded. If
the following happens, in order:

  - an unreachable object is detected, and marked for deletion
  - that object then becomes reachable via some ref-update
  - then the object becomes an ancestor of some push which depends on it
  - _then_ the object is deleted by repack

...then the repository will be missing some objects which are in its
reachable set, and thus corrupt. IOW, the `--unpack-unreachable` option
(and its successor, cruft packs) are both racy with respect to
ref-updates.

Are you able to find evidence of that race in your logging? I would bet
that is likely what is going on here.

Thanks,
Taylor
