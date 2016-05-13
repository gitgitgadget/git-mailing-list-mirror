From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/6] t9107: use "return 1" instead of "exit 1"
Date: Fri, 13 May 2016 19:45:42 -0400
Message-ID: <CAPig+cQKkkP=Go=w65mGcgqZN6ckz21kG2=KCJS8L+0D3mgC+g@mail.gmail.com>
References: <20160513204654.GA10684@sigill.intra.peff.net>
	<20160513204721.GC15391@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 14 01:45:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1MmC-0008NA-LI
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbcEMXpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:45:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35275 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbcEMXpn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:45:43 -0400
Received: by mail-io0-f196.google.com with SMTP id i75so5872761ioa.2
        for <git@vger.kernel.org>; Fri, 13 May 2016 16:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=KPfmXn8lWP8ugweeXsHqZwAsqV/RIjbRR78S1zdUs4Q=;
        b=xf+rU7YeknUraBrk30m/wH3Kjx3gveSTSuQjcOBF2XKtUjvllsg/9ebbW49p4ylaYE
         wZQ63ejYkTKTsnEsKrEQ5SOxwyc0XQ7wHdZ3mHE8NBK26WiFjDGW37WMi0+V7BNwZ9mL
         OkMd+pibFYnDqZ+JDoH7HvuHgHln3a6hyre0X7j2+l7CyInsO7X8qMUvF5WhuruuI9ND
         IDtVsh+jS8XKLGhhskmvRBLs/2B8mepW5pDtfuzZM2LgEbU1rQoYdpaRadubh0TMtCWi
         ki+Nfv6Eod/Dh4YcA80bVdo4enV1WD0XV/I2BAxZgatmGrBglIL0DFrCRGkE+CW8cQqQ
         tHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=KPfmXn8lWP8ugweeXsHqZwAsqV/RIjbRR78S1zdUs4Q=;
        b=HTN00s7UULByt0olAYUr4nIEkPwHcRBv3lDdMmrSvkpPL+nfNRoEPl2dGKnpv2gWmi
         jtC59meZzYSPZabJRaQWR1byjMCyJi815P+w65FQ4qzA9TzL3Z3YLsdR8NhEGR27cc0K
         DfhIvnKZ4xyJhyyanwzPS6fzTyn5UpEdH77feBDsdaqqyl1YiPp1zPAFh4tz/+bsRdKf
         2HyjId9gmHqR8tgPBG5QwJaUUXBkk8zvaW/n6Cs6Um2JLWkcVyAoU45NREOoHTGCLv/o
         ahG+yK7nnwPBTxdkJFLcgTjQLINGgIyAaf3qWZWWjaYHRy6pFMIJ1skjPs0LpH8YzeSW
         QlkA==
X-Gm-Message-State: AOPr4FWoX0rzHG8bi4jZeR/W6A5SHPn7iGMR5WbWR/VVdKQVyp4lPM4afj+zcD8lI8dHO3fsjHdDLIWM0/VbZw==
X-Received: by 10.36.31.65 with SMTP id d62mr3488216itd.84.1463183142853; Fri,
 13 May 2016 16:45:42 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Fri, 13 May 2016 16:45:42 -0700 (PDT)
In-Reply-To: <20160513204721.GC15391@sigill.intra.peff.net>
X-Google-Sender-Auth: NSj24eTQ_btRVe59xJsIgMkiN34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294599>

On Fri, May 13, 2016 at 4:47 PM, Jeff King <peff@peff.net> wrote:
> When a test runs a loop, it cannot rely on the usual
> &&-chaining to propagate a failure inside the loop; it needs
> to break out with a failure signal. However, unless you are
> in a subshell, doing so with "exit 1" will exit the entire
> test script, not just the test snippet we are in (and cause
> the harness to complain that test_done was never reached).
> [...snip...]
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
> @@ -70,30 +72,38 @@ test_expect_success 'initialize a multi-repository repo' '
>  # refs should all be different, but the trees should all be the same:
> -test_expect_success 'multi-fetch works on partial urls + paths' "
> +test_expect_success 'multi-fetch works on partial urls + paths' '
> +       refs="trunk a b tags/0.1 tags/0.2 tags/0.3" &&
>         git svn multi-fetch &&
> -       for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
> -               git rev-parse --verify refs/remotes/origin/\$i^0 >> refs.out || exit 1;
> -           done &&
> -       test -z \"\$(sort < refs.out | uniq -d)\" &&
> -       for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
> -         for j in trunk a b tags/0.1 tags/0.2 tags/0.3; do
> -               if test \$j != \$i; then continue; fi
> -           test -z \"\$(git diff refs/remotes/origin/\$i \
> -                                refs/remotes/origin/\$j)\" ||exit 1; done; done
> -       "
> +       for i in $refs
> +       do
> +               git rev-parse --verify refs/remotes/origin/$i^0 || return 1;
> +       done >refs.out &&
> +       test -z "$(sort <refs.out | uniq -d)" &&
> +       >expect &&

What's this 'expect' file for? Is it leftover gunk from before you
settled on 'diff --exit-code'?

> +       for i in $refs
> +       do
> +               for j in $refs
> +               do
> +                       git diff --exit-code refs/remotes/origin/$i refs/remotes/origin/$j ||
> +                               return 1
> +               done
> +       done
> +'
