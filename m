From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 19/20] transport-helper: Use capname for gitdir capability too
Date: Sun, 19 Jun 2011 17:18:44 +0200
Message-ID: <1308496725-22329-20-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJna-00042G-AI
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481Ab1FSPUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:17 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44389 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab1FSPUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:20:13 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981213ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=UloYZNqoCf22EWmhaDLKKWPvUVZA3JkTTTikmMt/eJs=;
        b=jMfcZGGqpPzqxQ5MdbfHuLAYIImDv7unrCbMvYbYaTa4avGWdagZ9LDkgXWjn+7/Eu
         e4CEe1XvpJAmupdeAhsOiaAhHJaY9QqLDV+Mjx5wOzRR9qGvj/xs5N2mFUidkO9Re6eH
         W3fonGIsnsyP5YwydQb6yMbsWcgEGlE9yhsKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pZYn/vdP9R84GkFGC15uS7CJluXVAxUF7rEYg3PT1/yYii7zUdBso0jbKl4EwHEvJa
         hwzKvQsPY/KO4/2WfUVLJMmKpmgHRk1/U3eInYAd0fKndHZA89ZkrgUufTapV3Sx3D73
         C52AvWM0eozGk3V7jDqKnIBjmf8bT7HEyk0UE=
Received: by 10.213.14.7 with SMTP id e7mr402027eba.29.1308496813066;
        Sun, 19 Jun 2011 08:20:13 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.20.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:20:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176020>

Also properly use capname in the refspec capability.

Previously the gitdir and refspec capabilities could not be listed as
required or their parsing would break.

Most likely the reason the second hunk wasn't caught is because the
series that added 'gitdir' as capability, and the one that added
required capabilities were done in parallel.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Updated commit message.

 transport-helper.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index f78b670..ddf0ffa 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -171,10 +171,10 @@ static struct child_process *get_helper(struct transport *transport)
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
-			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
+			refspecs[refspec_nr++] = strdup(capname + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
-		} else if (!strcmp(buf.buf, "gitdir")) {
+		} else if (!strcmp(capname, "gitdir")) {
 			struct strbuf gitdir = STRBUF_INIT;
 			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
 			sendline(data, &gitdir);
-- 
1.7.5.1.292.g728120
