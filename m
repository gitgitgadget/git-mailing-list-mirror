From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 07/19] for-each-ref: add '--merged' and '--no-merged' options
Date: Mon, 22 Jun 2015 18:41:39 -0400
Message-ID: <CAPig+cQLHX2spg00Zn1J=PMg_cuy2ARuWPOQQXLT1yLoQZ_SFg@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
	<1434919705-4884-1-git-send-email-karthik.188@gmail.com>
	<1434919705-4884-7-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:41:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7APV-0004So-2R
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 00:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbbFVWlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 18:41:45 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35333 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbbFVWlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 18:41:40 -0400
Received: by ykdy1 with SMTP id y1so31254810ykd.2
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tcNbMTo6dkZiuvn1Ybu1GyGNIY0kjghqYel7A7zKGRM=;
        b=fUZWA/sKzrStjhrVrAQOhEdNGAIa8R4uU/ABuw+zqEdlr64X3T3E2/Vj0xlDoZ1NiA
         XdX4P8A1AHhs76Lx7aZiRUGOMNj2RabDVRT4J6Xum9Py6aQff4fDwyw1xgkDt3PJ48pA
         jAcfKXRsCm/Jye/AMt5HRMsx3amWGdvff2fgG4OqM1TwY3m7ZvVzcYBymeVJdUhGjNjJ
         YWWJqHp4tnj9TPjmw2fwa+1TybgCv2QnqK7GwMk4D+8HoOM/n2wpKL0RAcLvwPwY/tup
         xT2ZGXn6MvKXFtBehy9EGe1UOOp0mdDtWv+FH/CRBs1xWfFl0a8MpgUgb8Ct0/PcCax/
         Xtqw==
X-Received: by 10.170.97.9 with SMTP id o9mr39168118yka.84.1435012899733; Mon,
 22 Jun 2015 15:41:39 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Mon, 22 Jun 2015 15:41:39 -0700 (PDT)
In-Reply-To: <1434919705-4884-7-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: SzgmaGCS5Dpfm1pNuEeZlDo8cV0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272431>

On Sun, Jun 21, 2015 at 4:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add the '--merged' and '--no-merged' options provided by 'ref-filter'.
> The '--merged' option lets the user to only list refs merged into the
> named commit. The '--no-merged' option lets the user to only list refs
> not merged into the named commit.
>
> Add documentation and tests for the same.
>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 0ede41d..c6dcd99 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
>                    [(--sort=<key>)...] [--format=<format>] [<pattern>...]
> -                  [--points-at <object>]
> +                  [--points-at <object>] [(--merged | --no-merged) <object>]

According to the documentation you added to the OPTIONS section, the
object following --merged and --no-merged is optional. Therefore,
shouldn't this be s/<object>/[<object>]/ ?

Also, in the OPTIONS section, you spelled it "commit" rather than "object".

>  DESCRIPTION
>  -----------
> @@ -66,6 +66,14 @@ OPTIONS
>  --points-at <object>::
>         Only list refs pointing to the given object.
>
> +--merged [<commit>]::
> +       Only list refs whose tips are reachable from the
> +       specified commit (HEAD if not specified).
> +
> +--no-merged [<commit>]::
> +       Only list refs whose tips are not reachable from the
> +       specified commit (HEAD if not specified).
> +
>  FIELD NAMES
>  -----------
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 46f9b05..09d48da 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -8,6 +8,7 @@
>  static char const * const for_each_ref_usage[] = {
>         N_("git for-each-ref [<options>] [<pattern>]"),
>         N_("git for-each-ref [--points-at <object>]"),
> +       N_("git for-each-ref [(--merged | --no-merged) <object>]"),

Ditto: s/<object>/[<object>]/

>         NULL
>  };
