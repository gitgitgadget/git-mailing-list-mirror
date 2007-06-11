From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Unquote From line from patch before comparing with given from address.
Date: Mon, 11 Jun 2007 13:04:40 -0400
Message-ID: <11815814802456-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 19:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxnKK-0003vz-IQ
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 19:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbXFKRE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 11 Jun 2007 13:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbXFKRE6
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 13:04:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42969 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbXFKRE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 13:04:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l5BH4tcM014358
	for <git@vger.kernel.org>; Mon, 11 Jun 2007 13:04:56 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l5BH4tb2024645
	for <git@vger.kernel.org>; Mon, 11 Jun 2007 13:04:55 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l5BH4s1B021319
	for <git@vger.kernel.org>; Mon, 11 Jun 2007 13:04:54 -0400
X-Mailer: git-send-email 1.5.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49865>

This makes --suppress-from actually work when you're unfortunate enough
to have non-ASCII in your name.  Also, if there's a match use the optio=
nally
RFC2047 quoted version from the email.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 git-send-email.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index eb876f8..7c0c90b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -561,7 +561,8 @@ foreach my $t (@files) {
 					$subject =3D $1;
=20
 				} elsif (/^(Cc|From):\s+(.*)$/) {
-					if ($2 eq $from) {
+					if (unquote_rfc2047($2) eq $from) {
+						$from =3D $2;
 						next if ($suppress_from);
 					}
 					elsif ($1 eq 'From') {
--=20
1.5.2.GIT
