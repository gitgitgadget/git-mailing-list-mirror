From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] clean: read user input with strbuf_getline()
Date: Sun, 21 Feb 2016 21:27:29 -0500
Message-ID: <CAPig+cSi-4R-a=HVmpCWAZ3kr=yQtJ9GdT-JZ4hJ2kmqg-edVA@mail.gmail.com>
References: <56CA5DBB.8040006@moritzneeb.de>
	<56CA6264.1040400@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 03:27:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXgDm-0006SO-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 03:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbcBVC1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 21:27:31 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34814 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbcBVC1a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 21:27:30 -0500
Received: by mail-vk0-f50.google.com with SMTP id e185so117656821vkb.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 18:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=voixFOqVlt8STx3Y2WRd6j1ZEtR1iFOVK8bTAEGzBoE=;
        b=iZQF9dzxFyuYCOhenQjp2mn2bRt8zk60tWurLbAv0DFtuVwBxDT7fW1inzir0PaUuM
         WA8Jmsak9w/4CEcy5Im+BcJdIaK3Qd4XJd4OdwzNo+ri9HkLQ5o1un5urwSe6Z/iqXq4
         gTN0QFLqbj7RtbowdHae9J7XNDTdOiXRWkslGcGSdT6Rn5sFoekMblhKtZeX1/eQAgBO
         0fzyEj1EeVywrXVaCHMYEEhFwNLTI4gent4qgfixFYySbm1ODyDCckuv0GYSCBoQGAOj
         ZG6vIkZcppIIHNlW4Nc50cWF/e7wE5CmoAy1NQJth8N2KTaSnNLV0Rv+USoWAC0ETT3m
         TcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=voixFOqVlt8STx3Y2WRd6j1ZEtR1iFOVK8bTAEGzBoE=;
        b=XtIgcyq08weLne3LgSDrrunsomg1hEZHtG8tdgA6V1qbRRjRs/f1yNEQmZOZqVc8ev
         zF9m0YzTe9GqLBAfAMcrfzMwN2B0LJv8HA2FCW36WYAy07jAyxqHbQwkVIHAfRqlSdIP
         7j9dyM5C8FTWgjpkFoqBPq1xMRDChWIf5dJdnuH61LNP+hV0Y34x+pSByZ8Een/vGa8N
         aQ/r3A7KG/wUJ/hcnzNiY4sCGpFkpUStLPvZ6S+SZ0crfON6Zsz9IwritgnaHlXr28PW
         pZvUfp7rCGelvV0kvj53kRvHsZEUf/a2WlovDoMd5HIdoInQy6dYc4DRxpBLBGTHUu5E
         OMBw==
X-Gm-Message-State: AG10YOSEfYli4nv7O6+3QmTZ/PAfK7tgCMlk5Itym9YLm1gcT2EUygwIXiAF0/QkqjDf0bfbr439CHk9Q+zv0A==
X-Received: by 10.31.168.76 with SMTP id r73mr21233965vke.117.1456108049417;
 Sun, 21 Feb 2016 18:27:29 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 18:27:29 -0800 (PST)
In-Reply-To: <56CA6264.1040400@moritzneeb.de>
X-Google-Sender-Auth: JXGRE3p_MVl1hA6vqlYfxDjewHk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286867>

On Sun, Feb 21, 2016 at 8:20 PM, Moritz Neeb <lists@moritzneeb.de> wrote:
> The inputs that are read are all answers that are given by the user
> when interacting with git on the commandline. As these answers are
> not supposed to contain a meaningful CR it is safe to
> replace strbuf_getline_lf() can be replaced by strbuf_getline().
>
> Before the user input was trimmed to remove the CR. This would be now
> redundant. Another effect of the trimming was that some (accidentally)
> typed spaces were filtered. But here we want to be consistent with similar UIs
> like interactive adding, which only accepts space-less input.

I don't at all insist upon it, but this behavior change feels somewhat
like it ought to be in its own commit. I'm also not convinced that
making this consistent with the less forgiving behavior of
"interactive adding" is desirable (rather the reverse: that that case
should be more flexible). However, I wasn't following the discussion
with Junio closely, and perhaps missed you two agreeing that this is
preferable.

> For the case of filtering by patterns the input is still trimmed in an
> untouched codepath after it is split up into multiple patterns.
> This is considered as desirable, because of two reasons:

s/, because of/ for/

> First this fitering is not part of similar UIs and it is way more likely
> to accidentally type a space in this way of interacting.
>
> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
> diff --git a/builtin/clean.c b/builtin/clean.c
> @@ -570,9 +570,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
>                                clean_get_color(CLEAN_COLOR_RESET));
>                 }
>  -              if (strbuf_getline_lf(&choice, stdin) != EOF) {
> -                       strbuf_trim(&choice);
> -               } else {
> +               if (strbuf_getline(&choice, stdin) == EOF) {
>                         eof = 1;
>                         break;
>                 }
> @@ -652,9 +650,7 @@ static int filter_by_patterns_cmd(void)
>                 clean_print_color(CLEAN_COLOR_PROMPT);
>                 printf(_("Input ignore patterns>> "));
>                 clean_print_color(CLEAN_COLOR_RESET);
> -               if (strbuf_getline_lf(&confirm, stdin) != EOF)
> -                       strbuf_trim(&confirm);
> -               else
> +               if (strbuf_getline(&confirm, stdin) == EOF)
>                         putchar('\n');
>                 /* quit filter_by_pattern mode if press ENTER or Ctrl-D */
> @@ -750,9 +746,7 @@ static int ask_each_cmd(void)
>                         qname = quote_path_relative(item->string, NULL, &buf);
>                         /* TRANSLATORS: Make sure to keep [y/N] as is */
>                         printf(_("Remove %s [y/N]? "), qname);
> -                       if (strbuf_getline_lf(&confirm, stdin) != EOF) {
> -                               strbuf_trim(&confirm);
> -                       } else {
> +                       if (strbuf_getline(&confirm, stdin) == EOF) {
>                                 putchar('\n');
>                                 eof = 1;
>                         }
> --
> 2.7.1.345.gc14003e
