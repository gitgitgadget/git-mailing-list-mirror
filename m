From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH 3/3] commit: advertize config --global --edit on
 guessed identity
Date: Fri, 25 Jul 2014 11:40:27 -0400
Message-ID: <CAPig+cQCD7rxVyJk9pLx6u6UEskm+25rhuraXNLUDNk3_SJYwA@mail.gmail.com>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
	<1406295891-7316-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 17:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAhbr-0008BP-TW
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 17:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934710AbaGYPkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 11:40:31 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:45821 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbaGYPk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 11:40:29 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so2864944ykq.7
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 08:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cnkumJWmfvcIJtkfRcw+67Tbhh9KQAZ+VIwbN9/C1R0=;
        b=eYtPnZ6L9d+4rBtMqj6aThk8mGnmyUoTyhISY54K1a2lD6O2XZzyhZZZiA0+m4cBSR
         QCm4xOUkDeKWnDphxPXltKCJ+6gf/nseT8FN5zvalYibhJY/kpPzycpSQfS+P0g6DrsI
         dxJul5kTRh1KVuhGqsSTvD/DpjTz6de9jCJn5pOF1y0c/3dgKOk1bdLQ1WX2EgwLStp3
         H/pA6MDtCJUuW6t//rnhsly5lsWkpPtN5SaxxU0NwCwbDIZcBa15fOdgOyDM3FN73VME
         elJeWDYqmNIQ3UNb1q4x23d+A+HneKL1DHTLRqhfl8PAXsiiRltnj7laZGoUiijUGvyn
         3H1Q==
X-Received: by 10.236.14.34 with SMTP id c22mr24139178yhc.97.1406302828020;
 Fri, 25 Jul 2014 08:40:28 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Fri, 25 Jul 2014 08:40:27 -0700 (PDT)
In-Reply-To: <1406295891-7316-3-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: 30DzbcUwR6RmcgPn_Lu3HQCgSnE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254227>

On Fri, Jul 25, 2014 at 9:44 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> commit: advertize config --global --edit on guessed identity

s/advertize/advertise/

> When the user has no user-wide configuration file, it's faster to use the
> newly introduced config file template than to run two commands to set
> user.name and user.email. Advise this to the user.
>
> The old advice is kept if the user already has a configuration file since
> the template feature would not trigger in this case.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  builtin/commit.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index f2d7979..52ef5a8 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -42,7 +42,20 @@ static const char * const builtin_status_usage[] = {
>         NULL
>  };
>
> -static const char implicit_ident_advice[] =
> +static const char implicit_ident_advice_noconfig[] =
> +N_("Your name and email address were configured automatically based\n"
> +"on your username and hostname. Please check that they are accurate.\n"
> +"You can suppress this message by setting them explicitly. Run the\n"
> +"following command and follow the instructions in your editor to edit\n"
> +"your configuration file:\n"
> +"\n"
> +"    git config --global --edit\n"
> +"\n"
> +"After doing this, you may fix the identity used for this commit with:\n"
> +"\n"
> +"    git commit --amend --reset-author\n");
> +
> +static const char implicit_ident_advice_config[] =
>  N_("Your name and email address were configured automatically based\n"
>  "on your username and hostname. Please check that they are accurate.\n"
>  "You can suppress this message by setting them explicitly:\n"
> @@ -1403,6 +1416,23 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +static const char *implicit_ident_advice() {
> +       char *user_config = NULL;
> +       char *xdg_config = NULL;
> +       int config_exists;
> +
> +       home_config_paths(&user_config, &xdg_config, "config");
> +       config_exists = file_exists(user_config) || file_exists(xdg_config);
> +       free(user_config);
> +       free(xdg_config);
> +
> +       if (config_exists)
> +               return _(implicit_ident_advice_config);
> +       else
> +               return _(implicit_ident_advice_noconfig);
> +
> +}
> +
>  static void print_summary(const char *prefix, const unsigned char *sha1,
>                           int initial_commit)
>  {
> @@ -1441,7 +1471,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
>                 strbuf_addbuf_percentquote(&format, &committer_ident);
>                 if (advice_implicit_identity) {
>                         strbuf_addch(&format, '\n');
> -                       strbuf_addstr(&format, _(implicit_ident_advice));
> +                       strbuf_addstr(&format, implicit_ident_advice());
>                 }
>         }
>         strbuf_release(&author_ident);
> --
> 2.0.2.737.gfb43bde
