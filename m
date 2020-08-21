Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410F5C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105AB20724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYQarT5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHUT4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726593AbgHUT4I (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Aug 2020 15:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598039766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rXPptV5IoHq19Mr7lJ6o8NzD6v3UGPD6sqtkMQ8IyQM=;
        b=KYQarT5yQUhkV2clxffzeP8K5rIqpYr9cGcq6S4lgq5RHxzVDOjIgydpceC9kbbwBuvek0
        3uOcYhs9Om3TvQSF+bpo0zItIwJm5ZSYC3d/r1rZVXQ0WOTrUwdIBSiEVv2XtZRomKt+gf
        Gb4H6yHbs9woiTVuQPxbtp6PmOmb3Wc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Pv3ZA9-YPQCtRWqFtvn7jA-1; Fri, 21 Aug 2020 15:56:03 -0400
X-MC-Unique: Pv3ZA9-YPQCtRWqFtvn7jA-1
Received: by mail-pf1-f199.google.com with SMTP id y11so1964573pfq.8
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 12:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXPptV5IoHq19Mr7lJ6o8NzD6v3UGPD6sqtkMQ8IyQM=;
        b=duv3nScWW0speWH1GnQ9wuU8wUuYgzfRejzO6Ot6w7+yjeemZu60SjIOub8eGqmCva
         1MslXmuudS59cmYzNKzizpUQFj0N9X4aLFvy1VFx22NonOpKytRpHosFCWFRAr/hW3hi
         QH1LV1d1adhWpZe5CZPr+pP0Hjk5Dpg3+tuIoAKEF+MG8nMoguNMq9BrapP548bxbiva
         R4k2tJ4XuGjeODT9fyIdWGhK8HLRfEjl2nLZXFBKgjX/7pTo7f80PmSjPg08rw7wogZe
         ottFu2W4pWbQofLMZduFAMEa3IGFJo9cgbdyP1v666doklmKWqFMJEfLTStWoh4CSPbz
         6A3A==
X-Gm-Message-State: AOAM531NPVMwEJpNeYnPzLmk90dhoIW/KeJWMce7lZwwn+nCEypHZZaF
        d8RxyB05Bhie4BfFOcLM9MrzgrWVOO9osli2hkTQ65PmLV8ef1ZJFOgeqpduVu22zFSNqgu4dkN
        rsIPmKbTDV7CHxQYC0/UUjZrckF6t
X-Received: by 2002:a65:6882:: with SMTP id e2mr3485796pgt.290.1598039762611;
        Fri, 21 Aug 2020 12:56:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo8K5ooNIWxp/Hg4WiXxQg/IdHVNClRIbwyDCTzBi5YK9nsDJf4ME0R1YpD4zYuLf8UbHrKCK6p3b+c6Rj3YU=
X-Received: by 2002:a65:6882:: with SMTP id e2mr3485772pgt.290.1598039762195;
 Fri, 21 Aug 2020 12:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
 <87ft8fvoow.fsf@igel.home> <xmqqr1rz96ry.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1rz96ry.fsf@gitster.c.googlers.com>
From:   Alvaro Aleman <aaleman@redhat.com>
Date:   Fri, 21 Aug 2020 15:55:51 -0400
Message-ID: <CAOW=8D3WZyoc=PpyzmPRYM2MT_=F4tnuTxJ0Z+_dHMb4Xk8imQ@mail.gmail.com>
Subject: Re: --author arg on commit only works if there is an email configured already
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the explanation. Yes, having the error explicitly
mention t about which of author/committer this is would be helpful.

On Fri, Aug 21, 2020 at 2:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Andreas Schwab <schwab@linux-m68k.org> writes:
>
> > On Aug 21 2020, Alvaro Aleman wrote:
> >
> >> It seems the `--author` arg on the `git commit` command only works if
> >> an author email is configured already somewhere:
> >
> > The `--author' argument only sets the author, but git still need to fill
> > in the committer.
>
> In other words, the --author option works just fine.  You still need
> to tell Git what committer identity you want to use, and the easiest
> way to do so is with user.{name,email} configuration variables.
>
> I wonder if it helps to give an extra line of message like the
> attached (untested) patch, though.
>
>  ident.c | 51 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index e666ee4e59..177ac00261 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -345,18 +345,35 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
>         return 0;
>  }
>
> -static const char *env_hint =
> -N_("\n"
> -   "*** Please tell me who you are.\n"
> -   "\n"
> -   "Run\n"
> -   "\n"
> -   "  git config --global user.email \"you@example.com\"\n"
> -   "  git config --global user.name \"Your Name\"\n"
> -   "\n"
> -   "to set your account\'s default identity.\n"
> -   "Omit --global to set the identity only in this repository.\n"
> -   "\n");
> +
> +static void ident_env_hint(enum want_ident whose_ident)
> +{
> +       static const char *env_hint =
> +               N_("\n"
> +                  "*** Please tell me who you are.\n"
> +                  "\n"
> +                  "Run\n"
> +                  "\n"
> +                  "  git config --global user.email \"you@example.com\"\n"
> +                  "  git config --global user.name \"Your Name\"\n"
> +                  "\n"
> +                  "to set your account\'s default identity.\n"
> +                  "Omit --global to set the identity only in this repository.\n"
> +                  "\n");
> +
> +       switch (whose_ident) {
> +       case WANT_AUTHOR_IDENT:
> +               fputs(_("Author identity unknown\n"), stderr);
> +               break;
> +       case WANT_COMMITTER_IDENT:
> +               fputs(_("Committer identity unknown\n"), stderr);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       fputs(_(env_hint), stderr);
> +}
>
>  const char *fmt_ident(const char *name, const char *email,
>                       enum want_ident whose_ident, const char *date_str, int flag)
> @@ -375,12 +392,12 @@ const char *fmt_ident(const char *name, const char *email,
>         if (!email) {
>                 if (strict && ident_use_config_only
>                     && !(ident_config_given & IDENT_MAIL_GIVEN)) {
> -                       fputs(_(env_hint), stderr);
> +                       ident_env_hint(whose_ident);
>                         die(_("no email was given and auto-detection is disabled"));
>                 }
>                 email = ident_default_email();
>                 if (strict && default_email_is_bogus) {
> -                       fputs(_(env_hint), stderr);
> +                       ident_env_hint(whose_ident);
>                         die(_("unable to auto-detect email address (got '%s')"), email);
>                 }
>         }
> @@ -397,13 +414,13 @@ const char *fmt_ident(const char *name, const char *email,
>                 if (!name) {
>                         if (strict && ident_use_config_only
>                             && !(ident_config_given & IDENT_NAME_GIVEN)) {
> -                               fputs(_(env_hint), stderr);
> +                               ident_env_hint(whose_ident);
>                                 die(_("no name was given and auto-detection is disabled"));
>                         }
>                         name = ident_default_name();
>                         using_default = 1;
>                         if (strict && default_name_is_bogus) {
> -                               fputs(_(env_hint), stderr);
> +                               ident_env_hint(whose_ident);
>                                 die(_("unable to auto-detect name (got '%s')"), name);
>                         }
>                 }
> @@ -411,7 +428,7 @@ const char *fmt_ident(const char *name, const char *email,
>                         struct passwd *pw;
>                         if (strict) {
>                                 if (using_default)
> -                                       fputs(_(env_hint), stderr);
> +                                       ident_env_hint(whose_ident);
>                                 die(_("empty ident name (for <%s>) not allowed"), email);
>                         }
>                         pw = xgetpwuid_self(NULL);
>

