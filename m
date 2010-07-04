From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/4] git-cvsserver: implement script based pserver 
	authentication
Date: Sun, 4 Jul 2010 12:22:05 +0000
Message-ID: <AANLkTin3I8aKYTkfVD602TZoosHuUsFLv35WAqVyuKDi@mail.gmail.com>
References: <1058578005711783867@unknownmsgid>
	<AANLkTikbPyZ-q8XgTBX1P9HQlFwUhiJSpiOgYG75mtiq@mail.gmail.com>
	<AANLkTil4C_oF972J5iRApUGXpwoFNqcYTgkzvorCseZZ@mail.gmail.com>
	<AANLkTimVYRJOJ6MG1HDFnj56cLxWrP1gjmIi-dKOuE-7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4FzaGluIEzDoXN6bMOz?= <ashinlaszlo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 14:22:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVODD-0001P3-4j
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 14:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522Ab0GDMWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jul 2010 08:22:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61581 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757306Ab0GDMWI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jul 2010 08:22:08 -0400
Received: by fxm14 with SMTP id 14so3137479fxm.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xrxjm68GgL8f3pgyhI22tss0mZeyac+RkrZi6I6mR48=;
        b=Wn2F8+vDopjdoN7TlWJ56MQlOfIm2vFPWa6bAyrC/Gsqm0chGoR2gTjt+ncGwdToo2
         +3MOIrqqSHAMEj3JIQ8FbIYBuXFlaHn3ngOGYlNvQFDpTIzoi1dB1bc8+wSAuGHgYZ80
         duFfKFuN2QTW2VwzDy7l1FvdVZQSywTibjuCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sKA12qXWMp9eZZQbwwPtaMD8CWKAToJUtJh/+5wcG55qKgKgHqgJbnRMbb+6lpT6JU
         uZQCBIDUPDLOF8+ZONwBS2CpssV+vqmNiJ1dF3/UMp8ggCVdpIgPgtYzfGXRM/qrQzap
         eXNwPzyG+wHAzwPLgmP/pIg4phP4gFf3E6PYg=
Received: by 10.223.107.17 with SMTP id z17mr1090291fao.42.1278246125220; Sun, 
	04 Jul 2010 05:22:05 -0700 (PDT)
Received: by 10.223.103.84 with HTTP; Sun, 4 Jul 2010 05:22:05 -0700 (PDT)
In-Reply-To: <AANLkTimVYRJOJ6MG1HDFnj56cLxWrP1gjmIi-dKOuE-7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150224>

On Sun, Jul 4, 2010 at 08:51, =C3=81shin L=C3=A1szl=C3=B3 <ashinlaszlo@=
gmail.com> wrote:
> Hi,
>
> On Sun, Jul 4, 2010 at 00:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> On Sat, Jul 3, 2010 at 21:21, =C3=81shin L=C3=A1szl=C3=B3 <ashinlasz=
lo@gmail.com> wrote:
>>> =C2=A0Documentation/git-cvsserver.txt | =C2=A0 46 +++++++++++++++++=
++++++++++++++++++---
>>> =C2=A0git-cvsserver.perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 28 +++++++++++++++++++++++
>>> =C2=A0t/t9400-git-cvsserver-server.sh | =C2=A0 45 +++++++++++++++++=
+++++++++++++++++++++
>>> =C2=A03 files changed, 115 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cv=
sserver.txt
>>> index 7004dd2..b3c3122 100644
>>> --- a/Documentation/git-cvsserver.txt
>>> +++ b/Documentation/git-cvsserver.txt
>>> @@ -100,10 +100,48 @@ looks like
>>> =C2=A0------
>>>
>>> =C2=A0Only anonymous access is provided by pserve by default. To co=
mmit you
>>
>> I think it's always called "pserver" with an -r.
>
> Yes but it is not part of my changeset.

Sorry, misread the diff.

>>> -will have to create pserver accounts, simply add a gitcvs.authdb
>>> -setting in the config file of the repositories you want the cvsser=
ver
>>> -to allow writes to, for example:
>>> +will have to specify an authentication option in the config file.
>>> +Currently there are two options are available for authentication t=
hrough
>>> +pserver in git-cvsserver: one through an authenticator script and =
an other
>>> +through a textual authentication database. If both are specified i=
n the config
>>> +file then the script based solution will be used.
>>
>> If both are specified shouldn't we throw an error?
>
> Actually a check can be added to the code. OK, I will do that.

Nice.

>>> + =C2=A0a. To use the authentication script based method, simply ad=
d a
>>> + =C2=A0 =C2=A0 gitcvs.authscript setting in the config file of the=
 repositories you want
