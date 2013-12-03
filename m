From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH 2/3] gitweb: Add a feature for adding more branch refs
Date: Tue,  3 Dec 2013 15:56:42 +0100
Message-ID: <1386082603-8404-3-git-send-email-krzesimir@endocode.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 15:57:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnrQ6-0006xp-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 15:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab3LCO5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 09:57:47 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:43200 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747Ab3LCO5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 09:57:40 -0500
Received: by mail-bk0-f43.google.com with SMTP id mz12so6057448bkb.16
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 06:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=M+9T2/j/x/2nAlYjJRUYQAyoO8aockRjYQmPYVH8jys=;
        b=PuThFrMikwJbcNuNpMIAG/f0GJQwv8yM9y1qp6ehiLHrs9pRVab2/IKDkZiF5tRRMT
         ODnnzm+mi/w8QiQsXtRJpy/d0j62380QbKXvQkBni6b6zW/Y7kqkNho0mSvrBrZRgrRf
         WK4/jzLuDAbc6prHheb0tCO5RUl8xdV07NJ5rCPee/jPKEFhd6yirh+wQ0xTmqLGu33J
         DHDCK2xbGkDKhYoNm02HJYNtAoE8ANG41zDYpCr/REUqf4Ftf5Ds4bNgN3/F3vV5g29S
         bN96XgjgNBwZ3eedcmZWlROQK0vX/e37XSOh/AoNdYadZ8U+MfKR6Wo8n+5VnO0XMqRJ
         OcgA==
X-Gm-Message-State: ALoCoQloi5fIy3j1bWvcZyHcTteXVGv+lk50lQn3uHaac/GyWNkY1HqhXOc9mpmbbHr7E9VEQrFc
X-Received: by 10.205.20.132 with SMTP id qo4mr408605bkb.110.1386082658641;
        Tue, 03 Dec 2013 06:57:38 -0800 (PST)
Received: from localhost.localdomain (p5792264C.dip0.t-ipconnect.de. [87.146.38.76])
        by mx.google.com with ESMTPSA id bf8sm30500407bkb.14.2013.12.03.06.57.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2013 06:57:38 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238695>

Allow extra-branch-refs feature to tell gitweb to show refs from
additional hierarchies in addition to branches in the list-of-branches
view.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/gitweb.conf.txt | 27 +++++++++++++++
 gitweb/gitweb.perl            | 76 +++++++++++++++++++++++++++++++++++=
+-------
 2 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
index e2113d9..3de8e14 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -849,6 +849,33 @@ time zones in the form of "+/-HHMM", such as "+020=
0".
 +
 Project specific override is not supported.
=20
+extra-branch-refs::
+	List of additional directories under "refs" which are going to
+	be used as branch refs. For example if you have a gerrit setup
+	where all branches under refs/heads/ are official,
+	push-after-review ones and branches under refs/sandbox/,
+	refs/wip and refs/other are user ones where permissions are
+	much wider, then you might want to set this variable as
+	follows:
++
+----------------------------------------------------------------------=
----------
+$feature{'extra-branch-refs'}{'default'} =3D
+	['sandbox', 'wip', 'other'];
+----------------------------------------------------------------------=
----------
++
+If overriding was enabled then this feature can be configured on a
+per-repository basis via repository's `gitweb.extrabranchrefs`
+configuration variable, which contains a space separated list of
+refs. An example:
++
+----------------------------------------------------------------------=
----------
+[gitweb]
+	extrabranchrefs =3D sandbox wip other
+----------------------------------------------------------------------=
----------
++
+It is an error to specify a ref that does not pass "git check-ref-form=
at"
+scrutiny. Duplicated values are filtered.
+
=20
 EXAMPLES
 --------
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f7730d7..6326075 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -548,6 +548,20 @@ our %feature =3D (
 		'sub' =3D> sub { feature_bool('remote_heads', @_) },
 		'override' =3D> 0,
 		'default' =3D> [0]},
+
+	# Enable showing branches under other refs in addition to heads
+
+	# To set system wide extra branch refs have in $GITWEB_CONFIG
+	# $feature{'extra-branch-refs'}{'default'} =3D ['dirs', 'of', 'choice=
'];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'extra-branch-refs'}{'override'} =3D 1;
+	# and in project config gitweb.extrabranchrefs =3D dirs of choice
+	# Every directory is separated with whitespace.
+
+	'extra-branch-refs' =3D> {
+		'sub' =3D> \&feature_extra_branch_refs,
+		'override' =3D> 0,
+		'default' =3D> []},
 );
