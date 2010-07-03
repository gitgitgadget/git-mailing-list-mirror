From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: [PATCH 2/4] git-cvsserver: simplify control flow in pserver 
	authentication
Date: Sat, 3 Jul 2010 23:22:45 +0200
Message-ID: <AANLkTiktRjlLWrvLG4Jkd_Yu7FLAgJ6_mhYITy3bI3Cb@mail.gmail.com>
References: <1707116361121042582@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 23:23:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVAB8-0007rF-Br
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 23:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab0GCVXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 17:23:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37870 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0GCVXG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 17:23:06 -0400
Received: by fxm14 with SMTP id 14so2997104fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=RickWQo3DF4LTzW4c+Uc3q+qZ/Na5N6EhszhbymnV8U=;
        b=rxNXl1zUDd3jLlMSA7cHGfwe2A8SMYqwM0KMBfv4X/Zpo0rHMKir7SKcKVFiflNM0B
         iesGakqcsXE5QqATO6HiY2CHS2a3lXPPMOqMyIcHLVe9RtwIdZ/Bg0dmcg1P4hXX895+
         LFwE6mPatgGnwm9o2Hri8IDgrf6hY5P9WUZzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=l5OWy9DZyTDqVdn310v2RrXGyHNb4gfn79AWKdMybCUcAZ6sEXMmpiv4UJ58yapQE5
         2i6zIresO4lSXMlObiHxDEdBhIA2PUlr6WGgslT8dXoTGKToyaxca5wMuwNdpUQ+V4sy
         Bt7zRb8S643MFQIBtu2qiMZsvmIQKVhQlO5kI=
Received: by 10.103.221.1 with SMTP id y1mr62368muq.19.1278192185161; Sat, 03 
	Jul 2010 14:23:05 -0700 (PDT)
Received: by 10.103.225.9 with HTTP; Sat, 3 Jul 2010 14:22:45 -0700 (PDT)
In-Reply-To: <1707116361121042582@unknownmsgid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150204>

=A0git-cvsserver.perl | =A0 16 +++++++---------
=A01 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 9664e86..46e5fdb 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -225,18 +225,12 @@ if ($state->{method} eq 'pserver') {
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
 in ";
+ =A0 =A0 =A0 =A0 =A0 =A0print "[gitcvs.authdb] does not exist\n";
=A0 =A0 =A0 =A0 =A0 =A0 print "I HATE YOU\n";
=A0 =A0 =A0 =A0 =A0 =A0 exit 1;
=A0 =A0 =A0 =A0 }
@@ -258,6 +252,10 @@ if ($state->{method} eq 'pserver') {
=A0 =A0 =A0 =A0 }

=A0 =A0 =A0 =A0 # Fall through to LOVE
+ =A0 =A0} else {
+ =A0 =A0 =A0 =A0print "E Unable to find usable authentication method\n=
";
+ =A0 =A0 =A0 =A0print "I HATE YOU\n";
+ =A0 =A0 =A0 =A0exit 1;
=A0 =A0 }

=A0 =A0 # For checking whether the user is anonymous on commit
--
1.7.2.rc1.dirty
