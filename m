Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC60C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 07:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32F5206D5
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 07:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOwEbPM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfLHHtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 02:49:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41727 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfLHHtL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 02:49:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so9547058otc.8
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 23:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BST8B9DrSIxlYBdwDFXYZva5Fsdj4GzPoWQX2hhhcvs=;
        b=BOwEbPM06p+otuchFGQ8OGhsvXYj6dKuyK9ObLRecENLddbh6YuYc0hIuHT9dDi44v
         YAucIVXwKeI9VTyfE+4nC3U6Q0fPc7qyCTMJC6YQE3pabKKnZCTV8Ep/nrBKM5KIeiEk
         LQ4SYBalQglP+v28L0RoagUlw3uwqH9EmaM7M2tuvHOFXxfrUX5L/7a7EEhTsVcGTcAM
         CPZRpPswutDHu1oM1D/P7d/9pTyR9yNxnpX3fCdAjRxClsPFDsWGmGoMP/EiKJhipYhy
         BwZCxBbf/gog74dNfSzFf0ZewCiNcaB0frA47FB4R5Uf/KM8E1y0/qyQuy4GoM+0jzlG
         SGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BST8B9DrSIxlYBdwDFXYZva5Fsdj4GzPoWQX2hhhcvs=;
        b=DJeZnaH1nOx6ScB8pcWwr3xqwcNetGgRfeD3Ndz20B1ux5H27L4oejFFQDVToGalsU
         +bN753TYfeHNxjObcL1JJPKhl7wLoNyQTobsyOVz3ISISYgx89yBLiOON0GsxYmOcCZP
         XLRZmqHBCMSlypBJ6Oub/U/EKCr/XnSkofSxwvOIoTdbgbR3hOsJ4Mk9aHMIKMfTFhuc
         QWkz+s8QXKE3/DfmIthx/K+CEaNmsVqzqAS6u5FKtewGhNScjBMaRvQRe/i2Tve8gFOG
         XnbHa7v6J4NMQW4A0fvheIeITdt8OaKIcj+oVZ/ix/dg0tzvEBkGfKdTFijaNaSWXmTR
         SQLw==
X-Gm-Message-State: APjAAAXjsvhh/MzbOmqpo8GeftWdjguYpqDsgG7yxOIFFuSrbeO5CcLK
        RDHkpzO2f+E/L5ODhtrCO7vAJ7iSBX54Hncb9yA=
X-Google-Smtp-Source: APXvYqzao/hZMHOgGwRYE84akJBx9KguoTdvwRm68jp2gyalSJt1u5Mkd2+IhQ02LGk/v19nmn2DF9COT69gMHFlOSU=
X-Received: by 2002:a9d:1988:: with SMTP id k8mr18017072otk.316.1575791350346;
 Sat, 07 Dec 2019 23:49:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1558048212.git.liu.denton@gmail.com> <7cb770e190f235accf50e4af3ec9a964f26358c5.1558048212.git.liu.denton@gmail.com>
In-Reply-To: <7cb770e190f235accf50e4af3ec9a964f26358c5.1558048212.git.liu.denton@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 7 Dec 2019 23:48:59 -0800
Message-ID: <CABPp-BF44+6gvZVNimKf-k7AWbOjw3OK-cJeFunNR96wvZGkcw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] format-patch: teach format.notes config option
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

I was recently digging in this area (due to the recent
rebase-applies-patches-incorrectly bug report) and found a couple bugs
from this old commit:

