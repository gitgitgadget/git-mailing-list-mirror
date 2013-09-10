From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 12/14] reduce confusion over smart server response behaviour
Date: Wed, 11 Sep 2013 01:07:56 +0800
Message-ID: <1378832878-12811-13-git-send-email-rctay89@gmail.com>
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
 <1378832878-12811-10-git-send-email-rctay89@gmail.com>
 <1378832878-12811-11-git-send-email-rctay89@gmail.com>
 <1378832878-12811-12-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:09:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRR8-000483-DF
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578Ab3IJRI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:57 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:65153 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab3IJRIo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:44 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so8059646pad.9
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ZcrMT7QAhISQksQsz4nSfhZ7Q6jslz2RvwoBCJqruA=;
        b=xrDKZWWcpmGOVkwy4ADaEU9TdYmAdwuqNXbUzaeT4684iqGLEZ6YTUKeaVIF4mQEgv
         MGZNzNvTL91zu1ZTGz2BndNaGTuMAozR3qZxK8wW/bIazd9SHqCeYmTivCAfnP42OlQx
         dg7slUvp0XHMniD0tmDCuUy7kDG+joblG45BuZcGLKM2oh19XJ+H6CBbx4dcvd85xPSp
         E7VPuROnc2NkD1aE/YehliNsEhTlRH9gyB1F/5OPPnFmM88QgWjFykdIQUde9mRrV9TR
         c1/tvpocPs8xSF488IBYQgSBrJha8DSI3yBK9MfQlCphUmm6YOf7bJFf1Q+eIZIsEVEk
         8B8w==
X-Received: by 10.66.250.47 with SMTP id yz15mr10640219pac.154.1378832924332;
        Tue, 10 Sep 2013 10:08:44 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-12-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234459>

The MUST and the following 'If' scenario may seem contradictory at first
glance; swap their order to alleviate this.

Also mention that the response should specifically be for the requested
service, for clarity's sake.

Based on:

  From:   Junio C Hamano <gitster@pobox.com>
  Message-ID: <7vskdss3ei.fsf@alter.siamese.dyndns.org>

  > +Smart Server Response
  > +^^^^^^^^^^^^^^^^^^^^^
  > +
  > +Smart servers MUST respond with the smart server reply format.
  > +If the server does not recognize the requested service name, or the
  > +requested service name has been disabled by the server administrator,
  > +the server MUST respond with the '403 Forbidden' HTTP status code.

  This is a bit confusing.

  If you as a server administrator want to disable the smart upload-pack for
  one repository (but not for other repositories), you would not be able to
  force smart clients to fall back to the dumb protocol by giving "403" for
  that repository.

  Maybe in 2 years somebody smarter than us will have invented a more
  efficient git-upload-pack-2 service, which is the only fetch protocol his
  server supports other than dumb.  If your v1 smart client asks for the
  original git-upload-pack service and gets a "403", you won't be able to
  fall back to "dumb".

  The solution for such cases likely is to pretend as if you are a dumb
  server for the smart request.  That unfortunately means that the first
  sentence is misleading, and the second sentence is also an inappropriate
  advice.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/technical/http-protocol.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 4bb1614..63a089a 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -234,12 +234,13 @@ description of the dumb server response.
 
 Smart Server Response
 ^^^^^^^^^^^^^^^^^^^^^
-Smart servers MUST respond with the smart server reply format.
-
 If the server does not recognize the requested service name, or the
 requested service name has been disabled by the server administrator,
 the server MUST respond with the '403 Forbidden' HTTP status code.
 
+Otherwise, smart servers MUST respond with the smart server reply
+format for the requested service name.
+
 Cache-Control headers SHOULD be used to disable caching of the
 returned entity.
 
-- 
1.8.4.rc4.527.g303b16c
