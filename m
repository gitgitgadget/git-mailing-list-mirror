From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v4 3/7] gettext: Add a Gettext interface for Perl
Date: Wed,  2 Jun 2010 01:06:00 +0000
Message-ID: <1275440764-26153-4-git-send-email-avarab@gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 03:06:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJcPp-0004k8-E8
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486Ab0FBBGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 21:06:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443Ab0FBBGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 21:06:19 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so1482447fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yydR7nUAfrqbPbiH/hVlpBmxIw1kjUnKoj/aC3GtJmk=;
        b=Wkf8+W4UeiEkWLaEGPHT5tSXX3wMD532QkTNJqjpdW4W6u1TY+ejDiqS3QAzVEc9wz
         y9ljkZlWIXX90Ibb7scoDm29oq2IUGwKaZQeCtNY2pJQHjV7P1Tjt0S7oBEhNp/C8fIJ
         mpcE/WzGaF+4VAUnOG4oJEHuOqd9068uI5EK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Q6KW9q/6yR+BZ6FbgG0M1bgHqegLVoa2m/3y+77BYQAa61c4X8A1voQpTLARx7fDQN
         I3+56gQeO3y6tZE8wE2GyVRYbuG7UPaNku2pvGondIJJdFk3kT70OCix1bTSSVd854pB
         Xoi9g93X88s+HDoDt+8YuGD2KUS+UwFlRIvoE=
Received: by 10.223.25.208 with SMTP id a16mr7858902fac.79.1275440778144;
        Tue, 01 Jun 2010 18:06:18 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm49688716fad.7.2010.06.01.18.06.16
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 18:06:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.gec7f5.dirty
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148184>

Make Git's gettext messages available to Perl programs through
Locale::Messages. Gracefully fall back to English on systems that
don't contain the module.

This contains some makefile hacks to pass localedir to
perl/Makefile. Which in turn passes it to perl.mak, which'll use it to
search/replace occurances of ++LOCALEDIR++ in .pm files.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile            |    6 +++-
 git-send-email.perl |    3 +-
 perl/Git/I18N.pm    |   73 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 perl/Makefile       |    3 +-
 perl/Makefile.PL    |   14 +++++++++-
 5 files changed, 94 insertions(+), 5 deletions(-)
 create mode 100644 perl/Git/I18N.pm

diff --git a/Makefile b/Makefile
index dce2faa..3f0e305 100644
--- a/Makefile
+++ b/Makefile
@@ -1505,7 +1505,7 @@ ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
 endif
 ifndef NO_PERL
-	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH=3D'$(PERL_PATH_SQ)' p=
refix=3D'$(prefix_SQ)' all
+	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH=3D'$(PERL_PATH_SQ)' p=
refix=3D'$(prefix_SQ)' localedir=3D'$(localedir_SQ)' all
 endif
 ifndef NO_PYTHON
 	$(QUIET_SUBDIR0)git_remote_helpers $(QUIET_SUBDIR1) PYTHON_PATH=3D'$(=
PYTHON_PATH_SQ)' prefix=3D'$(prefix_SQ)' all
@@ -1884,7 +1884,9 @@ cscope:
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
 pot:
