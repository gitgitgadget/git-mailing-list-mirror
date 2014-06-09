From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 05/19] branch: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:24 -0700
Message-ID: <6380bb5aabeb990729d821707d80d9b4f01137de.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:20:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7vq-0000as-J8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbaFIWUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:20:41 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:32853 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:20:40 -0400
Received: by mail-pd0-f179.google.com with SMTP id fp1so5409239pdb.10
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aB48Y+RM2Qwv4PUfH5Lu4W1oToiG2LM4LO9T1WlTamE=;
        b=veDldwROHm62vh2WeKDVWC1lUxni9CxqCTiRLA8/u3kqC54qABI9iH/CMGC37XlM8d
         U4zjs9JF1v94vQ9xs/IDN/HIX96EP+JpESHEcNWxdmoklElguq7MwBYNCoZM0LXD8mSm
         rhfzL8tSbpXPIXUxHFzqpF30MsXRL3vESB1uVGueXiMTLZNJ5Gkx0dn4w5ytPlDeN/O7
         ZV9Y6rT6el2xrBt8tG/TD7GIPISVmFZZpaZm5VRNwjK7TFp7IUAIQz0i2zipiIhetChD
         UfNpKOw4g1YB9EZGblqwZVU3m1sSxtwcedQHSIhJnTfVd729Fa4xYwe+5TwiDm/ULWZL
         H3aw==
X-Received: by 10.68.192.106 with SMTP id hf10mr7450880pbc.30.1402352440389;
        Mon, 09 Jun 2014 15:20:40 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xz7sm2757362pac.3.2014.06.09.15.20.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:39 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:36 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251114>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 branch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..bc7cc7e 100644
--- a/branch.c
+++ b/branch.c
@@ -65,13 +65,11 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	strbuf_addf(&key, "branch.%s.remote", local);
 	git_config_set(key.buf, origin ? origin : ".");
 
-	strbuf_reset(&key);
-	strbuf_addf(&key, "branch.%s.merge", local);
+	strbuf_setf(&key, "branch.%s.merge", local);
 	git_config_set(key.buf, remote);
 
 	if (rebasing) {
-		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.rebase", local);
+		strbuf_setf(&key, "branch.%s.rebase", local);
 		git_config_set(key.buf, "true");
 	}
 	strbuf_release(&key);
-- 
2.0.0.592.gf55b190
