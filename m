Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DDFC433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359252AbhK1U6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 15:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357906AbhK1U4L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 15:56:11 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0A0C06175E
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 12:52:54 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id j14so29666211uan.10
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 12:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jWh7vk57ChuS39zjjA7VhAbppsrAXz6SrxUfznhncJY=;
        b=fa5TAA+yStAtZJBkpGAnIS0nsuR4GrCTHiHtqqbvxJ2cYJhW42cTZliHg9sB9B1I+l
         9YuzRljelQZIZ/qFAR8wM0fdQdJgH/Hf9OqC0nO/V/4PUHGSoqVDdSwNnFF1G0CqAuWQ
         oKIDJ6v3HyzVE3M7DC6a+yLnwA6APsCDcy28MB6xtoJ7j4Ql2LSPYPQp/ly4cXrVj3ZX
         w43B57/wdCKyqv3td2Ib9DyUOyFUjYep/2MPziEDZgnzfT2txNnjPM3H+LJ1fgC8joTN
         e68vIp9GK/LLhuR2v7abhqnyR7Pk19s19DeY2uywcLD3eq/dhUto0kWoJKDNIP7NXHXl
         IEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jWh7vk57ChuS39zjjA7VhAbppsrAXz6SrxUfznhncJY=;
        b=txLZABONRQWaAilpCkyMZPed2dHbkvyeLmj2kh/PXfrtSU54kM4akrwFTcpgVC6GPM
         XKHktelWmXeb+/eeq0Ymv+hsT5BXTCIhaIterd7VfvGO9Nr3Jeg21V1AfceVWn1sALls
         palqQIydS/k7p5iS5n9QJx3/mPqRFvs+jSZEFetoEakjcEp1usG/ZqNulOWJmoKgOMCs
         pVsLpOh0+wKromL3dzimXGFFJ+BBncRpfI2CvFuXg2K6NW4BNjhtNX1dUEva/91IbC9i
         kvH66lRd/7nt4UAwIAc/5rJVpXsvha4HBQyS2geWBcpFyli93441IA59oQr10wa7lfnS
         PDbw==
X-Gm-Message-State: AOAM533c9KJ4GGhOb6RpqMwiwhePJOGkwnmF7mI9Q5TCeLtDI7MteAYg
        OmOQFX0z8ld7a7SC5w/qFtvjOYAHmL4MVuxebagMnPjO
X-Google-Smtp-Source: ABdhPJxOD80lkJnlgZYs0n1Mu+6cAAZyiFdaKz0l5amUnHvRC0pMiCd3wIWna3/O+C2u2NsWO+g6szKtlsdNe1SmI0Y=
X-Received: by 2002:a67:bb11:: with SMTP id m17mr29141523vsn.5.1638132773645;
 Sun, 28 Nov 2021 12:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20211128174903.5623-1-carenas@gmail.com> <xmqq8rx85ala.fsf@gitster.g>
In-Reply-To: <xmqq8rx85ala.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 28 Nov 2021 12:52:39 -0800
Message-ID: <CAPUEspjo+cKLnE+MoABp_NnGDCCz8fL=pJj3ZNsKmCVetUn1jA@mail.gmail.com>
Subject: Re: [PATCH] add -p: avoid use of undefined $key when ReadKey -> EOF
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, tr@thomasrast.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 28, 2021 at 11:44 AM Junio C Hamano <gitster@pobox.com> wrote:
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
> > Add a test for undefined and encapsulate the loop and the original
> > print that relied on it within it.
>
> I wondered where a change to t/ directory was, but we are not
> talking about that kind of test ;-)  OK.

Will change the wording in v2 with something less ambiguous like
"Check for undefined.."

> I am undecided, but the minimum patch below seems to makes the above
> intention in the updated code clearer.
>
> diff --git i/git-add--interactive.perl w/git-add--interactive.perl
> index bc3a1e8eff..c459c675e7 100755
> --- i/git-add--interactive.perl
> +++ w/git-add--interactive.perl
> @@ -1175,7 +1175,7 @@ sub prompt_single_character {
>                 ReadMode 'cbreak';
>                 my $key =3D ReadKey 0;
>                 ReadMode 'restore';
> -               if ($use_termcap and $key eq "\e") {
> +               if (defined $key && $use_termcap and $key eq "\e") {
>                         while (!defined $term_escapes{$key}) {
>                                 my $next =3D ReadKey 0.5;
>                                 last if (!defined $next);

The issue I had with that was that the order of the checks is slightly
awkward and inefficient (ex: $use_termcap =3D false probably should
short circuit, and both checks for $key make more sense next to each
other) and doing it outside avoids the extra !defined check for print.

It would also look cleaner IMHO if the expression would be rewritten
to use '&&' instead of 'and', which smells like unnecessary
refactoring that I intentionally tried to avoid by creating a
precondition instead so `diff -w` is really small and straight
forward.

I have no strong opinions eitherway, so let me know what you would
prefer and will get a v2 with it; thanks for reviewing.

Carlo

PS. list email is for whatever reason taking a long time to arrive
from vger, hopefully not many are affected, but I might be slow to
respond
