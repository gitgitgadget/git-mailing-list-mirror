From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 19/19] untracked-cache: config option
Date: Fri, 29 Apr 2016 21:02:13 -0400
Message-ID: <1461978133-13966-20-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJE-00082g-Ot
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbcD3BCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:02:55 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36753 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbcD3BCr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:47 -0400
Received: by mail-qg0-f42.google.com with SMTP id d90so49655406qgd.3
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0rQD4/mpzZ/RnTnkSvGtEdwmaQsXbG0TQMjNSwXUXqY=;
        b=pKBy87jdqTcLjk3b+FN1MuHCZNcsVWGpWlAOmPyKmaXMnaFiXS/J68Zcrx7GGcLZfL
         6lkebEM7vWeAAGwHEmoMdztmwiCwYvxnldl3kD+6SZPb0KRB8uKWluwX6sKev1kffzWS
         pItXQKee//jevG9lUvMa+KrhosQm6Mbbaa6NBtpuBz3YjUl10csxMBlKzuU+wu6EUcAW
         1YXXFVgr1aMYEnLlaoBTMXbOeQJ3YLw00CGUsfu1QDptZn4UEmqSne2/K8UqO4yCOZKl
         QjkOoJG+raKaDFhcqIDgXOse4oCIjUEjtItjrw2Wf5bQcxt3tviM+tCmgyI9BUDv5w1k
         2dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0rQD4/mpzZ/RnTnkSvGtEdwmaQsXbG0TQMjNSwXUXqY=;
        b=PAeZGl98Gq9V+VvWNQU4+fS6cc826YNsl0cEwjxJ/1oCMaTP1SrR/rpEYk8D5YuUtk
         vGjsgurVvnvbuyKDCKRLYv37X6FsG3G7hx/Nef8zTV43LK2IVbwY8j9SvHDHbKqchG3Q
         nYBaE9oz+l360JqWT0rhbF+DjJcRy1+CsTKBAjpSbG5VAW62C7ktdG4T+EkGV/bjFkeH
         OKYYZ882xR1Y2/2jHPd3fIoXu+2PMbd97Zcvgofsso42BBrUeHcdI7pqPiYOexpFduJW
         u6nFNeWDY5Pg7me6yR59HqIc9VxVkM+Bv1Ova+sTTmOx1XR1BQ1fec9rdZGXvX/Ia6pr
         FDxA==
X-Gm-Message-State: AOPr4FWWX0stNpoMB9kwkP6mggjCPyTyQIBekua9QqF4kOu5MxkaQm39gzwrwe5U6DrC8Q==
X-Received: by 10.140.91.194 with SMTP id z60mr21500544qgd.70.1461978165798;
        Fri, 29 Apr 2016 18:02:45 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293111>

Add a config option to populate the untracked cache.

For installations that have centrally-managed configuration, it's
easier to set a config once than to run update-index on every
repository.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/config.txt | 4 ++++
 read-cache.c             | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 385ea66..c7b76ef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1848,6 +1848,10 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
+index.adduntrackedcache::
+	Automatically populate the untracked cache whenever the index
+	is written.
+
 index.addwatchmanextension::
 	Automatically add the watchman extension to the index whenever
 	it is written.
diff --git a/read-cache.c b/read-cache.c
index 1bbac86..2e70976 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2468,7 +2468,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
-	int watchman = 0;
+	int watchman = 0, untracked = 0;
 	uint64_t start = getnanotime();
 
 	for (i = removed = extended = 0; i < entries; i++) {
@@ -2498,6 +2498,11 @@ static int do_write_index(struct index_state *istate, int newfd,
 	    !the_index.last_update)
 		the_index.last_update = xstrdup("");
 
+	if (!git_config_get_bool("index.adduntrackedcache", &untracked) &&
+	    untracked &&
+	    !istate->untracked)
+	    add_untracked_cache(&the_index);
+
 	hdr_version = istate->version;
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
-- 
2.4.2.767.g62658d5-twtrsrc
