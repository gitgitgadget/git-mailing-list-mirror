From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon, 3 Mar 2014 17:59:15 -0500
Message-ID: <CAPig+cQgYOz7rDax=HFNG9mr-H1FaoL-ss2mgdpMazPS4pWbNQ@mail.gmail.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:59:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbpQ-0003fg-G6
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbaCCW7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:59:16 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:57896 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbaCCW7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:59:16 -0500
Received: by mail-yh0-f42.google.com with SMTP id a41so4232184yho.15
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 14:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hXBRII9a2pNGtR01g25hJmslwWmLTZIIpwCxADBpDN4=;
        b=R+2W8imTuHPbmoyMLM5KeeKJURehf2edpZbgj5/3W28w7oPFaSoXsN0ozSPy50a9nr
         k3TgXARr+zUuKnDAZR2HqkDcwdPtRe1b3Wnhwxp1ezWtx2cQMnGPfYUGTqvnp4tEprmF
         g1wPCxe3T6Q4oMQW9zzjSxEuVXjnRPmPrgf45BVbSn2uyYFi/4JL9hUg6UODdPHAPBs2
         eiyCa0+OYbraKZnkATr9+8z4Mtx1T3tHrgGtwcR+B8BoaRB93A3Y8KEMXioKGf62Ez5l
         IpnTtMV0pl6ExkG959L0bi6q+gH24R4Y0utFP3lVu7C0YO7lnPqj3OthqsK/dvf4PDzR
         wPQg==
X-Received: by 10.236.46.18 with SMTP id q18mr25111426yhb.21.1393887555559;
 Mon, 03 Mar 2014 14:59:15 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 14:59:15 -0800 (PST)
In-Reply-To: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
X-Google-Sender-Auth: yLU7a3VEpJg9qDCuViIPf8JDuYU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243298>

On Mon, Mar 3, 2014 at 5:24 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
> We used to show "(missing )" next to tests skipped because they are
> specified in GIT_SKIP_TESTS.  Use "(matched by GIT_SKIP_TESTS)" instead.

Bikeshedding: That's pretty verbose. Perhaps just say "(excluded)"?

> ---
>  t/test-lib.sh |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1531c24..89a405b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -446,25 +446,28 @@ test_finish_ () {
>
>  test_skip () {
>         to_skip=
> +       skipped_reason=
>         if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
>         then
>                 to_skip=t
> +               skipped_reason="matched GIT_SKIP_TESTS"
>         fi
>         if test -z "$to_skip" && test -n "$test_prereq" &&
>            ! test_have_prereq "$test_prereq"
>         then
>                 to_skip=t
> -       fi
> -       case "$to_skip" in
> -       t)
> +
>                 of_prereq=
>                 if test "$missing_prereq" != "$test_prereq"
>                 then
>                         of_prereq=" of $test_prereq"
>                 fi
> -
> +               skipped_reason="missing $missing_prereq${of_prereq}"
> +       fi
> +       case "$to_skip" in
> +       t)
>                 say_color skip >&3 "skipping test: $@"
> -               say_color skip "ok $test_count # skip $1 (missing $missing_prereq${of_prereq})"
> +               say_color skip "ok $test_count # skip $1 ($skipped_reason)"
>                 : true
>                 ;;
>         *)
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
