From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] blame,shortlog: don't make local option variables static
Date: Tue, 14 Jun 2016 00:32:15 -0400
Message-ID: <CAPig+cQudTwT6H35YgEvxdK9AAn0BwvUC8bi8-DxGYNh9rb_Lw@mail.gmail.com>
References: <20160613053203.GB3950@sigill.intra.peff.net> <20160613053928.GC23880@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 06:32:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCg1f-0005yI-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 06:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbcFNEcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 00:32:23 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33300 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933196AbcFNEcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 00:32:22 -0400
Received: by mail-io0-f195.google.com with SMTP id 5so19264806ioy.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 21:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mkU5j/y3ZNjWI67NJiTZ5gHb8Mb6E5GKx6yBQsZyZns=;
        b=cSo8EieI0fgja8wgBuB9vgPQfF2Ap/Ln8LInezwg8NwMjB3DmAD1lzGBE9cDouYbG3
         ictoKw53hQocsqYOlelmjkMInQxX3LXfdqUr+H+nkf0JfGT+MCxvi/c89emq5XygUs7M
         VikJJsVk2TqYMxnVI5MVylCpH3AHrFQxAJ2lkBs9zfc+CxuyQlEtxYoasE+55eSs0T1x
         ZIqM3PGq+yvJhIj09yL0W0WBMmNW2UF90rKw4qIVBLx/H9DIjM7KbKF09Qi0WV0VDjKz
         I48xBgf0CIwCExxIGTvuYGjQlTpdr+leu1Xr8GdxHTnakN6+kZ3YFxj98sxi3ckvCcdO
         bO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mkU5j/y3ZNjWI67NJiTZ5gHb8Mb6E5GKx6yBQsZyZns=;
        b=jN1xB+/LkfWacYKephSRuM6Up+Oxmf/H/sQZs6VWVJlB223wabPI/TXQgXNAGDHu5H
         1nabsyu7kpaOB/KIu5SZtQ58sl6hgpzGHPi4UpQkHM8PGne4mYLle/FsQ6pJJORWmrW+
         Co3qpEvOuuVpOSknKA5rF54SMx5fcRBfVy9IgsmXZzHbU6cVyKBpcA1KRj9vEEwx+8RV
         zh+vE/j7duTxVwBIDKm9fc43/7MzEmi/n07D25e391JiPPxijfItgiqYLVXlz3paF3z5
         tf0JER7SULDYPohwe5m7eq3tYuJO8l+bEgagm5SxeEQH0UgAVMaGTWiahiTgbNDQqBCD
         H4AA==
X-Gm-Message-State: ALyK8tLYcP9pRAzMUtd9VfN+8TbGx41l8ZATYp9hsQd/Oy/lcLF+RBc3caUt2ALqhvHNV04URIZCixaH8DelSQ==
X-Received: by 10.107.47.41 with SMTP id j41mr27390055ioo.168.1465878736249;
 Mon, 13 Jun 2016 21:32:16 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Mon, 13 Jun 2016 21:32:15 -0700 (PDT)
In-Reply-To: <20160613053928.GC23880@sigill.intra.peff.net>
X-Google-Sender-Auth: C5loWS2w4H8YonnmHUO1EvPNEt0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297261>

On Mon, Jun 13, 2016 at 1:39 AM, Jeff King <peff@peff.net> wrote:
> There's no need for these option variables to be static,
> except that they are referenced by the options array itself,
> which is static. But having all of this static is simply
> unnecessary and confusing (and inconsistent with most other
> commands, which either use a static global option list or a
> true function-local one).
>
> Note that in some cases we may need to actually initialize
> the variables (since we cannot rely on BSS to do so). This
> is a net improvement to readability, though, as we can use
> the more verbose initializers for our string_lists.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -2522,12 +2522,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> -       static struct string_list range_list;
> -       static int output_option = 0, opt = 0;
> -       static int show_stats = 0;
> -       static const char *revs_file = NULL;
> -       static const char *contents_from = NULL;
> -       static const struct option options[] = {
> +       struct string_list range_list = STRING_LIST_INIT_NODUP;

Related to this series, there's an additional "fix" which ought to be
made, probably as a separate patch. In particular, in cmd_blame():

    if (lno && !range_list.nr)
        string_list_append(&range_list, xstrdup("1"));

which supplies a default range ("line 1 through end of file") if -L
was not specified. I used xstrdup() on the literal "1" in 58dbfa2
(blame: accept multiple -L ranges, 2013-08-06) to be consistent with
parse_opt_string_list() which was unconditionally xstrdup'ing the
argument (but no longer does as of patch 1/3 of this series).

> +       int output_option = 0, opt = 0;
> +       int show_stats = 0;
> +       const char *revs_file = NULL;
> +       const char *contents_from = NULL;
> +       const struct option options[] = {
>                 OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
>                 OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
>                 OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
