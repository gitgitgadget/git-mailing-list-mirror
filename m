Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WNr8Q5rl"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E6B1A8
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 11:30:32 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3651A1D281;
	Thu, 16 Nov 2023 14:30:32 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=cUUJ5TVu5cT0ZWmobCYGy2o9D
	IR1GawcM98ZXcYGPho=; b=WNr8Q5rlFfTAdIHD88R7Nyoo7PQgtXzYcjE7nIiox
	xFsP8q7Z/DqHBQbOcqGRZ4pPvIXGvcQ7d+JUwYcnsLGvZb0pF/kuzNzRPSOrjiUY
	RT1B5TE4rG1xMtanKiBPvyT7ess0368bsordC3+oX1NxlM+lSlnnvO46AZkfRJoO
	oo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E71C1D27F;
	Thu, 16 Nov 2023 14:30:32 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 36BF01D26A;
	Thu, 16 Nov 2023 14:30:26 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
Subject: [PATCH v3 1/2] perl: bump the required Perl version to 5.8.1 from 5.8.0
Date: Thu, 16 Nov 2023 14:30:10 -0500
Message-ID: <20231116193014.470420-2-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc2
In-Reply-To: <20231116193014.470420-1-tmz@pobox.com>
References: <20231116193014.470420-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 98CAE022-84B6-11EE-BC68-F515D2CDFF5E-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The following commit will make use of a Getopt::Long feature which is
only present in Perl >=3D 5.8.1.  Document that as the minimum version we
support.

Many of our Perl scripts will continue to run with 5.8.0 but this change
allows us to adjust them as needed without breaking any promises to our
users.

The Perl requirement was last changed in d48b284183 (perl: bump the
required Perl version to 5.8 from 5.6.[21], 2010-09-24).  At that time,
5.8.0 was 8 years old.  It is now over 21 years old.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I debated changing all the 'use 5.008;' lines here, as most don't
actually require a newer Perl, but the previous bump did the same.

I can see the merit in either direction.

Changing it allows future contributors to be confident in relying on
5.8.1 features.

Not changing it allows anyone stuck on 5.8.0 to continue using the perl
scripts which don't actually require 5.8.1.

Tangentially, the Perl docs for 'use' function recommend against the
5.008001 form[1]:

    Specifying VERSION as a numeric argument of the form 5.024001 should
    generally be avoided as older less readable syntax compared to
    v5.24.1. Before perl 5.8.0 released in 2002 the more verbose numeric
    form was the only supported syntax, which is why you might see it in
    older code.

        use v5.24.1;    # compile time version check
        use 5.24.1;     # ditto
        use 5.024_001;  # ditto; older syntax compatible with perl 5.6

I'm not enough of a Perl coder to have a strong preference or desire to
push for such a change, but I thought it was worth mentioning in case
others wonder why we're using the 5.008001 form.

[1] https://perldoc.perl.org/functions/use#use-VERSION

 Documentation/CodingGuidelines          | 2 +-
 INSTALL                                 | 2 +-
 contrib/diff-highlight/DiffHighlight.pm | 2 +-
 contrib/mw-to-git/Git/Mediawiki.pm      | 2 +-
 git-archimport.perl                     | 2 +-
 git-cvsexportcommit.perl                | 2 +-
 git-cvsimport.perl                      | 2 +-
 git-cvsserver.perl                      | 2 +-
 git-send-email.perl                     | 4 ++--
 git-svn.perl                            | 2 +-
 gitweb/INSTALL                          | 2 +-
 gitweb/gitweb.perl                      | 2 +-
 perl/Git.pm                             | 2 +-
 perl/Git/I18N.pm                        | 2 +-
 perl/Git/LoadCPAN.pm                    | 2 +-
 perl/Git/LoadCPAN/Error.pm              | 2 +-
 perl/Git/LoadCPAN/Mail/Address.pm       | 2 +-
 perl/Git/Packet.pm                      | 2 +-
 t/t0202/test.pl                         | 2 +-
 t/t5562/invoke-with-content-length.pl   | 2 +-
 t/t9700/test.pl                         | 2 +-
 t/test-terminal.perl                    | 2 +-
 22 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index 8d3a467c01..39b9b7260f 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -490,7 +490,7 @@ For Perl programs:
=20
  - Most of the C guidelines above apply.
=20
- - We try to support Perl 5.8 and later ("use Perl 5.008").
+ - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
=20
  - use strict and use warnings are strongly preferred.
=20
diff --git a/INSTALL b/INSTALL
index 4b42288882..06f29a8ae7 100644
--- a/INSTALL
+++ b/INSTALL
@@ -119,7 +119,7 @@ Issues of note:
 	- A POSIX-compliant shell is required to run some scripts needed
 	  for everyday use (e.g. "bisect", "request-pull").
=20
-	- "Perl" version 5.8 or later is needed to use some of the
+	- "Perl" version 5.8.1 or later is needed to use some of the
 	  features (e.g. sending patches using "git send-email",
 	  interacting with svn repositories with "git svn").  If you can
 	  live without these, use NO_PERL.  Note that recent releases of
diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highl=
ight/DiffHighlight.pm
index 376f577737..636add6968 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -1,6 +1,6 @@
 package DiffHighlight;
=20
-use 5.008;
+use 5.008001;
 use warnings FATAL =3D> 'all';
 use strict;
