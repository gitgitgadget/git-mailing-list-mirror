From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/8] refs.c: let fprintf handle the formatting
Date: Fri,  5 Dec 2014 18:46:28 -0800
Message-ID: <1417833995-25687-2-git-send-email-sbeller@google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 06 03:46:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx5OU-0004kd-Kh
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbaLFCqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:46:42 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:59055 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbaLFCqk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:46:40 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so297844iga.14
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4KwsDfuXecZsNEaVP0ZkmTd2AGTMPw0ocGfQExlx7bc=;
        b=QFlv7hfZwGuw3MaibRuvPLscMbHgnUYu57ofTq5rkh6NGFzS36HQL9i4eu8PFm8kJv
         MsJ4YtG4JS3fiZZ6x8fqYo9+fwdxiHRwZCcDJkdSIptX42B3fNDy1vGnMB4WK9D7P2D5
         21gyB/sEeTLOJ2pRay8YAUufqeBYu/jEsVe+Vv6FEgdJxe0bAVO1zoH7M7g8CXnHAMFj
         mEnoBCgPJ6lt/ZNNFMdBufwjah+UN3yRQlNVC/M/pelJN4cTZM10GuHl/4Epi7hUWzg6
         aFERZ6PevCXv5Js4cdikNplk/M3rzFJpfh6wKZyQFLA5OOTPU/XNsF44bezvmZgABghB
         EsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4KwsDfuXecZsNEaVP0ZkmTd2AGTMPw0ocGfQExlx7bc=;
        b=Eo6f6qBhFMw1YB2zoEfp8rvMhyvr8lSq9Ycv+086KjBs8JAAbjJS6lTCQbpsP4YQyD
         QGIYBklRq4+BPN6xya92AkuEF4nmI27ouAvfKF+iuU2HAhGYkXT5zFZ06MeHUGJBIB8g
         Tt3WM88umpiGQB9j8HsX8lKINrWdyl0K3ghHlsr3mTxbhV9k7t9HoCVa0bRmpzG0Jyyx
         zIEJp+g6cjPfilz0bp9xc56xmc6P41E5XOOrlC7LCusL75wz6FD/zkbi2UBGGmj0rHc5
         YSzswPa+V54HmzeGDNRh5Hv1YV6rjHNx4UiB9UfJ69SNruQkorEXJCw7fjC/qUZ/qSeR
         Fmsw==
X-Gm-Message-State: ALoCoQnxiputIpS78UAtW0PMpEKp0h2wNaLjdaETYn8mDsy/r/v/KyvF+Nwujozy2mBzi25YWzj2
X-Received: by 10.43.89.68 with SMTP id bd4mr17876421icc.63.1417833999438;
        Fri, 05 Dec 2014 18:46:39 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id x10sm153736igl.19.2014.12.05.18.46.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 18:46:38 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417833995-25687-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260926>

Instead of calculating, whether to put a plus or minus sign, offload
the responsibilty to the fprintf function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This patch was already sent as a single patch to the list,
    but not yet acknowledge in any way, so I am including it here.
    
    This series goes on top of Michaels series
    https://github.com/mhagger/git/tree/reflog-expire-api-v1

 refs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 40c5591..1147216 100644
--- a/refs.c
+++ b/refs.c
@@ -3972,12 +3972,9 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 			printf("prune %s", message);
 	} else {
 		if (cb->newlog) {
-			char sign = (tz < 0) ? '-' : '+';
-			int zone = (tz < 0) ? (-tz) : tz;
-			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
+			fprintf(cb->newlog, "%s %s %s %lu %+05d\t%s",
 				sha1_to_hex(osha1), sha1_to_hex(nsha1),
-				email, timestamp, sign, zone,
-				message);
+				email, timestamp, tz, message);
 			hashcpy(cb->last_kept_sha1, nsha1);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-- 
2.2.0
