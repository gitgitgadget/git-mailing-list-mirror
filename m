From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv5 2/3] git rebase -i: warn about removed commits
Date: Wed, 10 Jun 2015 16:53:32 +0200
Message-ID: <vpqvbevty1f.fsf@anie.imag.fr>
References: <1433931035-20011-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433931035-20011-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Galan =?iso-8859-1?Q?R=E9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:54:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hOA-00042O-RL
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 16:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbbFJOxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 10:53:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60750 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110AbbFJOxw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 10:53:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AErVdq015016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 16:53:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AErXUE024063;
	Wed, 10 Jun 2015 16:53:33 +0200
In-Reply-To: <1433931035-20011-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	("Galan \=\?iso-8859-1\?Q\?R\=E9mi\=22's\?\= message of "Wed, 10 Jun 2015 12:10:34
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 10 Jun 2015 16:53:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5AErVdq015016
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434552816.17458@a6cI0gGSliHESKi0Yi4MxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271293>

Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Check if commits were removed (i.e. a line was deleted) and print
> warnings or stop git rebase depending on the value of the
> configuration variable rebase.missingCommitsCheck.
>
> This patch gives the user the possibility to avoid silent loss of
> information (losing a commit through deleting the line in this case)
> if he wants.
>
> Add the configuration variable rebase.missingCommitsCheck.
>     - When unset or set to "ignore", no checking is done.
>     - When set to "warn", the commits are checked, warnings are
>       displayed but git rebase still proceeds.
>     - When set to "error", the commits are checked, warnings are
>       displayed and the rebase is stopped.
>       (The user can then use 'git rebase --edit-todo' and
>       'git rebase --continue', or 'git rebase --abort')
>
> rebase.missingCommitsCheck defaults to "ignore".
>
> Signed-off-by: Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-inp.=
fr>
> ---
>  In git-rebase--interactive, in the error case of check_todo_list, I
>  added 'git checkout $onto' so that using 'die' for the error allows
>  to use 'git rebase --edit-todo' (otherwise HEAD would not have been
>  changed and it still would be placed after the commits of the
>  rebase).
>  Since now it doesn't abort the rebase, the documentation and the
>  messages in the case error have changed.
>  I moved the error case away from the initial test case for missing
>  commits as to prepare for 3/3 part of the patch. It is something tha=
t
>  was advised by Eric Sunshine when I checked both missing and
>  duplicated commits, but that I removed it when removing the checking
>  for duplicated commits since there was only one test. However I add
>  it again since 3/3 will add more checking.
>  I use the variable raiseError that I affect if the error must be
>  raised instead of testing directly because I think it makes more
>  sense with 3/3 and if we add other check in the future since it adds
>  more possible errors (the test for the error case if not something
>  like 'if (test checkLevel =3D error && test -s todo.miss) || test co=
nd2
>  || test cond3 || ...').
>  I am wondering if a check_todo_list call should be added in the
>  '--continue' part of the code: with this patch, the checking is only
>  done once, if the user doesn't edit correctly with 'git rebase
>  --edit-todo', it won't be picked by this.
>  In the tests in t3404 I now also test that the warning/error message=
s
>  are correct.
>  I tried to not change this patch too much since it was already
>  heavily reviewed, but there are some changes (mostly the ones
>  mentionned above).
>
>  Documentation/config.txt      | 11 +++++
>  Documentation/git-rebase.txt  |  6 +++
>  git-rebase--interactive.sh    | 96 +++++++++++++++++++++++++++++++++=
++++++++++
>  t/t3404-rebase-interactive.sh | 66 +++++++++++++++++++++++++++++
>  4 files changed, 179 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4d21ce1..25b2a04 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2160,6 +2160,17 @@ rebase.autoStash::
>  	successful rebase might result in non-trivial conflicts.
>  	Defaults to false.
> =20
> +rebase.missingCommitsCheck::
> +	If set to "warn", git rebase -i will print a warning if some
> +	commits are removed (e.g. a line was deleted), however the
> +	rebase will still proceed. If set to "error", it will print
> +	the previous warning and stop the rebase, 'git rebase
> +	--edit-todo' can then be used to correct the error. If set to
> +	"ignore", no checking is done.
> +	To drop a commit without warning or error, use the `drop`
> +	command in the todo-list.
> +	Defaults to "ignore".
> +
>  receive.advertiseAtomic::
>  	By default, git-receive-pack will advertise the atomic push
>  	capability to its clients. If you don't want to this capability
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 34bd070..2ca3b8d 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -213,6 +213,12 @@ rebase.autoSquash::
>  rebase.autoStash::
>  	If set to true enable '--autostash' option by default.
> =20
> +rebase.missingCommitsCheck::
> +	If set to "warn", print warnings about removed commits in
> +	interactive mode. If set to "error", print the warnings and
> +	stop the rebase. If set to "ignore", no checking is
> +	done. "ignore" by default.
> +
>  OPTIONS
>  -------
>  --onto <newbase>::
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 72abf90..68a71d0 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -834,6 +834,100 @@ add_exec_commands () {
>  	mv "$1.new" "$1"
>  }
> =20
> +# Print the list of the SHA-1 of the commits
> +# from stdin to stdout
> +todo_list_to_sha_list () {
> +	git stripspace --strip-comments |
> +	while read -r command sha1 rest
> +	do
> +		case $command in
> +		"$comment_char"*|''|noop|x|"exec")
> +			;;
> +		*)
> +			printf "%s\n" "$sha1"
> +			;;
> +		esac
> +	done
> +}
> +
> +# Use warn for each line of a file
> +# $1: file
> +warn_file () {
> +	while read -r line
> +	do
> +		warn " - $line"
> +	done <"$1"
> +}
> +
> +# Check if the user dropped some commits by mistake
> +# Behaviour determined by rebase.missingCommitsCheck.
> +check_todo_list () {
> +	raiseError=3Df
> +
> +	checkLevel=3D$(git config --get rebase.missingCommitsCheck)
> +	checkLevel=3D${checkLevel:-ignore}
> +	# Don't be case sensitive
> +	checkLevel=3D$(echo "$checkLevel" | tr 'A-Z' 'a-z')

Avoid echo on user-supplied data. If $checkLevel starts with a "-", the
behavior is platform-dependant. Should not happen if the user is
sensible, but using

  printf '%s' "$checkLevel"

is safer.

> +			opt=3D"--no-walk=3Dsorted --format=3Doneline --abbrev-commit --st=
din"
> +			git rev-list $opt <"$todo".miss >"$todo".miss+
> +			mv "$todo".miss+ "$todo".miss
> +
> +			warn "Warning: some commits may have been dropped" \
> +				"accidentally."
> +			warn "Dropped commits (newer to older):"
> +			warn_file "$todo".miss

I would find it more elegant with less intermediate files, like

git rev-list $opt <"$todo".miss | while read -r line
do
	warn " - $line"
done

> +	if test $raiseError =3D t
> +	then
> +		# Checkout before the first commit of the
> +		# rebase: this way git rebase --continue
> +		# will work correctly as it expects HEAD to be
> +		# placed before the commit of the next action
> +		GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION: checkout $onto_name"
> +		output git checkout $onto || die_abort "could not detach HEAD"
> +		git update-ref ORIG_HEAD $orig_head

This is cut-and-pasted from below in the same file. It would deserve a
helper function I think.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
