From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t7508: avoid non-portable sed expression
Date: Sat, 14 Sep 2013 00:47:12 -0400
Message-ID: <1379134032-83211-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 06:47:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKhlu-0005f3-Fk
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 06:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab3INErp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 00:47:45 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:62228 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab3INErp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 00:47:45 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so1888861obb.12
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 21:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=7fUDn9Vq2RtnFwaokfoxZpXz767aKBpTcAsft2j3DF4=;
        b=APsywjQ7s87GI8y/bK54fjIgqhDpY0O//BmmgdrnbWd1hN8Fd4r9mw7mpM9bcBXiEK
         K84qGk9CKTlg7KicYa/b9y6nUAk92N9GIwdIAL5MtC2hYHv+WfCJS/nK5AUZL5if3Ysb
         D6kMJCXGfC3nbR+vas96MLN/kzffz+olexrFOuy89H9P4sV1QpnKtC+AZ0PMhlvLobRn
         v4qlzaiDJpcWgbcDXqP+8egzDFL9BG0IiSoocxmF5SvKeOQHE3TQjBXsjA/8GeLbyJl/
         hB1ceQ5F5Gxqc1tCaHv30ta60QIley6i9MEH8yjU6vVSvX8p2p7IIoZUS4OfO+rPO2+C
         WNsQ==
X-Received: by 10.60.124.14 with SMTP id me14mr15502926oeb.4.1379134064504;
        Fri, 13 Sep 2013 21:47:44 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id d8sm20397019oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 21:47:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234789>

2556b996 (status: disable display of '#' comment prefix by default;
2013-09-06) introduced tests which fail on Mac OS X due to unportable
use of \t (for TAB) in a sed expression. POSIX [1][2] also disallows
it. Fix this.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html#tag_20_116_13_02
[2]: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03_02

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This applies against 'next'.

 t/t7508-status.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 7d52dbf..6fb59f3 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -61,7 +61,8 @@ test_expect_success 'status (1)' '
 '
 
 strip_comments () {
-	sed "s/^\# //; s/^\#$//; s/^#\t/\t/" <"$1" >"$1".tmp &&
+	tab='	'
+	sed "s/^\# //; s/^\#$//; s/^#$tab/$tab/" <"$1" >"$1".tmp &&
 	rm "$1" && mv "$1".tmp "$1"
 }
 
-- 
1.8.4.535.g7b94f8e
