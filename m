From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: [PATCH 2/5] simplify control flow in cvs pserver auth
Date: Tue, 6 Jul 2010 19:35:45 +0200
Message-ID: <AANLkTil27QbVl_Li1P2C53SUBZYYtwrWXYdOeZN5FVHl@mail.gmail.com>
References: <2703392615631579763@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?B?TOFzemzzIMFTSElO?= <laszlo.ashin@neti.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 19:36:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWC4I-0002rX-E6
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab0GFRgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 13:36:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42605 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895Ab0GFRgM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 13:36:12 -0400
Received: by bwz1 with SMTP id 1so3685443bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lqh5i+KnXxsg/KdMbTecVi73qNIhk5IHy1eLTT+wLe8=;
        b=bdmFS4gfq/SOSFYYunQFsBptjvASyn+fBSwRRJ+Aq9bwwR9vlKGwXVfdgyLSye1s1j
         ccUvFXwYnk+HIg/BPrwjJGUqW7OLvwG5xPEpgOyIIhnwlC3j30sqJminN5RJAjB9IRml
         iTwTa0L5Ghau96v6uNGXYuR0KwJCV00tO8TN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=u01boxAfwSSXJDmT7DHd62VpwiiWQQliBOAXnPoKkexcCdzAd+XBePLe++Hs+fazSR
         E802aKXbwZ+UAAeMABm15eW6ztjo+OiyG4pdh7Hbaaohe0I2RiWfA1CK+rTu7AWZxClo
         XZ38iFiCsg+7b7Lbx5dpCeB44umSeBo5A1HMI=
Received: by 10.204.79.199 with SMTP id q7mr4046328bkk.76.1278437767072; Tue, 
	06 Jul 2010 10:36:07 -0700 (PDT)
Received: by 10.204.79.19 with HTTP; Tue, 6 Jul 2010 10:35:45 -0700 (PDT)
In-Reply-To: <2703392615631579763@unknownmsgid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150375>

---
=A0git-cvsserver.perl | =A0 16 +++++++---------
=A01 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index c89d999..10dcc65 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -231,18 +231,12 @@ if ($state->{method} eq 'pserver') {
=A0 =A0 =A0 =A0 }

=A0 =A0 =A0 =A0 # Fall through to LOVE
- =A0 =A0} else {
- =A0 =A0 =A0 =A0# Trying to authenticate a user
- =A0 =A0 =A0 =A0if (not exists $cfg->{gitcvs}->{authdb}) {
- =A0 =A0 =A0 =A0 =A0 =A0print "E the repo config file needs a [gitcvs]=
 section
with an 'authdb' parameter set to the filename of the authentication
database\n";
- =A0 =A0 =A0 =A0 =A0 =A0print "I HATE YOU\n";
- =A0 =A0 =A0 =A0 =A0 =A0exit 1;
- =A0 =A0 =A0 =A0}
-
+ =A0 =A0} elsif (exists $cfg->{gitcvs}->{authdb}) {
=A0 =A0 =A0 =A0 my $authdb =3D $cfg->{gitcvs}->{authdb};

=A0 =A0 =A0 =A0 unless (-e $authdb) {
- =A0 =A0 =A0 =A0 =A0 =A0print "E The authentication database specified=
 in
[gitcvs.authdb] does not exist\n";
+ =A0 =A0 =A0 =A0 =A0 =A0print "E The authentication database specified=
 in " .
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"[gitcvs.authdb] does not exist\n";
=A0 =A0 =A0 =A0 =A0 =A0 print "I HATE YOU\n";
=A0 =A0 =A0 =A0 =A0 =A0 exit 1;
=A0 =A0 =A0 =A0 }
@@ -264,6 +258,10 @@ if ($state->{method} eq 'pserver') {
=A0 =A0 =A0 =A0 }

=A0 =A0 =A0 =A0 # Fall through to LOVE
+ =A0 =A0} else {
+ =A0 =A0 =A0 =A0print "E Unable to find a usable authentication method=
\n";
+ =A0 =A0 =A0 =A0print "I HATE YOU\n";
+ =A0 =A0 =A0 =A0exit 1;
=A0 =A0 }

=A0 =A0 # For checking whether the user is anonymous on commit
--
1.7.0.4
