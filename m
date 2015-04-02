From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC 2] systemd socket activation support
Date: Thu, 2 Apr 2015 13:20:28 -0400
Message-ID: <CAPig+cT45fsT47XTgRE23geqisc_Q+9AZLjtPJWWorzjXi8uqQ@mail.gmail.com>
References: <1427991310-19754-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 19:20:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdinD-00085W-Vb
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 19:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbbDBRUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 13:20:31 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:33991 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbDBRUa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 13:20:30 -0400
Received: by lagg8 with SMTP id g8so65020482lag.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=81GAJ1Iz7hlDE1exaIAkzVteMfN2s+3OvpYWfMolzgI=;
        b=kQ8fILLfKeW1mEbuzQr3+qg3nRvVD8ECYG1coq8NapcCxswJcCZ34Lt2RAfmQZH2hc
         tJWhfzo2BYfceQPQ1vWJpNCbXgkX8FZwxMORaDm6+HVghqZwjReQodxxRffRsRGNx4tg
         Owic0yW3pd9zllb1R9ZfIKPmITHw1c2H+OKDMKx9vS9sTG3Ov5Dd1m6bCp+JGSNpcFDB
         DHFHd6dE9RWisvsHDOGRhj3bvaCJQ+WCosdSjQazSNcCSvk3bSXE8MSJUy4lzPKnQ8p3
         EoDE23mee1ThuZi141rujWxH/kDCPwamBpXKmzyPg3phH4zbEpspgi+Q5e5ErDY7gEpC
         JYLw==
X-Received: by 10.112.9.236 with SMTP id d12mr42879593lbb.102.1427995228503;
 Thu, 02 Apr 2015 10:20:28 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Thu, 2 Apr 2015 10:20:28 -0700 (PDT)
In-Reply-To: <1427991310-19754-1-git-send-email-shawn@churchofgit.com>
X-Google-Sender-Auth: 4bhbYRoQ1REGqUuOMV8GE1ju_YQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266650>

On Thu, Apr 2, 2015 at 12:15 PM, Shawn Landden <shawn@churchofgit.com> wrote:
> [RFC 2] systemd socket activation support

Rephrase this as:

    [PATCH/RFC v2] daemon: add systemd support

> systemd support git-daemon's --inetd mode as well.

Unable to make sense of this sentence (fragment). A better commit
message would explain the purpose of the change, its justification,
and any important issues which readers need to know to understand and
review the patch. See my previous review[1] for some ideas.

[1]: http://article.gmane.org/gmane.comp.version-control.git/266631

> v2: actually test...

It is indeed a good idea to explain what changed between versions of
the patch, however, this isn't telling us much. To ease the task of
reviewers, explain changes between versions with sufficient detail so
that readers don't need to guess. Also, it is very helpful to provide
a link to the previous version of the patch and its discussion since
this is a high-traffic list, and reviewers won't necessarily remember
the details of the previous version.

Also, you don't generally want this sort of commentary recorded in the
permanent project history, so it doesn't belong in the commit message
proper. Instead, place it below the "---" line following your
sign-off, just above the diffstat.

> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
> ---

This is where you should place commentary which you don't want in the
permanent project history.

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index a69b361..898e01f 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -20,6 +20,7 @@ SYNOPSIS
>              [--inetd |
>               [--listen=<host_or_ipaddr>] [--port=<n>]
>               [--user=<user> [--group=<group>]]]
> +             [--systemd]
>              [<directory>...]
>
>  DESCRIPTION
> @@ -190,6 +191,12 @@ Git configuration files in that directory are readable by `<user>`.
>         exiting with a zero status).  It can also look at the $REMOTE_ADDR
>         and $REMOTE_PORT environment variables to learn about the
>         requestor when making this decision.
> +--systemd::
> +       For running git-daemon under systemd(1) which will pass
> +       an open connection. This is similar to --inetd, except
> +       that more than one address/port can be listened to at once
> +       both through systemd and through --listen, and git-daemon doesn't get
> +       invoked for every connection. For more details see systemd.socket(5).

The documentation for the --inetd option mentions other options with
which it is incompatible. This new documentation probably ought to do
the same. Moreover, you should update the --inetd documentation to
mention that it is incompatible with --systemd.

Unfortunately, you plopped this new text right in the middle of the
the description of --access-hook (which is continued by the "+" line
and the left-justified paragraph below). If you format the
documentation and look at the before and after output, you will see
the problem.

>  +
>  The external command can optionally write a single line to its
>  standard output to be sent to the requestor as an error message when
> @@ -304,7 +311,25 @@ selectively enable/disable services per repository::
>                 uploadpack = false
>                 uploadarch = true
>  ----------------------------------------------------------------

Unfortunately, the new example you've added (below) doesn't format
properly, and results in Asciidoc warnings. To ensure correctness,
follow the other examples more closely, and try formatting it
yourself.

> ++

This "+" line incorrectly ties your new example to the preceding
"selectively enable/disable services per repository" item. Just insert
a blank line here rather than a "+" line.

> +systemd configuration example:

This item must end with "::", not just ":".

> +

