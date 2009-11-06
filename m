From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 10/12] Allow helpers to request the path to the .git directory
Date: Fri,  6 Nov 2009 23:52:44 +0100
Message-ID: <1257547966-14603-11-git-send-email-srabbelier@gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-5-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-10-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Xgq-000813-57
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbZKFWxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbZKFWxo
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:53:44 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:9359 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442AbZKFWxl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:41 -0500
Received: by ey-out-2122.google.com with SMTP id 25so372974eya.19
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7p9q3oH0rbpyVHdRv9BhCLJMDGoukPODd4bpr/X6KRY=;
        b=AL7eXbk1bc7kUG0IRktLVjA/z+8qoQXHw9vH8Ff+10SHZLhiOOygqyOTjfEkSadaxd
         3oSDQL8I71WOb/Q7z3N/ZBPykRaVyLG/LGIuRlNudte96zbJ4o4SpSji2Tt41NyvEfPi
         1yf5V1fno/bXdF3NFgFsjijDMqUHigsa2yVNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CpwJGcYe/ED6tzvqZtOGD8CD6zK4JcXWf4o9suEVQCqO2gTncIq72uCsDH8L7/s2qr
         vZYp50fnTqNgtxKvHHPhjHWW6qmzvsi2zWQSc7pVSt8WTwsKNClfO2WXgHm0tOWFZw48
         U+xCpHfDgQPp3r/KHTYBODMHldCalvmJU7MLI=
Received: by 10.213.23.75 with SMTP id q11mr1704ebb.74.1257548026046;
        Fri, 06 Nov 2009 14:53:46 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:45 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
In-Reply-To: <1257547966-14603-10-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132334>

The 'gitdir' capability is reported by the remote helper if it
requires the location of the .git directory. The location of the .git
directory can then be used by the helper to store status files even
when the current directory is not a git repository (such as is the
case when cloning).

The location of the .git dir is specified as an absolute path.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Rebased, but otherwise unchanged.
	Needs to be updated when we decide on a proper location for
	the helper specific info.

 transport-helper.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index d38dedf..7ea76fd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -64,6 +64,12 @@ static struct child_process *get_helper(struct transport *transport)
 				   refspec_alloc);
 			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
 		}
+		if (!strcmp(buf.buf, "gitdir")) {
+			struct strbuf gitdir = STRBUF_INIT;
+			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
+			write_in_full(helper->in, gitdir.buf, gitdir.len);
+			strbuf_reset(&gitdir);
+		}
 	}
 	if (refspecs) {
 		data->refspec_nr = refspec_nr;
-- 
1.6.5.2.158.g6dacb
