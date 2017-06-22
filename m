Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158F820802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753465AbdFVUid (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:38:33 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35383 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFVUic (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:38:32 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so13801575pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H1dByqk1D0SK5c6ieLSlqqguLzcNXZ92ZdaiagmWqqs=;
        b=oSK2mGCeodQQEZL32ZRLBAWzX3pQO56R+5Dfuq/qsy641YHYbSDfApB4XcaarJvM2z
         uMcOHBf3YFOvlFxAITwm80Ckkg4647gJm9NDD9YH4q1cEzPDhT8AT6jNJzEQr1wCCe5g
         dA04EqH23HVnSy7nIsit4I1XiqWM9rSoZ7FzT2mwEhS4ubNvJ7KWuL476j0d8iXhzEvt
         0ZrbtymLcy4eZYzaT0qTgqvk/izcJ0vaAUnMaKEVrM2Dp3E7UO1iabpWVRNSuEOZomHz
         yXm9VDeeHoI83xC8dGFg8j8OUa/BYWweoVnI4Ju7osxgCAyiZiPf8n4ftrpSTrceIXvC
         zl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H1dByqk1D0SK5c6ieLSlqqguLzcNXZ92ZdaiagmWqqs=;
        b=OVMgFtOOOjaQ0LBMlKdQ0GsQ/3u3w2VmL1xuroYyGMqdHoS58XhZnfHMWgP2NWmzP/
         MiCDNezQpyN0IIfxos62I/u1xp68wnQaZZzIPW4S9WKeZW28+JtIH3TpmKWruWO30uwF
         2ENkm7MTiBji52WhWdcXUPdT02Q61CrqA1iTaUtxg3HuWNIsfiLOer/5xsKUGH553ueY
         OHjjrIDyf8NTZ8Uj2GExdK+LKZD6LIcbllMR3Jxr98p5jlGEXcORil+40lRhP2AYQVZN
         8Kax3kPcnkZQNtp8yjCy0vDOF+tOJwe0LtrqEj119tfT55D/PrcXSbCtUz8zDds3pbQH
         Awsw==
X-Gm-Message-State: AKS2vOxde2uEZrEUFsprLrJDLW0kN+GxeankHAeUTKKtqfYgjqxTcKey
        OFd0yZp7WgphNP7trnKxgGh+J9YNviVa
X-Received: by 10.98.85.196 with SMTP id j187mr4444631pfb.19.1498163911296;
 Thu, 22 Jun 2017 13:38:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Thu, 22 Jun 2017 13:38:30 -0700 (PDT)
In-Reply-To: <20170622195245.11252-1-orgads@gmail.com>
References: <20170622195245.11252-1-orgads@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Jun 2017 13:38:30 -0700
Message-ID: <CAGZ79kYFcZ_wMQ5grH-keFpnf=V7Y=3KkAJEH3AuoZYMDvqTTQ@mail.gmail.com>
Subject: Re: [PATCH] name-rev: Fix tag lookup on repository with mixed types
 of tags
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 12:52 PM,  <orgads@gmail.com> wrote:
> From: Orgad Shaneh <orgads@gmail.com>
>
> Commit 7550424804 (name-rev: include taggerdate in considering the best
> name) introduced a bug in name-rev.
>
> If a repository has both annotated and non-annotated tags, annotated
> tag will always win, even if it was created decades after the commit.
>
> Consider a repository that always used non-annotated tags, and at some
> point started using annotated tags - name-rev --tags will return the
> first annotated tags for all the old commits (in our repository it is
> followed by ~5067 for one commit, or by ~120^2~21^2~88^2~87 for
> another...). This is obviously not what the user expects.
>
> The taggerdate should only be matched if *both tags* have it.

Please sign off the patch. See https://developercertificate.org/
or Documentation/SubmittingPatches

> ---
>  builtin/name-rev.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 92a5d8a5d2..8f77023482 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -46,11 +46,13 @@ static void name_rev(struct commit *commit,
>                 commit->util = name;
>                 goto copy_data;
>         } else if (name->taggerdate > taggerdate ||
> -                       (name->taggerdate == taggerdate &&
> +                       ((taggerdate == ULONG_MAX || name->taggerdate == taggerdate) &&
>                          name->distance > distance)) {
>  copy_data:
>                 name->tip_name = tip_name;
> -               name->taggerdate = taggerdate;
> +               if (taggerdate != ULONG_MAX) {
> +                       name->taggerdate = taggerdate;
> +               }

style: you may omit the braces for a single statement
after if.

>                 name->generation = generation;
>                 name->distance = distance;
>         } else
> --
> 2.13.1.windows.1.1.ga36e14b3aa
>
