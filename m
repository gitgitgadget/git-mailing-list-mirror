From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 07/16] refs.c: rollback the lockfile before we die() in repack_without_refs
Date: Mon, 17 Nov 2014 17:44:48 -0800
Message-ID: <1416275097-3616-8-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:45:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXrJ-0003rt-Un
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbaKRBpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:23 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59106 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbaKRBpL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:11 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so6414852ier.28
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P7pguJPqLc/r0gV/Uj7sLctehRqfY0DxVdQ+R0kiXGo=;
        b=oeZhkXWOVbR+z0tlFCWc2NeXYk5AfLy8fA6R0P55g3Oe2q1/VZfzfH+W/obe3eWRi1
         NOEBKE8FRdQ8iAZIE/K26YaCd7Mzt8KzLSiyhW8pYzx8U1fQ3g+b6bukmdWoDPsEBkSM
         wf89MD/ANsoDx1CwFA+gfCxhClJkBan/4CdWnDGaoxf3TdgW8Ig/iZ95GaEqcHa/6nxT
         FEl78ieGDqnpj3x7wRCe2T1206o2vxWRabK+y5LYW7vyDMua+UH7hdI3J6xBS8pwCYxn
         XnoftxkRZekyOMX8brt8n1slD4hKHuJK38MeAzNIL9HH3jiYkDsmVpJL21jh3hth9VhW
         I7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P7pguJPqLc/r0gV/Uj7sLctehRqfY0DxVdQ+R0kiXGo=;
        b=FuFO+EIVW28w4t7HhwVcu3saWHoeWWlVMebuI0nIvER7/MNdNEHMqZaASaGMKLSXgK
         UFR3VpF03hg+T39PkiIbKPJ51DHdRvggxyKL5G6z7yfo2utCUhITCdoafsnBuObZ+vZR
         pLI3s4zSVqy/ZV3fwQepeqNZrruU1DOgsy9XIkLKhW1GDYvN95SGGAT1Blp7NxIhvuM0
         AZTEolTHgB/psCDqypA1ssum6szXSMQfNh8SBpTAjsphhWNbyWCWODugJLh8r6MrWKN4
         UTD0ONd5jV/r2FsCN1/3N+80ilJwLD/WBEdADOVsokXaTMtUWwIcGEffsI6FZYdeghtM
         EfZg==
X-Gm-Message-State: ALoCoQmeugTFiPnMhX9RBJqGGC6y4XARWNXOB9xSRhMmykarT7E2W318nvwLt8tUtSoiRWzyF3ES
X-Received: by 10.50.50.228 with SMTP id f4mr29823734igo.49.1416275110765;
        Mon, 17 Nov 2014 17:45:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id o4sm117755ige.7.2014.11.17.17.45.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:10 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 780acd5..2db1dff 100644
--- a/refs.c
+++ b/refs.c
@@ -2707,8 +2707,10 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
 	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
-		if (remove_entry(packed, ref_to_delete->string) == -1)
+		if (remove_entry(packed, ref_to_delete->string) == -1) {
+			rollback_packed_refs();
 			die("internal error");
+		}
 	}
 
 	/* Write what remains */
-- 
2.2.0.rc2.5.gf7b9fb2
