From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 00/13] bash prompt speedup
Date: Tue, 18 Jun 2013 04:28:26 +0200
Message-ID: <20130618022826.GA2204@goldbirke>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:28:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoleq-00021M-Tc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab3FRC23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:28:29 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:55619 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab3FRC22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:28:28 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MNezy-1Uhe7N0UqA-006fsA; Tue, 18 Jun 2013 04:28:27 +0200
Content-Disposition: inline
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:9OPbqlH+l2fFtu3JUxLNdwlYtswbHFd1nhOPgpzhKQo
 UheONsOSYTKX2+0wVMUKYFIwE3W6JNMkNemfl4ryZt5py2AQWn
 4n9PSCoe3SEVEdJN1yVHE/ClHlTXWxTWKzcVvy5LyQjvoMJovD
 CSN6wu5uRc20Ad5KX95bMlEcHABCFl4z5aG7Yc/5BUCMbaypTg
 sLuN6pDwBWlMT9LJBvihBrFoMm4clUAJ5GZ5Ucwh4TfATJLqi9
 t0wOTz64ZtvjGhs+ETza8ZXcZzqAHK0jWTvD446z5ZJuNA60D9
 rvY5FcnIcDEzHazA9Lo3DrGNlMFbXFFVqjrl9XJpgQiVCG9L6d
 bsowUjcp1tE4I9rHk5KE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228148>

=46orgot to mention that it's built on top of 2847cae8 (prompt: squelch
error output from cat, 2013-06-14).


Best,
G=E1bor


On Tue, Jun 18, 2013 at 04:16:53AM +0200, SZEDER G=E1bor wrote:
> Hi,
>=20
> displaying the git-specific bash prompt on Windows/MinGW takes quite
> long, long enough to be noticeable.  This is mainly caused by the
> numerous fork()s and exec()s to create subshells and run git or other
> commands, which are rather expensive on Windows.
>=20
> This patch series eliminates many command substitutions and commands
> in __git_ps1() from top to bottom by replacing them with bash builtin=
s
> or consolidating them.  A few timing results are shown in the log
> message of patch 10.
>=20
>=20
> SZEDER G=E1bor (13):
>   bash prompt: fix redirection coding style in tests
>   bash prompt: fix here document indentation in interactive rebase te=
st
>   completion, bash prompt: move __gitdir() tests to completion test
>     suite
>   bash prompt: add a test for symbolic link symbolic refs
>   bash prompt: return early from __git_ps1() when not in a git
>     repository
>   bash prompt: run 'git rev-parse --git-dir' directly instead of
>     __gitdir()
>   bash prompt: use bash builtins to find out rebase state
>   bash prompt: use bash builtins to find out current branch
>   bash prompt: use bash builtins to get detached HEAD abbrev. object
>     name
>   bash prompt: combine 'git rev-parse' executions
>   bash prompt: use bash builtins to check stash state
>   bash prompt: avoid command substitution when checking for untracked
>     files
>   bash prompt: avoid command substitution when finalizing gitstring
>=20
>  contrib/completion/git-completion.bash |   2 -
>  contrib/completion/git-prompt.sh       | 223 ++++++++++++-----------
>  t/t9902-completion.sh                  | 134 ++++++++++++++
>  t/t9903-bash-prompt.sh                 | 319 +++++++++++------------=
----------
>  4 files changed, 345 insertions(+), 333 deletions(-)
>=20
> --=20
> 1.8.3.1.487.g8f4672d
>=20
