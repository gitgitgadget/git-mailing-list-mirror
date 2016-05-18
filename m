From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 13/21] rev-parse: add '--absolute-git-dir' option
Date: Wed, 18 May 2016 18:58:25 +0200
Message-ID: <20160518185825.Horde.EPd2nJNvqEW_VX4b01yWdIr@webmail.informatik.kit.edu>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
 <1456440650-32623-14-git-send-email-szeder@ira.uka.de>
 <CANoM8SXO_Rz_CVOz9ptsaVCzcQ2D1FQrSuFFW4vZ4SdRYMzD=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 18:58:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34o6-0007gq-Nh
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbcERQ6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2016 12:58:46 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44380 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992AbcERQ6p convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:58:45 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1b34nw-0001L7-Bu; Wed, 18 May 2016 18:58:40 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1b34nh-00035n-Lc; Wed, 18 May 2016 18:58:25 +0200
Received: from x590c0b33.dyn.telefonica.de (x590c0b33.dyn.telefonica.de
 [89.12.11.51]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 18 May 2016 18:58:25 +0200
In-Reply-To: <CANoM8SXO_Rz_CVOz9ptsaVCzcQ2D1FQrSuFFW4vZ4SdRYMzD=w@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1463590720.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294979>


Quoting Mike Rappazzo <rappazzo@gmail.com>:

> On Thu, Feb 25, 2016 at 5:54 PM SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
>>
>> Some scripts can benefit from not having to deal with the possibilit=
y
>> of relative paths to the repository, but the output of 'git rev-pars=
e
>> --git-dir' can be a relative path.  Case in point: supporting 'git -=
C
>> <path>' in our Bash completion script turned out to be considerably
>> more difficult, error prone and required more subshells and git
>> processes when we had to cope with a relative path to the .git
>> directory.
>>
>> Help these use cases and teach 'git rev-parse' a new
>> '--absolute-git-dir' option which always outputs a canonicalized
>> absolute path to the .git directory, regardless of whether the path =
is
>> discovered automatically or is specified via $GIT_DIR or 'git
>> --git-dir=3D<path>'.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>> ---
>> Documentation/git-rev-parse.txt |  4 ++++
>> builtin/rev-parse.c             | 29 +++++++++++++++++++++--------
>> t/t1500-rev-parse.sh            | 17 ++++++++++-------
>> 3 files changed, 35 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/git-rev-parse.txt
>> b/Documentation/git-rev-parse.txt
>> index b6c6326cdc7b..fb06e3118570 100644
>> --- a/Documentation/git-rev-parse.txt
>> +++ b/Documentation/git-rev-parse.txt
>> @@ -216,6 +216,10 @@ If `$GIT_DIR` is not defined and the current di=
rectory
>> is not detected to lie in a Git repository or work tree
>> print a message to stderr and exit with nonzero status.
>>
>> +--absolute-git-dir::
>> +       Like `--git-dir`, but its output is always the canonicalized
>> +       absolute path.
>> +
>> --git-common-dir::
>>    Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
>>
>
> After working a little bit with rev-parse [1], I feel that this might
> be better served as a
> stand-alone option.  Consider that in addition to --git-dir, the
> options --git-common-dir,
> --git-path, and --git-shared-index produce relative paths.
>
> I propose that it might make more sense to use something like
> `--abs-path` to indicate
> that the result should include an absolute path (or we could also
> just spell out
> `--absolute-path`).  That way we don't have to add additional options
> for any other type
> that might want an absolute path.

Do you have a specific use case in mind, where scripts struggle because
in some cases '--git-dir', '--git-common-dir' or '--git-path' return a
relative path?  (Assuming that these options produce the right relative
paths, of course.  At the moment some don't in some cases, but your
patches elsewhere will eventually take care of that.)

As far as git is concerned, relative paths are relative to the current
working directory of the git process or script.  If a script is invoked
as 'git -C subdir myscript', then the CWD is changed accordingly by the
main git process first going into the given directory before starting
the script.

Now, though I wrote that generalizing "some scripts" and "these use
cases" in the commit message, I really only meant the completion
script, because it is rather special in that it's executed in the
user's interactive shell environment.  This means that it can't just
simply 'cd' around and it has to cope with 'git -C subdir' options on
it's own, because in that case the CWD of the git processes invoked
from the completion script will be different from the CWD of the
user's shell.  That's the situation where a relative path returned
from 'git rev-parse --git-dir' causes troubles.

I can't really see other scripts in this situation, and I really don't
expect that the completion script would need any path other than the
path to the git repository, i.e. it only needs '--absolute-git-dir'.
Therefore I think that a separate '--absolute-path' option would offer
little benefit, but at the same time would pose considerable
complications, more on that below.

> git rev-parse --git-dir --abs-path
> git rev-parse --git-common-dir --absolute-path

'git rev-parse's command line option parsing loop not just parses an
option but in a lot of cases performs the necessary action right away,
before examining any subsequent options.  In the above example
it would print the path to the .git directory as soon as it encounters
'--git-dir' while iterating through the command line options, before
even noticing that there is an '--absolute-path' option as well.  If
anything, then the other way around:

     git rev-parse --absolute-path --git-dir

And if we were to go this route, then there are a bunch of questions
about the gory details that would have to be cleared up first:

Should the presence of an '--absolute-path' option influence all
subsequent path-returning options or just the one immediately
following it?  I.e. should all these options always return an
absolute path?

     git rev-parse --absolute-path --git-dir --git-common-dir \
                   --git-path objects

What about this, i.e. when there are other option(s) between
'--absolute-path' and a path-returning option?

     git rev-parse --absolute-path --is-bare-repository --git-dir

I'd think they should all return an absolute path then.

Now, should '--absolute-path' have an effect on '--show-prefix'
and '--prefix' as well?

     git rev-parse --absolute-path --show-prefix
     git rev-parse --absolute-path --prefix t/ README

Luckily, options after a filename are not allowed, so we don't even
have to think about cases like

     git rev-parse --prefix t/ README --absolute-path Makefile

as it would error out anyway.

Would we need a '--no-absolute-path' (or '--relative-path', perhaps?)
option to turn off the effect of a previous '--absolute-path', e.g.

     git rev-parse --absolute-path --git-dir \
                   --no-absolute-path --git-common-dir

If yes, should a '--no-abolute-path' force subsequent path-returning
options to return a relative path even when they by default would
return an absolute path, e.g.:

     git -C t/ rev-parse --no-absolute-path --git-dir

Or should it return a relative path even when paths are explicitly
specified as absolute paths?

     git --git-dir=3D/absolute/path/to/repo.git rev-parse =20
--no-absolute-path --git-dir
     git rev-parse --prefix /home/szeder/src/git/t/ --no-absolute-path =
README
