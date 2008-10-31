From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: A typesetting problem with git man pages
Date: Fri, 31 Oct 2008 09:37:03 +0200
Message-ID: <8763n9tduo.fsf@iki.fi>
References: <87skqfus7v.fsf@iki.fi>
	<2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Oct 31 08:38:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvoaN-0003X0-6i
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 08:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbYJaHhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2008 03:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbYJaHhI
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 03:37:08 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:34845 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbYJaHhH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 03:37:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B8900991208; Fri, 31 Oct 2008 09:37:04 +0200
In-Reply-To: <2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com> (Jonas Fonseca's message of "Wed\, 29 Oct 2008 20\:35\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99558>

Jonas Fonseca (2008-10-29 20:35 +0100) wrote:

> On Wed, Oct 29, 2008 at 20:16, Teemu Likonen <tlikonen@iki.fi> wrote:
>> Does anybody know why "man" prints those ".ft" commands? The
>> corresponding code in git-log.1 file is this:
>>
>>    \&.ft C
>>    [i18n]
>>            commitencoding =3D ISO\-8859\-1
>>    \&.ft
>>
>> Recently I upgraded my system from Debian 4.0 (Etch) to 5.0 (Lenny) =
and
>> it is possible that some tools which are related to compiling the ma=
n
>> pages are now newer versions.
>
> I had a similar problem after upgrading on Ubuntu and came up with a
> patch to optionally disable some of asciidoc.conf (commit
> 7f55cf451c9e7). Try putting DOCBOOK_XSL_172=3DYes in your config.mak.

Alas, there are still problems - or at least I have. Let's look at the
"git checkout" manual page and its output in the "EXAMPLES" section:


        $ git checkout master             =E2fB(1)=E2fR    =20
        $ git checkout master~2 Makefile  =E2fB(2)=E2fR    =20
        $ rm -f hello.c                                =20
        $ git checkout hello.c            =E2fB(3)=E2fR    =20
    =E2                                                  =20
    =E2fB1. =E2fRswitch branch =E2                           =20
    =E2fB2. =E2fRtake out a file out of other commit =E2     =20
    =E2fB3. =E2fRrestore hello.c from HEAD of current branch

    If you have an unfortunate branch that is named hello.c, this step
    would be confused as an instruction to switch to that branch. You
    should instead write:

        $ git checkout -- hello.c
    =E2
    .RE

    2.  After working in a wrong branch, switching to the correct branc=
h
       would be done using:

           $ git checkout mytopic


The corresponding code in the git-checkout.txt file:


    ------------                                  =20
    $ git checkout master             <1>         =20
    $ git checkout master~2 Makefile  <2>         =20
    $ rm -f hello.c                               =20
    $ git checkout hello.c            <3>         =20
    ------------                                  =20
    +                                             =20
    <1> switch branch                             =20
    <2> take out a file out of other commit       =20
    <3> restore hello.c from HEAD of current branch
    +
    If you have an unfortunate branch that is named `hello.c`, this
    step would be confused as an instruction to switch to that branch.
    You should instead write:
    +
    ------------
    $ git checkout -- hello.c
    ------------

    . After working in a wrong branch, switching to the correct
    branch would be done using:
    +
    ------------
    $ git checkout mytopic
    ------------
