Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F7C2BB85
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623B92072A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqMxG5ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgDGPGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:06:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46065 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgDGPGx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:06:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id l22so1751329oii.12
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZWw+hjDsNCLef4wGJtQuAn8zjJb2PTZEGKPqhr8TG4=;
        b=eqMxG5ksh+6j9cuZShWC0SQOYK4GlGEC8OW3Bq4zSpU6eMHoe4jfTf5w2H6lkrZ+vS
         JZjyBdaCfEjwXSlFVcAq4fCTtXo4OBg8ugILFezEyYj6k+lB6DNAkL9RrEm1+Cs9+zj9
         1I9WtxPhAyJZhmm2Apl79f00U3497CyyUiAzavLMPYYV/0BHSjdj81jkuMmpcPb6PbDB
         ia1dHhXBUCkZDbJiOUbfb/dzKHoncWw3OpBPG0nhLsCaF2NGjCrXnXcPlOeqs0O9Z6fH
         smd+iOlvbtM5TK2gf07+8N0q8gkKmrOJpQcAuxcvu4rWFwfPbxYRinxVem7yPBXDYW1Z
         FJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZWw+hjDsNCLef4wGJtQuAn8zjJb2PTZEGKPqhr8TG4=;
        b=GMfL260rmB6teFG48cwbFYKI55674kG1A1BK6YvohQpr4bNhfF9eeFBIf29Q+SH+Eb
         C5UNrg0TERa61iclsYMekgWK0+7+kC9ElpnT7PMMAZAjcgHKPi+PHATmvZC/L8WIeiln
         KIxM4atgVLXDocCppfz5iDhN7mvqAAsEGWfdoUDugWoFUzsr4Vm8kP90Euh9EWUKhzzQ
         DZH5UMiBJxJTcSWfVjkNFpkFyTnMFwmq+HOyupz0qpgHlkz2ukZP4h44RQVJTzhidQlP
         FwsXVAu8qAyCJTt3p4HVQ50Bmo7eJY60LsUCECyuayRzQTPHDXu+Jse3XSe1xyiaAWay
         qM5w==
X-Gm-Message-State: AGi0PuZcViiYUX5nXojuuiY7wRYxegxCzBljWk58ZgiibRZf4/sK+5de
        erEcRnSpEluw3JObUgIt/bkryPYXlxTJo3wJET1Et3Z9
X-Google-Smtp-Source: APiQypJqwYDUXtBHIajIdTYBVR2r6UoNnYlyp/nBUJ22YsZlLPp7VI93N/aWYO9oScZrQbGK5+kGgVSXMLlOkr5vJd4=
X-Received: by 2002:aca:4b84:: with SMTP id y126mr2008761oia.31.1586272012781;
 Tue, 07 Apr 2020 08:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200407141125.30872-6-phillip.wood123@gmail.com>
In-Reply-To: <20200407141125.30872-6-phillip.wood123@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 08:06:41 -0700
Message-ID: <CABPp-BEr8dHY1f6trPBMAZxoP7a3SbtNZahLA4pj6rNomAMLZg@mail.gmail.com>
Subject: Re: [PATCH 5/6] Revert "sequencer: allow callers of
 read_author_script() to ignore fields"
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This reverts commit c068bcc59b4f16322a77b6a47b53d44b05c51fec.
>
> This functionality is no longer used as since the last commit we always
> want all of the fields returned.

That's a little hard to parse.  Maybe s/used as since/used; since/ ?

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 56f6e49289..17c7b18245 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -825,19 +825,9 @@ int read_author_script(const char *path, char **name, char **email, char **date,
>                 error(_("missing 'GIT_AUTHOR_DATE'"));
>         if (date_i < 0 || email_i < 0 || date_i < 0 || err)
>                 goto finish;
> -
> -       if (name)
> -               *name = kv.items[name_i].util;
> -       else
> -               free(kv.items[name_i].util);
> -       if (email)
> -               *email = kv.items[email_i].util;
> -       else
> -               free(kv.items[email_i].util);
> -       if (date)
> -               *date = kv.items[date_i].util;
> -       else
> -               free(kv.items[date_i].util);
> +       *name = kv.items[name_i].util;
> +       *email = kv.items[email_i].util;
> +       *date = kv.items[date_i].util;
>         retval = 0;
>  finish:
>         string_list_clear(&kv, !!retval);
> --
> 2.26.0
>
