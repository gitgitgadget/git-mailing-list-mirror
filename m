From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 09/14] reduce ambiguity over '?' in $GIT_URL for dumb clients
Date: Wed, 11 Sep 2013 01:07:53 +0800
Message-ID: <1378832878-12811-10-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
 <1378832878-12811-4-git-send-email-rctay89@gmail.com>
 <1378832878-12811-5-git-send-email-rctay89@gmail.com>
 <1378832878-12811-6-git-send-email-rctay89@gmail.com>
 <1378832878-12811-7-git-send-email-rctay89@gmail.com>
 <1378832878-12811-8-git-send-email-rctay89@gmail.com>
 <1378832878-12811-9-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:08:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQp-0003Wj-U8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab3IJRIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:41 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:45287 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab3IJRIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:39 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so7865930pbc.32
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bL6t/8sd6A3uTjAA0/iCFDBi/0CSZNTxwEZq+Hle7so=;
        b=Nr3O7HsV602+TJKSZBfk1uMJCIUNF+p9GtGNCW/ogGuEMiQD8rjkJoRlG59dE+ndUa
         Pu7HBtaD1TyYC/fbAHXHeeM48uugh+BKUFItcu6U/aV0vqw4QxJR1kdTadGZx0QKBtWt
         N2S/T+OfqC27KG0GcKwWnvN9HhkXVy6dOo3saS0Osfpd2/4jwPtdLQ8h6oM49cbS0gi/
         EvPScYRonZyzl3hHmHy9DMKwWLr5QIWFvbLDYaZz03qs93R+EjUEcwquEvfb5MV3x/Ao
         whzTdlZuElaruVfievBh6E8o7c4w7dj2glQwNJVV+Lj1xo/26mnL9mQuzmiWhZZnnEjR
         Hh3Q==
X-Received: by 10.66.150.232 with SMTP id ul8mr27958141pab.26.1378832918561;
        Tue, 10 Sep 2013 10:08:38 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-9-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234453>

From: Junio C Hamano <gitster@pobox.com>

It is unclear if '?' can be part of $GIT_URL. E.g.

    $ wget http://example.xz/serve.cgi?path=git.git/info/refs
    $ git clone http://example.xz/serve.cgi?path=git.git

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
--

Notes:
 - said "request to" instead of Junio's "request against", for
   consistency with the rest of the document.
 - said "E.g." instead of "I.e." since it's an example request and
   response

Based on:

  From:   Junio C Hamano <gitster@pobox.com>
  Message-ID: <7vskdss3ei.fsf@alter.siamese.dyndns.org>

  > +Dumb Clients
  > +~~~~~~~~~~~~
  > +
  > +HTTP clients that only support the "dumb" protocol MUST discover
  > +references by making a request for the special info/refs file of
  > +the repository.
  > +
  > +Dumb HTTP clients MUST NOT include search/query parameters when
  > +fetching the info/refs file.  (That is, '?' must not appear in the
  > +requested URL.)

  It is unclear if '?' can be part of $GIT_URL. E.g.

      $ wget http://example.xz/serve.cgi?path=git.git/info/refs
      $ git clone http://example.xz/serve.cgi?path=git.git

  It might be clearer to just say

      Dumb HTTP clients MUST make a GET request against $GIT_URL/info/refs,
      without any search/query parameters.  I.e.

          C: GET $GIT_URL/info/refs HTTP/1.0

  to also exclude methods other than GET.
---
 Documentation/technical/http-protocol.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index d0955c2..5141c6a 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -150,9 +150,8 @@ HTTP clients that only support the "dumb" protocol MUST discover
 references by making a request for the special info/refs file of
 the repository.
 
-Dumb HTTP clients MUST NOT include search/query parameters when
-fetching the info/refs file.  (That is, '?' MUST NOT appear in the
-requested URL.)
+Dumb HTTP clients MUST make a GET request to $GIT_URL/info/refs,
+without any search/query parameters.  E.g.
 
    C: GET $GIT_URL/info/refs HTTP/1.0
 
-- 
1.8.4.rc4.527.g303b16c
