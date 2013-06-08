From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 15/22] git-remote-mediawiki: Put long code into a subroutine
Date: Fri, 7 Jun 2013 20:27:38 -0400
Message-ID: <CAPig+cRckkYnDxqzvM4TZ_bOwpDBkn3aXNPy-sTg551d38L7jA@mail.gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-16-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 02:27:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul70T-0004gq-1Z
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 02:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813Ab3FHA1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 20:27:41 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35841 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3FHA1k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 20:27:40 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so4799562lbd.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OxyDIlUDx3iNfPp/M1j6mHhji+CTaWmN3Qx9yzW8iDM=;
        b=kxRJfomI6YdckBKDVmW/bAy8QzmHy3oC/AVspuoaMdVar4C9fziD7D5QigWY/J3Ig9
         pGDTow6PdmfXhdVVNgjTDuoHtbJsrWiXjq/i1A3qB1YjKMHH99PSfe/lI00nlxGzVeG2
         IAs5Wr9tNk/d6ayUx4nCEjLkWNBpdkUNb97bw0XlUFmbYG9Hc0N/0I2Q+RveReAMDHec
         +y0ZBE1XOX5WIC7Ql/dWL7kMkDVF7tHrara04nFlWxc7WEaghnoEs/5ImFS0DICVaI/Q
         srKU7WPzMwvmLU+HAn0NLIz7Eg2poHZ/pnGfsepCAttdpdWFUGHHqcL00nM+sBiQUXZz
         cXbA==
X-Received: by 10.152.43.82 with SMTP id u18mr412086lal.86.1370651258808; Fri,
 07 Jun 2013 17:27:38 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 7 Jun 2013 17:27:38 -0700 (PDT)
In-Reply-To: <1370641344-4253-16-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: QKWWiflLTKYRiDuDMkJmr40xYfs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226771>

On Fri, Jun 7, 2013 at 5:42 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |   42 +++++++++++++++++=
----------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 1c34ada..f37488b 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -133,22 +133,7 @@ while (<STDIN>) {
>         @cmd =3D split(/ /);
>         if (defined($cmd[0])) {
>                 # Line not blank
> -               if ($cmd[0] eq "capabilities") {
> -                       die("Too many arguments for capabilities\n") =
if (defined($cmd[1]));
> -                       mw_capabilities();
> -               } elsif ($cmd[0] eq "list") {
> -                       die("Too many arguments for list\n") if (defi=
ned($cmd[2]));
> -                       mw_list($cmd[1]);
> -               } elsif ($cmd[0] eq "import") {
> -                       die("Invalid arguments for import\n") if ($cm=
d[1] eq "" || defined($cmd[2]));
> -                       mw_import($cmd[1]);
> -               } elsif ($cmd[0] eq "option") {
> -                       die("Too many arguments for option\n") if ($c=
md[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));
> -                       mw_option($cmd[1],$cmd[2]);
> -               } elsif ($cmd[0] eq "push") {
> -                       mw_push($cmd[1]);
> -               } else {
> -                       print STDERR "Unknown command. Aborting...\n"=
;
> +               if (parse_commands() =3D=3D 1) {
>                         last;

Better. A few minor nits:

The new subroutine is only parsing/invoking a single command at a time
from the input line rather than multiple commands, so the name
parse_commands() is slightly misleading. Perhaps parse_command() would
be more appropriate.

Now that the functionality has been pushed into a subroutine, it does
not necessarily need to be accessing global @cmd. It might be
appropriate to pass @cmd as an argument to parse_command() (or not
depending upon your preference).

The "Unknown command. Aborting" case indicates a failure. It's pretty
typical for failures to return false rather than true. The resulting
conditional would then read a bit more idiomatically:

  if (!parse_command(\@cmd)) {
    last;
  }

>                 }
>         } else {
> @@ -168,6 +153,31 @@ sub exit_error_usage {
>      die "ERROR: git-remote-mediawiki module was not called with a co=
rrect number of parameters\n";
>  }
>
> +sub parse_commands {
> +       if ($cmd[0] eq "capabilities") {
> +               die("Too many arguments for capabilities\n")
> +                   if (defined($cmd[1]));
> +               mw_capabilities();
> +       } elsif ($cmd[0] eq "list") {
> +               die("Too many arguments for list\n") if (defined($cmd=
[2]));
> +               mw_list($cmd[1]);
> +       } elsif ($cmd[0] eq "import") {
> +               die("Invalid arguments for import\n")
> +                   if ($cmd[1] eq "" || defined($cmd[2]));
> +               mw_import($cmd[1]);
> +       } elsif ($cmd[0] eq "option") {
> +               die("Too many arguments for option\n")
> +                   if ($cmd[1] eq "" || $cmd[2] eq "" || defined($cm=
d[3]));
> +               mw_option($cmd[1],$cmd[2]);
> +       } elsif ($cmd[0] eq "push") {
> +               mw_push($cmd[1]);
> +       } else {
> +               print STDERR "Unknown command. Aborting...\n";
> +               return 1;
> +       }
> +       return 0;
> +}
> +
>  # MediaWiki API instance, created lazily.
>  my $mediawiki;
>
> --
