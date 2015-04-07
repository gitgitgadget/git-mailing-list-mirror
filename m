From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/5] log: honor log.merges= option
Date: Tue, 7 Apr 2015 01:18:24 -0400
Message-ID: <CAPig+cStJ9WC1HaJXGEpPqZUi+S2aE2-1vV-D4B1ZBekKpLcLQ@mail.gmail.com>
References: <1428110521-31028-1-git-send-email-koosha@posteo.de>
	<1428110521-31028-2-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 07:18:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfLuA-0004rH-Lw
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 07:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbbDGFS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 01:18:26 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:33103 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbDGFS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 01:18:26 -0400
Received: by layy10 with SMTP id y10so33888677lay.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 22:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZsESQP+A5jpSuNbJpoBYfoVM43Or82c33lsbr6+LY7U=;
        b=eBpRnOIUcF8yQUFPTAztB2lR3M+HsepuO20EFtBkFrxWpGXpB+p4ia5SHswC05w5vS
         zoFq0CsjiuGZhDosfhIJ8GPDXiPenwr7w/RM2rAnhLaNMg/paWCQkRJkahLNGFSAwk2G
         xImzggbmH0cQY2I83dgFdvShIYPH6GoalZxZKdrslqFhJabTw+1EQQhrH+qm8UyX5nKP
         hcm/HUWym49pUJPYkJT5+0LWl1jZCShZKGPz20jqus4Bb2vdMZBVxKmVX6JR7h5h75kz
         YKAOa+aDoxrUXE+2ChB0UTm+gmm//bcUn6RBCqC1tJkBaQFm90iKMhCJ6gdGeM2Io0u9
         onLg==
X-Received: by 10.112.151.211 with SMTP id us19mr16016740lbb.120.1428383904579;
 Mon, 06 Apr 2015 22:18:24 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 22:18:24 -0700 (PDT)
In-Reply-To: <1428110521-31028-2-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: lXwiV1uB_KQm1zn9Y3soMfF6vXI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266899>

On Fri, Apr 3, 2015 at 9:21 PM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> From: Junio C Hamano <gitster@pobox.com>
>
> [kk: wrote commit message]
>
> Helped-by: Eris Sunshine <sunshine@sunshineco.com>

s/Eris/Eric/

> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
>  builtin/log.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..c7a7aad 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -36,6 +36,7 @@ static int decoration_given;
>  static int use_mailmap_config;
>  static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
> +static const char *log_merges;
>
>  static const char * const builtin_log_usage[] = {
>         N_("git log [<options>] [<revision range>] [[--] <path>...]"),
> @@ -386,6 +387,9 @@ static int git_log_config(const char *var, const char *value, void *cb)
>                         decoration_style = 0; /* maybe warn? */
>                 return 0;
>         }
> +       if (!strcmp(var, "log.merges")) {
> +               return git_config_string(&log_merges, var, value);
> +       }
>         if (!strcmp(var, "log.showroot")) {
>                 default_show_root = git_config_bool(var, value);
>                 return 0;
> @@ -628,6 +632,8 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>
>         init_revisions(&rev, prefix);
>         rev.always_show_header = 1;
> +       if (log_merges && parse_merges_opt(&rev, log_merges))
> +               die("unknown config value for log.merges: %s", log_merges);
>         memset(&opt, 0, sizeof(opt));
>         opt.def = "HEAD";
>         opt.revarg_opt = REVARG_COMMITTISH;
> --
> 2.3.3.263.g095251d.dirty