=20
diff --git a/contrib/mw-to-git/Git/Mediawiki.pm b/contrib/mw-to-git/Git/M=
ediawiki.pm
index 917d9e2d32..ff7811225e 100644
--- a/contrib/mw-to-git/Git/Mediawiki.pm
+++ b/contrib/mw-to-git/Git/Mediawiki.pm
@@ -1,6 +1,6 @@
 package Git::Mediawiki;
=20
-use 5.008;
+use 5.008001;
 use strict;
 use POSIX;
 use Git;
diff --git a/git-archimport.perl b/git-archimport.perl
index b7c173c345..f5a317b899 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -54,7 +54,7 @@ =3Dhead1 Devel Notes
=20
 =3Dcut
=20
-use 5.008;
+use 5.008001;
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 289d4bc684..1e03ba94d1 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
=20
-use 5.008;
+use 5.008001;
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 7bf3c12d67..07ea3443f7 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -13,7 +13,7 @@
 # The head revision is on branch "origin" by default.
 # You can change that with the '-o' option.
=20
-use 5.008;
+use 5.008001;
 use strict;
 use warnings;
 use Getopt::Long;
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7b757360e2..124f598bdc 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -15,7 +15,7 @@
 ####
 ####
=20
-use 5.008;
+use 5.008001;
 use strict;
 use warnings;
 use bytes;
diff --git a/git-send-email.perl b/git-send-email.perl
index cacdbd6bb2..d75a4a33dd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -16,7 +16,7 @@
 #    and second line is the subject of the message.
 #
=20
-use 5.008;
+use 5.008001;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Getopt::Long;
@@ -228,7 +228,7 @@ sub system_or_msg {
 	my @sprintf_args =3D ($cmd_name ? $cmd_name : $args->[0], $exit_code);
 	if (defined $msg) {
 		# Quiet the 'redundant' warning category, except we
-		# need to support down to Perl 5.8, so we can't do a
+		# need to support down to Perl 5.8.1, so we can't do a
 		# "no warnings 'redundant'", since that category was
 		# introduced in perl 5.22, and asking for it will die
 		# on older perls.
diff --git a/git-svn.perl b/git-svn.perl
index 4e8878f035..b0d0a50984 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
-use 5.008;
+use 5.008001;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use strict;
 use vars qw/	$AUTHOR $VERSION
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index a58e6b3c44..dadc6efa81 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -29,7 +29,7 @@ Requirements
 ------------
=20
  - Core git tools
- - Perl 5.8
+ - Perl 5.8.1
  - Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename.
  - web server
=20
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9ba..55e7c6567e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7,7 +7,7 @@
 #
 # This program is licensed under the GPLv2
=20
-use 5.008;
+use 5.008001;
 use strict;
 use warnings;
 # handle ACL in file access tests
diff --git a/perl/Git.pm b/perl/Git.pm
index 117765dc73..03bf570bf4 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -7,7 +7,7 @@ =3Dhead1 NAME
=20
 package Git;
=20
-use 5.008;
+use 5.008001;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
=20
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 895e759c57..5454c3a6d2 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -1,5 +1,5 @@
 package Git::I18N;
-use 5.008;
+use 5.008001;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 BEGIN {
diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
index 0c360bc799..8c7fa805f9 100644
--- a/perl/Git/LoadCPAN.pm
+++ b/perl/Git/LoadCPAN.pm
@@ -1,5 +1,5 @@
 package Git::LoadCPAN;
-use 5.008;
+use 5.008001;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
=20
diff --git a/perl/Git/LoadCPAN/Error.pm b/perl/Git/LoadCPAN/Error.pm
index 5d84c20288..5cecb0fcd6 100644
--- a/perl/Git/LoadCPAN/Error.pm
+++ b/perl/Git/LoadCPAN/Error.pm
@@ -1,5 +1,5 @@
 package Git::LoadCPAN::Error;
-use 5.008;
+use 5.008001;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Git::LoadCPAN (
diff --git a/perl/Git/LoadCPAN/Mail/Address.pm b/perl/Git/LoadCPAN/Mail/A=
ddress.pm
index 340e88a7a5..9f808090a6 100644
--- a/perl/Git/LoadCPAN/Mail/Address.pm
+++ b/perl/Git/LoadCPAN/Mail/Address.pm
@@ -1,5 +1,5 @@
 package Git::LoadCPAN::Mail::Address;
-use 5.008;
+use 5.008001;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Git::LoadCPAN (
diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index d144f5168f..d896e69523 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -1,5 +1,5 @@
 package Git::Packet;
-use 5.008;
+use 5.008001;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 BEGIN {
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 2cbf7b9590..47d96a2a13 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -1,5 +1,5 @@
 #!/usr/bin/perl
-use 5.008;
+use 5.008001;
 use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-=
content-length.pl
index 718dd9b49d..9babb9a375 100644
--- a/t/t5562/invoke-with-content-length.pl
+++ b/t/t5562/invoke-with-content-length.pl
@@ -1,4 +1,4 @@
-use 5.008;
+use 5.008001;
 use strict;
 use warnings;
=20
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 6d753708d2..d8e85482ab 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
=20
-use 5.008;
+use 5.008001;
 use warnings;
 use strict;
=20
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 1bcf01a9a4..3810e9bb43 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -1,5 +1,5 @@
 #!/usr/bin/perl
-use 5.008;
+use 5.008001;
 use strict;
 use warnings;
 use IO::Pty;
--=20
2.43.0.rc2

