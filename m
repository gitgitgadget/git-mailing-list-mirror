From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Change the way "content tags" ('ctags') are handled
Date: Mon, 7 Mar 2011 19:00:13 +0100
Message-ID: <201103071900.16126.jnareb@gmail.com>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek> <201103030142.17258.jnareb@gmail.com> <20110303081904.GM22310@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog9@kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, admin@repo.or.cz
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 19:08:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwerZ-00013Y-He
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 19:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab1CGSIo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 13:08:44 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46879 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab1CGSId (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 13:08:33 -0500
Received: by fxm17 with SMTP id 17so4329671fxm.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 10:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Z9pRJ/MJQwRNnHeboI7THxF0eOc7zxeYfTNAlr8lDd4=;
        b=Fa2951kjsMZG7zdKNt81aI6kGXU3R3b+Yd4va2hl1+EbV1mLCtkGpoG81VlqfrbhZb
         HwrJkgtfqvfwizkpBS8GFFdhkpSCpKyvA3OW3uz3v4IWbSebvTsGr/VRTsVi3ruDQK09
         GjHJmSGz8KNQirxB5Ec9MxB8BJihBpIP+xMcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D1ei0EjdWe3Lj7rF/MBySaV785CM8MI+GnYINPTuZXkXXFfqATL8wWqqxjrPMk31ka
         KvSFgxRLVxuJrfAVrZ6u62TNgc8qmb7lCrCljpodV2/8Zdd211T3L5uSebWFMdxctBdd
         13yLpfDTt+jCcn87D+gds/96TAEh9HS41TzeY=
Received: by 10.223.14.137 with SMTP id g9mr2754719faa.8.1299520819536;
        Mon, 07 Mar 2011 10:00:19 -0800 (PST)
Received: from [192.168.1.13] (abwr209.neoplus.adsl.tpnet.pl [83.8.241.209])
        by mx.google.com with ESMTPS id j11sm1105488faa.44.2011.03.07.10.00.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 10:00:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110303081904.GM22310@pengutronix.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168599>

On Thu, 3 March 2011, Uwe Kleine-K=F6nig wrote:
> On Thu, Mar 03, 2011 at 01:42:15AM +0100, Jakub Narebski wrote:
>> On Wed, 2 Mar 2011, Uwe Kleine-K=F6nig wrote:
>>> On Wed, Mar 02, 2011 at 10:18:44PM +0100, Jakub Narebski wrote:

>>>> What is most important that makes this feature to be considered fo=
r
>>>> removal (or rehauling) is that only half of this feature is implem=
ented
>>>> in gitweb: the displaying part.  There is half-attempt of providin=
g
>>>> some web interface for managing tags... which needs external scrip=
t with
>>>> strict coupling, doesn't offer any access control as far as I know=
, do
>>>> not allow deleting tags, etc.
>>>
>>> For a small set of repositories the need to hand-edit the tags is O=
K
>>> IMHO.  That's what I intended to do.
>>=20
>> So what would you like to see?
>>=20
>> 1. Hardening parsing of ctags files, so that gitweb does not crash o=
n
>>    malformed entries, but e.g. just ignores them.

Done.
=20
>> 2. Generating tag cloud upfront, before sending any output to browse=
r,
>>    to catch error better (and perhaps separate CSS for HTML::TagClou=
d).

Not done, but with 1. it should be not very necessary... unless another
bug is found in related code, that is.

>> 3. Describe format of ctags files, either in comments in code, or in
>>    gitweb/README.

Done (comments in code).

>> 4. Either:
>>=20
>>    A. Remove editing ctags from gitweb, or
>>    B. Add some simple generation of ctags file to gitweb

Done 4.A.

> yes :-)  (1-3, 4a)  I wouldn't mind 4b, but it should be possible to
> disable the possibility to publically edit tags via gitweb.


The patch below (addressing those issues) is based on

  "[PATCHv2/RFC] gitweb: Restructure projects list generation"
  http://thread.gmane.org/gmane.comp.version-control.git/167996/focus=3D=
168321
  http://repo.or.cz/w/git/jnareb-git.git/commit/420071752d13dcecd59e794=
d82285e7e142ef75f
  ('gitweb/web' branch in http://repo.or.cz/w/git/jnareb-git.git reposi=
tory)

-- >8 --
Subject: [RFC/PATCH] gitweb: Change the way "content tags" ('ctags') ar=
e handled

The major change is removing the ability to edit content tags (ctags)
in a web browser.

The interface was created by gitweb, while actual editing of tags was
to be done by external script; the API was not defined, and neither
was provided example implementation.  Such split is also a bit fragile
- interface and implementation have to be kept in sync.  Gitweb
provided only ability to add tags; you could not edit tags nor delete
them.


