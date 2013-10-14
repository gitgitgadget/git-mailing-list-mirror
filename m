From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH try2 01/14] Add proper 'stage' command
Date: Mon, 14 Oct 2013 15:44:11 -0400
Message-ID: <CAPig+cQN5e8hOKTvHRKUQoLmctUWbAqTydgfY10Kr4AzHtB7kg@mail.gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
	<1381561488-20294-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 21:44:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVo3t-0004LS-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 21:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab3JNToN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 15:44:13 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:41244 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400Ab3JNToN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 15:44:13 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so6224387lbh.28
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=N/kayg4tk+mvqksStnza48J6TFLzmI466/4nMo9wQeE=;
        b=rHIY6GsilG8IBspOaxeBSSqACvcvsfTLCEaYQlH32uv/GNz46Nbyg6eq701nxPNtIY
         ceSp3MO0RJbssRVE4l1EAsAioacAoy2JbwKHX2R9Fcf3PRozQgRBgobQoAhCPD89DOU1
         njqn5l+/TJBQ3mfQlx5Cr/IB2Eqo9Buan8zJKR09kjQtEu/6dJg2xTb17WoAnMDl5coo
         MXtCWVg+EvFgbAm2FaFdd+M7s0TD0w9AgxKpkJ9Q9ZIiRu5fjPURix2Xl5XUwHRD6oUS
         hR1Eh+VP5rpmsNCOgssFy7eeRFqGSJbGkxTah7kpWggzoGjz/Xm+YXPziLLEgnRcwTw7
         8ZFw==
X-Received: by 10.152.228.130 with SMTP id si2mr3291841lac.32.1381779851920;
 Mon, 14 Oct 2013 12:44:11 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 14 Oct 2013 12:44:11 -0700 (PDT)
In-Reply-To: <1381561488-20294-6-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: 1bpuya3A8oolU0IX0ffjmwe2dv4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236117>

On Sat, Oct 12, 2013 at 3:04 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>  SYNOPSIS
>  --------
>  [verse]
> -'git stage' args...
> -
> +'git stage' [options] [--] [<paths>...]
> +'git stage add' [options] [--] [<paths>...]
> +'git stage reset' [-q|--patch] [--] [<paths>...]
> +'git stage diff' [options] [<commit>] [--] [<paths>...]
> +'git stage rm' [options] [--] [<paths>...]
> +'git stage apply' [options] [--] [<paths>...]
>
> diff --git a/builtin/stage.c b/builtin/stage.c
> new file mode 100644
> index 0000000..3023d17
> --- /dev/null
> +++ b/builtin/stage.c
> @@ -0,0 +1,52 @@
> +/*
> + * 'git stage' builtin command
> + *
> + * Copyright (C) 2013 Felipe Contreras
> + */
> +
> +#include "builtin.h"
> +#include "parse-options.h"
> +
> +static const char *const stage_usage[] = {
> +       N_("git stage [options] [--] <paths>..."),
> +       N_("git stage add [options] [--] <paths>..."),
> +       N_("git stage reset [-q|--patch] [--] <paths>..."),
> +       N_("git stage diff [options] [<commit]> [--] <paths>..."),
> +       N_("git stage rm [options] [--] <paths>..."),
> +       NULL
> +};

Missing usage for "git stage apply".

> +
> +int cmd_stage(int argc, const char **argv, const char *prefix)
> +{
> +       struct option options[] = { OPT_END() };
> +
> +       argc = parse_options(argc, argv, prefix, options, stage_usage,
> +                       PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
> +
> +       if (argc > 1) {
> +               if (!strcmp(argv[1], "add"))
> +                       return cmd_add(argc - 1, argv + 1, prefix);
> +               if (!strcmp(argv[1], "reset"))
> +                       return cmd_reset(argc - 1, argv + 1, prefix);
> +               if (!strcmp(argv[1], "diff")) {
> +                       argv[0] = "diff";
> +                       argv[1] = "--staged";
> +
> +                       return cmd_diff(argc, argv, prefix);
> +               }
> +               if (!strcmp(argv[1], "rm")) {
> +                       argv[0] = "rm";
> +                       argv[1] = "--cached";
> +
> +                       return cmd_rm(argc, argv, prefix);
> +               }
> +               if (!strcmp(argv[1], "apply")) {
> +                       argv[0] = "apply";
> +                       argv[1] = "--cached";
> +
> +                       return cmd_apply(argc, argv, prefix);
> +               }
> +       }
> +
> +       return cmd_add(argc, argv, prefix);
> +}
