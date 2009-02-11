From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/3] builtin-remote: move duplicated cleanup code its own function
Date: Wed, 11 Feb 2009 01:01:21 -0500
Message-ID: <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 07:02:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX8BV-0008EH-0n
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 07:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbZBKGBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 01:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbZBKGBa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 01:01:30 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:18162 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZBKGB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 01:01:28 -0500
Received: by an-out-0708.google.com with SMTP id c2so32219anc.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 22:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sDPBmGeFyY63Y92DUSJuf9rcMKOaWb+i0hu+VbWcOmM=;
        b=fwXT/ZODznX2F6cnjnIwGBkhnMeLrUmxmDY67cz60T3XGIb9fGkr96rUod5VQuE+Wd
         uGoXocAmilcv8gsRpbcY1PXNsCYbJ/ZMUT8xO+P7iFAomBc/FF0+cNNhKYsK0h67NJlB
         TM87hBbBWhSP54vIV5VJyN7tVUZ3tnZxqLQ3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LuHl3ae9J+wCrCeXU++isBN0gtlCzOOPtCl3BNPPEL+F3OhYaykU7YrENilBsKvCJw
         CJTYYUCpYVwtDGuvsOMZHp3tgH+/ZZ5y6ZzGHbO0ZdeAY055NSCpp20TtmI+UNX7wFJK
         2lT5ccJ1roN1LGddsdNxS2cgRQ67P8KWkud5o=
Received: by 10.100.125.12 with SMTP id x12mr5499983anc.4.1234332088119;
        Tue, 10 Feb 2009 22:01:28 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d29sm6497253and.14.2009.02.10.22.01.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 22:01:27 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.187.g9fcfb
In-Reply-To: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109375>

Moved some identical lines of code into their own function in
preparation for adding additional functionality which will use this
function as well.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index db18bcf..00e7ca5 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -632,6 +632,14 @@ static void show_list(const char *title, struct string_list *list,
 		printf("    %s\n", list->items[i].string);
 }
 
+static void free_remote_ref_states(struct ref_states *states)
+{
+	/* NEEDSWORK: free remote */
+	string_list_clear(&states->new, 0);
+	string_list_clear(&states->stale, 0);
+	string_list_clear(&states->tracked, 0);
+}
+
 static int get_remote_ref_states(const char *name,
 				 struct ref_states *states,
 				 int query)
@@ -738,10 +746,7 @@ static int show(int argc, const char **argv)
 			}
 		}
 
-		/* NEEDSWORK: free remote */
-		string_list_clear(&states.new, 0);
-		string_list_clear(&states.stale, 0);
-		string_list_clear(&states.tracked, 0);
+		free_remote_ref_states(&states);
 	}
 
 	return result;
@@ -786,10 +791,7 @@ static int prune(int argc, const char **argv)
 			       abbrev_ref(refname, "refs/remotes/"));
 		}
 
-		/* NEEDSWORK: free remote */
-		string_list_clear(&states.new, 0);
-		string_list_clear(&states.stale, 0);
-		string_list_clear(&states.tracked, 0);
+		free_remote_ref_states(&states);
 	}
 
 	return result;
-- 
1.6.2.rc0.187.g9fcfb
