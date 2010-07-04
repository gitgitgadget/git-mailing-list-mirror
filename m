From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: Re: [PATCH 1/4] git-cvsserver: implement script based pserver 
	authentication
Date: Sun, 4 Jul 2010 10:51:10 +0200
Message-ID: <AANLkTimVYRJOJ6MG1HDFnj56cLxWrP1gjmIi-dKOuE-7@mail.gmail.com>
References: <1058578005711783867@unknownmsgid> <AANLkTikbPyZ-q8XgTBX1P9HQlFwUhiJSpiOgYG75mtiq@mail.gmail.com> 
	<AANLkTil4C_oF972J5iRApUGXpwoFNqcYTgkzvorCseZZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 10:51:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVKvO-0007uK-Pm
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 10:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab0GDIvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jul 2010 04:51:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34794 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758Ab0GDIvd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jul 2010 04:51:33 -0400
Received: by fxm14 with SMTP id 14so3090456fxm.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vm24JRWKb/xqTdoCWoifHweP/vXIsCZb+tLUsf4wp9g=;
        b=jYC4x7glclGSwD8MBrRi/idMgqOSKiMlIlD+LrzlvrR29/v7pTwtQNLsmXQsRpR9K2
         1tmrhO0yJfnx9VnSiSu1y8nhyGLBevA+j8yVO3roZcwoK1Ol+o/eHbms0JItlL090rWZ
         Z3RRToVLzWGKaupQ/7C6a7HNuIY8puaM4x8Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ua1v3O+IP0Wl2CUSppLwmZmUq4NJL4sNqptwcR+RpkIXn31jhoXj6NBZecY8AklQTv
         ydPoXrTzAuZFb43oKoM6CMhMFWpGAOAEeexxOyaVbVkE6V18HhBKqNao1elo12c71L5r
         lYqGnn3OKSA97EHV8Dv/iesTpqraqZ1l0GCLs=
Received: by 10.103.192.15 with SMTP id u15mr102585mup.57.1278233490094; Sun, 
	04 Jul 2010 01:51:30 -0700 (PDT)
Received: by 10.103.225.9 with HTTP; Sun, 4 Jul 2010 01:51:10 -0700 (PDT)
In-Reply-To: <AANLkTil4C_oF972J5iRApUGXpwoFNqcYTgkzvorCseZZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150219>

Hi,

On Sun, Jul 4, 2010 at 00:14, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gma=
il.com> wrote:
> On Sat, Jul 3, 2010 at 21:21, =C1shin L=E1szl=F3 <ashinlaszlo@gmail.c=
om> wrote:
>> =A0Documentation/git-cvsserver.txt | =A0 46 ++++++++++++++++++++++++=
+++++++++++---
>> =A0git-cvsserver.perl =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 28 ++++++++++=
+++++++++++++
>> =A0t/t9400-git-cvsserver-server.sh | =A0 45 ++++++++++++++++++++++++=
++++++++++++++
>> =A03 files changed, 115 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvs=
server.txt
>> index 7004dd2..b3c3122 100644
>> --- a/Documentation/git-cvsserver.txt
>> +++ b/Documentation/git-cvsserver.txt
>> @@ -100,10 +100,48 @@ looks like
>> =A0------
>>
>> =A0Only anonymous access is provided by pserve by default. To commit=
 you
>
> I think it's always called "pserver" with an -r.

Yes but it is not part of my changeset.


>> -will have to create pserver accounts, simply add a gitcvs.authdb
>> -setting in the config file of the repositories you want the cvsserv=
er
>> -to allow writes to, for example:
>> +will have to specify an authentication option in the config file.
>> +Currently there are two options are available for authentication th=
rough
>> +pserver in git-cvsserver: one through an authenticator script and a=
n other
>> +through a textual authentication database. If both are specified in=
 the config
>> +file then the script based solution will be used.
>
> If both are specified shouldn't we throw an error?

Actually a check can be added to the code. OK, I will do that.


>> + =A0a. To use the authentication script based method, simply add a
>> + =A0 =A0 gitcvs.authscript setting in the config file of the reposi=
tories you want
>> + =A0 =A0 the cvsserver to allow writes to, for example:
>> ++
>> +--
>> +------
>> +
>> + =A0 [gitcvs]
>> + =A0 =A0authscript =3D /usr/local/bin/cvsserver-auth.sh
>> +
>> +------
>> +The file specified here must be executable by the user the git-cvss=
erver runs
>> +under the name of. This script has to read exactly two lines from i=
ts standard
>
> "the name of" is redundant here.
>
>> +input as long as git-cvsserver passes the username and the password=
 on separate
