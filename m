From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv4 2/2] git rebase -i: warn about removed commits
Date: Wed, 03 Jun 2015 19:38:31 +0200
Message-ID: <vpq1thsbsko.fsf@anie.imag.fr>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 03 19:39:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Cd0-00023l-Vt
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbbFCRip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 13:38:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45673 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708AbbFCRin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:38:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t53HcTPA011417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2015 19:38:29 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t53HcVJK011370;
	Wed, 3 Jun 2015 19:38:31 +0200
In-Reply-To: <1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	("Galan \=\?iso-8859-1\?Q\?R\=E9mi\=22's\?\= message of "Wed, 3 Jun 2015 13:44:19
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jun 2015 19:38:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t53HcTPA011417
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433957909.81347@R0lntJumq9sRDIFoztvL/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270708>

Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Check if commits were removed (i.e. a line was deleted) and print
> warnings or abort git rebase depending on the value of the
> configuration variable rebase.missingCommits.

Spelled missingCommitsCheck everywhere else.

> +rebase.missingCommitsCheck::
> +	If set to "warn" print warnings about removed commits in

If set to warn, print (comma). Here and below

> +	interactive mode. If set to "error" print the warnings and
> +	abort the rebase. If set to "ignore" no checking is
> +	done. "ignore" by default.


> +# Print the list of the SHA-1 of the commits
> +# from a todo list in a file.
> +# $1: todo-file, $2: outfile
> +todo_list_to_sha_list () {
> +	git stripspace --strip-comments <"$1" | while read -r command sha1 =
rest

I'd split the line in two:

	git stripspace --strip-comments <"$1" |
	while read -r command sha1 rest

> +	do
> +		case $command in
> +		x|"exec")
> +			;;
> +		*)
> +			printf "%s\n" "$sha1"
> +			;;
> +		esac
> +	done >"$2"
> +}

You're using $1 and $2 only to redirect input and output. I would find
it more elegant to write todo_list_to_sha_list as a filter, and do the
redirection in the call site (to keep the option of using
todo_list_to_sha_list in a pipe).

> +check_commits

You're not really checking commits, but rather the todo-list.

> +Use git --config rebase.missingCommitsCheck to change the level of w=
arnings (ignore, warn, error).

Long line. Please, wrap the message to <80 columns.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