>>> + =C2=A0 =C2=A0 the cvsserver to allow writes to, for example:
>>> ++
>>> +--
>>> +------
>>> +
>>> + =C2=A0 [gitcvs]
>>> + =C2=A0 =C2=A0authscript =3D /usr/local/bin/cvsserver-auth.sh
>>> +
>>> +------
>>> +The file specified here must be executable by the user the git-cvs=
server runs
>>> +under the name of. This script has to read exactly two lines from =
its standard
>>
>> "the name of" is redundant here.
>>
>>> +input as long as git-cvsserver passes the username and the passwor=
d on separate
>>> +lines. After the script did its task by checking the username and =
password
>>> +given it has to return zero if the authentication was successful a=
nd return
>>> +other value if it was not.
>>
>> Better as: "The script will receive two lines on standard input, the
>> first is the username and the second is the password. It should retu=
rn
>> 0 if the user was successfully authenticated, and a non-zero value i=
f
>> not".
>
> OK, a little bit I overcomplicated it :)
>
>
>>> +
>>> +Here is an example for an authentication script which checks the u=
sers against
>>> +active directory:
>>> +------
>>> +#!/bin/sh
>>> +# /usr/local/bin/cvsserver-auth.sh
>>>
>>> +read username
>>> +read password
>>> +
>>> +wbinfo -a "${username}%${password}"
>>
>> Do all POSIX shells implicitly exit with the return value of the las=
t
>> statement they evaluate. I don't know.
>
> "The exit status of a sequential list *shall* be the exit status of
> the last command in the list."
> ( After registration,
> http://www.opengroup.org/onlinepubs/000095399/utilities/xcu_chap02.ht=
ml#tag_02_08
> )
> Generally, all kind of list constructions use this principle accordin=
g
> to this page.
>
> Terminology of "shall":
> "For an implementation that conforms to IEEE Std 1003.1-2001,
> describes a feature or behavior that is mandatory. *An application ca=
n
> rely on the existence of the feature or behavior*.
>
> For an application or user, describes a behavior that is mandatory."

Nice, good to have that cleared up in general :)

>>> +------
>>> +--
>>> +
>>> + =C2=A0b. To use the authentication database based method, simply =
add a
>>> + =C2=A0 =C2=A0 gitcvs.authdb setting in the config file of the rep=
ositories you want the
>>> + =C2=A0 =C2=A0 cvsserver to allow writes to, for example:
>>> ++
>>> +--
>>> =C2=A0------
>>>
>>> =C2=A0 =C2=A0[gitcvs]
>>> @@ -125,7 +163,7 @@ Alternatively you can produce the password with
>>> perl's crypt() operator:
>>> =C2=A0-----
>>> =C2=A0 =C2=A0perl -e 'my ($user, $pass) =3D @ARGV; printf "%s:%s\n"=
, $user,
>>> crypt($user, $pass)' $USER password
>>> =C2=A0-----
>>> -
>>> +--
>>> =C2=A0Then provide your password via the pserver method, for exampl=
e:
>>> =C2=A0------
>>> =C2=A0 =C2=A0cvs -d:pserver:someuser:somepassword <at> server/path/=
repo.git co <HEAD_name>
>>> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
>>> index e9f3037..9664e86 100755
>>> --- a/git-cvsserver.perl
>>> +++ b/git-cvsserver.perl
>>> @@ -197,6 +197,34 @@ if ($state->{method} eq 'pserver') {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Fall through to LOVE
>>> + =C2=A0 =C2=A0} elsif (exists $cfg->{gitcvs}->{authscript}) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0my $authscript =3D $cfg->{gitcvs}->{au=
thscript};
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unless (-x $authscript) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "E The authenticat=
ion script specified in ";
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "[gitcvs.authscrip=
t] cannot be executed\n";
>>
>> I *think* you have to prefix anything that's not "I (HATE|LOVE) YOU"
>> with "E " if it's an error. I.e. this should probably be:
>>
>> =C2=A0 =C2=A0print "E The authentication script specified in";
>> =C2=A0 =C2=A0print "E [gitcvs.authscript] cannot be executed\n";
>>
>> But that's just my hazy memory. Maybe CVS clients will report the
>> error anyway.
>
> Please note that there is no "\n" after the first line. This is only =
a
> line break in the source code.
> Should I have used the following?

Ah yes, I missed that there wasn't a \n there.

> =C2=A0=C2=A0 =C2=A0print "E The authentication script specified in" .
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0"E [gitcvs.authscript] cannot be exe=
cuted\n";

Probably yeah, at least I managed to misread it :)

