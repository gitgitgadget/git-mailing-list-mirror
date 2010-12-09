From: "Alan Raison" <alan@theraisons.me.uk>
Subject: [PATCH] Corrected return values in prep_for_email;
Date: Thu, 9 Dec 2010 16:03:05 -0000
Message-ID: <004301cb97ba$90772630$b1657290$@me.uk>
References: <002501cb962c$5fa3aa40$1eeafec0$@me.uk> <7v1v5tqswl.fsf@alter.siamese.dyndns.org> <4CFE8E97.4020508@digium.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Kevin P. Fleming'" <kpfleming@digium.com>,
	"'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 17:03:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQiy0-0005Ht-LS
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 17:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab0LIQDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 11:03:12 -0500
Received: from gateway.bjss.co.uk ([77.86.30.29]:46492 "EHLO
	gateway.bjss.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab0LIQDK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 11:03:10 -0500
Received: from exchange.bjss.co.uk ([172.22.32.28]) by gateway.bjss.co.uk with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 9 Dec 2010 16:03:05 +0000
Received: from kitkat ([172.22.33.188]) by exchange.bjss.co.uk with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 9 Dec 2010 16:03:05 +0000
In-Reply-To: <4CFE8E97.4020508@digium.com>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcuWRylNHE+witzbTUKvAHNYKsYlyABXN5Cw
Content-Language: en-gb
X-OriginalArrivalTime: 09 Dec 2010 16:03:05.0299 (UTC) FILETIME=[906D6230:01CB97BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163292>

Function was returning 0 for failure and 1 for success which was breaking
the logic in the main loop.

Corrected to return 0 for success, 1 for failure.  Function now also returns
in all cases, rather than exiting.

Acked-By: Kevin P. Fleming <kpfleming@digium.com>
Signed-Off-By: Alan Raison <alan@theraisons.me.uk>
---
 contrib/hooks/post-receive-email |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/hooks/post-receive-email
b/contrib/hooks/post-receive-email
index 85724bf..f99ea95 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -144,13 +144,13 @@ prep_for_email()
 			short_refname=${refname##refs/remotes/}
 			echo >&2 "*** Push-update of tracking branch,
$refname"
 			echo >&2 "***  - no email generated."
-			exit 0
+			return 1
 			;;
 		*)
 			# Anything else (is there anything else?)
 			echo >&2 "*** Unknown type of update to $refname
($rev_type)"
 			echo >&2 "***  - no email generated"
-			return 0
+			return 1
 			;;
 	esac
 
@@ -166,10 +166,10 @@ prep_for_email()
 		esac
 		echo >&2 "*** $config_name is not set so no email will be
sent"
 		echo >&2 "*** for $refname update $oldrev->$newrev"
-		return 0
+		return 1
 	fi
 
-	return 1
+	return 0
 }
 
 #
-- 
1.7.3.1.msysgit.0
