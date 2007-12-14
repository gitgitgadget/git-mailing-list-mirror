From: avar@cpan.org (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
Subject: Re: [PATCH] Authentication support for pserver
Date: Fri, 14 Dec 2007 21:08:46 +0000
Message-ID: <877ijhm1b5.fsf@cpan.org>
References: <87wsrhex4c.fsf@cpan.org>
	<7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
	<7vir31u210.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org, martyn@catalyst.net.nz, martin@catalyst.net.nz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 22:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Hm0-0006q6-Sa
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 22:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655AbXLNVIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 16:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbXLNVIN
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 16:08:13 -0500
Received: from jeep.ipf.is ([85.197.192.148]:60453 "EHLO mx2.ipf.is"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757655AbXLNVIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 16:08:11 -0500
Received: (qmail 4735 invoked by uid 1010); 14 Dec 2007 21:08:10 +0000
Received: from 85.197.228.236 by jeep (envelope-from <avar@cpan.org>, uid 1008) with qmail-scanner-1.25-st-qms 
 (clamdscan: 0.88.4/1639. spamassassin: 3.1.4. perlscan: 1.25-st-qms.  
 Clear:RC:1(85.197.228.236):SA:0(-3.9/4.5):. 
 Processed in 2.39 secs); 14 Dec 2007 21:08:10 -0000
X-Spam-Status: No, hits=-3.9 required=4.5
X-Antivirus-HIVE-Mail-From: avar@cpan.org via jeep
X-Antivirus-HIVE: 1.25-st-qms (Clear:RC:1(85.197.228.236):SA:0(-3.9/4.5):. Processed in 2.39 secs Process 4722)
Received: from unknown (HELO oe.cpan.org) (85.197.228.236)
  by mx2.ipf.is with SMTP; 14 Dec 2007 21:08:07 +0000
In-Reply-To: <7vir31u210.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 14 Dec 2007 00:13:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68346>

--=-=-=

Junio C Hamano <gitster@pobox.com> writes:

> Looks good.  I'll queue only so that I won't lose it and wait for Acks
> from Mart[iy]ns.  Please sign off your patch.

Will this do?


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=git-cvsserver.patch
Content-Transfer-Encoding: quoted-printable
Content-Description: signed-off patch to git-cvsserver

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@cpan.org>
---
 Documentation/git-cvsserver.txt |   21 +++++++++--
 git-cvsserver.perl              |   74 ++++++++++++++++++++++++++++++++++-=
---
 2 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.=
txt
index 258a62f..5ca84fc 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -69,9 +69,6 @@ plugin. Most functionality works fine with both of these =
clients.
 LIMITATIONS
 -----------
=20
-Currently cvsserver works over SSH connections for read/write clients, and
-over pserver for anonymous CVS access.
-
 CVS clients cannot tag, branch or perform GIT merges.
=20
 git-cvsserver maps GIT branches to CVS modules. This is very different
@@ -81,7 +78,7 @@ one or more directories.
 INSTALLATION
 ------------
=20
-1. If you are going to offer anonymous CVS access via pserver, add a line =
in
+1. If you are going to offer CVS access via pserver, add a line in
    /etc/inetd.conf like
 +
 --
@@ -98,6 +95,22 @@ looks like
    cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver git-cvsserve=
r pserver
=20
 ------
+
+Only anonymous access is provided by pserve by default. To commit you
+will have to create pserver accounts, simply add a [gitcvs.users]
+section to the repositories you want to access, for example:
+
+------
+=20=20=20
+   [gitcvs.users]
+        someuser =3D somepassword
+        otheruser =3D otherpassword
+=20=20=20
+------
+Then provide your password via the pserver method, for example:
+------
+   cvs -d:pserver:someuser:somepassword@server/path/repo.git co <HEAD_name>
+------
 No special setup is needed for SSH access, other than having GIT tools
 in the PATH. If you have clients that do not accept the CVS_SERVER
 environment variable, you can rename git-cvsserver to cvs.
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ecded3b..6f08bed 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -150,12 +150,35 @@ if ($state->{method} eq 'pserver') {
        exit 1;
     }
     $line =3D <STDIN>; chomp $line;
-    unless ($line eq 'anonymous') {
-       print "E Only anonymous user allowed via pserver\n";
-       print "I HATE YOU\n";
-       exit 1;
+    my $user =3D $line;
+    $line =3D <STDIN>; chomp $line;
+    my $password =3D $line;
+
+    unless ($user eq 'anonymous') {
+        # Trying to authenticate a user
+        if (not exists $cfg->{gitcvs}->{users}) {
+            print "E the repo config file needs a [gitcvs.users] section w=
ith user/password key-value pairs\n";
+            print "I HATE YOU\n";
+            exit 1;
+        } elsif (exists $cfg->{gitcvs}->{users} and not exists $cfg->{gitc=
vs}->{users}->{$user}) {
+            #print "E the repo config file has a [gitcvs.users] section bu=
t the user $user is not defined in it\n";
+            print "I HATE YOU\n";
+            exit 1;
+        } else {
+            my $descrambled_password =3D descramble($password);
+            my $cleartext_password =3D $cfg->{gitcvs}->{users}->{$user};
+            if ($descrambled_password ne $cleartext_password) {
+                #print "E The password supplied for user $user was incorre=
ct\n";
+                print "I HATE YOU\n";
+                exit 1;
+            }
+            # else fall through to LOVE
+        }
     }
-    $line =3D <STDIN>; chomp $line;    # validate the password?
+
+    # For checking whether the user is anonymous on commit
+    $state->{user} =3D $user;
+
     $line =3D <STDIN>; chomp $line;
     unless ($line eq "END $request REQUEST") {
        die "E Do not understand $line -- expecting END $request REQUEST\n";
@@ -273,7 +296,7 @@ sub req_Root
     }
     foreach my $line ( @gitvars )
     {
-        next unless ( $line =3D~ /^(gitcvs)\.(?:(ext|pserver)\.)?([\w-]+)=
=3D(.*)$/ );
+        next unless ( $line =3D~ /^(gitcvs)\.(?:(ext|pserver|users)\.)?([\=
w-]+)=3D(.*)$/ );
         unless ($2) {
             $cfg->{$1}{$3} =3D $4;
         } else {
@@ -1176,9 +1199,9 @@ sub req_ci
=20
     $log->info("req_ci : " . ( defined($data) ? $data : "[NULL]" ));
=20
-    if ( $state->{method} eq 'pserver')
+    if ($state->{method} eq 'pserver' and $state->{user} eq 'anonymous')
     {
-        print "error 1 pserver access cannot commit\n";
+        print "error 1 anonymous user cannot commit via pserver\n";
         exit;
     }
=20
@@ -2107,6 +2130,41 @@ sub kopts_from_path
     }
 }
=20
+
+sub descramble
+{
+    # This table is from src/scramble.c in the CVS source
+    my @SHIFTS =3D (
+        0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+        16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+        114,120, 53, 79, 96,109, 72,108, 70, 64, 76, 67,116, 74, 68, 87,
+        111, 52, 75,119, 49, 34, 82, 81, 95, 65,112, 86,118,110,122,105,
+        41, 57, 83, 43, 46,102, 40, 89, 38,103, 45, 50, 42,123, 91, 35,
+        125, 55, 54, 66,124,126, 59, 47, 92, 71,115, 78, 88,107,106, 56,
+        36,121,117,104,101,100, 69, 73, 99, 63, 94, 93, 39, 37, 61, 48,
+        58,113, 32, 90, 44, 98, 60, 51, 33, 97, 62, 77, 84, 80, 85,223,
+        225,216,187,166,229,189,222,188,141,249,148,200,184,136,248,190,
+        199,170,181,204,138,232,218,183,255,234,220,247,213,203,226,193,
+        174,172,228,252,217,201,131,230,197,211,145,238,161,179,160,212,
+        207,221,254,173,202,146,224,151,140,196,205,130,135,133,143,246,
+        192,159,244,239,185,168,215,144,139,165,180,157,147,186,214,176,
+        227,231,219,169,175,156,206,198,129,164,150,210,154,177,134,127,
+        182,128,158,208,162,132,167,209,149,241,153,251,237,236,171,195,
+        243,233,253,240,194,250,191,155,142,137,245,235,163,242,178,152
+    );
+    my ($str) =3D @_;
+
+    # This should never happen, the same password format (A) bas been
+    # used by CVS since the beginning of time
+    $str =3D~ s/^(.)//;
+    die "invalid password format $1" unless $1 eq 'A';
+
+    $str =3D~ s/(.)/chr $SHIFTS[ord $1]/ge;
+
+    return $str;
+}
+
+
 package GITCVS::log;
=20
 ####
--=20
1.5.3.6.gea559


--=-=-=--
