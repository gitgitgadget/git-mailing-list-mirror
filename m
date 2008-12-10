From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] gitweb: A bit of code cleanup in git_blame()
Date: Wed, 10 Dec 2008 00:35:37 -0800
Message-ID: <7voczk1l7q.fsf@gitster.siamese.dyndns.org>
References: <20081209223703.28106.29198.stgit@localhost.localdomain>
 <20081209224814.28106.83387.stgit@localhost.localdomain>
 <ghn8jv$hg9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 09:37:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAKZ5-0002ug-80
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 09:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbYLJIfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2008 03:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbYLJIfq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 03:35:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbYLJIfp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 03:35:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 42CF41888A;
	Wed, 10 Dec 2008 03:35:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 746DB18889; Wed,
 10 Dec 2008 03:35:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 890B0F76-C695-11DD-A0AD-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102674>

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>
> I'm sorry, there should be
>
>   +       my $ftype =3D "blob";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!defined $hash) =
{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0$hash =3D git_get_hash_by_path($hash_base, $=
file_name, "blob")
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0or die_error(404, "Error looking up file");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0$ftype =3D git_get_type($hash);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if ($ftype !~ "blob") {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0di=
e_error(400, "Object is not a blob");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}

I will squash in the following and queue [1/3] and [3/3] to 'pu', as th=
ere
seem to be a few comments on [2/3] that look worth addressing.

 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git c/gitweb/gitweb.perl w/gitweb/gitweb.perl
index d491a1d..ccbf5d4 100755
--- c/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -4585,11 +4585,12 @@ sub git_blame {
 	die_error(404, "Couldn't find base commit") unless $hash_base;
 	my %co =3D parse_commit($hash_base)
 		or die_error(404, "Commit not found");
+	my $ftype =3D "blob";
 	if (!defined $hash) {
 		$hash =3D git_get_hash_by_path($hash_base, $file_name, "blob")
 			or die_error(404, "Error looking up file");
 	} else {
-		my $ftype =3D git_get_type($hash);
+		$ftype =3D git_get_type($hash);
 		if ($ftype !~ "blob") {
 			die_error(400, "Object is not a blob");
 		}
@@ -4637,7 +4638,8 @@ HTML
 			$metainfo{$full_rev} =3D {};
 		}
 		my $meta =3D $metainfo{$full_rev};
-		while (my $data =3D <$fd>) {
+		my $data;
+		while ($data =3D <$fd>) {
 			chomp $data;
 			last if ($data =3D~ s/^\t//); # contents of line
 			if ($data =3D~ /^(\S+) (.*)$/) {
