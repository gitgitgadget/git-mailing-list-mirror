From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/WIP] git-svn: tweak log format to match "svn log" output
Date: Sat, 24 Jul 2010 21:31:14 -0500
Message-ID: <20100725023114.GB18606@burratino>
References: <20100423134611.GA3440@merkur.sol.de>
 <20100426132710.GA9930@progeny.tock>
 <20100427112656.GB16323@merkur.sol.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Jens Seidel <jensseidel@users.sf.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 04:32:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocr0z-0006Xt-6Z
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 04:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041Ab0GYCcT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 22:32:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53205 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0GYCcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 22:32:18 -0400
Received: by gyg10 with SMTP id 10so554213gyg.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 19:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vEK7FeVAh7TZtxDarg1H19LW2vIOejpIqNYYkVBegkA=;
        b=GwoauChtOLoXFGbddD/YCdrjy+OMUn5cNI9XsaY23Hu4pQF6csLJzHYc3t/mwj1+ly
         I6iFuD1VtTOMWcR+OhTI/y8Lz9tde9oY2qXSlLLMWGRfg6MnYcNJv1JmPOmf31ZljsdE
         73r/FFw1TIFkXYNddfplP4a6xmkXKJu9T7ixQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=II6S0iMCgNDfKOxJIAEYFfqqPIR+XxLZQqhB1I6AyTMb2tNCiQwRg88r9WcLfb33zw
         6hJKXT6nDCj0TJlOYIGuw69Xia56jS9ICy1/V29ZLuc3VA4zTMc2I1rzPYYWHKKx43Uy
         2Igos9+tPeoHh2Do5EP2+K3fssiYdBo6YYWOI=
Received: by 10.100.12.14 with SMTP id 14mr5860289anl.244.1280025137847;
        Sat, 24 Jul 2010 19:32:17 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r7sm3460430anb.15.2010.07.24.19.32.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 19:32:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100427112656.GB16323@merkur.sol.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151703>

=46rom: Jens Seidel <jensseidel@users.sf.net>

Tweak "git svn log" output to more closely match what svn produces.
In particular, if Locale::gettext is available, use that to produce
localized output using svn=E2=80=99s translations.

So now instead of=20

 git:
 r2105 | viktor | 2010-03-19 13:40:54 +0100 (Fr, 19 M=C3=A4r 2010) | 2 =
lines
=20
 svn:
 r2105 | viktor | 2010-03-19 13:40:54 +0100 (Fr, 19. M=C3=A4r 2010) | 1=
 Zeile

we get the much closer

 git:
 r2105 | viktor | 2010-03-19 13:40:54 +0100 (Fr, 19. M=C3=A4r 2010) | 2=
 Zeilen
=20
 svn:
 r2105 | viktor | 2010-03-19 13:40:54 +0100 (Fr, 19. M=C3=A4r 2010) | 1=
 Zeile

and a script for munging to compare logs would only have to fuzz
out the extra blank lines in git svn=E2=80=99s commit log.

[jn: made Locale::gettext dependency optional; added a test script]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jens Seidel wrote at http://bugs.debian.org/578915:
>> Jens Seidel wrote:

> Ah, git svn ignores any locale, this explains the problem.
>
>>> The dot stands for an ordinal number (e.g. "19." =3D=3D "19th").
>>> Second: "line(s)" is not translated. I can workaround by starting g=
it/svn in an
>>> English locale ...
>
> I tried to fix both.
>
>>> Third: the git log often contains an addional empty line.
>
> This remains open. Probably that can be solved by setting a git confi=
g
> option and resyncing all git svn history from git.

Sorry to leave this hanging for so long.  I think it is an improvement
as is, but I have not tested in the following scenarios:

 - Locale::gettext not available
 - subversion not translated
 - subversion translated but not to the current language

And the extra blank line at the end of log messages remains unsolved.

Thoughts?

diff --git i/git-svn.perl w/git-svn.perl
index c416358..55dc50d 100755
--- i/git-svn.perl
+++ w/git-svn.perl
@@ -45,6 +45,7 @@ sub _req_svn {
 	}
 }
 my $can_compress =3D eval { require Compress::Zlib; 1};
+my $can_localize =3D eval { require Locale::gettext; 1};
 push @Git::SVN::Ra::ISA, 'SVN::Ra';
 push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
 push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