=46ormat of ctags is now described in the comment above git_get_project=
_ctags
subroutine.  Gitweb now is more robust with respect to original ctags
format; it also accepts two new formats: $GIT_DIR/ctags file, with one
content tag per line, and multi-value `gitweb.ctag' config variable.

Gathering all ctags of all project is now put in git_gather_all_ctags
subroutine, making git_project_list_body more clear.

git_populate_project_tagcloud subroutine now generates data used for
tag cloud, including generation of ctag link, also in the case
HTML::TagCloud module is unavailable.  Links are now generated using
href() subroutine - this is more robust, as ctags might contain '?',
';' and '=3D' special characters that need to be escaped in query param=
=2E
Shown tags are HTML-escaped.

The generation of tag cloud in git_show_project_tagcloud in the case
when HTML::TagCloud is not available is now changed slightly.

The 'content tags' field on project summary page is made more in line
with other fields in "projects_list" table.  Because one cannot now
add new tags from web interface, this field is no longer displayed
when there are no content tags for given project.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |  141 +++++++++++++++++++++++++++++++++++---------=
-------
 1 files changed, 97 insertions(+), 44 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 996b647..4d80818 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -412,20 +412,23 @@ our %feature =3D (
 		'override' =3D> 0,
 		'default' =3D> []},
=20
-	# Allow gitweb scan project content tags described in ctags/
-	# of project repository, and display the popular Web 2.0-ish
-	# "tag cloud" near the project list. Note that this is something
-	# COMPLETELY different from the normal Git tags.
+	# Allow gitweb scan project content tags of project repository,
+	# and display the popular Web 2.0-ish "tag cloud" near the projects
+	# list.  Note that this is something COMPLETELY different from the
+	# normal Git tags.
=20
 	# gitweb by itself can show existing tags, but it does not handle
-	# tagging itself; you need an external application for that.
-	# For an example script, check Girocco's cgi/tagproj.cgi.
+	# tagging itself; you need to do it externally, outside gitweb.
+	# The format is described in git_get_project_ctags() subroutine.
 	# You may want to install the HTML::TagCloud Perl module to get
 	# a pretty tag cloud instead of just a list of tags.
=20
 	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'ctags'}{'default'} =3D ['path_to_tag_script'];
+	# $feature{'ctags'}{'default'} =3D [1];
 	# Project specific override is not supported.
+
+	# In the future whether ctags editing is enabled might depend
+	# on the value, but using 1 should always mean no editing of ctags.
 	'ctags' =3D> {
 		'override' =3D> 0,
 		'default' =3D> [0]},
@@ -703,6 +706,7 @@ our @cgi_param_mapping =3D (
 	snapshot_format =3D> "sf",
 	extra_options =3D> "opt",
 	search_use_regexp =3D> "sr",
+	ctag =3D> "by_tag",
 	# this must be last entry (for manipulation from JavaScript)
 	javascript =3D> "js"
 );
@@ -2564,23 +2568,66 @@ sub git_get_project_description {
 	return $descr;
 }
=20
+# supported formats:
+# * $GIT_DIR/ctags/<tagname> file (in 'ctags' subdirectory)
+#   - if its contents is a number, use it as tag weight,
+#   - otherwise add a tag with weight 1
+# * $GIT_DIR/ctags file, each line is a tag (with weight 1)
+#   the same value multiple times increases tag weight
+# * `gitweb.ctag' multi-valued repo config variable
 sub git_get_project_ctags {
-	my $path =3D shift;
+	my $project =3D shift;
 	my $ctags =3D {};
=20
-	$git_dir =3D "$projectroot/$path";
-	opendir my $dh, "$git_dir/ctags"
-		or return $ctags;
-	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh)) {
-		open my $ct, '<', $_ or next;
-		my $val =3D <$ct>;
-		chomp $val;
-		close $ct;
-		my $ctag =3D $_; $ctag =3D~ s#.*/##;
-		$ctags->{$ctag} =3D $val;
+	$git_dir =3D "$projectroot/$project";
+	if (opendir my $dh, "$git_dir/ctags") {
+		my @files =3D grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh=
);
+		foreach my $tagfile (@files) {
+			open my $ct, '<', $tagfile
+				or next;
+			my $val =3D <$ct>;
+			chomp $val if $val;
+			close $ct;
+
+			(my $ctag =3D $tagfile) =3D~ s#.*/##;
+			if ($val =3D~ /\d+/) {
+				$ctags->{$ctag} =3D $val;
+			} else {
+				$ctags->{$ctag} =3D 1;
+			}
+		}
+		closedir $dh;
+
+	} elsif (open my $fh, '<', "$git_dir/ctags") {
+		while (my $line =3D <$fh>) {
+			chomp $line;
+			$ctags->{$line}++ if $line;
+		}
+		close $fh;
+
+	} else {
+		my $taglist =3D config_to_multi(git_get_project_config('ctag'));
+		foreach my $tag (@$taglist) {
+			$ctags->{$tag}++;
+		}
 	}
