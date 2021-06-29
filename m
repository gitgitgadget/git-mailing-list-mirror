Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893FBC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 14:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBF661DB4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 14:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhF2Okb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234256AbhF2Okb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jun 2021 10:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624977483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IlUeIW2+hQ8YF56IgIP1YOdSzePbiA1f/5qlTrlK4JQ=;
        b=NwMUU+WiAi8RDmGRfyAKn9KyCJiA9afbd1MmiCJp3z6BcNd1bKYmMMhe/KnBbOSmfmRvlv
        dTJY1Q4OySBOyM2tIGTQ5VO4trg/JKxnCps+hKotbSLGn1RfWOxQz5wksI+23VpkszWOd3
        bNTkq0i5qRvuc5vSusAEcXH3sfe9m3g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-rCE86LrQM4eFTFc8HE-Ckg-1; Tue, 29 Jun 2021 10:38:01 -0400
X-MC-Unique: rCE86LrQM4eFTFc8HE-Ckg-1
Received: by mail-ej1-f69.google.com with SMTP id c2-20020a170906d182b02904bf8ceef772so2139737ejz.7
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 07:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=IlUeIW2+hQ8YF56IgIP1YOdSzePbiA1f/5qlTrlK4JQ=;
        b=iTamiQK6kWu/mYKrvEf+CfjrKO6NfBivSHGPCmRMag/xC/SHOrc9p7cbKLUhRUuw3e
         co+7F+/WGQa0GxUTI8tQiU3DHg4ClF0TWjO+j9K2YnEl0WZtDnSCA/7boGaCO5ldSnVA
         e8EX+9rWETNXctqZ9jbCtI0O5VqtHXEKrcivwHeF636T/Kh/JA1dRF7x3v44niQysx0o
         4E4Q/ZA4E6xhDkXOO8Uj3cyTM4m2oHDuabiJGlZTXqg6SFFXlY7MQ+uwGzOOU+W/uTRL
         aubz9bwGWbGuMyqAmK/WjG0TqzSMjMKSprAX4cmxqJQfPbhR+vf7zrdOtI7stPaxvm9A
         +sDA==
X-Gm-Message-State: AOAM532Fy8ariFhniTBJEitm5HFOS2/Bw4Bd0O3WBzLoPRkQMdQsJR2+
        22jt3MvNxrc+O6LZ5vLFW8rJWOLvVJXVZ/b+TO2ZJI0wrYFkt9AEFXIriV/vlDCLmxZCchIwRoG
        +/vj6lGUKMWUrFOt/GI/P8JFzPwLc
X-Received: by 2002:a17:906:7e51:: with SMTP id z17mr4103247ejr.164.1624977480384;
        Tue, 29 Jun 2021 07:38:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRJtxAhcoksT/88aky6TSDKZE9NuzaBnu/2GlDxFNXEOD1dGi91sYpOeOKituChUELb5rxjbuTWsfwDNWEJKA=
X-Received: by 2002:a17:906:7e51:: with SMTP id z17mr4103237ejr.164.1624977480231;
 Tue, 29 Jun 2021 07:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+B51BHBoDn+xFXOXWe0SvRzzuPo+YYj63f0dyafJELbBTgGbw@mail.gmail.com>
 <YNslktip/qknZoFf@camp.crustytoothpaste.net>
In-Reply-To: <YNslktip/qknZoFf@camp.crustytoothpaste.net>
From:   Ondrej Pohorelsky <opohorel@redhat.com>
Date:   Tue, 29 Jun 2021 16:37:47 +0200
Message-ID: <CA+B51BGeqxryH6qZKAo3hbTZCFmprsHH4JYUkCFLVAMWGnV6_g@mail.gmail.com>
Subject: Re: GIT_TERMINAL_PROMPT environment variable isn't honored properly
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much for your explanation, this makes perfect sense now!

Best regards,
Ond=C5=99ej Poho=C5=99elsk=C3=BD

On Tue, Jun 29, 2021 at 3:53 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-06-29 at 13:46:44, Ondrej Pohorelsky wrote:
> > Hi, we've run into an issue when running git as part of an automated sy=
stem.
> >
> > When you set the GIT_TERMINAL_PROMPT environment variable as 0 you
> > expect git to die instead of trying to issue a prompt on the terminal.
> >
> >
> > $ GIT_TERMINAL_PROMPT=3D0
>
> When you write this in the shell, the shell doesn't by default export
> this variable to processes it invokes, like git.  If you want to do
> that, you need to write:
>
> $ export GIT_TERMINAL_PROMPT=3D0
>
> or
>
> $ GIT_TERMINAL_PROMPT=3D0
> $ export GIT_TERMINAL_PROMPT
>
> > $ echo $GIT_TERMINAL_PROMPT
> > 0
> > $ git clone https://github.com/some/non-existent-repo
> > Cloning into 'non-existent-repo'...
> > Username for 'https://github.com':
> >
> >
> > You get expected behaviour only when you set the GIT_TERMINAL_PROMPT
> > variable just before you run git clone.
> >
> >
> > $ GIT_TERMINAL_PROMPT=3D0 git clone https://github.com/some/non-existen=
t-repo
> > Cloning into 'non-existent-repo'...
> > fatal: could not read Username for 'https://github.com': terminal
> > prompts disabled
>
> When you write this, the variable is always exported to the command, sinc=
e
> it's not possible to use export here and otherwise this syntax wouldn't
> be very useful.
>
> Hopefully this explains why you're seeing some different behavior
> between the two situations.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

