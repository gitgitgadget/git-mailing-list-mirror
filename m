From: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
Subject: [PATCH] git-send-email: Don't add To: recipients to the Cc: header too
Date: Tue, 20 Nov 2007 01:34:09 -0800
Message-ID: <1195551249-22747-1-git-send-email-ask@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 10:34:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuPUz-00072r-Fg
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 10:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbXKTJeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2007 04:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965AbXKTJeM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 04:34:12 -0500
Received: from gw.develooper.com ([64.81.84.140]:54510 "EHLO
	freja.develooper.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754728AbXKTJeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 04:34:11 -0500
Received: by freja.develooper.com (Postfix, from userid 500)
	id 83CEB17D028; Tue, 20 Nov 2007 01:34:09 -0800 (PST)
X-Mailer: git-send-email 1.5.3.6.729.ge8e09
In-Reply-To: 7vr6ill5f1.fsf@gitster.siamese.dyndns.org
References: 7vr6ill5f1.fsf@gitster.siamese.dyndns.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65534>


Signed-off-by: Ask Bj=C3=B8rn Hansen <ask@develooper.com>
---
 git-send-email.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fd0a4ad..b832d2d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -557,7 +557,11 @@ sub sanitize_address
 sub send_message
 {
 	my @recipients =3D unique_email_list(@to);
-	@cc =3D (map { sanitize_address($_) } @cc);
+	@cc =3D (grep { my $cc =3D extract_valid_address($_);
+		      not grep { $cc eq $_ } @recipients
+		    }
+	       map { sanitize_address($_) }
+	       @cc);
 	my $to =3D join (",\n\t", @recipients);
 	@recipients =3D unique_email_list(@recipients,@cc,@bcclist);
 	@recipients =3D (map { extract_valid_address($_) } @recipients);
--=20
1.5.3.5.561.g140d
