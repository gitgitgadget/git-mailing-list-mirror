From: Etienne Vallette d'Osia <Etienne.VallettedOsia@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: link to toggle 'no merges' option
Date: Thu, 17 Dec 2009 14:03:58 +0100
Message-ID: <hgda76$tf5$1@ger.gmane.org>
References: <1261040753-4859-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 14:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLG1h-0004JY-L2
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 14:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbZLQNEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2009 08:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbZLQNEJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 08:04:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:58932 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932566AbZLQNEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 08:04:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NLG1O-0004Dt-EU
	for git@vger.kernel.org; Thu, 17 Dec 2009 14:03:58 +0100
Received: from ram94-11-88-187-113-157.fbx.proxad.net ([88.187.113.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 14:03:58 +0100
Received: from Etienne.VallettedOsia by ram94-11-88-187-113-157.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 14:03:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ram94-11-88-187-113-157.fbx.proxad.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.9.1.5) Gecko/20091204 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <1261040753-4859-1-git-send-email-giuseppe.bilotta@gmail.com>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135370>

Oh, this is exactly what I wanted for a long long time...
I hope this feature will be merged soon !

Le 12/17/2009 10:05 AM, Giuseppe Bilotta a =E9crit :
> In views that support --no-merges, introduce a link that toggles the
> option.
>=20
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>=20
> ---
>  gitweb/gitweb.css  |   11 +++++++++++
>  gitweb/gitweb.perl |   14 ++++++++++++++
>  2 files changed, 25 insertions(+), 0 deletions(-)
>=20
> This is something I've been wanting for a while. There are a number o=
f
> things that don't 'click' with this proof of concept, and I'm coming =
to
> the list to hear the opinion of users and developers on how to improv=
e
> the thing.
>=20
> The patch is live at http://git.oblomov.eu/, an example affected page=
 is
> http://git.oblomov.eu/git/shortlog
>=20
> Things that are sure to change:
>=20
>  * the aesthetics and location of the toggle link (it shows on mouseh=
over
>    in the title). Other options I've considered are:
>     + next to pagination (first | prev | next), either before or afte=
r
>       the existing entries
>     + on mouseover for the table section that refers to the (short)lo=
g;
>       this would make it possible to put it summary view too, for exa=
mple
>=20
>  * if you toggle merge view when not on the first page, the reference
>    (first) commit in the view is likely to change drastically, which
>    causes confusion. I have not found a satisfactory solution for thi=
s,
>    since the obvious way to 'lock' the view (start paginating from th=
e
>    current top commit) prevents prev/next navigation
>=20
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 50067f2..0da6ef0 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -572,3 +572,14 @@ span.match {
>  div.binary {
>  	font-style: italic;
>  }
> +
> +span.merge_toggle a {
> +	font-size: 66%;
> +	color: white !important;
> +	font-weight: normal;
> +	vertical-align: top;
> +	text-decoration:none;
> +	visibility: hidden;
> +}
> +
> +*:hover > span.merge_toggle a { visibility:visible }
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7e477af..a63f419 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3118,11 +3118,15 @@ sub git_header_html {
>  	my $status =3D shift || "200 OK";
>  	my $expires =3D shift;
> =20
> +	my $can_have_merges =3D grep(/^$action$/, @{$allowed_options{'--no-=
merges'}});
> +	my $has_merges =3D !grep(/^--no-merges$/, @extra_options);
> +
>  	my $title =3D "$site_name";
>  	if (defined $project) {
>  		$title .=3D " - " . to_utf8($project);
>  		if (defined $action) {
>  			$title .=3D "/$action";
> +			$title .=3D " (no merges)" unless $has_merges;
>  			if (defined $file_name) {
>  				$title .=3D " - " . esc_path($file_name);
>  				if ($action eq "tree" && $file_name !~ m|/$|) {
> @@ -3235,6 +3239,16 @@ EOF
>  		print $cgi->a({-href =3D> href(action=3D>"summary")}, esc_html($pr=
oject));
>  		if (defined $action) {
>  			print " / $action";
> +			if ($can_have_merges) {
> +				print " <span class=3D'merge_toggle'>";
> +				if ($has_merges) {
> +					printf('<a href=3D"%s">hide merges</a>', href(-replay=3D>1, 'ex=
tra_options'=3D>('--no-merges', @extra_options)));
> +				} else {
> +					my @href_extra =3D grep(!/^--no-merges$/, @extra_options);
> +					printf('<a href=3D"%s">show merges</a>', href(-replay=3D>1, 'ex=
tra_options'=3D>@href_extra));
> +				}
> +				print "</span>";
> +			}
>  		}
>  		print "\n";
>  	}

--
Etienne Vallette d'Osia