=20
 sub gitweb_get_feature {
@@ -626,6 +640,17 @@ sub feature_avatar {
 	return @val ? @val : @_;
 }
=20
+sub feature_extra_branch_refs {
+	my (@branch_refs) =3D @_;
+	my $values =3D git_get_project_config('extra_branch_refs');
+
+	if ($values) {
+		@branch_refs =3D split /\s+/, $values;
+	}
+
+	return @branch_refs;
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -656,6 +681,18 @@ sub filter_snapshot_fmts {
 		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
 }
=20
+sub filter_and_validate_refs {
+	my @refs =3D @_;
+	my %unique_refs =3D ();
+
+	foreach my $ref (@refs) {
+		die_error(500, "Invalid ref '$ref' in 'extra-branch-refs' feature") =
unless (check_ref_format($ref));
+		# 'heads' are added implicitly in get_branch_refs().
+		$unique_refs{$ref} =3D 1 if ($ref ne 'heads');
+	}
+	return sort keys %unique_refs;
+}
+
 # If it is set to code reference, it is code that it is to be run once=
 per
 # request, allowing updating configurations that change with each requ=
est,
 # while running other code in config file only once.
@@ -1113,7 +1150,7 @@ sub evaluate_git_dir {
 	our $git_dir =3D "$projectroot/$project" if $project;
 }
=20
-our (@snapshot_fmts, $git_avatar);
+our (@snapshot_fmts, $git_avatar, @extra_branch_refs);
 sub configure_gitweb_features {
 	# list of supported snapshot formats
 	our @snapshot_fmts =3D gitweb_get_feature('snapshot');
@@ -1131,6 +1168,13 @@ sub configure_gitweb_features {
 	} else {
 		$git_avatar =3D '';
 	}
+
+	our @extra_branch_refs =3D gitweb_get_feature('extra-branch-refs');
+	@extra_branch_refs =3D filter_and_validate_refs (@extra_branch_refs);
+}
+
+sub get_branch_refs {
+	return ('heads', @extra_branch_refs);
 }
=20
 # custom error handler: 'die <message>' is Internal Server Error
@@ -2524,6 +2568,7 @@ sub format_snapshot_links {
 sub get_feed_info {
 	my $format =3D shift || 'Atom';
 	my %res =3D (action =3D> lc($format));
+	my $matched_ref =3D 0;
=20
 	# feed links are possible only for project views
 	return unless (defined $project);
@@ -2531,12 +2576,17 @@ sub get_feed_info {
 	# or don't have specific feed yet (so they should use generic)
 	return if (!$action || $action =3D~ /^(?:tags|heads|forks|tag|search)=
$/x);
=20
-	my $branch;
-	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
-	# from tag links; this also makes possible to detect branch links
-	if ((defined $hash_base && $hash_base =3D~ m!^refs/heads/(.*)$!) ||
-	    (defined $hash      && $hash      =3D~ m!^refs/heads/(.*)$!)) {
-		$branch =3D $1;
+	my $branch =3D undef;
+	# branches refs uses 'refs/' + $get_branch_refs()[x] + '/' prefix
+	# (fullname) to differentiate from tag links; this also makes
+	# possible to detect branch links
+	for my $ref (get_branch_refs()) {
+		if ((defined $hash_base && $hash_base =3D~ m!^refs/\Q$ref\E/(.*)$!) =
||
+		    (defined $hash      && $hash      =3D~ m!^refs/\Q$ref\E/(.*)$!))=
 {
+			$branch =3D $1;
+			$matched_ref =3D $ref;
+			last;
+		}
 	}
 	# find log type for feed description (title)
 	my $type =3D 'log';
@@ -2549,7 +2599,7 @@ sub get_feed_info {
 	}
=20
 	$res{-title} =3D $type;
-	$res{'hash'} =3D (defined $branch ? "refs/heads/$branch" : undef);
+	$res{'hash'} =3D (defined $branch ? "refs/$matched_ref/$branch" : und=
ef);
 	$res{'file_name'} =3D $file_name;
=20
 	return %res;
@@ -3202,7 +3252,7 @@ sub git_get_last_activity {
 	     '--format=3D%(committer)',
 	     '--sort=3D-committerdate',
 	     '--count=3D1',
-	     'refs/heads') or return;
+	     map { "refs/$_" } get_branch_refs ()) or return;
 	my $most_recent =3D <$fd>;
 	close $fd or return;
 	if (defined $most_recent &&
@@ -3653,7 +3703,7 @@ sub parse_from_to_diffinfo {
=20
 sub git_get_heads_list {
 	my ($limit, @classes) =3D @_;
-	@classes =3D ('heads') unless @classes;
+	@classes =3D get_branch_refs() unless @classes;
 	my @patterns =3D map { "refs/$_" } @classes;
 	my @headslist;
=20
@@ -3671,7 +3721,8 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =3D
 			($committerinfo =3D~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  =3D $name;
-		$name =3D~ s!^refs/(?:head|remote)s/!!;
+		my $strip_refs =3D join '|', map { quotemeta } get_branch_refs();
+		$name =3D~ s!^refs/($strip_refs|remotes)/!!;
=20
 		$ref_item{'name'}  =3D $name;
 		$ref_item{'id'}    =3D $hash;
@@ -7188,7 +7239,8 @@ sub snapshot_name {
 		$ver =3D $1;
 	} else {
 		# branches and other need shortened SHA-1 hash
-		if ($hash =3D~ m!^refs/(?:heads|remotes)/(.*)$!) {
+		my $strip_refs =3D join '|', map { quotemeta } get_branch_refs();
+		if ($hash =3D~ m!^refs/($strip_refs|remotes)/(.*)$!) {
 			$ver =3D $1;
 		}
 		$ver .=3D '-' . git_get_short_hash($project, $hash);
--=20
1.8.3.1
