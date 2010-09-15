From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (bugfix)] gitweb: Add and use prep_attr helper
Date: Wed, 15 Sep 2010 23:16:34 +0200
Message-ID: <201009152316.36225.jnareb@gmail.com>
References: <201009152234.14253.jnareb@gmail.com> <AANLkTi=o2PFB=JkO5wYHCLAHCO=Ebe63mAc6WB8GfktH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Uwe =?utf-8?q?Kleine-K=C3=B6nig?=" <u.kleine-koenig@pengutronix.de>
To: "=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason" 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 23:15:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvzKd-0002Zc-Sb
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 23:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab0IOVPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 17:15:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43490 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab0IOVPt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 17:15:49 -0400
Received: by bwz11 with SMTP id 11so952600bwz.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=w9/WpS8nq4orsqtq7aMZcQK1yiltxbK/VeRoxwnAxWA=;
        b=HtPyv5QmECJxCkroW3Uu+AgF14pDAa5Ho6RsxtwEJQXqvNqDuqR2kYCJAw3iHghX4G
         80D8KlDPOyYn0bMBLW0O/2A+Bj2xt2Fkq6fRjFIygteLVkyY+djj2suC56WZMgwCkC7p
         PYTqJqGzfUmA8/aOLOOUqsSGVLn4iuLwwDj38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xCgnInQv76ArWF0KQiuGcLMDM7dq5HcN0rmjvt1yaRGv+nTTvafjr8/QCZj/vEHZl6
         jjUfmzFsO35Z3qYezN2fi4j0j3itSkW3R94RD+3Lmj3AutRNc6q7Y7M3iWJJ5bpq/zGK
         O70Zm9UjM87ElMCljiUlDoynq9IJrTjduvlLA=
Received: by 10.204.61.133 with SMTP id t5mr1913884bkh.4.1284585347430;
        Wed, 15 Sep 2010 14:15:47 -0700 (PDT)
Received: from [192.168.1.13] (abve52.neoplus.adsl.tpnet.pl [83.8.202.52])
        by mx.google.com with ESMTPS id 11sm1772583bkj.23.2010.09.15.14.15.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Sep 2010 14:15:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=o2PFB=JkO5wYHCLAHCO=Ebe63mAc6WB8GfktH@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156259>

On Wed, 15 Sep 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> 2010/9/15 Jakub Narebski <jnareb@gmail.com>:
> > One of features of CGI.pm module is HTML generation. =C2=A0The HTML
> > generation subroutines / methods automatically escape values of
> > attributes of HTML elements... but in older versions didn't do it
> > fully, not removing / replacing control characters. =C2=A0Control
> > characters are forbidden in XML / XHTML, and some browsers
> > (e.g. Firefox) do not skip over them but display error instead of p=
age
> > in strict XHTML mode (XHTML DTD + application/xml+html mimetype).
> >
> > This issue was noticed by Uwe Kleine-K=C3=B6nig and resolved to be =
a
> > problem with control characters in XHTML output by =C3=86var Arnfj=C3=
=B6r=C3=B0
> > Bjarmason in format_search_author() subroutine.
>=20
> FWIW this looks good to me, but perhaps instead of using "?" for
> everything in ASCII from \0 to " " it would be better to display the
> human-readable escape sequence, like "\r" or "\b".

