From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: [PATCH 2/2] shell: pay attention to exit status from 'help' command
Date: Mon, 11 Feb 2013 01:06:17 -0500
Message-ID: <CAE_TNikNH_8eUyX7s_zkY5FWEgyYXM617DG+j+3f1jOFC1Ud1w@mail.gmail.com>
References: <20130210224345.GA32318@sigill.intra.peff.net> <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin> <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin> <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin> <20130211043322.GA12735@sigill.intra.peff.net>
 <20130211055604.GE15329@elie.Belkin> <20130211055847.GG15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 07:07:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mXi-0004D0-VW
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 07:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab3BKGGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 01:06:40 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:45333 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab3BKGGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 01:06:38 -0500
Received: by mail-qa0-f48.google.com with SMTP id j8so1044649qah.0
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 22:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SZ9WjfJMx1RxPTMCJ6CE4zk/XcZDmcWTTeztZOkO0gg=;
        b=aPqG4BEXZS40Szu+nkIcd+AG0Dy3JWAECuT/ZOT2Kbnwjx9SaHZa5/wvhbm8yo7siI
         9bcoiccqUL7QdcQQGkSqMY12RRa/fbC3OHHi3wGiujVel/2QlxwQbRCysN0QwK4PW/Pz
         ZSqHbldsigN/Fy9SQaI/1ncVjsl+DXTNlQJDIwqLMGzhqaboNv9rtmTpIlykEkxmqhzl
         aaAiTm0UtD3KWo4MtL7sHT2Ps5jAARJ7CO7U1BCPsScmHpNKJTErcXb16OVtGn9sRx7b
         YzaQG6BXOhnnnMHsT6Jf4wlBX+W5eV4TZlVhxmLM2ym5yRyGib7gIcNGlvbIGpfULEm9
         +iww==
X-Received: by 10.224.180.212 with SMTP id bv20mr4886409qab.6.1360562797667;
 Sun, 10 Feb 2013 22:06:37 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 22:06:17 -0800 (PST)
In-Reply-To: <20130211055847.GG15329@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215997>

I feel like the suggestion I posted in response to Junio C Hamano
<gitster@pobox.com>'s complaint on the RFC for this patch provides a
more elegant solution to the problem of administrators wanting to
prevent interactive sessions for users with their login shell set to
git-prompt. The suggestion was as follows:

> How is this for an alternative? Have shell.c look for a
>        [shell]
>                missing_commands_directory = "Stuff is broke."
> setting. If the setting is missing, then it prints the default message
> (the current message). That way, there's a default setting, there can
> be a system-wide message, there can be a user specific message, and
> those messages can be set via `git-config`.

On Mon, Feb 11, 2013 at 12:58 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> If I disable git-shell's interactive mode by removing the
> ~/git-shell-commands directory, then attempts to use 'ssh' with the
> git account interactively produce an error message intended for the
> administrator:
>
>         $ ssh git@myserver
>         fatal: Interactive git shell is not enabled.
>         hint: ~/git-shell-commands should exist and have read and execute access.
>         $
>
> That is helpful for the new admin who is wondering "What? Why isn't
> the git-shell I just set up working?", but once the site setup is
> finished, it is better to give the user a friendly hint that she is on
> the right track, like GitHub does:
>
>         Hi <username>! You've successfully authenticated, but
>         GitHub does not provide shell access.
>
> An appropriate greeting might even include more complex information,
> like a list of repositories the user has access to.  If the
> git-shell-commands directory exists and contains a "help" script, we
> already run it when the shell is run without any commands, giving the
> server a chance to provide a custom message.  Unfortunately, the
> presence of the git-shell-commands directory means we also enter an
> interactive mode, prompting and accepting commands (of which there may
> be none) from the user, which many servers would not want.  To solve
> this, we abort the interactive shell on a non-zero exit code from the
> "help" script.  This lets the server say whatever it likes, and then
> hang up.
>
> Downside: this will prevent interactive git-shell logins in existing
> setups where the "help" script exits with nonzero status by mistake.
> Hopefully those are rare enough to not cause much trouble in practice.
>
> Reported-by: Ethan Reesor <firelizzard@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Improved-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-shell.txt | 20 ++++++++++++++++++++
>  shell.c                     | 10 ++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
> index 4fe93203..60051e63 100644
> --- a/Documentation/git-shell.txt
> +++ b/Documentation/git-shell.txt
> @@ -59,6 +59,26 @@ users to list repositories they have access to, create, delete, or
>  rename repositories, or change repository descriptions and
>  permissions.
>
> +If the `help` command exists and exits with nonzero status, the
> +interactive shell is aborted.
> +
> +EXAMPLE
> +-------
> +
> +To disable interactive logins, displaying a greeting instead:
> ++
> +----------------
> +$ chsh -s /usr/bin/git-shell
> +$ mkdir $HOME/git-shell-commands
> +$ cat >$HOME/git-shell-commands/help <<\EOF
> +#!/bin/sh
> +printf '%s\n' "Hi $USER! You've successfully authenticated, but I do not"
> +printf '%s\n' "provide interactive shell access."
> +exit 128
> +EOF
> +$ chmod +x $HOME/git-shell-commands/help
> +----------------
> +
>  SEE ALSO
>  --------
>  ssh(1),
> diff --git a/shell.c b/shell.c
> index 84b237fe..3abc2b84 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -63,10 +63,16 @@ static void cd_to_homedir(void)
>
>  static void run_shell(void)
>  {
> -       int done = 0;
> +       int done = 0, status;
>         static const char *help_argv[] = { HELP_COMMAND, NULL };
>         /* Print help if enabled */
> -       run_command_v_opt(help_argv, RUN_SILENT_EXEC_FAILURE);
> +       status = run_command_v_opt(help_argv, RUN_SILENT_EXEC_FAILURE);
> +       if (!status)
> +               ; /* success */
> +       else if (status == -1 && errno == ENOENT)
> +               ; /* help disabled */
> +       else
> +               exit(status);
>
>         do {
>                 struct strbuf line = STRBUF_INIT;
> --
> 1.8.1.3
>



--
Ethan Reesor (Gmail)
