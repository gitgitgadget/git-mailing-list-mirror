From: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
Subject: [PATCH] Don't add To: recipients to the Cc: header
Date: Mon, 19 Nov 2007 03:00:26 -0800
Message-ID: <1195470026-7389-1-git-send-email-ask@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 12:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu4Mv-0005LA-Fa
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 12:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbXKSLA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2007 06:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbXKSLA1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 06:00:27 -0500
Received: from gw.develooper.com ([64.81.84.140]:62228 "EHLO
	freja.develooper.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751396AbXKSLA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 06:00:26 -0500
Received: by freja.develooper.com (Postfix, from userid 500)
	id 1ED7117D028; Mon, 19 Nov 2007 03:00:26 -0800 (PST)
X-Mailer: git-send-email 1.5.3.6.735.ge0de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65425>


Signed-off-by: Ask Bj=C3=B8rn Hansen <ask@develooper.com>
---
 git-send-email.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 65620ab..530b456 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -557,8 +557,11 @@ sub sanitize_address
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
