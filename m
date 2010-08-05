From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] rebase -i: add exec command to launch a shell command
Date: Thu, 5 Aug 2010 13:31:18 +0000
Message-ID: <AANLkTinWvJvNOj6Ga7LgTMmEF37GbZN=hQBFJz4EBry5@mail.gmail.com>
References: <1281013217-29577-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 05 15:31:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh0Xe-0002MR-RI
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 15:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933273Ab0HENbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 09:31:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64941 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933220Ab0HENbU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 09:31:20 -0400
Received: by iwn33 with SMTP id 33so207252iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IANn2n5TKY9ZXXF8Ed1jO/LikiKdpZExo8L38FaeNpY=;
        b=kQ3PuKB91FIzRtqQU7YIldbcDWLEWEEiHqoM20CF0foRNmHpWQ1ytkW52Pv+Zzp3bX
         LSs5U4bap3fvE7QWTIPMIQKyXv66KQo5xLH9h8K/Dbf9WcyzMC6uFIOPN1bcgCqNsr19
         pAsrgDWgsyXJaIdd0S/biB+0zuEIlnVBYdpng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r6pd73AE+N86gRn91eRdfNyr2m7KpFdlb/2eCTFmDAtovWuhA47IQdkKFgaDOYMbdz
         j4B7I4UnKgiY6c8XNFs8GDgEplU4K0A+eDlsncnF0FZas/vTi3atPCagwLEl6dwzcMFj
         bPLIVSSBy5CkmaUhQPhvZNHr6Zk+8vaTeKYg0=
Received: by 10.231.183.81 with SMTP id cf17mr12125816ibb.32.1281015078647; 
	Thu, 05 Aug 2010 06:31:18 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 5 Aug 2010 06:31:18 -0700 (PDT)
In-Reply-To: <1281013217-29577-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152659>

On Thu, Aug 5, 2010 at 13:00, Matthieu Moy <Matthieu.Moy@imag.fr> wrote=
:
> The typical usage pattern would be to run a test (or simply a compila=
tion
> command) at given points in history.
>
> The shell command is ran (from the worktree root), and the rebase is
> stopped when the command fails, to give the user an opportunity to fi=
x
> the problem before continuing with "git rebase --continue".
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>
> So, back to the "run from tree root", but that't now properly
> documented and tested.
>
> One notable difference with my first version is that the command is
> ran in a subshell, defaulting to $SHELL (typically for users like me
> with $SHELL=3Dzsh who may want to take advantage of their shell's
> advanced features)
>
> =C2=A0Documentation/git-rebase.txt =C2=A0| =C2=A0 24 ++++++++++++++++=
+++
> =C2=A0git-rebase--interactive.sh =C2=A0 =C2=A0| =C2=A0 20 +++++++++++=
+++++
> =C2=A0t/lib-rebase.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A02 +
> =C2=A0t/t3404-rebase-interactive.sh | =C2=A0 50 +++++++++++++++++++++=
++++++++++++++++++++
> =C2=A04 files changed, 96 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index be23ad2..4bd4b66 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -459,6 +459,30 @@ sure that the current HEAD is "B", and call
> =C2=A0$ git rebase -i -p --onto Q O
> =C2=A0-----------------------------
>
> +Reordering and editing commits usually creates untested intermediate
> +steps. =C2=A0You may want to check that your history editing did not=
 break
> +anything by running a test, or at least recompiling at intermediate
> +points in history by using the "exec" command (shortcut "x"). =C2=A0=
You may
> +do so by creating a todo list like this one:
> +
> +-------------------------------------------
> +pick deadbee Implement feature XXX
> +fixup f1a5c00 Fix to feature XXX
> +exec make
> +pick c0ffeee The oneline of the next commit
> +edit deadbab The oneline of the commit after
> +exec cd subdir; make test
> +...
> +-------------------------------------------
> +
> +The interactive rebase will stop when a command fails (i.e. exits wi=
th
> +non-0 status) to give you an opportunity to fix the problem. You can
> +continue with `git rebase --continue`.
> +
> +The "exec" command launches the command in a shell (the one specifie=
d
> +in `$SHELL`, or the default shell if `$SHELL` is not set), so you ca=
n
> +use usual shell commands like "cd". The command is run from the

I think that needs a definite article: ".. use the usual ..".

> +# debugging-friendly alternatives to "test -f" and "test ! -f"
> +file_must_exist () {
> + =C2=A0 =C2=A0if ! [ -f "$1" ]; then
> + =C2=A0 =C2=A0 =C2=A0 echo "file $1 not created."
> + =C2=A0 =C2=A0 =C2=A0 false
> + =C2=A0 =C2=A0fi
> +}
> +
> +file_must_not_exist () {
> + =C2=A0 =C2=A0if [ -f "$1" ]; then
> + =C2=A0 =C2=A0 =C2=A0 echo "file $1 created while it shouldn't have.=
 $2"
> + =C2=A0 =C2=A0 =C2=A0 false
> + =C2=A0 =C2=A0fi
> +}

As I pointed out in a previous comment to the series this sort of
debug code should either be converted to use "test" or we should
incorporate it into test-lib.sh and use it everywhere.

I somewhat like the latter. It's sometimes hard to see what's going
wrong with our tests. It'd also translate to TAP subtests.

Otherwise this all looks good. Especially without the fragile mkdir/chd=
ir
part present in a previous submission.
