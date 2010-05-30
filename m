From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2 5/6] gettext: Add a Gettext interface for Perl
Date: Sun, 30 May 2010 20:54:16 +0000
Message-ID: <1275252857-21593-6-git-send-email-avarab@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 22:55:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIpXQ-0007nM-1a
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 22:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab0E3Uyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 16:54:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36908 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab0E3Uyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 16:54:51 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1964086fxm.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yAUY8pDoEQ/AsUcwAJ/gNPOyy819IQZZ2U4YiuRJNIE=;
        b=Cdi4sCHKCkcpVL0KpHwlcxnimxMkLGmhY7oG5csvgBGrJWpFKlLX/49OGVjEg12+sd
         VpR4fSYvaJcLNJP4yOMq8+MKOK+yJ28SFoJUqj64SPo6tkt4+1uvaFM//mFfFtrnLxg4
         cvoIzYRCbd/B8w3QjOgZStlr6p4/J3reuirzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Tni5/8e6hXmmlEznbFaHTi9LGjnRg5Y4psH09vX3qBWQlsGQqb+O4k9owtdOFH+r3C
         kkJ/Rikzcs63K2qceIH2Ad9wIM6F5YrFzr/tOni2DIDAmKYZGUT1go14oUcoIph5CFfh
         LForDfni96rAkJaNCLIOz8dcJ5awimCfaIM9I=
Received: by 10.223.98.24 with SMTP id o24mr4332853fan.29.1275252890977;
        Sun, 30 May 2010 13:54:50 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id r12sm33459492fah.8.2010.05.30.13.54.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 13:54:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.gde05d
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148019>

Make Git's gettext messages available to Perl programs through
Locale::Messages. Gracefully fall back to English on systems that
don't contain the module.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile            |    4 ++-
 git-send-email.perl |    3 +-
 perl/Git/Gettext.pm |   83 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 perl/Makefile.PL    |    5 ++-
 4 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 perl/Git/Gettext.pm

diff --git a/Makefile b/Makefile
index dce2faa..2101713 100644
--- a/Makefile
+++ b/Makefile
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
index 111c981..a36718e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,6 +26,7 @@ use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use Error qw(:try);
 use Git;
+use Git::Gettext qw< :all >;
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
diff --git a/perl/Git/Gettext.pm b/perl/Git/Gettext.pm
new file mode 100644
index 0000000..f434783
--- /dev/null
+++ b/perl/Git/Gettext.pm
@@ -0,0 +1,83 @@
+package Git::Gettext;
+use strict;
+use warnings;
+use Exporter;
+use base 'Exporter';
+
+our $VERSION =3D '0.01';
+
+our @EXPORT;
+our @EXPORT_OK =3D qw< gettext >;
+our %EXPORT_TAGS;
+@{ $EXPORT_TAGS{'all'} } =3D @EXPORT_OK;
+
+sub __bootstrap_locale_messages {
+	our $TEXTDOMAIN =3D 'git';
+
+	# TODO: How do I make the sed replacements in the top level
+	# Makefile reach me here?
+	#our $TEXTDOMAINDIR =3D q|@@LOCALEDIR@@|;
+	our $TEXTDOMAINDIR =3D q</usr/local/share/locale>;
+
+	require POSIX;
+	POSIX->import(qw< setlocale >);
+	# Non-core prerequisite module
+	require Locale::Messages;
+	Locale::Messages->import(qw< :locale_h :libintl_h >);
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
+Git::Gettext - Perl interface to Git's Gettext localizations
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
+=3Dhead1 EXPORTS
+
+Exports are done via L<Exporter>. Invididual functions can be
+exporter, or all of them via the C<:all> export tag.
+
+=3Dhead1 AUTHOR
+
+E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail.com>
+
+=3Dhead1 LICENSE AND COPYRIGHT
+
+Copyright 2010 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail=
=2Ecom>
+
+This program is free software, you can redistribute it and/or modify
+it under the same terms as Perl itself.
+
+=3Dcut
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 0b9deca..702ec7c 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -16,7 +16,10 @@ endif
 MAKE_FRAG
 }
=20
-my %pm =3D ('Git.pm' =3D> '$(INST_LIBDIR)/Git.pm');
+my %pm =3D (
+	'Git.pm' =3D> '$(INST_LIBDIR)/Git.pm',
+	'Git/Gettext.pm' =3D> '$(INST_LIBDIR)/Git/Gettext.pm',
+);
=20
 # We come with our own bundled Error.pm. It's not in the set of defaul=
t
 # Perl modules so install it if it's not available on the system yet.
--=20
1.7.1.248.gcd6d1
