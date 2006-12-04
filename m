X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: [PATCH 1/3] git-fetch: ignore dereferenced tags in
	expand_refs_wildcard
Date: Mon, 04 Dec 2006 20:34:34 +0100
Message-ID: <1165260874.20055.4.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 19:34:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.6.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33224>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJaO-0007n7-6P for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937181AbWLDTel (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759421AbWLDTel
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:34:41 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:43865 "EHLO mx01.ap-wdsl.de"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759360AbWLDTel
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 14:34:41 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

There was a little bug in the brace expansion which should remove
the ^{} from the tagname. It used ${name#'^{}'} instead of $(name%'^{}'},
the difference is that '#' will remove the given pattern only from the
beginning of a string and '%' only from the end of a string.

Signed-off-by: Michael Loeffler <zvpunry@zvpunry.de>
---
 git-parse-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 19bc385..da064a5 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -116,7 +116,7 @@ expand_refs_wildcard () {
 			while read sha1 name
 			do
 				mapped=${name#"$from"}
-				if test "z$name" != "z${name#'^{}'}" ||
+				if test "z$name" != "z${name%'^{}'}" ||
 					test "z$name" = "z$mapped"
 				then
 					continue
-- 
1.4.4


