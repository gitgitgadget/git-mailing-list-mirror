From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 04/14] normalize rules with RFC 5234
Date: Wed, 11 Sep 2013 01:07:48 +0800
Message-ID: <1378832878-12811-5-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
 <1378832878-12811-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:08:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQn-0003Wj-MG
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab3IJRIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:30 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40583 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab3IJRI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:26 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so8001169pab.24
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W45OeuNxU5kXaDA87Iihp+kSC9q/otIa114gxS7vXIM=;
        b=PMM/hYe9VskCCqxpAEJm5ShE+NgEJXbjJyQqz00ClMT8GPEC9Y0Ddf1qLkld6tzzr5
         L9y/Q0IJzvDxjCpDh2B0yBKvajUrR4VaxEUPKXXZok0P0CJQbGsmvnrUSwc014UTF5NM
         /H6McDKxGWtg91IkXnK69TQrlMCI6NlScYlmxcO4H8ZAz4Y4NBREzC+UHv9r1KE+IlM9
         b2r9iJrs18GfIlGAGYKflmDEq8AKyBDynu0izGXgUgORA3oVIQGbqC0Cl6nJSuXIe4rJ
         o7etDWpxt5eie/lpkO5jU2oLVEWnwHa6t/vzwlzr4N7ZqzEj+jOdMXfmdXmHA9SWp1VA
         XNaQ==
X-Received: by 10.66.25.232 with SMTP id f8mr27849601pag.25.1378832906368;
        Tue, 10 Sep 2013 10:08:26 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234449>

Drop LF, SP which are defined in RFC 5234.

Replace HT with HTAB (also defined in the RFC).

Use '/' instead of '|', as the RFC does.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/technical/http-protocol.txt | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 55753bb..ff91bb0 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -192,16 +192,13 @@ according to the C locale ordering.  The file SHOULD NOT include
 the default ref named 'HEAD'.
 
   info_refs        =  *( ref_record )
-  ref_record       =  any_ref | peeled_ref
+  ref_record       =  any_ref / peeled_ref
 
-  any_ref          =  id HT name LF
-  peeled_ref       =  id HT name LF
-		      id HT name "^{}" LF
+  any_ref          =  id HTAB name LF
+  peeled_ref       =  id HTAB name LF
+		      id HTAB name "^{}" LF
   id               =  40*HEX
 
-  HEX              =  "0".."9" | "a".."f"
-  LF               =  <US-ASCII LF, linefeed (10)>
-  HT               =  <US-ASCII HT, horizontal-tab (9)>
 
 Smart Clients
 ~~~~~~~~~~~~~
@@ -288,7 +285,7 @@ declarations behind a NUL on the first ref.
   smart_reply      =  PKT-LINE("# service=$servicename" LF)
 		      ref_list
 		      "0000"
-  ref_list         =  empty_list | non_empty_list
+  ref_list         =  empty_list / non_empty_list
 
   empty_list       =  PKT-LINE(id SP "capabilities^{}" NUL cap_list LF)
 
@@ -296,18 +293,13 @@ declarations behind a NUL on the first ref.
 		      *ref_record
 
   cap_list         =  *(SP capability) SP
-  ref_record       =  any_ref | peeled_ref
+  ref_record       =  any_ref / peeled_ref
 
   any_ref          =  PKT-LINE(id SP name LF)
   peeled_ref       =  PKT-LINE(id SP name LF)
 		      PKT-LINE(id SP name "^{}" LF
   id               =  40*HEX
 
-  HEX              =  "0".."9" | "a".."f"
-  NL               =  <US-ASCII NUL, null (0)>
-  LF               =  <US-ASCII LF,  linefeed (10)>
-  SP               =  <US-ASCII SP,  horizontal-tab (9)>
-
 
 Smart Service git-upload-pack
 ------------------------------
@@ -343,7 +335,7 @@ appear in the response obtained through ref discovery.
   compute_request  =  want_list
 		      have_list
 		      request_end
-  request_end      =  "0000" | "done"
+  request_end      =  "0000" / "done"
 
   want_list        =  PKT-LINE(want NUL cap_list LF)
 		      *(want_pkt)
@@ -353,7 +345,7 @@ appear in the response obtained through ref discovery.
 
   have_list        =  *PKT-LINE("have" SP id LF)
 
-  command          =  create | delete | update
+  command          =  create / delete / update
   create           =  40*"0" SP new_id SP name
   delete           =  old_id SP 40*"0" SP name
   update           =  old_id SP new_id SP name
@@ -530,7 +522,7 @@ the id obtained through ref discovery as old_id.
   command_pkt      =  PKT-LINE(command LF)
   cap_list         =  *(SP capability) SP
 
-  command          =  create | delete | update
+  command          =  create / delete / update
   create           =  40*"0" SP new_id SP name
   delete           =  old_id SP 40*"0" SP name
   update           =  old_id SP new_id SP name
-- 
1.8.4.rc4.527.g303b16c