Well, the advantage of this version is that it can be changed in single
place, i.e. in prep_attr(), see updated patch below.
=20
> Gitweb already does this (although I don't have a link handy) if you
> check in a file with Windows newlines, it'll display "\r" in a little
> box.
>=20
> Maybe that should be done everywhere? I don't know.

Note that we have three different situations:
1. Output is HTML fragment (esc_html, esc_path)
2. Output is attribute of HTML element, i.e. text (prep_attr)
3. Output is HTTP header (in snapshot_name)
   for proposed filename

But having the same result for 1 and 2 might be good idea.

-- >8 --
Subject: [PATCH] gitweb: Add and use prep_attr helper

One of features of CGI.pm module is HTML generation.  The HTML
generation subroutines / methods automatically escape values of
attributes of HTML elements... but in older versions didn't do it
fully, not removing / replacing control characters.  Control
characters are forbidden in XML / XHTML, and some browsers
(e.g. Firefox) do not skip over them but display error instead of page
in strict XHTML mode (XHTML DTD + application/xml+html mimetype).

This issue was noticed by Uwe Kleine-K=C3=B6nig and resolved to be a
problem with control characters in XHTML output by =C3=86var Arnfj=C3=B6=
r=C3=B0
Bjarmason in format_search_author() subroutine.


Introduce prep_attr subroutine to deal with this problem, and use it
in all places where we use data from outside gitweb in attributes of
HTML elements, where those HTML elements are generated by CGI.pm
subroutines / methods (this usually means 'title' attribute).

While at it simplify format_search_author() a bit, and use spaces
for align.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Intediff (indented)

  diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
  index da20209..92a634a 100755
  --- a/gitweb/gitweb.perl
  +++ b/gitweb/gitweb.perl
  @@ -1357,7 +1357,7 @@ sub prep_attr {
          my ($attr_name, $value) =3D @_ > 1 ? @_ : (undef, @_);
  =20
          $value =3D to_utf8($value);
  -       $value =3D~ s/[[:cntrl:]]/?/g;
  +       $value =3D~ s/([[:cntrl:]])/quot_cec($1, '-nohtml' =3D> 1)/eg=
;
  =20
          return defined $attr_name ? ($attr_name =3D> $value) : $value=
;
   }


 gitweb/gitweb.perl |   62 +++++++++++++++++++++++++++++++-------------=
--------
 1 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a85e2f6..92a634a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1346,6 +1346,22 @@ sub esc_param {
 	return $str;
 }
=20
+# prepare 'attribute =3D> value' pair for CGI.pm HTML generation,
+# by escaping/quoting/replacing/removing values which are invalid in (=
X)HTML,
+# and which older versions of CGI.pm do not quote correctly
+#
+# USAGE:
+#   $cgi->a({-href =3D> ..., prep_attr(-title =3D> $title)}, esc_html(=
$contents));
+#   $cgi->a({-href =3D> ..., -title =3D> prep_attr($title)}, esc_html(=
$contents));
+sub prep_attr {
+	my ($attr_name, $value) =3D @_ > 1 ? @_ : (undef, @_);
+
+	$value =3D to_utf8($value);
+	$value =3D~ s/([[:cntrl:]])/quot_cec($1, '-nohtml' =3D> 1)/eg;
+
+	return defined $attr_name ? ($attr_name =3D> $value) : $value;
+}
+
 # quote unsafe chars in whole URL, so some characters cannot be quoted
 sub esc_url {
 	my $str =3D shift;
@@ -1555,8 +1571,7 @@ sub chop_and_escape_str {
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
-		$str =3D~ s/[[:cntrl:]]/?/g;
-		return $cgi->span({-title=3D>$str}, esc_html($chopped));
+		return $cgi->span({prep_attr(-title=3D>$str)}, esc_html($chopped));
 	}
 }
