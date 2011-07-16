From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 21/23] transport-helper: die early on encountering deleted refs
Date: Sat, 16 Jul 2011 15:03:41 +0200
Message-ID: <1310821424-4750-22-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4YZ-0005RE-4H
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab1GPNFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:05:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45883 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab1GPNFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:05:05 -0400
Received: by ewy4 with SMTP id 4so996213ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gtlzw1BYr+n+t/5FI9SbvfnKH3Yf88G9ydHFNebMNDw=;
        b=Ev1SVP81XD/FJd2XIYGYJEiKSL/4Osngipi+Os8JkVx15Dui21JaEBKIJJ65twWJSQ
         VM6fBYB0szhM+l5OFt2F/kdokLbsO2lCJ6pLbsVUD1mWXTuzBeQV0pKTKz0esFnwM0T/
         6HPYBXvZf0QxbnYoN1ALZMMr+uBtJwUSaUYJA=
Received: by 10.14.29.11 with SMTP id h11mr1590878eea.45.1310821504666;
        Sat, 16 Jul 2011 06:05:04 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.05.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:05:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177268>

Remote helpers do not support deleting refs by means of the 'export'
command sincethe fast-import protocol does not support it.

Check explicitly for deleted refs and die early.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  New in this series.

 transport-helper.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 74c3122..4eab844 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -746,6 +746,10 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
+		if (ref->deletion) {
+			die("remote-helpers do not support ref deletion");
+		}
+
 		if (ref->peer_ref)
 			string_list_append(&revlist_args, ref->peer_ref->name);
 
-- 
1.7.5.1.292.g728120