Instead of a blank line, this should be a "+" line in order to tie the
example (below) to the "systemd configuration example" item.

> +# /etc/systemd/system/git-daemon.socket
> +[Unit]
> +Description=Git Daemon socket
> +
> +[Socket]
> +ListenStream=9418
> +
> +[Install]
> +WantedBy=sockets.target
> +# /etc/systemd/system/git-daemon.service
> +[Unit]
> +Description=Git Daemon
>
> +[Service]
> +ExecStart=/usr/lib/git-core/git-daemon --systemd --reuseaddr --base-path=/var/lib /var/lib/git
> +User=gitdaemon

The example block must be delimited by "------" lines to be formatted
correctly as literal text. (Both "------" lines should have the same
number of dashes in order to satisfy all versions of Asciidoc).

Also, indent the text as other examples in git-daemon.txt.

More below.

>  ENVIRONMENT
>  -----------
> diff --git a/daemon.c b/daemon.c
> index 9ee2187..e809a4c 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -4,6 +4,7 @@
>  #include "run-command.h"
>  #include "strbuf.h"
>  #include "string-list.h"
> +#include "sd-daemon.h"
>
>  #ifndef HOST_NAME_MAX
>  #define HOST_NAME_MAX 256
> @@ -29,6 +30,7 @@ static const char daemon_usage[] =
>  "           [--access-hook=<path>]\n"
>  "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
>  "                      [--detach] [--user=<user> [--group=<group>]]\n"
> +"           [--systemd]\n"
>  "           [<directory>...]";
>
>  /* List of acceptable pathname prefixes */
> @@ -1176,11 +1178,22 @@ static void store_pid(const char *path)
>  }
>
>  static int serve(struct string_list *listen_addr, int listen_port,
> -    struct credentials *cred)
> +    struct credentials *cred, int systemd_mode)
>  {
>         struct socketlist socklist = { NULL, 0, 0 };
>
> -       socksetup(listen_addr, listen_port, &socklist);
> +       if (systemd_mode) {
> +               int i;
> +               int n;

Minor: If you examine other parts of daemon.c, you will find that
these declarations are normally placed together on a single line, so
you could collapse this to:

    int i, n = sd_listen_fds(0);

or:

    int i, n;
    n = ...;

in order make better use of precious vertical screen real-estate.

More below.

> +
> +               n = sd_listen_fds(0);
> +               ALLOC_GROW(socklist.list, socklist.nr + n, socklist.alloc);
> +               for (i = 0; i < n; i++)
> +                       socklist.list[socklist.nr++] = SD_LISTEN_FDS_START + i;
> +       }
> +
> +       if (listen_addr->nr > 0 || !systemd_mode)
> +               socksetup(listen_addr, listen_port, &socklist);
>         if (socklist.nr == 0)
>                 die("unable to allocate any listen sockets on port %u",
>                     listen_port);
> @@ -1196,7 +1209,7 @@ int main(int argc, char **argv)
>  {
>         int listen_port = 0;
>         struct string_list listen_addr = STRING_LIST_INIT_NODUP;
> -       int serve_mode = 0, inetd_mode = 0;
> +       int serve_mode = 0, inetd_mode = 0, systemd_mode = 0;
>         const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
>         int detach = 0;
>         struct credentials *cred = NULL;
> @@ -1331,6 +1344,10 @@ int main(int argc, char **argv)
>                         informative_errors = 0;
>                         continue;
>                 }
> +               if (!strcmp(arg, "--systemd")) {
> +                       systemd_mode = 1;

The --inetd switch implies --syslog. Should --systemd do the same by
setting "log_syslog = 1"?

> +                       continue;
> +               }
>                 if (!strcmp(arg, "--")) {
>                         ok_paths = &argv[i+1];
>                         break;
> @@ -1349,14 +1366,20 @@ int main(int argc, char **argv)
>                 /* avoid splitting a message in the middle */
>                 setvbuf(stderr, NULL, _IOFBF, 4096);
>
> -       if (inetd_mode && (detach || group_name || user_name))
> -               die("--detach, --user and --group are incompatible with --inetd");
> +       if ((inetd_mode || systemd_mode) && (detach || group_name || user_name))
> +               die("--detach, --user and --group are incompatible with --inetd and --systemd");
> +
> +       if (systemd_mode && inetd_mode)
> +               die("--inetd is incompatible with --systemd");
>
>         if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
>                 die("--listen= and --port= are incompatible with --inetd");
>         else if (listen_port == 0)
>                 listen_port = DEFAULT_GIT_PORT;
>
> +       if (systemd_mode && !sd_booted())
> +               die("--systemd passed and not invoked from systemd");
> +
>         if (group_name && !user_name)
>                 die("--group supplied without --user");

Note shown in this patch, but --inetd redirects stderr to /dev/null.
Should --systemd be doing so as well?

> @@ -1395,5 +1418,5 @@ int main(int argc, char **argv)
>                 cld_argv[i+1] = argv[i];
>         cld_argv[argc+1] = NULL;
>
> -       return serve(&listen_addr, listen_port, cred);
> +       return serve(&listen_addr, listen_port, cred, systemd_mode);
>  }
