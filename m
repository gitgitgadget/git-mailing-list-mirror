From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv3 2/2] git rebase -i: warn about removed commits
Date: Tue, 02 Jun 2015 16:56:01 +0200
Message-ID: <vpqzj4ignwe.fsf@anie.imag.fr>
References: <1433252180-25591-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433252180-25591-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Tue Jun 02 16:56:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yznc5-0004qB-TL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759202AbbFBO4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 10:56:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39843 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755895AbbFBO4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:56:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t52EtxkS008641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2015 16:55:59 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t52Eu1p4014210;
	Tue, 2 Jun 2015 16:56:01 +0200
In-Reply-To: <1433252180-25591-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	("Galan \=\?iso-8859-1\?Q\?R\=E9mi\=22's\?\= message of "Tue, 2 Jun 2015 15:36:20
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 02 Jun 2015 16:56:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t52EtxkS008641
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433861761.57976@y4SnZylnRPv7iIZ3q0DZLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270553>

Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Check if commits were removed (i.e. a line was deleted) and print
> warnings or abort git rebase according to the value of the

s/according to/depending on/

(although both translate to the same "selon" in french ;-))

> configuration variable rebase.missingCommitsCheckLevel.

Now I'm wondering whether rebase.missingCommits would be sufficient. Th=
e
full config would be

[rebase]
	missingCommits =3D warn

which reads like "in rebase, on missing commit, warn me".

> Add the configuration variable rebase.missingCommitsCheckLevel.
>     - When unset or set to "ignore", no checking is done.
>     - When set to "warn", the commits are checked, warnings are
>       displayed but git rebase still proceeds.
>     - When set to "error", the commits are checked, warnings are
>       displayed and the rebase is aborted.
>
> rebase.missingCommitsCheckLevel defaults to "ignore".

This all describes well *what* the commit is doing (which is essentiall=
y
rendundant with the documentation actually), but fails to really explai=
n
*why*, which is the most important question to adress in a commit
message.

I'm convinced that this is a good idea (partly because I'm the one who
suggested ^^), but not everybody is.

> +rebase.missingCommitsCheckLevel::
> +	If set to "warn", git rebase -i will print a warning if some
> +	commits are removed (i.e. a line was deleted), however the
> +	rebase will still proceed. If set to "error", it will print
> +	the previous warning and abort the rebase. If set to
> +	"ignore", no checking is done.  Defaults to "ignore".

I think the relationship with 'drop' should be clarified here.

"To drop a commit without warning or error, use the `drop` command in t=
he
todo-list."

?

> +# Print the list of the SHA-1 of the commits
> +# from a todo list in a file.
> +# $1: todo-file, $2: outfile
> +todo_list_to_sha_list () {
> +	todo_list=3D$(git stripspace --strip-comments <"$1")
> +	temp_file=3D$(mktemp)

c5770f7 (contrib/diffall: create tmp dirs without mktemp, 2012-03-14)
says "mktemp is not available on all platforms." ...

> +	echo "$todo_list" >$temp_file

Don't use echo on user-supplied data. It's not portable (think what
happens if $todo_list starts with a -).

printf '%s' "$todo_list"

You don't need all these intermediate variables/files. It looks like yo=
u
want

git stripspace --strip-comments | while read -r command sha1 rest
do
=2E..

> +# Transforms SHA-1 list in argument
> +# to a list of commits (in place)
> +# Doesn't check if the SHA-1 are commits.

s/if/whether/

> +# $1: file with long SHA-1 list
> +long_sha_to_commit_list () {
> +	short_missing=3D""
> +	git_command=3D"git show --oneline"
> +	get_line_command=3D"head -n 1"
> +	temp_file=3D$(mktemp)
> +	while read -r sha
> +	do
> +		if test -n "$sha"
> +		then
> +			commit=3D$($git_command $sha | $get_line_command)

Why not git show --oneline $sha without using this $git_command?

To me

  git show --oneline $sha | head -n 1

says all that has to be said, while

  $git_command $sha | $get_line_command

does not say anything (although it uses more characters).

But actually, computing the diff with `git show` and eliminating it wit=
h
`head` seems backwards.

I guess you want something like:

  git rev-list --pretty=3Doneline -1 $sha

And the whole long_sha_to_commit_list is more or less equivalent to

  git rev-list --stdin --no-walk --format=3Doneline --abbrev-commit

(Yes, git was _meant_ to be scriptable, and it really is)

> +# Use warn for each line of a file
> +# $1: file to warn

I don't parse "file to warn". I'd rather warn the user than a file ;-).

> +# Check if the user dropped some commits by mistake
> +# Behaviour determined by .gitconfig.

not necessarily .gitconfig, there are other names. Say
rebase.missingCommitsCheckLevel if you want to be technically accurate.

> +check_commits () {
> +	checkLevel=3D$(git config --get rebase.missingCommitsCheckLevel)
> +	checkLevel=3D${checkLevel:-ignore}
> +	# To lowercase
> +	checkLevel=3D$(echo "$checkLevel" | tr 'A-Z' 'a-z')

Good comments insist on _why_ not _what_. I'd write:

	# Don't be case sensitive
	checkLevel=3D$(echo "$checkLevel" | tr 'A-Z' 'a-z')

> +	case "$checkLevel" in
> +	warn|error)
> +		# Get the SHA-1 of the commits
> +		todo_list_to_sha_list "$todo".backup "$todo".oldsha1
> +		todo_list_to_sha_list "$todo" "$todo".newsha1
> +
> +		# Sort the SHA-1 and compare them
> +		echo "$(sort -u "$todo".oldsha1)" >"$todo".oldsha1
> +		echo "$(sort -u "$todo".newsha1)" >"$todo".newsha1

Useless uses of echo.

echo $(foo) -> foo

> +			warn "Warning : some commits may have been dropped" \

No space before : in english (hmm, didn't I already notice this one?)

> +			warn "Use git --config rebase.missingCommitsCheckLevel to change"=
 \
> +				"the level of warnings (ignore,warn,error)."

Spaces after commas, or (ignore/warn/error).

> +		warn "Unrecognized setting $checkLevel for option" \
> +			"rebase.missingCommitsCheckLevel in git rebase -i."

I'd drop the "in git rebase -i" part. The user may have run "git rebase
--interactive" and not know -i, and normally already knows which comman=
d
is executed.

> +test_expect_success 'rebase -i respects rebase.missingCommitsCheckLe=
vel=3Derror' '
> +	test_config rebase.missingCommitsCheckLevel error &&
> +	test_when_finished "git checkout master &&
> +		git branch -D tmp2" &&
> +	git checkout -b tmp2 master &&
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES=3D"1 2 3 4" \
> +		git rebase -i --root &&
> +	test E =3D $(git cat-file commit HEAD | sed -ne \$p)
> +'

You should test also that

git rebase --edit-todo # playing with $EDITOR to restore the original l=
ines.
git rebase --continue

actually continues. You did have problems with this in early
implementations, so it's not straightforward, so it deserves a test.

You should check the output of git rebase -i too.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