>> +lines. After the script did its task by checking the username and p=
assword
>> +given it has to return zero if the authentication was successful an=
d return
>> +other value if it was not.
>
> Better as: "The script will receive two lines on standard input, the
> first is the username and the second is the password. It should retur=
n
> 0 if the user was successfully authenticated, and a non-zero value if
> not".

OK, a little bit I overcomplicated it :)


>> +
>> +Here is an example for an authentication script which checks the us=
ers against
>> +active directory:
>> +------
>> +#!/bin/sh
>> +# /usr/local/bin/cvsserver-auth.sh
>>
>> +read username
>> +read password
>> +
>> +wbinfo -a "${username}%${password}"
>
> Do all POSIX shells implicitly exit with the return value of the last
> statement they evaluate. I don't know.

"The exit status of a sequential list *shall* be the exit status of
the last command in the list."
( After registration,
http://www.opengroup.org/onlinepubs/000095399/utilities/xcu_chap02.html=
#tag_02_08
)
Generally, all kind of list constructions use this principle according
to this page.

Terminology of "shall":
"For an implementation that conforms to IEEE Std 1003.1-2001,
describes a feature or behavior that is mandatory. *An application can
rely on the existence of the feature or behavior*.

=46or an application or user, describes a behavior that is mandatory."


>> +------
>> +--
>> +
>> + =A0b. To use the authentication database based method, simply add =
a
>> + =A0 =A0 gitcvs.authdb setting in the config file of the repositori=
es you want the
>> + =A0 =A0 cvsserver to allow writes to, for example:
>> ++
>> +--
>> =A0------
>>
>> =A0 =A0[gitcvs]
>> @@ -125,7 +163,7 @@ Alternatively you can produce the password with
>> perl's crypt() operator:
>> =A0-----
>> =A0 =A0perl -e 'my ($user, $pass) =3D @ARGV; printf "%s:%s\n", $user=
,
>> crypt($user, $pass)' $USER password
>> =A0-----
>> -
>> +--
>> =A0Then provide your password via the pserver method, for example:
>> =A0------
>> =A0 =A0cvs -d:pserver:someuser:somepassword <at> server/path/repo.gi=
t co <HEAD_name>
>> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
>> index e9f3037..9664e86 100755
>> --- a/git-cvsserver.perl
>> +++ b/git-cvsserver.perl
>> @@ -197,6 +197,34 @@ if ($state->{method} eq 'pserver') {
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 # Fall through to LOVE
>> + =A0 =A0} elsif (exists $cfg->{gitcvs}->{authscript}) {
>> + =A0 =A0 =A0 =A0my $authscript =3D $cfg->{gitcvs}->{authscript};
>> +
>> + =A0 =A0 =A0 =A0unless (-x $authscript) {
>> + =A0 =A0 =A0 =A0 =A0 =A0print "E The authentication script specifie=
d in ";
>> + =A0 =A0 =A0 =A0 =A0 =A0print "[gitcvs.authscript] cannot be execut=
ed\n";
>
> I *think* you have to prefix anything that's not "I (HATE|LOVE) YOU"
> with "E " if it's an error. I.e. this should probably be:
>
> =A0 =A0print "E The authentication script specified in";
> =A0 =A0print "E [gitcvs.authscript] cannot be executed\n";
>
> But that's just my hazy memory. Maybe CVS clients will report the
> error anyway.

Please note that there is no "\n" after the first line. This is only a
line break in the source code.
Should I have used the following?

 =A0 =A0print "E The authentication script specified in" .
 =A0 =A0    "E [gitcvs.authscript] cannot be executed\n";


>> + =A0 =A0 =A0 =A0 =A0 =A0print "I HATE YOU\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0exit 1;
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0open my $script_fd, '|-', "'$authscript'"
>> + =A0 =A0 =A0 =A0 =A0 =A0or die "Couldn't open authentication script=
 '$authscript': $!";
>> +
>> + =A0 =A0 =A0 =A0if (length($password) > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0$password =3D descramble($password);
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0print $script_fd "$user\n";
>> + =A0 =A0 =A0 =A0print $script_fd "$password\n";
>> + =A0 =A0 =A0 =A0close $script_fd;
>> +
>> + =A0 =A0 =A0 =A0unless ($? =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0print "E External script authentication fai=
led.\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0print "I HATE YOU\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0exit 1;
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0# Fall through to LOVE
>> =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 # Trying to authenticate a user
>> =A0 =A0 =A0 =A0 if (not exists $cfg->{gitcvs}->{authdb}) {
>> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver=
-server.sh
>> index 8639506..0743e9a 100755
>> --- a/t/t9400-git-cvsserver-server.sh
>> +++ b/t/t9400-git-cvsserver-server.sh
>> @@ -64,6 +64,16 @@ test_expect_success 'basic checkout' \
>> =A0# PSERVER AUTHENTICATION
>> =A0#------------------------
>>
>> +cat >"$SERVERDIR/authscript.sh" <<EOF
>> +#!/bin/sh
>> +read username
>> +read password
>> +
>> +test "x\$username" =3D xcvsuser -a "x\$password" =3D xcvspassword
>
> This is offtopic. But I've never figured out why you need to do
>
> =A0 =A0test "x$foo" =3D "xbar"
>
> As opposed to:
>
> =A0 =A0test "$foo" =3D "bar"
>
> In shellscript. Are there really some shells that get equality tests
> where one term is "" wrong?

Maybe this is too much. Maybe x was used only where " couldn't be:

    test x$foo =3D xbar

So, if $foo is empty we have to make sure that test gets something to
both side of the equation mark. But if quotation marks can be used it
is possibly unneeded:

    test "$foo" =3D "bar"

My solution is an overkill in this case. But which of the above ones
is preferred then?
I think I can answer my own question. If $foo contains spaces only the
quotation mark based version will do what we want. I will remove the x
characters.


>> +EOF
>> +
>> +chmod a+x "$SERVERDIR/authscript.sh"
>> +
>> =A0cat >request-anonymous =A0<<EOF
>> =A0BEGIN AUTH REQUEST
>> =A0$SERVERDIR
>> @@ -134,6 +144,41 @@ test_expect_success 'pserver authentication
>> failure (login/non-anonymous user)'
>> =A0 =A0fi &&
>> =A0 =A0sed -ne \$p log | grep "^I HATE YOU\$"'
>>
>> +GIT_DIR=3D"$SERVERDIR" git config --unset gitcvs.authdb || exit 1
>> +GIT_DIR=3D"$SERVERDIR" git config gitcvs.authscript
>> "$SERVERDIR/authscript.sh" || exit 1
>> +
>> +test_expect_success 'pserver authentication (authscript)' \
>> + =A0'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
>> + =A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
>> +
>> +test_expect_success 'pserver authentication failure (authscript,
>> non-anonymous user)' \
>> + =A0'if cat request-git | git-cvsserver pserver >log 2>&1
>> + =A0 then
>> + =A0 =A0 =A0 false
>> + =A0 else
>> + =A0 =A0 =A0 true
>> + =A0 fi &&
>
> This should probably be (untested):
>
> =A0 =A0test_must_fail cat request-git git-cvsserver pserver >log 2>&1=
 &&

I copied this code from above so this was not my decision. These test
cases are all can be find elsewhere in the code, the only difference
is in their names and the fact that the script based authentication
method is active while they are running.


>> + =A0 sed -ne \$p log | grep "^I HATE YOU\$"'
>> +
>> +test_expect_success 'pserver authentication success (authscript,
>> non-anonymous user with password)' \
>> + =A0'cat login-git-ok | git-cvsserver pserver >log 2>&1 &&
>> + =A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
>> +
>> +test_expect_success 'pserver authentication (authscript, login)' \
>> + =A0'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
>> + =A0 sed -ne \$p log | grep "^I LOVE YOU\$"'
>> +
>> +test_expect_success 'pserver authentication failure (authscript,
>> login/non-anonymous user)' \
>> + =A0'if cat login-git | git-cvsserver pserver >log 2>&1
>> + =A0 then
>> + =A0 =A0 =A0 false
>> + =A0 else
>> + =A0 =A0 =A0 true
>> + =A0 fi &&
>> + =A0 sed -ne \$p log | grep "^I HATE YOU\$"'
>> +
>> +GIT_DIR=3D"$SERVERDIR" git config --unset gitcvs.authscript || exit=
 1
>> +GIT_DIR=3D"$SERVERDIR" git config gitcvs.authdb "$SERVERDIR/auth.db=
" || exit 1
>>
>> =A0# misuse pserver authentication for testing of req_Root
>
> Otherwise looking good.
>

I am not familiar the way that a patch goes in this project. Where can
I find the repository my patches will be commited? When will this kind
of changes go to mainline?

Thanks,
L=E1szl=F3 =C1SHIN
