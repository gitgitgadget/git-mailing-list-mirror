From: avar@cpan.org (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
Subject: Re: Switching to Git
Date: Fri, 07 Mar 2008 12:39:24 +0000
Message-ID: <86mypaso77.fsf@cpan.org>
References: <b77c1dce0803060447m12cf2ed9v2dbe17ed59e6073@mail.gmail.com>
	<47D01A57.60701@havurah-software.org>
	<51dd1af80803060858t5cb3d54ek3ee420ea313625ec@mail.gmail.com>
	<47D05229.2070900@vilain.net>
	<51dd1af80803061300y1a2abcf2n9b9d3184e4ed42b2@mail.gmail.com>
	<47D06B57.4090607@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	John Peacock <john.peacock@havurah-software.org>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Perl 5 Porters <perl5-porters@perl.org>,
	Martin.Langhoff@gmail.com, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Mar 07 13:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXbrs-0005RN-12
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 13:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181AbYCGMja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 07:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbYCGMja
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 07:39:30 -0500
Received: from u.nix.is ([208.78.101.240]:42205 "EHLO t"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756616AbYCGMj3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 07:39:29 -0500
Received: from localhost
	([127.0.0.1] helo=t.cpan.org ident=avar)
	by t with esmtp (Exim 4.63)
	(envelope-from <avar@cpan.org>)
	id 1JXbrB-0004GL-Go; Fri, 07 Mar 2008 12:39:25 +0000
In-Reply-To: <47D06B57.4090607@vilain.net> (Sam Vilain's message of "Fri, 07
	Mar 2008 11:08:23 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76487>

Sam Vilain <sam@vilain.net> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Yes see [1] it works but the list members wanted some tool to manage
>> passwords too which I didn't pursue since it worked for me in its
>> present form.
>>=20
>> 1. http://lists-archives.org/git/640574-authentication-support-for-p=
server.html
>
> Cool, well done.  Having re-read that thread, I think Martin Langhoff=
's
> response
> http://lists-archives.org/git/641074-authentication-support-for-pserv=
er.html
> is the most pertinent.  I didn't see any requests for an actual tool =
to
> be written, just that the password file be separate to the git config
> file, and/or use crypt() to store its contents.  Perhaps point them a=
t
> "htpasswd" if they want a tool :)
>
> This patch is untested and sits on top of the previous patch by =C3=86=
var.
> Pullable from git://git.catalyst.net.nz/git.git#cvsserver-auth
>
> Subject: [PATCH] git-cvsserver: use a password file cvsserver pserver
>
> If a git repository is shared via HTTP, the config file is typically
> visible.  Use an external file instead.
> ---
>  Documentation/git-cvsserver.txt |   21 ++++++++++++++++-----
>  git-cvsserver.perl              |   27 ++++++++++++++-------------
>  2 files changed, 30 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvss=
erver.txt
> index 98183d4..c642f12 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -97,16 +97,27 @@ looks like
>  ------
> =20
>  Only anonymous access is provided by pserve by default. To commit yo=
u
> -will have to create pserver accounts, simply add a [gitcvs.users]
> -section to the repositories you want to access, for example:
> +will have to create pserver accounts, simply add a gitcvs.authdb
> +setting in the config file of the repositories you want the cvsserve=
r
> +to allow writes to, for example:
> =20
>  ------
>    =20
> -   [gitcvs.users]
> -        someuser =3D somepassword
> -        otheruser =3D otherpassword
> +   [gitcvs]
> +        authdb =3D /etc/cvsserver/passwd
>    =20
>  ------
> +The format of these files is username followed by the crypted passwo=
rd,
> +for example:
> +
> +------
> +   myuser:$1Oyx5r9mdGZ2
> +   myuser:$1$BA)@$vbnMJMDym7tA32AamXrm./
> +------
> +You can use the 'htpasswd' facility that comes with Apache to make t=
hese
> +files, but Apache's MD5 crypt method differs from the one used by mo=
st C
> +library's crypt() function, so don't use the -m option.
> +
>  Then provide your password via the pserver method, for example:
>  ------
>     cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co=
 <HEAD_name>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 9bc2ff5..e54cbcd 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -156,24 +156,25 @@ if ($state->{method} eq 'pserver') {
> =20
>      unless ($user eq 'anonymous') {
>          # Trying to authenticate a user
> -        if (not exists $cfg->{gitcvs}->{users}) {
> -            print "E the repo config file needs a [gitcvs.users] sec=
tion with user/password key-value pairs\n";
> +        if (not exists $cfg->{gitcvs}->{authdb}) {
> +            print "E the repo config file needs a [gitcvs.authdb] se=
ction with a filename\n";
>              print "I HATE YOU\n";
>              exit 1;
> -        } elsif (exists $cfg->{gitcvs}->{users} and not exists $cfg-=
>{gitcvs}->{users}->{$user}) {
> -            #print "E the repo config file has a [gitcvs.users] sect=
ion but the user $user is not defined in it\n";
> +        }
> +	my $auth_ok;
> +	open PASSWD, "<$cfg->{gitcvs}->{authdb}" or die $!;
> +	while(<PASSWD>) {
> +	    if (m{^\Q$user\E:(.*)}) {
> +		if (crypt($user, $1) eq $1) {
> +		    $auth_ok =3D 1;
> +		}
> +	    };
> +	}
> +	unless ($auth_ok) {
>              print "I HATE YOU\n";
>              exit 1;
> -        } else {
> -            my $descrambled_password =3D descramble($password);
> -            my $cleartext_password =3D $cfg->{gitcvs}->{users}->{$us=
er};
> -            if ($descrambled_password ne $cleartext_password) {
> -                #print "E The password supplied for user $user was i=
ncorrect\n";
> -                print "I HATE YOU\n";
> -                exit 1;
> -            }
> -            # else fall through to LOVE
>          }
> +        # else fall through to LOVE
>      }
> =20
>      # For checking whether the user is anonymous on commit
> --=20
> 1.5.3.5

Ah, I didn't notice that this got crossposted, here, anyway I've cleane=
d
up this patch a bit and submitted it in reply to the original thread
[1].

1. http://article.gmane.org/gmane.comp.version-control.git/76446/match=3D=
bjarmason
