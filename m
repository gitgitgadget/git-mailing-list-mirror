From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: Bug report
Date: Fri, 05 Oct 2012 12:47:42 +0200
Message-ID: <87boghdwkx.fsf@centaur.cmartin.tk>
References: <61FEBCE8-8206-498C-B3D4-ECD6AF192EE0@gmail.com>
	<20121005143231.788094d675c9974f4777318d@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?0JzRg9C60L7QstC90LjQutC+0LIg0JzQuNGF0LDQuNC7?= 
	<m.mukovnikov@gmail.com>, git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:48:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK5Rl-0000A4-Hu
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 12:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151Ab2JEKrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 06:47:45 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:45440 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932072Ab2JEKro convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 06:47:44 -0400
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 43F7A81667;
	Fri,  5 Oct 2012 12:47:42 +0200 (CEST)
Received: (nullmailer pid 13878 invoked by uid 1000);
	Fri, 05 Oct 2012 10:47:43 -0000
In-Reply-To: <20121005143231.788094d675c9974f4777318d@domain007.com>
	(Konstantin Khomoutov's message of "Fri, 5 Oct 2012 14:32:31 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207096>

Konstantin Khomoutov <flatworm@users.sourceforge.net> writes:

> On Fri, 5 Oct 2012 14:13:49 +0400
> =D0=9C=D1=83=D0=BA=D0=BE=D0=B2=D0=BD=D0=B8=D0=BA=D0=BE=D0=B2 =D0=9C=D0=
=B8=D1=85=D0=B0=D0=B8=D0=BB <m.mukovnikov@gmail.com> wrote:
>
>> There's a problem using git with files having cyrillic '=D0=B9' in t=
heir
>> name, git just can't track them.
>>=20
>> uname: Darwin 12.2.0 Darwin Kernel Version 12.2.0: Sat Aug 25
>> 00:48:52 PDT 2012; root:xnu-2050.18.24~1/RELEASE_X86_64 x86_64 git
>> version: 1.7.12.1 (from macports)
>>=20
>> Steps to reproduce:
>> - git init
>> - touch test_=D0=B9
>> - git status (should be "untracked files present")
>> - git add test_=D0=B9
>> - git status
>>=20
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #	"test_\320\270\314\206"
>> nothing added to commit but untracked files present (use "git add" t=
o
>> track)
>>=20
>> Could this be helped somehow?--
>
> What "this"?  If you mean displaying escapes for UTF-8 bytes
> representing that letter "=D0=B9", then try setting core.quotepath to=
 false
> for this repository and see if that helps.

Notice the 'git add test_=D0=B9'. The problem is that git reports it as=
 untracked.

=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB, is this the whole output or do yo=
u also see a
differently-escaped version of the filename under tracked files? Does
this problem not show up if you use 'git add -A' or 'git add .' instead
of typing the name? If so, this happens because HFS+ stores and reports
names differently than the way we told it to store it, so git sees a
different set of bytes than what it's expecting and considers it a
different file.

With a recent version of git, you can set the core.precomposeunicode
config setting to true, which deals with this situation. This tells git
to transform the data it gets from the filesystem to the format that
everyone else uses, which helps not only this, but also the 'git add .'
case, so git stores the filename in the format the same way that other
OSs expect to find.

   cmn
