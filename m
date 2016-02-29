From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv19 09/11] git submodule update: have a dedicated helper
 for cloning
Date: Mon, 29 Feb 2016 11:03:10 -0800
Message-ID: <CAGZ79kZYqXWAqjmYJtHM5rPUPbCS_NxOsrbspkOS1WAVV44wzg@mail.gmail.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
	<1456444119-6934-1-git-send-email-sbeller@google.com>
	<1456444119-6934-10-git-send-email-sbeller@google.com>
	<CACsJy8DmhJrUkp=d4kSst=0yGWn+Hk=MqxCmhH3WqfPzhTt+Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:03:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaT6C-000836-3D
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbcB2TDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:03:12 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33499 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbcB2TDL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:03:11 -0500
Received: by mail-ig0-f175.google.com with SMTP id y8so2665853igp.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4zDf7MTiMVE2/WdBsQNDp+XRAOBF9ND8NlHi1s0HWBs=;
        b=b8/9yGWK5fP6TYqtREgtH+KqenigNE9f0z+A6FctnUk4wTp947yijgRlVkP2g/iGYM
         nHC6R/HgJM7+dMI34UzdoY3lbGT/GQnLf3A77mgbxYnr1o6GaPLwA+Sf7tYU6fV/ZJ58
         FefqzTErsGGG3WMP4bCPlv2DSzEA1xfVR7BEG30RpPpHeoKczbafRB5MACBfmrKnwT+1
         Wi0a6FwoeaIpIahGrFpW50e64fEF0IXh2fsB3e3+dCPhUdZ1kTPNHeFbXS9pyhKz9m4x
         0XePDiHzWlZ+4RCBUFV34U3xHLNIVZ8kSWGgJxHlEBEYyLBL8IvNzotuTuDbrGTRIGS7
         /gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4zDf7MTiMVE2/WdBsQNDp+XRAOBF9ND8NlHi1s0HWBs=;
        b=S7CFNHqca0movyvK9uwSL4WI9DZ5DFDvxpWr19RXl94cVtcfTxUrw2YZdu18mTceLX
         ngyMixMGyrS3GmLIT2RSi8MqmWnWG742llH3PDN0wVia6s5mZoXg8jV68W833UfxI06Y
         MsWhzlsJBud3q3NVbIZFbeRNC+zkkOKbmB3RbJNY7keSlUmBRn6HzswZn0SUqKFv6G1e
         GEfLDW9i0SvKasGT3ZM1wNbN5sA+iR8/HyjkBywOdiFcy4Ml+iFtrMOLj+G3l06Ps8nX
         wOohl5u/OwLTThip38Dt6TifyWqs9e+upHTns3wcRIa4q09eNtYFYZl1gr63u1DhLlPa
         CkEw==
X-Gm-Message-State: AD7BkJItVn76KmXR4L69l1QjNSQR0z8EJGk9kKzAQOF7yr/PlH/mvypkO/nGYcRI40/tGBNLxi7LlUO5VBrU8eXR
X-Received: by 10.50.112.10 with SMTP id im10mr11539122igb.93.1456772590528;
 Mon, 29 Feb 2016 11:03:10 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 11:03:10 -0800 (PST)
In-Reply-To: <CACsJy8DmhJrUkp=d4kSst=0yGWn+Hk=MqxCmhH3WqfPzhTt+Uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287871>

On Sat, Feb 27, 2016 at 12:40 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Feb 26, 2016 at 6:48 AM, Stefan Beller <sbeller@google.com> wrote:
>> +static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>> +                                          struct child_process *child,
>> +                                          struct submodule_update_clone *suc,
>> +                                          struct strbuf *out)
>> +{
>> +       const struct submodule *sub = NULL;
>> +       struct strbuf displaypath_sb = STRBUF_INIT;
>> +       struct strbuf sb = STRBUF_INIT;
>> +       const char *displaypath = NULL;
>> +       char *url = NULL;
>> +       int needs_cloning = 0;
>> +
>> +       if (ce_stage(ce)) {
>> +               if (suc->recursive_prefix) {
>> +                       strbuf_addf(out, "Skipping unmerged submodule %s/%s\n",
>> +                                   suc->recursive_prefix, ce->name);
>
> I'm pretty sure this string is for human consumption (because it's
> _()'d elsehwere in this function), please _() this string.
>
>> +               } else {
>> +                       strbuf_addf(out, "Skipping unmerged submodule %s\n",
>> +                                   ce->name);
>
> and this one
>
>> +               }
>> +               goto cleanup;
>> +       }
>> +
>> +       sub = submodule_from_path(null_sha1, ce->name);
>> +
>> +       if (suc->recursive_prefix)
>> +               displaypath = relative_path(suc->recursive_prefix,
>> +                                           ce->name, &displaypath_sb);
>> +       else
>> +               displaypath = ce->name;
>> +
>> +       if (suc->update.type == SM_UPDATE_NONE
>> +           || (suc->update.type == SM_UPDATE_UNSPECIFIED
>> +               && sub->update_strategy.type == SM_UPDATE_NONE)) {
>> +               strbuf_addf(out, "Skipping submodule '%s'\n",
>> +                           displaypath);
>
> and this one
>
>> +               goto cleanup;
>> +       }
>> +
>> +       /*
>> +        * Looking up the url in .git/config.
>> +        * We must not fall back to .gitmodules as we only want
>> +        * to process configured submodules.
>> +        */
>> +       strbuf_reset(&sb);
>> +       strbuf_addf(&sb, "submodule.%s.url", sub->name);
>> +       git_config_get_string(sb.buf, &url);
>> +       if (!url) {
>> +               /*
>> +                * Only mention uninitialized submodules when their
>> +                * path have been specified
>> +                */
>> +               if (suc->warn_if_uninitialized)
>> +                       strbuf_addf(out, _("Submodule path '%s' not initialized\n"
>> +                                   "Maybe you want to use 'update --init'?\n"),
>> +                                   displaypath);
>
> oh it's already marked :)
>
> BTW, while you're editing this file, perhaps do this too (maybe in a
> separate patch)? Because die() already prepends "fatal:"

Makes sense. As builtin/submodule--helper.c was introduced in 2.7.0
and translation has already started fr 2.8.0, I'll just pick it up as
part of this series
instead of sending a bugfix patch alone.

Thanks for review!

>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a6e54fa..6cf47de 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -731,13 +731,13 @@ int cmd_submodule__helper(int argc, const char
> **argv, const char *prefix)
>  {
>         int i;
>         if (argc < 2)
> -               die(_("fatal: submodule--helper subcommand must be "
> +               die(_("submodule--helper subcommand must be "
>                       "called with a subcommand"));
>
>         for (i = 0; i < ARRAY_SIZE(commands); i++)
>                 if (!strcmp(argv[1], commands[i].cmd))
>                         return commands[i].fn(argc - 1, argv + 1, prefix);
>
> -       die(_("fatal: '%s' is not a valid submodule--helper "
> +       die(_("'%s' is not a valid submodule--helper "
>               "subcommand"), argv[1]);
>  }
> --
> Duy
