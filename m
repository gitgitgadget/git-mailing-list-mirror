Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D9C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 13:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B032070A
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 13:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+gTFdqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfLVN13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 08:27:29 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:33605 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfLVN13 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 08:27:29 -0500
Received: by mail-yw1-f48.google.com with SMTP id 192so6138883ywy.0
        for <git@vger.kernel.org>; Sun, 22 Dec 2019 05:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:in-reply-to:date:cc:subject:from:to
         :message-id;
        bh=OLmWq4ZqFfQ0qZgU4pJ1cov03Y91H661PfYtNXWQ3j8=;
        b=r+gTFdqGjrJZUVbqLCe8x3UurpbxaL6Qnngakea2+3m+lrJEvkmrG7Z4yRPM7Vww4e
         YH9q/9V8+jFsZuLebuYfVCg1nv1sYcXes2o9jlTPk53rCEehYfeMJrzE+z0+LceOytCj
         VBW8TJHq/pxP/PjIG35QfLm7QKR0Ec+UWk+knwzqT3k7d+jko1yp3OuC7tTInSmwgt7Y
         8UGCrPWa4zFxZDDcfhrO0S4cyh0tSCLcF+/JxmZd5OdVHBIvVMzsQ3vkTPFrzv7bLcWX
         RcZz4yZ5QTReCISCDF6d8BLclNelnslFA56NBAqy9CO0JezRCZtzo9RyyIvQIg/cVope
         DFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:in-reply-to:date:cc
         :subject:from:to:message-id;
        bh=OLmWq4ZqFfQ0qZgU4pJ1cov03Y91H661PfYtNXWQ3j8=;
        b=garW9a15eBYnrDgPzHSobyJMNflmUDuK/l5x/irKRgqJ/YaCRNwJi8esU55uzTTcBR
         IBo5WtLfDpG8IVYCa/BcUkYF3Xaw7utCIZoHVjijkhILgiQ8z0HqKROZFYEUMj829Wr+
         Nx9kaNwD5tnqh9yG04Vo5HdzAolQGIU6u+ue3DD2RV8yznukWmv5QeX9wZgUjl3+pKay
         61Ux+HSfMSvU75gyT8009WjsM/U/c6rh62mR3Vj/9siKUBLkdbZRS0SROij84H6AMSlY
         CptTSL/RJgQ0LhUn5P+gyDhjBswaOObAOpERzSYi6aHLzXc3bucehk0uOBtIAucZppkT
         06rQ==
X-Gm-Message-State: APjAAAV9T9h8W08l/oLt/RE+J1dD6luu6Rkxo95U9Wpfu0I8JejkcCKi
        KlL2ufkxyeFPMIPTBqb65ry5C7kE249SQw==
X-Google-Smtp-Source: APXvYqwhRLAlD4BDnZ8anv88vRjFcllzlWIA7ukM5dtDKheZfd9vguHVV3aL69eI11y6w/OYbrxSNg==
X-Received: by 2002:a81:6507:: with SMTP id z7mr18384483ywb.77.1577021247779;
        Sun, 22 Dec 2019 05:27:27 -0800 (PST)
Received: from localhost ([108.209.60.34])
        by smtp.gmail.com with ESMTPSA id l200sm6691768ywl.106.2019.12.22.05.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 05:27:27 -0800 (PST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191222075836.GA3425263@coredump.intra.peff.net>
Date:   Sun, 22 Dec 2019 07:14:55 -0600
Cc:     "Tom Miller" <jackerran@gmail.com>, <git@vger.kernel.org>
Subject: Re: Propose promoting 'contrib/rerere-train.sh' to command
From:   "Tom Miller" <jackerran@gmail.com>
To:     "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <BZBZ3Y9WU7J7.3PGDZKEYVQ165@penguin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun Dec 22, 2019 at 2:58 AM, Jeff King wrote:
> On Sat, Dec 21, 2019 at 03:52:53PM -0800, Junio C Hamano wrote:
>
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > > The situations where I need rerere-train don't come up often, but whe=
n
> > > they do, it has always worked easily and without hiccups for me. So
> > > perhaps there are lurking gotchas that Junio might know about, but AF=
AIK
> > > the quality is high enough for it to be part of normal Git.
> >=20
> > I actually suspect that rewriting has a high chance of initially
> > degrading the quality, so we should take a two step approach if we
> > really want it as part of the core distribution.  As to the UI, I
> > think "git rerere train a..b" would be a good one, but if the
> > scripted version is of high quality (I haven't looked at it for a
> > long time---even though I used it for a couple of times a year in
> > recent years), perhaps we can add it as "git-rerere--train"
> > subcommand that is spawned from "builtin/rerere.c" for the first
> > cut?
>
>=20
> Yeah, I'd be pretty happy with that, too.
>
>=20
> I just suspect its ultimate fate is conversion to C, given the general
> trend. And converting it to C that just calls out to other git commands
> via run_command would presumably behave just like the original, leaving
> the more challenging and error-prone conversion for later. Hopefully any
> upgrade to "real Git command" would include some tests, though. :)
>
>=20
> -Peff

Thanks for the feedback everyone! This is roughly the feedback I
expected. I think moving the shell version first will give more time to
focus on getting a strong test harness in place and a some decent
documentation. I happy with doing this in a multi phase approach as it
introduces less risk. When I get to the point of writing it in C I will
try to do the work internally by looking at commits as Jeff has
suggested, and fall back to run commands if I have to.