>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "I HATE YOU\n";
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0open my $script_fd, '|-', "'$authscrip=
t'"
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0or die "Couldn't open au=
thentication script '$authscript': $!";
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (length($password) > 0) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$password =3D descramble=
($password);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print $script_fd "$user\n";
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0print $script_fd "$password\n";
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0close $script_fd;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0unless ($? =3D=3D 0) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "E External script=
 authentication failed.\n";
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "I HATE YOU\n";
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0# Fall through to LOVE
>>> =C2=A0 =C2=A0 } else {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Trying to authenticate a user
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (not exists $cfg->{gitcvs}->{authdb}=
) {
>>> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserve=
r-server.sh
>>> index 8639506..0743e9a 100755
>>> --- a/t/t9400-git-cvsserver-server.sh
>>> +++ b/t/t9400-git-cvsserver-server.sh
>>> @@ -64,6 +64,16 @@ test_expect_success 'basic checkout' \
>>> =C2=A0# PSERVER AUTHENTICATION
>>> =C2=A0#------------------------
>>>
>>> +cat >"$SERVERDIR/authscript.sh" <<EOF
>>> +#!/bin/sh
>>> +read username
>>> +read password
>>> +
>>> +test "x\$username" =3D xcvsuser -a "x\$password" =3D xcvspassword
>>
>> This is offtopic. But I've never figured out why you need to do
>>
>> =C2=A0 =C2=A0test "x$foo" =3D "xbar"
>>
>> As opposed to:
>>
>> =C2=A0 =C2=A0test "$foo" =3D "bar"
>>
>> In shellscript. Are there really some shells that get equality tests
>> where one term is "" wrong?
>
> Maybe this is too much. Maybe x was used only where " couldn't be:
>
> =C2=A0 =C2=A0test x$foo =3D xbar
>
> So, if $foo is empty we have to make sure that test gets something to
> both side of the equation mark. But if quotation marks can be used it
> is possibly unneeded:
>
> =C2=A0 =C2=A0test "$foo" =3D "bar"
>
> My solution is an overkill in this case. But which of the above ones
> is preferred then?
> I think I can answer my own question. If $foo contains spaces only th=
e
> quotation mark based version will do what we want. I will remove the =
x
> characters.

Ok.

>>> +EOF
>>> +
>>> +chmod a+x "$SERVERDIR/authscript.sh"
>>> +
>>> =C2=A0cat >request-anonymous =C2=A0<<EOF
>>> =C2=A0BEGIN AUTH REQUEST
>>> =C2=A0$SERVERDIR
>>> @@ -134,6 +144,41 @@ test_expect_success 'pserver authentication
>>> failure (login/non-anonymous user)'
>>> =C2=A0 =C2=A0fi &&
>>> =C2=A0 =C2=A0sed -ne \$p log | grep "^I HATE YOU\$"'
>>>
>>> +GIT_DIR=3D"$SERVERDIR" git config --unset gitcvs.authdb || exit 1
>>> +GIT_DIR=3D"$SERVERDIR" git config gitcvs.authscript
>>> "$SERVERDIR/authscript.sh" || exit 1
>>> +
>>> +test_expect_success 'pserver authentication (authscript)' \
>>> + =C2=A0'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
>>> + =C2=A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
>>> +
>>> +test_expect_success 'pserver authentication failure (authscript,
>>> non-anonymous user)' \
>>> + =C2=A0'if cat request-git | git-cvsserver pserver >log 2>&1
>>> + =C2=A0 then
>>> + =C2=A0 =C2=A0 =C2=A0 false
>>> + =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 true
>>> + =C2=A0 fi &&
>>
>> This should probably be (untested):
>>
>> =C2=A0 =C2=A0test_must_fail cat request-git git-cvsserver pserver >l=
og 2>&1 &&
>
> I copied this code from above so this was not my decision. These test
> cases are all can be find elsewhere in the code, the only difference
> is in their names and the fact that the script based authentication
> method is active while they are running.

Yeah, a lot of the test code is ancient and unoptimal. Just leave it
like that I guess.

>>> + =C2=A0 sed -ne \$p log | grep "^I HATE YOU\$"'
>>> +
>>> +test_expect_success 'pserver authentication success (authscript,
>>> non-anonymous user with password)' \
>>> + =C2=A0'cat login-git-ok | git-cvsserver pserver >log 2>&1 &&
>>> + =C2=A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
>>> +
>>> +test_expect_success 'pserver authentication (authscript, login)' \
>>> + =C2=A0'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
>>> + =C2=A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
>>> +
>>> +test_expect_success 'pserver authentication failure (authscript,
>>> login/non-anonymous user)' \
>>> + =C2=A0'if cat login-git | git-cvsserver pserver >log 2>&1
>>> + =C2=A0 then
>>> + =C2=A0 =C2=A0 =C2=A0 false
>>> + =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 true
>>> + =C2=A0 fi &&
>>> + =C2=A0 sed -ne \$p log | grep "^I HATE YOU\$"'
>>> +
>>> +GIT_DIR=3D"$SERVERDIR" git config --unset gitcvs.authscript || exi=
t 1
>>> +GIT_DIR=3D"$SERVERDIR" git config gitcvs.authdb "$SERVERDIR/auth.d=
b" || exit 1
>>>
>>> =C2=A0# misuse pserver authentication for testing of req_Root
>>
>> Otherwise looking good.
>>
>
> I am not familiar the way that a patch goes in this project. Where ca=
n
> I find the repository my patches will be commited? When will this kin=
d
> of changes go to mainline?

Patches are:

 * Discussed on the mailing list (you are here)

 * Submitted for inclusion (see Documentation/SubmittingPatches). You
   didn't CC Junio so it isn't there yet.

 * Maybe show up in a "What's cooking" post if they're more complex
   and warrant further discussion.

 * Get merged into git://git.kernel.org/pub/scm/git/git.git, either
   pu, next, master, maint or some combo of that.
