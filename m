From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/7] submodule: implement `module_list` as a builtin helper
Date: Wed, 19 Aug 2015 11:25:05 -0700
Message-ID: <CAGZ79kacYnaV-cF3jXzoCHm8OvJUpF305CumTXD0ozE2hhNRwA@mail.gmail.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
	<1439857323-21048-6-git-send-email-sbeller@google.com>
	<xmqqpp2j9m7g.fsf@gitster.dls.corp.google.com>
	<xmqqfv3f9m0l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 20:25:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS82z-0002BI-MM
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 20:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbbHSSZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 14:25:07 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33706 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbHSSZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 14:25:06 -0400
Received: by ykll84 with SMTP id l84so13884410ykl.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OPOZQgvADfBhxQrE6C6BLyokDExhfkpSx6Kw+KYy6J0=;
        b=LJLTve6tl6HxI4aebAAIFNWgm2oZpD5Vk/a9bBQ7ltcEa/vgvkfA29V+1FWILV+It3
         yPNN2iJqAbElIvfElo1/b0B6LVwH4cm78k9xZ+D4LryJW7vG7RSLWzZAV+Jn6ut7MlSc
         pYw7sfgPw30Kp9iCLrNwhlEHcabrbCdpfD6FeAdPPuS/aIW7H4QUpFpdpWHZTB3R3X61
         Gqj9ulRYBu3R+E5fTyJtMwFV8PdGACBq1UPigTxt+i4XX+OJMZ8HGtE84rBNVqJi6PWL
         UQbtW7j9MCf7k5h/YBOu5/gYR6WDSlTHbwQOWULNHnK/09sG08uFdnrKyodEh5H17+iO
         aymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OPOZQgvADfBhxQrE6C6BLyokDExhfkpSx6Kw+KYy6J0=;
        b=Bo4RTheRHinwCLOWIhRH64vjw6v6WmWRSf53ks/a4pseQ3h6waw/rC07pWPmVRSORq
         QkYeGcB2pQODlv4TCgOnRKHyOWW1Y4keopHYvdP3U0OmdzOiYXBWOhNHPujSm2+FoDac
         LGHTh83V/Kr9MTAIhixr1GvLPbrIT/2n5lJKM1SmSpHch9BKq3jfVu0LCNhbcnS8EnLA
         Vo0dWQdytYOKSggftVYv/anln1o8h1HpEQVZqxu6SYL7SdNdwcdGbqbDHVn+pV5kY9yQ
         Sj8KABFu2kIgdlHbZE6e/LcDT0vmwJLks3RAlwNlxshcmvO/yNibttxg1KM6YsYmZ3rI
         hIbA==
X-Gm-Message-State: ALoCoQkCoLjV0ekdUgskHtAAZRwVCnyTDLZ8AMvLjjw7Bgf5v1haP2nlBZFFIDBj562RSCyI0acw
X-Received: by 10.129.90.196 with SMTP id o187mr14576534ywb.32.1440008705409;
 Wed, 19 Aug 2015 11:25:05 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Wed, 19 Aug 2015 11:25:05 -0700 (PDT)
In-Reply-To: <xmqqfv3f9m0l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276212>

On Wed, Aug 19, 2015 at 11:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Micronit.  Even though multiplication is commutative, the order of
>> arguments to xcalloc() looks odd.  It lets you say "I want an array
>> with nmemb elements, and each of its is size-bytes long" by giving
>> it nmemb and then size.
>
> Unrelated tangent, but while I have output from "git grep 'calloc.*pathspec'"
> on my screen... ;-)
>
>  builtin/checkout.c | 2 +-
>  builtin/ls-files.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 7ea533e..e3b28e4 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -283,7 +283,7 @@ static int checkout_paths(const struct checkout_opts *opts,
>         if (opts->source_tree)
>                 read_tree_some(opts->source_tree, &opts->pathspec);
>
> -       ps_matched = xcalloc(1, opts->pathspec.nr);
> +       ps_matched = xcalloc(opts->pathspec.nr, 1);
>
>         /*
>          * Make sure all pathspecs participated in locating the paths
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 6fa2205..b6a7cb0 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -516,7 +516,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>
>         /* Treat unmatching pathspec elements as errors */
>         if (pathspec.nr && error_unmatch)
> -               ps_matched = xcalloc(1, pathspec.nr);
> +               ps_matched = xcalloc(pathspec.nr, 1);
>
>         if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
>                 die("ls-files --ignored needs some exclude pattern");

Looks good to me.
