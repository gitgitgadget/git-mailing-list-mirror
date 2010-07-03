From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: [PATCH 3/4] git-cvsserver: do not try to descramble empty password
Date: Sat, 3 Jul 2010 23:23:29 +0200
Message-ID: <AANLkTikUyBMOASPSQeyMLa_Vhp0QdP__c0kIsCMarY8L@mail.gmail.com>
References: <-1644121413921817001@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 23:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVABo-00087P-94
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 23:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab0GCVXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 17:23:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39631 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab0GCVXv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 17:23:51 -0400
Received: by fxm14 with SMTP id 14so2997242fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=B6XZAlKPtnCZeXhAOKEJgOQ3SJmAorVcxKazyS6dd+8=;
        b=iMteXQ0qE3xh/+q3XiIEkwNPfORwNs+U3jccnGHImHpK0OVBqPONdsj1wsR/I9ILfo
         ZTMZ7oQdH0vw55a3+b84kbGsRTvqwp6ORVtX1qL9zSmr8d1m9Z5PBL87A/2vxpjiKg1w
         9PHd43lFzDZo2BvMvaFRme0O3JqvmHQDPHSqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=WIEir5iL2g73PbuL0I7elsZK6cDuUtn8TfPl8hMvfbgrRkMPSa+df668+5Cv9uou2X
         N8USztJ66FhN5BzJ6l7maaphAYXgzp4yRFr14bpG8VAu1yY13xHg798V1R3g66fyjoD6
         CSz2/i38UrgpWDt1eIeaE9bBrHjOBQ28TMYak=
Received: by 10.103.138.4 with SMTP id q4mr62592mun.72.1278192229065; Sat, 03 
	Jul 2010 14:23:49 -0700 (PDT)
Received: by 10.103.225.9 with HTTP; Sat, 3 Jul 2010 14:23:29 -0700 (PDT)
In-Reply-To: <-1644121413921817001@unknownmsgid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150205>

=A0git-cvsserver.perl | =A0 =A06 +++++-
=A01 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 46e5fdb..01c5b21 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -235,11 +235,15 @@ if ($state->{method} eq 'pserver') {
=A0 =A0 =A0 =A0 =A0 =A0 exit 1;
=A0 =A0 =A0 =A0 }

+ =A0 =A0 =A0 =A0if (length($password) > 0) {
+ =A0 =A0 =A0 =A0 =A0 =A0$password =3D descramble($password);
+ =A0 =A0 =A0 =A0}
+
=A0 =A0 =A0 =A0 my $auth_ok;
=A0 =A0 =A0 =A0 open my $passwd, "<", $authdb or die $!;
=A0 =A0 =A0 =A0 while (<$passwd>) {
=A0 =A0 =A0 =A0 =A0 =A0 if (m{^\Q$user\E:(.*)}) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (crypt($user, descramble($password)=
) eq $1) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (crypt($user, $password) eq $1) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $auth_ok =3D 1;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
=A0 =A0 =A0 =A0 =A0 =A0 };
--
1.7.2.rc1.dirty
