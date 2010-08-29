From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 08/13] transport-helper: export should disconnect too
Date: Sat, 28 Aug 2010 22:45:35 -0500
Message-ID: <1283053540-27042-9-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:47:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYrO-0006pV-2N
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab0H2Dqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab0H2Dqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:45 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IrYkgHwPQ90VfNszW0rShVXvg2oBpHC0h7s1J6lZSbI=;
        b=fnAvEEFEK+smWbrPWWrF622XAx21nhjba1P4Dv657PW2+1ipFGhstj1SCMF8XZHZZJ
         aYeG8IMLDpkGlZG90u+gdsv00pMHa3L2vbOOuLPHLWCdIsyCJoIzYa0+p/3hqNhfYE+/
         E98Fdej3RV4ZmCuIjS5DndPnR563BLBmcphJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=odBUrR8QmPzpgVxNPevwmJx8qijclpbQoE+6NmXiB+gC2t5T+kr787r6GJnjFAIqvq
         +UaNSZpSzaLM7fEoIy+h+Z6XUP7yXsgsBcNaZZEIPhOahETb2sVqVGFeBL51dGa2Fx0I
         pWvy9siy3DSPRMYhZnOdp7/MPlj2Q2LDzvyEM=
Received: by 10.231.32.140 with SMTP id c12mr3272347ibd.90.1283053605300;
        Sat, 28 Aug 2010 20:46:45 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154679>

Now that the remote helper protocol uses the new done command in its
fast-import streams, export no longer needs to be the last command in
the stream.
---

  The fact that we had this before shows how messed up the protocol
  was earlier. Basically, any 'import' or 'export' command meant
  "you're done talking to the helper now".

 transport-helper.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 13ebb3b..1294d10 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -758,7 +758,6 @@ static int push_refs_with_export(struct transport *transport,
 			 export_marks, import_marks, &revlist_args))
 		die("Couldn't run fast-export");
 
-	data->no_disconnect_req = 1;
 	if(finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs);
-- 
1.7.2.1.240.g6a95c3
