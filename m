From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: Re: [PATCH] gitweb: Don't append ';js=(0|1)' to external links
Date: Tue, 29 Nov 2011 22:31:20 +0100
Message-ID: <CAKD0UuyH3m0RR2=jk5apFjVMgbD5iWeztR94mE-m7q9dyYKR2Q@mail.gmail.com>
References: <CAKD0UuzU4hAe7RGYukGyPpvfGeYJ3pgJ5pynupneMpQSaX5Cjw@mail.gmail.com>
 <m3pqgaloda.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 22:31:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVHJ-0006EA-GK
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 22:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809Ab1K2Vbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 16:31:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62032 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377Ab1K2Vbn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 16:31:43 -0500
Received: by faaq16 with SMTP id q16so144712faa.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 13:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AWcZs1B/obVq+Mm3S7JDFZvSkBomx5NJX9YrVF+IQYw=;
        b=V7q0XUfX9hyWjijgVHa1wx8e3istAyH2hQFq9/ONRwzqSaJ3iTaOiYCKTB7lBPeA5P
         nNW7TdjiKj4FNvYC+Uu1PtwDYpYr1jDK+rwR83YMhBeIPvY8JZ9vh08Eq6R9w2ygSX7J
         hHVLitqVsMhSPMuWpIFRM9yNOOMHKEAw7tBJo=
Received: by 10.180.24.65 with SMTP id s1mr49353944wif.59.1322602301210; Tue,
 29 Nov 2011 13:31:41 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Tue, 29 Nov 2011 13:31:20 -0800 (PST)
In-Reply-To: <m3pqgaloda.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186085>

On Tue, Nov 29, 2011 at 20:28, Jakub Narebski <jnareb@gmail.com> wrote:
> J=C3=BCrgen Kreileder <jk@blackdown.de> writes:
[...]
> Thanks for this, but I think a better solution would be to explicitly
> mark the few external links we have e.g. with 'class=3D"external"', a=
nd
> use that to avoid adding ';js=3D(0|1)' to them.

This won't work because there are more than a few external links.  Thin=
k of
links added in the header or footer or via a project specific README.ht=
ml.

You would have to do it the other way round: Mark all internal links.

> This has the advantage that we can use different style to mark
> outgoing external links.
>
> I even have such patch somewhere in the StGit stack...
> -- >8 --
> Subject: [PATCH] gitweb: Mark external links
>
> ...and do not add 'js=3D1' to them with JavaScript.
>
> Both $logo_url and $home_link links are now marked with "external"
> class, and fixLink does not add 'js=3D1' to them on click. =C2=A0We a=
dd
> 'js=3D1' to internal link to make server-side of gitweb know that it =
can
> use JavaScript-only actions; we shouldn't do this for extrenal links,
> as 'js=3D1' might mean something else to them.
>
> Note that only links using A element matter: images (linked using
> IMG), stylesheets (linked using STYLE) and JavaScript files (linked
> using SCRIPT) were never affected.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> =C2=A0gitweb/gitweb.perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A05 ++++-
> =C2=A0gitweb/static/js/javascript-detection.js | =C2=A0 =C2=A05 +++++
> =C2=A02 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7456a4b..f1c1caa 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3626,13 +3626,16 @@ EOF
> =C2=A0 =C2=A0 =C2=A0 =C2=A0print "<div class=3D\"page_header\">\n";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (defined $logo) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print $cgi->a(=
{-href =3D> esc_url($logo_url),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-class =3D> "external",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -title =3D> $logo_label},
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$cgi->img({-src =3D> esc_url($logo),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
-width =3D> 72, -height =3D> 27,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
-alt =3D> "git",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
-class =3D> "logo"}));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 print $cgi->a({-href =3D> esc_url($home_link)}=
, $home_link_str) . " / ";
> + =C2=A0 =C2=A0 =C2=A0 print $cgi->a({-href =3D> esc_url($home_link)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0-class =3D> "external"},
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 $home_link_str) . " / ";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (defined $project) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print $cgi->a(=
{-href =3D> href(action=3D>"summary")}, esc_html($project));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (defined $a=
ction) {
> diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static=
/js/javascript-detection.js
> index 2b51e55..fc59e42 100644
> --- a/gitweb/static/js/javascript-detection.js
> +++ b/gitweb/static/js/javascript-detection.js
> @@ -60,6 +60,11 @@ function fixLink(link) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0var jsExceptionsRe =3D /[;?]js=3D[01]$/;
>
> + =C2=A0 =C2=A0 =C2=A0 // don't change links marked as external ($log=
o_url, $home_link)
> + =C2=A0 =C2=A0 =C2=A0 if (link.className =3D=3D=3D 'external') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!jsExceptionsRe.test(link)) { // =3D~ =
/[;?]js=3D[01]$/;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link.href +=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(link.href.indexOf('?') =3D=3D=3D -1 ? '?' : ';') + 'js=3D=
1';
>
>
>



--=20
http://blog.blackdown.de/
http://www.flickr.com/photos/jkreileder/