-	closedir $dh;
-	$ctags;
+
+	return $ctags;
+}
+
+# return hash, where keys are content tags ('ctags'),
+# and values are sum of weights of given tag in every project
+sub git_gather_all_ctags {
+	my $projects =3D shift;
+	my $ctags =3D {};
+
+	foreach my $p (@$projects) {
+		foreach my $ct (keys %{$p->{'ctags'}}) {
+			$ctags->{$ct} +=3D $p->{'ctags'}->{$ct};
+		}
+	}
+
+	return $ctags;
 }
=20
 sub git_populate_project_tagcloud {
@@ -2600,31 +2647,41 @@ sub git_populate_project_tagcloud {
 	my $cloud;
 	if (eval { require HTML::TagCloud; 1; }) {
 		$cloud =3D HTML::TagCloud->new;
-		foreach (sort keys %ctags_lc) {
+		foreach my $ctag (sort keys %ctags_lc) {
 			# Pad the title with spaces so that the cloud looks
 			# less crammed.
-			my $title =3D $ctags_lc{$_}->{topname};
+			my $title =3D esc_html($ctags_lc{$ctag}->{topname});
 			$title =3D~ s/ /&nbsp;/g;
 			$title =3D~ s/^/&nbsp;/g;
 			$title =3D~ s/$/&nbsp;/g;
-			$cloud->add($title, $home_link."?by_tag=3D".$_, $ctags_lc{$_}->{cou=
nt});
+			$cloud->add($title, href(project=3D>undef, ctag=3D>$ctag),
+			            $ctags_lc{$ctag}->{count});
 		}
 	} else {
-		$cloud =3D \%ctags_lc;
+		$cloud =3D {};
+		foreach my $ctag (keys %ctags_lc) {
+			my $title =3D $ctags_lc{$ctag}->{topname};
+			$cloud->{$ctag}{count} =3D $ctags_lc{$ctag}->{count};
+			$cloud->{$ctag}{ctag} =3D
+				$cgi->a({-href=3D>href(project=3D>undef, ctag=3D>$ctag)},
+			          esc_html($title, -nbsp=3D>1));
+		}
 	}
-	$cloud;
+	return $cloud;
 }
=20
 sub git_show_project_tagcloud {
 	my ($cloud, $count) =3D @_;
-	print STDERR ref($cloud)."..\n";
 	if (ref $cloud eq 'HTML::TagCloud') {
 		return $cloud->html_and_css($count);
 	} else {
-		my @tags =3D sort { $cloud->{$a}->{count} <=3D> $cloud->{$b}->{count=
} } keys %$cloud;
-		return '<p align=3D"center">' . join (', ', map {
-			$cgi->a({-href=3D>"$home_link?by_tag=3D$_"}, $cloud->{$_}->{topname=
})
-		} splice(@tags, 0, $count)) . '</p>';
+		my @tags =3D sort { $cloud->{$a}->{'count'} <=3D> $cloud->{$b}->{'co=
unt'} } keys %$cloud;
+		return
+			'<div id=3D"htmltagcloud"'.($project ? '' : ' align=3D"center"').'>=
' .
+			join (', ', map {
+				$cloud->{$_}->{'ctag'}
+			} splice(@tags, 0, $count)) .
+			'</div>';
 	}
 }
=20
@@ -4905,13 +4962,8 @@ sub git_project_list_body {
 	@projects =3D sort_projects_list(\@projects, $order);
=20
 	if ($show_ctags) {
-		my %ctags;
-		foreach my $p (@projects) {
-			foreach my $ct (keys %{$p->{'ctags'}}) {
-				$ctags{$ct} +=3D $p->{'ctags'}->{$ct};
-			}
-		}
-		my $cloud =3D git_populate_project_tagcloud(\%ctags);
+		my $ctags =3D git_gather_all_ctags(\@projects);
+		my $cloud =3D git_populate_project_tagcloud($ctags);
 		print git_show_project_tagcloud($cloud, 64);
 	}
=20
@@ -5507,13 +5559,14 @@ sub git_summary {
 	my $show_ctags =3D gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my $ctags =3D git_get_project_ctags($project);
-		my $cloud =3D git_populate_project_tagcloud($ctags);
-		print "<tr id=3D\"metadata_ctags\"><td>Content tags:<br />";
-		print "</td>\n<td>" unless %$ctags;
-		print "<form action=3D\"$show_ctags\" method=3D\"post\"><input type=3D=
\"hidden\" name=3D\"p\" value=3D\"$project\" />Add: <input type=3D\"tex=
t\" name=3D\"t\" size=3D\"8\" /></form>";
-		print "</td>\n<td>" if %$ctags;
-		print git_show_project_tagcloud($cloud, 48);
-		print "</td></tr>";
+		if (%$ctags) {
+			# without ability to add tags, don't show if there are none
+			my $cloud =3D git_populate_project_tagcloud($ctags);
+			print "<tr id=3D\"metadata_ctags\">" .
+			      "<td>content tags</td>" .
+			      "<td>".git_show_project_tagcloud($cloud, 48)."</td>" .
+			      "</tr>\n";
+		}
 	}
=20
 	print "</table>\n";
--=20
1.7.3
