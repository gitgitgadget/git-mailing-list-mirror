From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/25] rename_ref: don't ask read_ref_full where the ref came
 from
Date: Tue, 14 Oct 2014 17:48:46 -0700
Message-ID: <20141015004846.GK32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:49:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeClq-0000dT-49
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbaJOAsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:48:50 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61812 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbaJOAsu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:48:50 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so227115pad.19
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OGTXPBNOV0AfT1m+cOFy+MP3XZzswk1iwGzOqvBhLJk=;
        b=ZgJKjbpTsSN1FGudNmTx1d+a3Fjz17ASMHZAoadJUmZVTHmNng5FKNnYTc7LvWqX0R
         bOG4wgzE2E5tKNnrIbnG4/2T7uKc9JiIQ5lYYHpXUrBGIJA03NCf0MojODBrWAWt6/vo
         0dtqySulsoi1yEDwsvemHdhKRAbOZ1+L3Kkv5/vFaqaOcsnYY0L949xLDXQot2UZ/emA
         yfwFc8S2bE0EpsKaL6sus2UUulXSE/rVTw7Z4thm9KzJxJbnYLVSbfrL0i+cYVLKgiT9
         msEHkQVqWnzbcNxnc9xQ4Hvb1dYb7soLAobDXkzlikxFxWKbOL0mZFrl06Zf4ZPXKmCy
         lQEQ==
X-Received: by 10.66.121.232 with SMTP id ln8mr8451032pab.5.1413334129669;
        Tue, 14 Oct 2014 17:48:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id nh8sm12653922pdb.25.2014.10.14.17.48.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:48:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 30 Apr 2014 12:41:04 -0700

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f5d7bd7..3c45615 100644
--- a/refs.c
+++ b/refs.c
@@ -2721,7 +2721,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.1.0.rc2.206.gedb03e5
