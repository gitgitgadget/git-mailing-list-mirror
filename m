From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list 
	available repositories
Date: Tue, 27 Jul 2010 23:15:49 -0700
Message-ID: <AANLkTik1D45_cHPapbmMMys-V544ssCyoxrs5Fxck7oP@mail.gmail.com>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
	<20100726232855.GA3157@burratino>
	<AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
	<201007270916.59210.j.sixt@viscovery.net>
	<20100727174105.GA5578@burratino>
	<AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com>
	<20100728003336.GA2248@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 08:16:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odzvt-0002JK-DC
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 08:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab0G1GP4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 02:15:56 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:45371 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752012Ab0G1GPz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 02:15:55 -0400
X-AuditID: 1209190e-b7bbeae000000a09-e0-4c4fcb1bef3f
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 3B.90.02569.B1BCF4C4; Wed, 28 Jul 2010 02:15:56 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6S6FqlJ012288
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 02:15:53 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6S6Fos8015886
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 02:15:52 -0400 (EDT)
Received: by iwn7 with SMTP id 7so4522621iwn.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 23:15:50 -0700 (PDT)
Received: by 10.231.34.70 with SMTP id k6mr11336943ibd.25.1280297750053; Tue, 
	27 Jul 2010 23:15:50 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Tue, 27 Jul 2010 23:15:49 -0700 (PDT)
In-Reply-To: <20100728003336.GA2248@dert.cs.uchicago.edu>
X-Brightmail-Tracker: AAAAAxVg7SYVYaj1FWHD7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152041>

> No, it was only a vague thing. =A0I do not even use git-shell
> myself, so it was a vague worry for a scenario I am not even
> involved in. =A0So if you have thought it over and decided it is
> not an issue, that is good enough for me.
>
> What would be most comforting is an explanation like this:
>
> =A0"Uses not using this feature will not be impacted by patch 1,
> =A0since all it adds is:
>
> =A0 - some memory allocation
> =A0 - a call to split_cmdline, which I have audited and
> =A0 =A0 seems to be safe
> =A0 - an execv that does not permit . or / characters and so
> =A0 =A0 can only run commands from the directory the user is
> =A0 =A0 in (which would be safe because..."
>
> Actually if I understand correctly I am not comforted at all,
> because a former user at a multi-user installation that only has
> git-shell access now can suddenly run arbitrary commands from
> the home directory once git is upgraded.
So, I think the full story here is that "if one can create a
git-shell-commands directory in the home directory of a user with
login shell git-shell, then the latter user can then run arbitrary
commands."  So there's a prerequisite of being able to write to the
git-shell user's $HOME, but if I can do that, I can presumably clobber
the hooks in the git-shell user's git repositories, which can also
allow arbitrary commands to be run.  So in some sense, providing this
functionality should be no worse than providing hooks.

That being said, perhaps one place where I could imagine this being
different is if:
- a nonbare repository is created in the git-shell user's $HOME directo=
ry
- an attacker creates a 'git-shell-commands' directory in a commit to
the repository
- someone checks out a commit with the 'git-shell-commands' directory.

One could avoid this by requiring that git-shell verify that the
user's home directory is not a non-bare repository.  However, I don't
view this as a regression because in this case, the attacker could
craft the git-shell user's dotfiles.  This would lead to arbitrary
command execution by e.g. setting the pager to /tmp/myevilscript in
=2Emanpath and running

  ssh git-shell-user@example.com "git-upload-pack '--help'"

That aside, here's an analysis of my patch series:
Patch 1 just adds
* Some memory allocation.
* A call to split_cmdline.  This splits a string on spaces, respecting
quotes and escaping via \.  I have audited it and it seems safe.
* An execv.  The command name is of the form
"git-shell-commands/$CLEAN" where $CLEAN does not contain . or /.
Thus it can only be run from the current working directory.  This will
be the git-shell user's $HOME if git-shell was spawned as a login
shell.  This will be an arbitrary directory if a user can 'su' to the
git-shell user.  (I am however starting to lean towards always
chdir'ing into the git-shell user's $HOME, do people feel strongly
about this in either direction?)
* An error message.

Patch 2 adds
* A call to run_shell, but only if the 'git-shell-commands' directory
is accessible.
* run_shell runs git-shell-commands/help and then runs in a loop
* a call to split_cmdline on user supplied input
* the user can type 'quit', 'exit', etc.. which will terminate the
shell, returning 0.
* an execv on a command of the form "git-shell-commands/$CLEAN", where
again $CLEAN does not contain . or /.
* an invalid command will restart the command loop

Patch 3 adds a list command and a help command to
contrib/git-shell-commands, which will only be used if
git-shell-commands is enabled.  (Note: I'd like to make a small change
to list, namely add a 2>/dev/null to the find command.)

See anything I'm missing?

Thanks,

Greg
