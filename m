From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Problems with Windows, Was: What's cooking in git.git (May 2013,
 #01; Fri, 3)
Date: Thu, 09 May 2013 18:18:01 +0100
Message-ID: <518BDA49.400@ramsay1.demon.co.uk>
References: <7vvc6zwta7.fsf@alter.siamese.dyndns.org> <51890F48.3090409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mlevedahl@gmail.com, Jonathan Nieder <jrnieder@gmail.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 09 19:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUX6-0002Ii-1e
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab3EIRVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 May 2013 13:21:22 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:36756 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751731Ab3EIRVV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:21:21 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 1D2C1A0C073;
	Thu,  9 May 2013 18:21:19 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id C9552A0C083;
	Thu,  9 May 2013 18:21:17 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Thu,  9 May 2013 18:21:16 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <51890F48.3090409@web.de>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223762>

Torsten B=F6gershausen wrote:
> On 2013-05-04 01.14, Junio C Hamano wrote:
>>
>>  Cygwin portability; both were reviewed by Jonathan, and the tip one
>>  seems to want a bit further explanation.  Needs positive report
>>  from Cygwin 1.7 users who have been on 1.7 to make sure it does not
>>  regress for them.
>=20
> I was trying to verify that cygwin 1.7 is still Ok, but got puzzled.
>=20
> Running the test suite under cygwin doesn't seem to work any more (?)=
:
>=20
> Scenario 1:
> The PC is running alone, and goes into the screen saver.
> Pressing CTRL-ALT-DEL didn't get any effect.
>=20
> Scenario 2:
> The PC didn't react any more, when the test suite was run in backgrou=
nd.
> In 3 or 4 cases the PC needed to be reboot hardly.
>=20
> Using the commits before and after this change makes the test suite h=
ang=20
> as well at some point, then it hangs somewhere at TC 3000--4000.
>=20
> Scenario 4:
> The I disabled the screensaver, upgdated cygwin,
>  and went back to an older commit:
> The latest run from commit 52d63e70, April 28,
> hangs in TC 5500, ok 26 clone shallow object count.
>=20
> I can see 2 times=20
> git.exe pull --depth 4 ..A=20
>=20
> Scenario 5:
> The run of today 1.8.3-rc1, hangs in t5510,
> some git.exe are running fetch. (or pull)
>=20
>=20
> It seems as if some process/exes are not terminated
> in the way it should be.
>=20
> I will try on a different machine,
> comments are wellcome

Hmm, I'm a little puzzled, but not shocked. ;-)

Somebody, I forget who, had already tested Jonathan's patch
on cygwin 1.7 successfully and my follow up patch should be
a no-op on cygwin 1.7; so I'm puzzled! (The high risk should
have been on cygwin 1.5).

I'm not shocked because running the test-suite on cygwin has
been a bit of a magical mystery tour for quite some time.

In about 2007, I could not run the test-suite for about six
to nine months; it would randomly wedge my laptop solid - I had
to pull the power-cord out in order to re-boot. (I suspect that
commit 9cb18f56fde may have cured that particular problem, but
don't quote me on that - I didn't investigate at the time.)

I have noticed that running the tests with 'prove' is more likely
to prove successful, so my config.mak looks like:

    $ cat config.mak
    NO_SVN_TESTS=3D1
    GIT_TEST_OPTS=3D--no-color
    NO_GETTEXT=3D1
    DEFAULT_TEST_TARGET=3Dprove
    GIT_PROVE_OPTS=3D'--timer'
    $

I currently run the tests like so:

    $ time $(GIT_SKIP_TESTS=3D't0061.3 t0070.3 t4130 t9010 t9300' make =
test \
    >test-outp13 2>&1)

    real    172m25.311s
    user    132m15.133s
    sys     66m43.122s
    $

The t0061.3 and t0070.3 failures don't require much discussion. The t41=
30
failure is an intermittent "racy git" issue that has been on my TODO li=
st
for several years. t9300 also fails intermittently. However, t9010 fail=
s
every time for me, hanging the test suite (although ^C interrupts it ju=
st
fine).

I have a "fix" for t9010 that looks like:

    diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
    index b7eed24..4d01e3b 100755
    --- a/t/t9010-svn-fe.sh
    +++ b/t/t9010-svn-fe.sh
    @@ -22,10 +22,9 @@ try_dump () {
            maybe_fail_fi=3D${3:+test_$3} &&
   =20
            {
    -               $maybe_fail_svnfe test-svn-fe "$input" >stream 3<ba=
ckflow &
    -       } &&
    -       $maybe_fail_fi git fast-import --cat-blob-fd=3D3 <stream 3>=
backflow &&
    -       wait $!
    +               $maybe_fail_svnfe test-svn-fe "$input" 3<backflow
    +       } |
    +       $maybe_fail_fi git fast-import --cat-blob-fd=3D3 3>backflow
     }
   =20
     properties () {

but I have not tested this patch enough to be happy to submit it (I hav=
e
some suspicions that it would still fail intermittently, just like t930=
0).

Also, commit 7bc0911d ("test-lib: Fix say_color () not to interpret \a\=
b\c
in the message", 11-10-2012) caused several random test failures. (don'=
t ask
me why). So, before each test run, I have to apply the following:

    diff --git a/t/test-lib.sh b/t/test-lib.sh
    index f50f834..ed32b7f 100644
    --- a/t/test-lib.sh
    +++ b/t/test-lib.sh
    @@ -230,7 +230,7 @@ else
            say_color() {
                    test -z "$1" && test -n "$quiet" && return
                    shift
    -               printf "%s\n" "$*"
    +               echo -E "$*"
            }
     fi

which effectively reverts that commit.

So, as I said, a "magical mystery tour". :-D

ATB,
Ramsay Jones