On Thu, May 16, 2019 at 5:27 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> In git-format-patch, notes can be appended with the `--notes` option.
> However, this must be specified by the user on an
> invocation-by-invocation basis. If a user is not careful, it's possible
> that they may forget to include it and generate a patch series without
> notes.
>
> Teach git-format-patch the `format.notes` config option. Its value is a
> notes ref that will be automatically appended. The special value of
> "standard" can be used to specify the standard notes. This option is
> overridable with the `--no-notes` option in case a user wishes not to
> append notes.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/config/format.txt    | 15 +++++++
>  Documentation/git-format-patch.txt |  3 ++
>  builtin/log.c                      | 20 ++++++++-
>  t/t4014-format-patch.sh            | 70 ++++++++++++++++++++++++++++++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
> index dc77941c48..414a5a8a9d 100644
> --- a/Documentation/config/format.txt
> +++ b/Documentation/config/format.txt
> @@ -85,3 +85,18 @@ format.outputDirectory::
>  format.useAutoBase::
>         A boolean value which lets you enable the `--base=auto` option of
>         format-patch by default.
> +
> +format.notes::
> +       Provides the default value for the `--notes` option to
> +       format-patch. Accepts a boolean value, or a ref which specifies
> +       where to get notes. If false, format-patch defaults to
> +       `--no-notes`. If true, format-patch defaults to `--notes`. If
> +       set to a non-boolean value, format-patch defaults to
> +       `--notes=<ref>`, where `ref` is the non-boolean value. Defaults
> +       to false.
> ++
> +If one wishes to use the ref `ref/notes/true`, please use that literal
> +instead.
> ++
> +This configuration can be specified multiple times in order to allow
> +multiple notes refs to be included.
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 2c3971390e..9ce5b8aaee 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -275,6 +275,9 @@ these explanations after `format-patch` has run but before sending,
>  keeping them as Git notes allows them to be maintained between versions
>  of the patch series (but see the discussion of the `notes.rewrite`
>  configuration options in linkgit:git-notes[1] to use this workflow).
> ++
> +The default is `--no-notes`, unless the `format.notes` configuration is
> +set.
>
>  --[no-]signature=<signature>::
>         Add a signature to each message produced. Per RFC 3676 the signature
> diff --git a/builtin/log.c b/builtin/log.c
> index e43ee12fb1..dad63cffc6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -779,6 +779,8 @@ enum {
>
>  static int git_format_config(const char *var, const char *value, void *cb)
>  {
> +       struct rev_info *rev = cb;
> +
>         if (!strcmp(var, "format.headers")) {
>                 if (!value)
>                         die(_("format.headers without value"));
> @@ -864,6 +866,22 @@ static int git_format_config(const char *var, const char *value, void *cb)
>                         from = NULL;
>                 return 0;
>         }
> +       if (!strcmp(var, "format.notes")) {
> +               struct strbuf buf = STRBUF_INIT;
> +               int b = git_parse_maybe_bool(value);
> +               if (!b)
> +                       return 0;
> +               rev->show_notes = 1;
> +               if (b < 0) {
> +                       strbuf_addstr(&buf, value);
> +                       expand_notes_ref(&buf);
> +                       string_list_append(&rev->notes_opt.extra_notes_refs,
> +                                       strbuf_detach(&buf, NULL));
> +               } else {
> +                       rev->notes_opt.use_default_notes = 1;
> +               }
> +               return 0;
> +       }

What if someone has multiple format.notes entries in their config
file, but the last entry is "false" -- shouldn't that disable notes?
Also, what if they specify both "true" and e.g.
"refs/notes/my-cool-notes"?  In that case, should it show
refs/notes/my-cool-notes because that's obviously showing some notes
so it satisfies true as well as the specific request about which note,
or should it treat "true" the same as the-default-notes-ref and then
add the two refs together and show them both?

>
>         return git_log_config(var, value, cb);
>  }
> @@ -1617,8 +1635,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>         extra_to.strdup_strings = 1;
>         extra_cc.strdup_strings = 1;
>         init_log_defaults();
> -       git_config(git_format_config, NULL);
>         repo_init_revisions(the_repository, &rev, prefix);
> +       git_config(git_format_config, &rev);

Calling git_config() after repo_init_revisions() breaks things;
generally git_config() should always be called first.  Here,
git_format_config() can set up parameters used by
repo_init_revisions(), and by reversing the order of the two you end
up ignoring settings specified by the user (e.g. diff.context having a
value of 5).  This came up due to the bug report at
https://lore.kernel.org/git/xmqqa78d2qmk.fsf@gitster-ct.c.googlers.com/T/#mb6a09958ff10acde295b37a9136bc3791fd4a2c2
(though fixing the issue there _also_ requires fixing git_am_config()
to call git_diff_ui_config()).  To break the circular dependency here,
we'd need to store the information that git_format_config() discovers
in some data structure besides rev, and then after the
repo_init_revisions() call has finished then update rev.

I was just going to do that, but then ran into the questions above
about multiple format.notes entries in the config file, and am not as
sure about what should be done about that stuff (and I don't want to
try to translate the current behavior as-is while tweaking where the
stuff is stored, both because I'm not sure of the right behavior and
because I don't want future folks to blame the code to me when they
hit bugs in this area), so I'm firing off this email instead.

So, um...help?

Thanks,
Elijah
