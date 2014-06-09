From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 17/19] transport: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:36 -0700
Message-ID: <090cdfb1c698b40b55828793c031f3723f2cb216.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wc-0001Do-VI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbaFIWV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:29 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:59548 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:29 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so5506943pbb.17
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=brLC4eWX8wjv2Ag46tDSlYDb9NwUzpgh9cZTNZTDUoM=;
        b=hxBRLQYbBEuJhgGngZboYACL2mI5BHafM9Oq9AdSec9/hdclrO8gO3cO3NfZ6da0G0
         Q69KjqBcU1o5z8ev+7l2UWfuxD7Fj1D13s0Z/VCxDTzCYEHRrhSSkgLkCUJesGwS/S0X
         Vzpa2e0a5VaxOqJ5t37r0hh+EjiKfkHhUWBwacqPG0Ma9I1Z4bZ2ui+gMpu/68TGjFXR
         Qn1chRj4MYd9aisyT1yA05s8ZHtEtvZraePAzAUDvC/UYv2XxDwm7kqh6tVECZzyHe6k
         cimgncfJyT7hPEdqrt4tpU8WAQkYVkRlbDu0rKsBPZTdKHpUvcRJngPeBLUPfhhZ8C0v
         U6Mw==
X-Received: by 10.66.66.225 with SMTP id i1mr1322555pat.0.1402352488735;
        Mon, 09 Jun 2014 15:21:28 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id jt7sm65809818pbc.46.2014.06.09.15.21.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:21:27 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:21:24 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251125>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 172b3d8..e8f5dfa 100644
--- a/transport.c
+++ b/transport.c
@@ -1092,8 +1092,7 @@ static int run_pre_push_hook(struct transport *transport,
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
+		strbuf_setf( &buf, "%s %s %s %s\n",
 			 r->peer_ref->name, sha1_to_hex(r->new_sha1),
 			 r->name, sha1_to_hex(r->old_sha1));
 
-- 
2.0.0.592.gf55b190