=20
@@ -1778,9 +1793,8 @@ sub format_subject_html {
 	$extra =3D '' unless defined($extra);
=20
 	if (length($short) < length($long)) {
-		$long =3D~ s/[[:cntrl:]]/?/g;
 		return $cgi->a({-href =3D> $href, -class =3D> "list subject",
-		                -title =3D> to_utf8($long)},
+		                prep_attr(-title =3D> $long)},
 		       esc_html($short)) . $extra;
 	} else {
 		return $cgi->a({-href =3D> $href, -class =3D> "list subject"},
@@ -1856,23 +1870,20 @@ sub format_search_author {
 	my ($author, $searchtype, $displaytext) =3D @_;
 	my $have_search =3D gitweb_check_feature('search');
=20
-	if ($have_search) {
-		my $performed =3D "";
-		if ($searchtype eq 'author') {
-			$performed =3D "authored";
-		} elsif ($searchtype eq 'committer') {
-			$performed =3D "committed";
-		}
-
-		return $cgi->a({-href =3D> href(action=3D>"search", hash=3D>$hash,
-				searchtext=3D>$author,
-				searchtype=3D>$searchtype), class=3D>"list",
-				title=3D>"Search for commits $performed by $author"},
-				$displaytext);
+	return $displaytext unless ($have_search);
=20
-	} else {
-		return $displaytext;
+	my $performed =3D "";
+	if ($searchtype eq 'author') {
+		$performed =3D "authored";
+	} elsif ($searchtype eq 'committer') {
+		$performed =3D "committed";
 	}
+
+	my $title =3D "Search for commits $performed by $author";
+	return $cgi->a({-href =3D> href(action=3D>"search", hash=3D>$hash,
+	                              searchtext=3D>$author, searchtype=3D>$s=
earchtype),
+	                -class=3D>"list", prep_attr(-title=3D>$title)},
+	               $displaytext);
 }
=20
 # format the author name of the given commit with the given tag
@@ -3559,7 +3570,7 @@ sub git_footer_html {
 		foreach my $format qw(RSS Atom) {
 			$href_params{'action'} =3D lc($format);
 			print $cgi->a({-href =3D> href(%href_params),
-			              -title =3D> "$href_params{'-title'} $format feed",
+			              prep_attr(-title =3D> "$href_params{'-title'} $format=
 feed"),
 			              -class =3D> $feed_class}, $format)."\n";
 		}
=20
@@ -3827,17 +3838,17 @@ sub git_print_page_path {
 			$fullname .=3D ($fullname ? '/' : '') . $dir;
 			print $cgi->a({-href =3D> href(action=3D>"tree", file_name=3D>$full=
name,
 			                             hash_base=3D>$hb),
-			              -title =3D> $fullname}, esc_path($dir));
+			              prep_attr(-title =3D> $fullname)}, esc_path($dir));
 			print " / ";
 		}
 		if (defined $type && $type eq 'blob') {
 			print $cgi->a({-href =3D> href(action=3D>"blob_plain", file_name=3D=
>$file_name,
 			                             hash_base=3D>$hb),
-			              -title =3D> $name}, esc_path($basename));
+			              prep_attr(-title =3D> $name)}, esc_path($basename));
 		} elsif (defined $type && $type eq 'tree') {
 			print $cgi->a({-href =3D> href(action=3D>"tree", file_name=3D>$file=
_name,
 			                             hash_base=3D>$hb),
-			              -title =3D> $name}, esc_path($basename));
+			              prep_attr(-title =3D> $name)}, esc_path($basename));
 			print " / ";
 		} else {
 			print esc_path($basename);
@@ -3981,7 +3992,8 @@ sub git_print_tree_entry {
 					print " -> " .
 					      $cgi->a({-href =3D> href(action=3D>"object", hash_base=3D>$=
hash_base,
 					                             file_name=3D>$norm_target),
-					               -title =3D> $norm_target}, esc_path($link_target))=
;
+					               prep_attr(-title =3D> $norm_target)},
+					              esc_path($link_target));
 				} else {
 					print " -> " . esc_path($link_target);
 				}
@@ -4687,7 +4699,7 @@ sub git_project_list_body {
 		print "<td>" . $cgi->a({-href =3D> href(project=3D>$pr->{'path'}, ac=
tion=3D>"summary"),
 		                        -class =3D> "list"}, esc_html($pr->{'path'})=
) . "</td>\n" .
 		      "<td>" . $cgi->a({-href =3D> href(project=3D>$pr->{'path'}, ac=
tion=3D>"summary"),
-		                        -class =3D> "list", -title =3D> $pr->{'descr=
_long'}},
+		                        -class =3D> "list", prep_attr(-title =3D> $p=
r->{'descr_long'})},
 		                        esc_html($pr->{'descr'})) . "</td>\n" .
 		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></t=
d>\n";
 		print "<td class=3D\"". age_class($pr->{'age'}) . "\">" .
--=20
1.7.2.1