-	$(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=3Dc) $(SCRIPT_SH)
+	$(XGETTEXT) --keyword=3D_ --output=3Dpo/git.pot --language=3DC $(C_OB=
J:o=3Dc)
+	$(XGETTEXT) --join-existing --output=3Dpo/git.pot --language=3DShell =
$(SCRIPT_SH)
+	$(XGETTEXT) --join-existing --output=3Dpo/git.pot --language=3DPerl $=
(SCRIPT_PERL)
=20
 POFILES :=3D $(wildcard po/*.po)
 MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(PO=
=46ILES))
diff --git a/git-send-email.perl b/git-send-email.perl
index 111c981..b9288af 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,6 +26,7 @@ use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use Error qw(:try);
 use Git;
+use Git::I18N;
=20
 Getopt::Long::Configure qw/ pass_through /;
=20
@@ -674,7 +675,7 @@ if (!defined $sender) {
 	$sender =3D $repoauthor || $repocommitter || '';
 	$sender =3D ask("Who should the emails appear to be from? [$sender] "=
,
 	              default =3D> $sender);
-	print "Emails will be sent from: ", $sender, "\n";
+	printf gettext("Emails will be sent from: %s\n"), $sender;
 	$prompting++;
 }
=20
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
new file mode 100644
index 0000000..e19d99b
--- /dev/null
+++ b/perl/Git/I18N.pm
@@ -0,0 +1,73 @@
+package Git::I18N;
+use strict;
+use warnings;
+use Exporter;
+use base 'Exporter';
+
+our $VERSION =3D '0.01';
+
+our @EXPORT =3D qw(gettext);
+our @EXPORT_OK =3D @EXPORT;
+
+sub __bootstrap_locale_messages {
+	our $TEXTDOMAIN =3D 'git';
+	our $TEXTDOMAINDIR =3D $ENV{GIT_TEXTDOMAINDIR} || '++LOCALEDIR++';
+
+	require POSIX;
+	POSIX->import(qw(setlocale));
+	# Non-core prerequisite module
+	require Locale::Messages;
+	Locale::Messages->import(qw(:locale_h :libintl_h));
+
+	setlocale(LC_MESSAGES(), '');
+	setlocale(LC_CTYPE(), '');
+	textdomain($TEXTDOMAIN);
+	bindtextdomain($TEXTDOMAIN =3D> $TEXTDOMAINDIR);
+
+	return;
+}
+
+BEGIN
+{
+	local ($@, $!);
+	eval { __bootstrap_locale_messages() };
+	if ($@) {
+		# Oh noes, no Locale::Messages here
+		*gettext =3D sub ($) { $_[0] };
+	}
+}
+
+1;
+
+__END__
+
+=3Dhead1 NAME
+
+Git::I18N - Perl interface to Git's Gettext localizations
+
+=3Dhead1 SYNOPSIS
+
+	use Git::I18N;
+
+	print gettext("Welcome to Git!\n");
+
+	printf gettext("The following error occured: %s\n"), $error;
+
+=3Dhead1 DESCRIPTION
+
+Git's internal interface to Gettext via L<Locale::Messages>. If
+L<Locale::Messages> can't be loaded (it's not a core module) we
+provide stub passthrough fallbacks.
+
+=3Dhead1 FUNCTIONS
+
+=3Dhead2 gettext($)
+
+L<Locale::Messages>'s gettext function if all goes well, otherwise our
+passthrough fallback function.
+
+=3Dhead1 AUTHOR
+
+E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail.com>
+
+=3Dcut
diff --git a/perl/Makefile b/perl/Makefile
index 4ab21d6..4e624ff 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -5,6 +5,7 @@ makfile:=3Dperl.mak
=20
 PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
 prefix_SQ =3D $(subst ','\'',$(prefix))
+localedir_SQ =3D $(subst ','\'',$(localedir))
=20
 ifndef V
 	QUIET =3D @
@@ -38,7 +39,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
-	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)'
+	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)' --localedir=3D'$(localedir_SQ=
)'
 endif
=20
 # this is just added comfort for calling make directly in perl dir
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 0b9deca..456d45b 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -1,4 +1,12 @@
+use strict;
+use warnings;
 use ExtUtils::MakeMaker;
+use Getopt::Long;
+
+# Sanity: die at first unknown option
+Getopt::Long::Configure qw/ pass_through /;
+
+GetOptions("localedir=3Ds" =3D> \my $localedir);
=20
 sub MY::postamble {
 	return <<'MAKE_FRAG';
@@ -16,7 +24,10 @@ endif
 MAKE_FRAG
 }
=20
-my %pm =3D ('Git.pm' =3D> '$(INST_LIBDIR)/Git.pm');
+my %pm =3D (
+	'Git.pm' =3D> '$(INST_LIBDIR)/Git.pm',
+	'Git/I18N.pm' =3D> '$(INST_LIBDIR)/Git/I18N.pm',
+);
=20
 # We come with our own bundled Error.pm. It's not in the set of defaul=
t
 # Perl modules so install it if it's not available on the system yet.
@@ -33,6 +44,7 @@ WriteMakefile(
 	NAME            =3D> 'Git',
 	VERSION_FROM    =3D> 'Git.pm',
 	PM		=3D> \%pm,
+	PM_FILTER	=3D> qq[\$(PERL) -pe "s<\\Q++LOCALEDIR++\\E><$localedir>"],
 	MAKEFILE	=3D> 'perl.mak',
 	INSTALLSITEMAN3DIR =3D> '$(SITEPREFIX)/share/man/man3'
 );
--=20
1.7.1.251.gec7f5.dirty
