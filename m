From: Charles McGarvey <chazmcgarvey@brokenzipper.com>
Subject: Re: [PATCH] instaweb: make the perl path configurable
Date: Wed, 12 Jun 2013 17:13:56 -0600
Organization: Sevenology
Message-ID: <20130612231356.GA27856@compy.Home>
References: <20130611201400.GA28010@compy.Home>
 <loom.20130612T155755-338@post.gmane.org>
 <51B8C271.9030105@brokenzipper.com>
 <CANQwDweOR_wAJh5sitai6yFED4XKrptoBKn0P=PF0zk89ze3fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub =?unknown-8bit?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 01:14:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmuEv-00033S-Lg
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 01:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127Ab3FLXOA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 19:14:00 -0400
Received: from romulus.brokenzipper.com ([71.19.157.142]:64628 "EHLO
	romulus.brokenzipper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907Ab3FLXN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 19:13:59 -0400
Received: from vulcan.local (unknown [IPv6:2602:61:7edf:e300:0:ff:fe00:7701])
	by romulus.brokenzipper.com (Postfix) with ESMTP id C095952CE4;
	Wed, 12 Jun 2013 17:13:58 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=brokenzipper.com;
	s=romulus; t=1371078838;
	bh=Cv5by09x3DVoA7oRq/H+u6atGnfIfLgEjlVpvR9uaAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uIhkBmN1zczGClxeMOM6R3+fC/HEmOED3NWvgzRiRhGmhBfilQ0YBk7TaoB8oN+Ac
	 S7aEN9CXHkVeas2vPcUDXqCYgFeSpFBuNu+woS+w9MHh2l1kDhJeEJkL4vIfr1RgOl
	 zt0eZcbCZoelhx9rPgnBTEgKM5FvsFfzndAqWX4I=
Received: from [2602:61:7edf:e300:0:ff:fe00:7700] (helo=compy)
	by vulcan.local with smtp (Exim 4.80)
	(envelope-from <chazmcgarvey@brokenzipper.com>)
	id 1UmuFW-0007vT-K3; Wed, 12 Jun 2013 17:14:43 -0600
Received: by compy (sSMTP sendmail emulation); Wed, 12 Jun 2013 17:13:56 -0600
Content-Disposition: inline
In-Reply-To: <CANQwDweOR_wAJh5sitai6yFED4XKrptoBKn0P=PF0zk89ze3fA@mail.gmail.com>
FCC: imap://chaz@mail.dogcows.com/Sent
X-Identity-Key: id1
X-Account-Key: account2
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130523
 Thunderbird/17.0.6
X-Enigmail-Version: 1.6a1pre
OpenPGP: url=https://www.brokenzipper.com/chaz.asc
X-Enigmail-Draft-Status: 513
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227692>

On 06/12/2013 03:03 PM, Jakub Nar=C4=99bski wrote:
> On Wed, Jun 12, 2013 at 8:48 PM, Charles McGarvey wrote:
>> On 06/12/2013 08:00 AM, Jakub Narebski wrote:
>>>
>>> Is it really necessary?  There is always PERL5LIB if one wants to u=
se Perl
>>> modules installed in one's own home directory.  If one is using loc=
al::lib
>>> one has it "for free".
>>
>> Yes, that's right.  Using PERL5LIB would solve the example problem i=
n the
>> commit message, and it would even be pretty simple to set up using
>> local::lib.  So, no, this isn't strictly necessary.
>>
>>> If they do not want to use system perl there is always perlbrew.
>>
>> Well, perlbrew is actually what I had in mind for this patch.  Witho=
ut it,
>> it seems like the perl path -- which is configured while building gi=
t.git
>> so is not easily changed by the user -- is "hard-coded" in the sheba=
ng line
>> of the plackup script file which is then made executable and exec'd,=
 to
>> start the httpd.  Given that process, I don't see how that code allo=
ws the
>> user to use any other perl, or am I missing something?
>=20
> I am sorry, this is my mistake.  Of course if one is using perlbrew t=
hen one
> wants to use perlbrew perl (nb. how does "perlbrew switch" work?), no=
t
> necessarily system perl hardcoded during installation time.

Perlbrew switch works by prepending the dirname of the specified perl t=
o PATH
(and removing paths to "inactive" perls); it is implemented as a shell
function wrapper which is why it can change the current shell's environ=
ment.

So yes, searching PATH instead of using the hard-coded perl would allow=
 the
instaweb command to use a perlbrew perl (or any other perl).  I think t=
his
would be better than not being able to use a non-system perl at all, bu=
t
a drawback I see -- and I mentioned this before, but I'll just restate =
it --
is that a perl module developer usually has a lot of perls installed an=
d it
would be up to them to know whether or not the perl that is "active" fo=
r the
shell they're currently in has the instaweb dependencies.  It's probabl=
y not
an unreasonable burden on the user, but it's something to consider.  If=
 the
perl path were configurable, the user could set it to a perl they know =
has the
dependencies and not have to deal with any uncertainty in the future wh=
ether
or not the git instaweb command would succeed in their current environm=
ent.

I think that's the benefit of the current code with hard-coded perl pat=
h: it's
more predictable.  In other words, changes in the user's environment wo=
n't
change how git (instaweb) works in potentially surprising ways.  I thin=
k this
is a benefit worth preserving, which is why the patch introduces a new =
config
variable rather than using PATH.

>> If adding a new config variable seems too heavy-handed for such a tr=
ivial
>> problem, another approach would be to use the first perl in PATH
>=20
> Hmmm... git moved out of using first "perl" in PATH...
>=20
>> and fall back
>> on the git.git build system-configured perl if there is no perl in P=
ATH.
>=20
> How to do this?

If you wanted to use PATH, I guess you could first try to invoke perl
explicitly and let the shell search PATH implicitly, such as the follow=
ing
(except it doesn't make sense to do this for mongoose, so the case woul=
d need
to be split).

@@ -110,11 +110,19 @@ start_httpd () {
 	case "$httpd" in
 	*mongoose*|*plackup*)
 		#These servers don't have a daemon mode so we'll have to fork it
-		$full_httpd "$conf" &
+		perl "$full_httpd" "$conf" &
 		#Save the pid before doing anything else (we'll print it later)
 		pid=3D$!
+		ret=3D$?
=20
-		if test $? !=3D 0; then
+		#If the shell couldn't find perl, try to exec the script file direct=
ly
+		if test $ret =3D 127; then
+			$full_httpd "$conf" &
+			pid=3D$!
+			ret=3D$?
+		fi
+
+		if test $ret !=3D 0; then
 			echo "Could not execute http daemon $httpd."
 			exit 1
 		fi

I'm also not completely certain how this would affect win32 users, thou=
gh
I suspect it would work fine with the same caveats.

> [...]
>> In short summary, this patch isn't necessary because everyone could =
use
>> local::lib to manage dependencies not installed at the system level,=
 but I
>> think this patch is desirable for those of us who use perlbrew and n=
ot
>> local::lib.  Of course, I'm open to alternatives and other suggestio=
ns.
>=20
> One other thing to think about is: why here, and not other places?

I'm not familiar enough with git.git to know whether this problem exist=
s for
other components.  If so, and if a solution can be agreed upon, definit=
ely
let's fix it at every place or perhaps come up with a broader solution.=
  I'll
spend some time poking around in the code.

> Nb. for short Perl scripts not using extra modules we pick first "per=
l"
> in PATH, IIRC...

Thanks,

--=20
Charles McGarvey
