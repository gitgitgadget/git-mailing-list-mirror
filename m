From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] stop putting argv[0] dirname at front of PATH
Date: Wed, 22 Apr 2015 14:23:27 -0400
Message-ID: <CAPig+cR1aAk053Lptq-vpsKtVP2nt9RF9YJxhNSicshEk7Ps7g@mail.gmail.com>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
	<xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
	<CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
	<20150416061732.GA5612@peff.net>
	<xmqq1tjcf432.fsf@gitster.dls.corp.google.com>
	<20150422181402.GB3535@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?David_Rodr=C3=ADguez?= <deivid.rodriguez@gmail.com>,
	Matthew Rothenberg <mroth@khanacademy.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 20:23:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkzJ6-0002MY-N3
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 20:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489AbbDVSX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 14:23:28 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34863 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbbDVSX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 14:23:27 -0400
Received: by igbyr2 with SMTP id yr2so4237052igb.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mKVyJLItJDxb40T4XkhNBI5x15yqcwZdi79016sn0j0=;
        b=YZ2HrbjWEgJfMLXNtGwnYnv2gkvCvh7Pe7DlWlu5VKTK0vZ+z4mvBc3l/lVwT968h6
         0x6yZUVU84/8wwJ6ouoKsvKeyLKokvU2iwwwQv8NMxUq1ovxC8f99JYj7EjPHVy59UEz
         KIg/DIEv67VtAaZvGcQPLTZO41xmErbkU+3TfNdBvAxRXNRQ5wzrOs+4/2A7Qn21MLXa
         tD/KNVOjh1zsO/aKo6+X0qbBecXc1OHJPiSFRdkw2n37jrSPZ7W9+cLVomVEWnq932CF
         f87h5kJGtIcjYQy2/IxWRxgX/3/HxA5WOFc4b/iNDbs4DeSr0yTihrw22Lp3hEZePoXb
         nC5A==
X-Received: by 10.50.66.230 with SMTP id i6mr6562853igt.22.1429727007178; Wed,
 22 Apr 2015 11:23:27 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 22 Apr 2015 11:23:27 -0700 (PDT)
In-Reply-To: <20150422181402.GB3535@peff.net>
X-Google-Sender-Auth: PuO1kEpHD35IIUgPOo-MYuY42fI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267607>

On Wed, Apr 22, 2015 at 2:14 PM, Jeff King <peff@peff.net> wrote:
> Subject: stop putting argv[0] dirname at front of PATH
>
> When the "git" wrapper is invoked, we prepend the baked-in
> exec-path to our PATH, so that any sub-processes we exec
> will all find the git-foo commands that match the wrapper
> version.
> [...]
> Given that the main motivation for git pulling the argv[0]

s/pulling/putting/

> dirname into the PATH has been broken for years, that the
> remaining cases are obscure and unlikely (and easily fixed
> by the user just setting up their $PATH sanely), and that
> the behavior is hurting real, reasonably common use cases,
> it's not worth continuing to do so.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 8ab37b5..e85f0fd 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -96,7 +96,6 @@ void setup_path(void)
>         struct strbuf new_path = STRBUF_INIT;
>
>         add_path(&new_path, git_exec_path());
> -       add_path(&new_path, argv0_path);
>
>         if (old_path)
>                 strbuf_addstr(&new_path, old_path);
> --
> 2.4.0.rc2.498.g02440db