@@ -5535,7 +5536,14 @@ sub format_svn_date {
 	my $gm =3D timelocal(gmtime($t));
 	my $sign =3D qw( + + - )[ $t <=3D> $gm ];
 	my $gmoff =3D sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,=
1]);
-	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime(=
$t));
+	my $format;
+	if ($can_localize) {
+		my $d =3D Locale::gettext->domain("subversion");
+		$format =3D "%Y-%m-%d %H:%M:%S $gmoff" . $d->get(" (%a, %d %b %Y)");
+	} else {
+		$format =3D "%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)";
+	}
+	return strftime($format, localtime($t));
 }
=20
 sub parse_git_date {
@@ -5631,9 +5639,16 @@ sub show_commit_normal {
 	my ($c) =3D @_;
 	print commit_log_separator, "r$c->{r} | ";
 	print "$c->{c} | " if $show_commit;
-	print "$c->{a} | ", format_svn_date($c->{t_utc}), ' | ';
+	print "$c->{a} | ", format_svn_date($c->{t_utc});
 	my $nr_line =3D 0;
+	my $sing_fmt =3D " | %d line";
+	my $plur_fmt =3D " | %d lines";
=20
+	if ($can_localize) {
+		my $d =3D Locale::gettext->domain("subversion");
+		$sing_fmt =3D $d->nget(" | %d line", " | %d lines", 1);
+		$plur_fmt =3D $d->nget(" | %d line", " | %d lines", 10);
+	}
 	if (my $l =3D $c->{l}) {
 		while ($l->[$#$l] eq "\n" && $#$l > 0
 		                          && $l->[($#$l - 1)] eq "\n") {
@@ -5641,20 +5656,23 @@ sub show_commit_normal {
 		}
 		$nr_line =3D scalar @$l;
 		if (!$nr_line) {
-			print "1 line\n\n\n";
+			print sprintf($sing_fmt, 1), "\n\n\n";
 		} else {
 			if ($nr_line =3D=3D 1) {
-				$nr_line =3D '1 line';
+				print sprintf($sing_fmt, $nr_line), "\n";
 			} else {
-				$nr_line .=3D ' lines';
+				print sprintf($plur_fmt, $nr_line), "\n";
 			}
-			print $nr_line, "\n";
 			show_commit_changed_paths($c);
 			print "\n";
 			print $_ foreach @$l;
 		}
 	} else {
-		print "1 line\n";
+		if ($nr_line =3D=3D 1) {
+			print sprintf($sing_fmt, $nr_line), "\n";
+		} else {
+			print sprintf($plur_fmt, $nr_line), "\n";
+		}
 		show_commit_changed_paths($c);
 		print "\n";
=20
diff --git i/t/t9116-git-svn-log.sh w/t/t9116-git-svn-log.sh
index 0374a74..586f64b 100755
--- i/t/t9116-git-svn-log.sh
+++ w/t/t9116-git-svn-log.sh
@@ -16,6 +16,7 @@ test_expect_success 'setup repository and import' '
 		done && \
 		svn_cmd import -m test . "$svnrepo"
 		cd .. &&
+	svn_cmd checkout "$svnrepo"/branches/a checkout &&
 	git svn init "$svnrepo" -T trunk -b branches -t tags &&
 	git svn fetch &&
 	git reset --hard trunk &&
@@ -36,7 +37,38 @@ test_expect_success 'setup repository and import' '
 	git commit -a -m spy &&
 	echo try >> README &&
 	git commit -a -m try &&
-	git svn dcommit
+	git svn dcommit &&
+	(
+		cd checkout &&
+		svn_cmd update
+	) &&
+
+	if test -n "$ORIGINAL_LANG" && test "$ORIGINAL_LANG" !=3D C
+	then
+		test_set_prereq NONCLOCALE
+	fi
+	'
+
+test_expect_failure 'log matches svn log' '
+	git reset --hard a &&
+	(
+		cd checkout &&
+		svn_cmd log >../expected
+	) &&
+	git svn log >actual &&
+	test_cmp expected actual
+	'
+
+test_expect_failure NONCLOCALE 'log matches svn log, original locale' =
'
+	(
+		LC_ALL=3D$ORIGINAL_LANG &&
+		(
+			cd checkout &&
+			svn_cmd log >../expected
+		) &&
+		git svn log >actual
+	) &&
+	test_cmp expected actual
 	'
=20
 test_expect_success 'run log' "
diff --git i/t/test-lib.sh w/t/test-lib.sh
index e5523dd..62aa48c 100644
--- i/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -34,6 +34,9 @@ esac
 # Keep the original TERM for say_color
 ORIGINAL_TERM=3D$TERM
=20
+# Keep the original locale for tests
+ORIGINAL_LANG=3D$LANG
+
 # For repeatability, reset the environment to known value.
 LANG=3DC
 LC_ALL=3DC
--=20
