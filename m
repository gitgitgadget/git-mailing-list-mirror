From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for
 prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Tue, 03 Jan 2012 14:51:45 -0800
Message-ID: <7vboqks8la.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de>
 <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 23:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiDDH-0005Fk-Fq
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 23:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab2ACWv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 17:51:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756219Ab2ACWvs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 17:51:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B99E75DCA;
	Tue,  3 Jan 2012 17:51:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/ANYNQWWtRB8
	qY49SIo77uZ+ggs=; b=d3TCzu19zpPiOb2vMF+fEA594DcIXU7ZbzOq/o587DeA
	oX8hJOdZEIyfMev/JCdN0WQdO/3MOO2gMUA7hfozrj41hjG4AuJa5KSSbPi9HVCD
	tkReykuIzT9bKgi8WSKnmlPpEE1XPmIlOOkkC8W8H6pNd37Iys+vkdNyoGotJLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RgYVq2
	oFBsYaGE5hxjQ0vT7Y+vn0uYYUt/VoSK8H8OmzLP1HhLmRlGBWVA8r7C4t3vDGtS
	yvAp28p7VOg7erM4zGB0Lp7DwjnnBQ89a50U2Shsh5JcIQGyK2eincl5Erb2trfl
	VycHvmKX7Fr6+E8748eGMir7cqtrYJUSNXae4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B06435DC9;
	Tue,  3 Jan 2012 17:51:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B31DB5DC3; Tue,  3 Jan 2012
 17:51:46 -0500 (EST)
In-Reply-To: <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 3 Jan
 2012 11:17:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83B65AC2-365D-11E1-A42A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187902>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Dec 28, 2011 at 01:11, Sven Strickroth
> <sven.strickroth@tu-clausthal.de> wrote:
>
> Nom nom, some Perl. Thanks for tackling this. Reviewing it as
> requested by Junio.
>

As I'd like to have this in 1.7.9-rc-something, here is my attempt to
rewrite the patch based on your comments, modulo the "chomp()" bit, to
expedite the cycle. Major fixes are:

 * make "prompt" just a helper subroutine. It does not have to be tied =
to
   any particular repository object anyway.

 * Move the "ah, the environment is there but the value is not set to
   anything sensible" logic from the caller "prompt" to the helper
   "_prompt". For now, forget about an executable whose name is "0" for
   simplicity.

 * Do so using Perl-ish idiom "return unless ($foo)" to avoid potential
   issues with callers who might call it in the list context (I do not
   think it is reasonable to call "prompt" in the list context to begin
   with, though. It is not like the function is to return a list of zer=
o
   or more answers, in which case "@answers =3D function()" makes
   sense. This is "ask to get a single answer" interface).

 * "open ... or return", not "||".

Sven, does it look agreeable? And more importantly, does it still work?=
 ;-)

Thanks.

 git-svn.perl |   20 +-------------------
 perl/Git.pm  |   51 ++++++++++++++++++++++++++++++++++++++++++++++++++=
-
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e30df22..6a01176 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4415,25 +4415,7 @@ sub username {
=20
 sub _read_password {
 	my ($prompt, $realm) =3D @_;
-	my $password =3D '';
-	if (exists $ENV{GIT_ASKPASS}) {
-		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
-		$password =3D <PH>;
-		$password =3D~ s/[\012\015]//; # \n\r
-		close(PH);
-	} else {
-		print STDERR $prompt;
-		STDERR->flush;
-		require Term::ReadKey;
-		Term::ReadKey::ReadMode('noecho');
-		while (defined(my $key =3D Term::ReadKey::ReadKey(0))) {
-			last if $key =3D~ /[\012\015]/; # \n\r
-			$password .=3D $key;
-		}
-		Term::ReadKey::ReadMode('restore');
-		print STDERR "\n";
-		STDERR->flush;
-	}
+	my $password =3D Git::prompt($prompt);
 	$password;
 }
=20
diff --git a/perl/Git.pm b/perl/Git.pm
index f7ce511..abf9de9 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -58,7 +58,7 @@ require Exporter;
                 command_output_pipe command_input_pipe command_close_p=
ipe
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
-                remote_refs
+                remote_refs prompt
                 temp_acquire temp_release temp_reset temp_path);
=20
=20
@@ -512,6 +512,55 @@ C<git --html-path>). Useful mostly only internally=
=2E
 sub html_path { command_oneline('--html-path') }
=20
=20
+=3Ditem prompt ( PROMPT )
+
+Query user C<PROMPT> and return answer from user.
+
+If an external helper is specified via GIT_ASKPASS or SSH_ASKPASS, it
+is used to interact with the user; otherwise the prompt is given to
+and the answer is read from the terminal.
+
+=3Dcut
+
+sub prompt {
+	my ($prompt) =3D @_;
+	my $ret;
+	if (!defined $ret) {
+		$ret =3D _prompt($ENV{'GIT_ASKPASS'}, $prompt);
+	}
+	if (!defined $ret) {
+		$ret =3D _prompt($ENV{'SSH_ASKPASS'}, $prompt);
+	}
+	if (!defined $ret) {
+		$ret =3D '';
+		print STDERR $prompt;
+		STDERR->flush;
+		require Term::ReadKey;
+		Term::ReadKey::ReadMode('noecho');
+		while (defined(my $key =3D Term::ReadKey::ReadKey(0))) {
+			last if $key =3D~ /[\012\015]/; # \n\r
+			$ret .=3D $key;
+		}
+		Term::ReadKey::ReadMode('restore');
+		print STDERR "\n";
+		STDERR->flush;
+	}
+	return $ret;
+}
+
+sub _prompt {
+	my ($askpass, $prompt) =3D @_;
+	return unless ($askpass);
+
+	open my $fh, "-|", $askpass, $prompt
+		or return;
+	my $ret =3D <$fh>;
+	$ret =3D~ s/[\012\015]//g; # \n\r
+	close ($fh);
+	return $ret;
+}
+
+
 =3Ditem repo_path ()
=20
 Return path to the git repository. Must be called on a repository inst=
ance.
