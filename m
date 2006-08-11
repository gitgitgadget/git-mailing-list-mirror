From: "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
Subject: [PATCH] gitweb: Different colours for tags and heads
Date: Fri, 11 Aug 2006 17:12:24 +0200
Message-ID: <20060811151224.177110@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 11 17:12:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBYgu-0001V8-0v
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 17:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWHKPMb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 11 Aug 2006 11:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWHKPMa
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 11:12:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:13491 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750824AbWHKPMa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 11:12:30 -0400
Received: (qmail 30661 invoked by uid 0); 11 Aug 2006 15:12:24 -0000
Received: from 141.130.250.71 by www071.gmx.net with HTTP;
 Fri, 11 Aug 2006 17:12:24 +0200 (CEST)
To: git@vger.kernel.org
X-Authenticated: #20307258
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25227>

Hello,

with the following patch there are different colours for tags
and heads in gitweb. So you can easily differentiate between=20
them.


Commit ca9e3b124f6313187da641b5cd55100c4ade6a9a

----

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 47c1ade..c47cbf4 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -330,6 +330,15 @@ span.tag {
 	border-color: #ffffcc #ffee00 #ffee00 #ffffcc;
 }
=20
+span.head {
+	padding: 0px 4px;
+	font-size: 10px;
+	font-weight: normal;
+	background-color: #aaaaff;
+	border: 1px solid;
+	border-color: #ccccff #0033cc #0033cc #ccccff;
+}
+
 span.atnight {
 	color: #cc0000;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 626fcc9..755b0b1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -363,10 +363,10 @@ sub format_log_line_html {
=20
 # format marker of refs pointing to given object
 sub git_get_referencing {
-	my ($refs, $id) =3D @_;
+	my ($refs, $id, $class) =3D @_;
=20
 	if (defined $refs->{$id}) {
-		return ' <span class=3D"tag">' . esc_html($refs->{$id}) . '</span>';
+		return " <span class=3D\"$class\">" . esc_html($refs->{$id}) . "</sp=
an>";
 	} else {
 		return "";
 	}
@@ -1054,7 +1054,7 @@ ## functions printing large fragments of
=20
 sub git_shortlog_body {
 	# uses global variable $project
-	my ($revlist, $from, $to, $refs, $extra) =3D @_;
+	my ($revlist, $from, $to, $refs, $heads, $extra) =3D @_;
 	$from =3D 0 unless defined $from;
 	$to =3D $#{$revlist} if (!defined $to || $#{$revlist} < $to);
=20
@@ -1062,8 +1062,9 @@ sub git_shortlog_body {
 	my $alternate =3D 0;
 	for (my $i =3D $from; $i <=3D $to; $i++) {
 		my $commit =3D $revlist->[$i];
-		#my $ref =3D defined $refs ? git_get_referencing($refs, $commit) : '=
';
-		my $ref =3D git_get_referencing($refs, $commit);
+		#my $ref =3D defined $refs ? git_get_referencing($refs, $commit, "ta=
g") : '';
+		my $ref =3D git_get_referencing($refs, $commit, "tag");
+		my $head =3D git_get_referencing($heads, $commit, "head");
 		my %co =3D git_read_commit($commit);
 		if ($alternate) {
 			print "<tr class=3D\"dark\">\n";
@@ -1078,11 +1079,11 @@ sub git_shortlog_body {
 		if (length($co{'title_short'}) < length($co{'title'})) {
 			print $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$project;a=3D=
commit;h=3D$commit"),
 			               -class =3D> "list", -title =3D> "$co{'title'}"},
-			      "<b>" . esc_html($co{'title_short'}) . "$ref</b>");
+			      "<b>" . esc_html($co{'title_short'}) . "$ref $head</b>");
 		} else {
 			print $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$project;a=3D=
commit;h=3D$commit"),
 			               -class =3D> "list"},
-			      "<b>" . esc_html($co{'title'}) . "$ref</b>");
+			      "<b>" . esc_html($co{'title'}) . "$ref $head</b>");
 		}
 		print "</td>\n" .
 		      "<td class=3D\"link\">" .
@@ -1407,7 +1408,8 @@ sub git_summary {
 		$owner =3D get_file_owner("$projectroot/$project");
 	}
=20
-	my $refs =3D read_info_ref();
+	my $refs =3D read_info_ref("tags");
+	my $heads =3D read_info_ref("heads");
 	git_header_html();
 	git_page_nav('summary','', $head);
=20
@@ -1423,7 +1425,7 @@ sub git_summary {
 	my @revlist =3D map { chomp; $_ } <$fd>;
 	close $fd;
 	git_header_div('shortlog');
-	git_shortlog_body(\@revlist, 0, 15, $refs,
+	git_shortlog_body(\@revlist, 0, 15, $refs, $heads,
 	                  $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$pr=
oject;a=3Dshortlog")}, "..."));
=20
 	my $taglist =3D git_read_refs("refs/tags");
@@ -1746,8 +1748,10 @@ sub git_tree {
 	close $fd or die_error(undef, "Reading tree failed");
 	$/ =3D "\n";
=20
-	my $refs =3D read_info_ref();
-	my $ref =3D git_get_referencing($refs, $hash_base);
+	my $refs =3D read_info_ref("tags");
+	my $heads =3D read_info_ref("heads");
+	my $ref =3D git_get_referencing($refs, $hash_base, "tag");
+	my $head =3D git_get_referencing($heads, $hash_base, "head");
 	git_header_html();
 	my $base_key =3D "";
 	my $base =3D "";
@@ -1755,7 +1759,7 @@ sub git_tree {
 	if (defined $hash_base && (my %co =3D git_read_commit($hash_base))) {
 		$base_key =3D ";hb=3D$hash_base";
 		git_page_nav('tree','', $hash_base);
-		git_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
+		git_header_div('commit', esc_html($co{'title'}) . $ref . $head, $has=
h_base);
 	} else {
 		print "<div class=3D\"page_nav\">\n";
 		print "<br/><br/></div>\n";
@@ -1818,7 +1822,8 @@ sub git_log {
 	if (!defined $page) {
 		$page =3D 0;
 	}
-	my $refs =3D read_info_ref();
+	my $refs =3D read_info_ref("tags");
+	my $heads =3D read_info_ref("heads");
=20
 	my $limit =3D sprintf("--max-count=3D%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
@@ -1839,13 +1844,14 @@ sub git_log {
 	}
 	for (my $i =3D ($page * 100); $i <=3D $#revlist; $i++) {
 		my $commit =3D $revlist[$i];
-		my $ref =3D git_get_referencing($refs, $commit);
+		my $ref =3D git_get_referencing($refs, $commit, "tag");
+		my $head =3D git_get_referencing($heads, $commit, "head");
 		my %co =3D git_read_commit($commit);
 		next if !%co;
 		my %ad =3D date_str($co{'author_epoch'});
 		git_header_div('commit',
 		               "<span class=3D\"age\">$co{'age_string'}</span>" .
-		               esc_html($co{'title'}) . $ref,
+		               esc_html($co{'title'}) . $ref . $head,
 		               $commit);
 		print "<div class=3D\"title_text\">\n" .
 		      "<div class=3D\"log_link\">\n" .
@@ -1902,8 +1908,10 @@ sub git_commit {
 	if ($hash =3D~ m/^[0-9a-fA-F]{40}$/) {
 		$expires =3D "+1d";
 	}
-	my $refs =3D read_info_ref();
-	my $ref =3D git_get_referencing($refs, $co{'id'});
+	my $refs =3D read_info_ref("tags");
+	my $heads =3D read_info_ref("heads");
+	my $ref =3D git_get_referencing($refs, $co{'id'}, "tag");
+	my $head =3D git_get_referencing($heads, $co{'id'}, "head");
 	my $formats_nav =3D '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent =3D $co{'parent'};
@@ -1915,9 +1923,9 @@ sub git_commit {
 	             $formats_nav);
=20
 	if (defined $co{'parent'}) {
-		git_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
+		git_header_div('commitdiff', esc_html($co{'title'}) . $ref . $head, =
$hash);
 	} else {
-		git_header_div('tree', esc_html($co{'title'}) . $ref, $co{'tree'}, $=
hash);
+		git_header_div('tree', esc_html($co{'title'}) . $ref . $head, $co{'t=
ree'}, $hash);
 	}
 	print "<div class=3D\"title_text\">\n" .
 	      "<table cellspacing=3D\"0\">\n";
@@ -2126,13 +2134,15 @@ sub git_commitdiff {
 	if ($hash =3D~ m/^[0-9a-fA-F]{40}$/) {
 		$expires =3D "+1d";
 	}
-	my $refs =3D read_info_ref();
-	my $ref =3D git_get_referencing($refs, $co{'id'});
+	my $refs =3D read_info_ref("tags");
+	my $heads =3D read_info_ref("heads");
+	my $ref =3D git_get_referencing($refs, $co{'id'}, "tag");
+	my $head =3D git_get_referencing($heads, $co{'id'}, "head");
 	my $formats_nav =3D
 		$cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$project;a=3Dcommitd=
iff_plain;h=3D$hash;hp=3D$hash_parent")}, "plain");
 	git_header_html(undef, $expires);
 	git_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
-	git_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
+	git_header_div('commit', esc_html($co{'title'}) . $ref . $head, $hash=
);
 	print "<div class=3D\"page_body\">\n";
 	my $comment =3D $co{'comment'};
 	my $empty =3D 0;
@@ -2271,7 +2281,8 @@ sub git_history {
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
-	my $refs =3D read_info_ref();
+	my $refs =3D read_info_ref("tags");
+	my $heads =3D read_info_ref("heads");
 	git_header_html();
 	git_page_nav('','', $hash_base,$co{'tree'},$hash_base);
 	git_header_div('commit', esc_html($co{'title'}), $hash_base);
@@ -2294,7 +2305,8 @@ sub git_history {
 			if (!%co) {
 				next;
 			}
-			my $ref =3D git_get_referencing($refs, $commit);
+			my $ref =3D git_get_referencing($refs, $commit, "tag");
+			my $head =3D git_get_referencing($heads, $commit, "head");
 			if ($alternate) {
 				print "<tr class=3D\"dark\">\n";
 			} else {
@@ -2304,7 +2316,7 @@ sub git_history {
 			print "<td title=3D\"$co{'age_string_age'}\"><i>$co{'age_string_dat=
e'}</i></td>\n" .
 			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 3)) . "=
</i></td>\n" .
 			      "<td>" . $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$pro=
ject;a=3Dcommit;h=3D$commit"), -class =3D> "list"}, "<b>" .
-			      esc_html(chop_str($co{'title'}, 50)) . "$ref</b>") . "</td>\n=
" .
+			      esc_html(chop_str($co{'title'}, 50)) . $ref . $head . "</b>")=
 . "</td>\n" .
 			      "<td class=3D\"link\">" .
 			      $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$project;a=3D=
commit;h=3D$commit")}, "commit") .
 			      " | " . $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$proj=
ect;a=3Dcommitdiff;h=3D$commit")}, "commitdiff") .
@@ -2468,7 +2480,8 @@ sub git_shortlog {
 	if (!defined $page) {
 		$page =3D 0;
 	}
-	my $refs =3D read_info_ref();
+	my $refs =3D read_info_ref("tags");
+	my $heads =3D read_info_ref("heads");
=20
 	my $limit =3D sprintf("--max-count=3D%i", (100 * ($page+1)));
 	open my $fd, "-|", $GIT, "rev-list", $limit, $hash
@@ -2489,7 +2502,7 @@ sub git_shortlog {
 	git_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
 	git_header_div('summary', $project);
=20
-	git_shortlog_body(\@revlist, ($page * 100), $#revlist, $refs, $next_l=
ink);
+	git_shortlog_body(\@revlist, ($page * 100), $#revlist, $refs, $heads,=
 $next_link);
=20
 	git_footer_html();
 }

----


Bye,
Thomas
--=20


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
