From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH] shell: Rewrite documentation and improve error message
Date: Sun, 22 Aug 2010 01:00:22 -0500
Message-ID: <AANLkTi=u7VUhz4VrU2hdd3SXK7rMvMrijL-X9qXCG1vs@mail.gmail.com>
References: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 08:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On3ba-0002Bi-Q5
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 08:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab0HVGA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Aug 2010 02:00:26 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:47075 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751329Ab0HVGAZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 02:00:25 -0400
X-AuditID: 12074424-b7b2bae000005b3f-be-4c70bce82507
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id C7.5D.23359.8ECB07C4; Sun, 22 Aug 2010 02:00:09 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o7M60NFU003171
	for <git@vger.kernel.org>; Sun, 22 Aug 2010 02:00:24 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7M60MQV014048
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 22 Aug 2010 02:00:23 -0400 (EDT)
Received: by iwn5 with SMTP id 5so2404486iwn.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 23:00:22 -0700 (PDT)
Received: by 10.231.59.83 with SMTP id k19mr4381849ibh.178.1282456822286; Sat,
 21 Aug 2010 23:00:22 -0700 (PDT)
Received: by 10.231.154.212 with HTTP; Sat, 21 Aug 2010 23:00:22 -0700 (PDT)
In-Reply-To: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
X-Brightmail-Tracker: AAAAAxWs/CYVrch4Fa3v2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154168>

Warning: the following email contains lots of nitpicks.  Proceed at
your own risk.

> +A login shell for SSH accounts to provide restricted Git access. Whe=
n
> +'-c' is given, the program executes <command> non-interactively;
> +<command> can be one of 'git receive-pack', 'git upload-pack', 'git
> +upload-archive', 'cvs server', or a command in COMMAND_DIR. The shel=
l
> +is started in interactive mode when no arguments are given; in this
> +case, COMMAND_DIR must exist, and any of the executables in them can
s/in them/in it/

> +COMMAND_DIR is the path 'git-shell-commands' in the user's home
> +directory. The user must have read and execute permissions to the
- Maybe instead 'COMMAND_DIR is the path "$HOME/git-shell-commands"'?
> +directory for it to be useful.
- I would be more specific here, and instead change this insertion to
something like: "directory in order to execute commands in it."
- What about adding something like 'Commands in COMMAND_DIR are run
with a cwd of $HOME'
- Perhaps note that if a COMMAND_DIR program is invoked, 'argument' is
parsed as a command-line?

>
> =A0Author
> =A0------
> diff --git a/shell.c b/shell.c
> index ffed615..3fb804e 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -152,8 +152,11 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0} else if (argc =3D=3D 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Allow the user to run an interactiv=
e shell */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd_to_homedir();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (access(COMMAND_DIR, R_OK | X_OK) =3D=
=3D -1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Sorry, the interac=
tive git-shell is not enabled");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (access(COMMAND_DIR, R_OK | X_OK) =3D=
=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Inteactive git she=
ll is not enabled.\n"
s/Inteactive/Interactive/

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hint: " COMMAN=
D_DIR " should exist "
I would recommend displaying ~/$COMMAND_DIR instead, or
$HOME/COMMAND_DIR.  The latter could be considered an information leak
though.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "and have read =
and execute access.");

Sounds fine to me otherwise.  Thanks for starting on this.
