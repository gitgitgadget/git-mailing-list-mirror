From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Aug 2011, #03; Thu, 11)
Date: Wed, 24 Aug 2011 12:14:55 +0200
Message-ID: <4E54CF1F.7020608@kdbg.org>
References: <7vr54rpogf.fsf@alter.siamese.dyndns.org> <4E4D7DD3.2000701@obry.net> <7vhb5e73hy.fsf@alter.siamese.dyndns.org> <4E502302.4000300@ramsay1.demon.co.uk> <7vaab0rodu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, pascal@obry.net,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 12:15:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwAUD-0007Qi-Lx
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 12:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566Ab1HXKPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Aug 2011 06:15:00 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:27604 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751395Ab1HXKO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 06:14:57 -0400
Received: from [77.117.184.250] (77.117.184.250.wireless.dyn.drei.com [77.117.184.250])
	by bsmtp.bon.at (Postfix) with ESMTP id E70A02C400E;
	Wed, 24 Aug 2011 12:14:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vaab0rodu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179993>

Am 23.08.2011 20:09, schrieb Junio C Hamano:
> Ramsay Jones<ramsay@ramsay1.demon.co.uk>  writes:
>
>> Commit 704c335 (On Cygwin support both UNIX and DOS style path-names=
,
>> 05-08-2011) in pu needs an update to fix the commit message.
>
> Thanks for a reminder, Ramsay.
>
> Here is the exchange where fixing the commit log was mentioned.
>
>      From: Pascal Obry<pascal@obry.net>
>      Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS sty=
le path-names
>      To: Ramsay Jones<ramsay@ramsay1.demon.co.uk>
>      Cc: git@vger.kernel.org
>      Date: Sat, 13 Aug 2011 19:34:37 +0200
>      Message-ID:<4E46B5AD.5050806@obry.net>
>
>      Le 11/08/2011 22:35, Ramsay Jones a =C3=A9crit :
>      >    ... could you please correct your commit message. Thanks!
>
>      Done, thanks for your review.
>
>> Also, I didn't see any response to Johannes Sixt's query concerning
>> backslash in pathspec. (I personally don't want to go down that
>> route, but ...)
>
> Here is what J6t said in the message:
>
>    From: Johannes Sixt<j6t@kdbg.org>
>    Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style=
 path-names
>    Date: Tue, 09 Aug 2011 21:47:15 +0200
>    Message-ID:<4E418EC3.4070904@kdbg.org>
>
>    >  Do you also want to support this:
>    >       $ git add src\file.c
>    >  i.e., backslash in pathspec? Then you need more than this:
>    >  >  +#define has_dos_drive_prefix(path) (isalpha(*(path))&&  (pa=
th)[1] =3D=3D ':')
>    >  >  +#define is_dir_sep(c) ((c) =3D=3D '/' || (c) =3D=3D '\\')
>    >
>    >  In particular, you have to enable backslash processing in
>    >  setup.c:prefix_filename(), but then you lose the ability to esc=
ape
>    >  special characters with the backslash.
>
> When "git add src\file.c" is given from the command line, what does o=
ur
> main() see in argv[2]? Do cmd.exe and bash give us the same thing? Wh=
at if
> the command line is "git add 'src\*.c'"?

Our main() sees the string as given on the command line, i.e., with the=
=20
backslash.

> I vaguely recall that on Windows you only get a single parameter stri=
ng
> from the program loader, and arguments are split in the invoked proce=
ss,
> but that is so common that as far as our main() is concerned we can e=
xpect
> the example command line to give us argc=3D3 and argv=3D{ "git", "add=
", "???",
> NULL }. What I do not recall is if there is some other magic such as
> expanding shell globs and swapping the direction of slashes in string=
s
> involved when this argument processing is done.

There is a linker option whether shell globs should be expanded or not=20
before they are passed to main(). If the option is enabled, the expansi=
on=20
is different from the way mandated by POSIX.

There was a proposal recently (on the msysgit list?) that this option=20
should be disabled, and any expansion of pathspec (globs) should be don=
e=20
entirely by git's own expansion rules, which includes automatic recursi=
ve=20
matching. As a result, git would behave differently on Windows and Unix=
,=20
but since it already does when the linker option is enabled, we argue t=
hat=20
git's rules are superior (and Windows's linker option is inferior), we=20
better should go the proposed new route.

> You probably _could_ do '\\' ->  '/' inside prefix_filename() and
> get_pathspec(), but as J6t mentioned, we _do_ handle backslash as a
> quoting character, and this is _not_ going to change.

=2E.. not going to change on platforms where this already works. It doe=
s not=20
work on Windows.

> So even if we were to go that route, the user would need to make git =
see
> "src\\file.c" or "src\\*.c" in order to make it turn into "src/file.c=
" and
> "src/*.c" pathspec. If it means that the user needs to type:
>
> 	$ git add src\\\\file.c
>
> I would have to say that it would be simpler for them to say
>
> 	$ git add src/file.c
>
> even on Cygwin. After all, isn't Cygwin for people who are forced to =
be on
> Windows and miss POSIXy environments?
>
> By the way, Johannes, how does Git for Windows handle pathspecs?

On Windows, prefix_filename() and prefix_path() (the latter via=20
normalize_path_copy()) transform any backslashes to forward-slashes.=20
Therefore, if you have src\*.c on the command line, it is processed as=20
src/*.c. That is, if \ was meant to escape the *, then this would not=20
work. It does not help to duplicate backslashes, because all of them ar=
e=20
transformed to forward-slashes before git's glob expansion kicks in.

-- Hannes
