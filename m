From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 19/19] untracked-cache: config option
Date: Wed, 27 Apr 2016 16:04:41 -0400
Message-ID: <1461787481-877-20-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:06:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVj4-0003YM-8M
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbcD0UFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:05:35 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36182 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbcD0UFc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:32 -0400
Received: by mail-qg0-f50.google.com with SMTP id d90so21817573qgd.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xYOGgiaAwgEEEVdco/dOaxJQEfDSeelQdooF5pIOsQU=;
        b=xGB/fri/fZ/CqEhWp4gHxEHcF0yvpDDdKMVDB+0NZoJ0W4mWup1oeE0yuCEw+LeIEU
         FRfPltMjy8XMZtVwswuaKWEQMCT+gp8lLwdk5AeDBctPazOjAEdfj19kNIvmG/61l+1y
         QYJVFsLEruuF1p+4aZt1praBxk5mZxxdCcl3sEljfD09YRe4+yLNXiNlQ9Z3yAiyW64+
         jVMYMAkLjCK6/I5OHRC5wmzBuDMhalqM6treNUup63t6Ue4vAL+Lfe0+/3EgQacftGyT
         +a1nrPAL4adjo4m9UKBJrJR+t1wvBlSiUxBjkAHr4unkD8CnKpcpT46L9K5SgAWq93en
         Je9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xYOGgiaAwgEEEVdco/dOaxJQEfDSeelQdooF5pIOsQU=;
        b=VfGyWYTMT8iWgdw1aKKEzol92FMExxlowHlgrv9ZmUYH+20FTM71jgm1hz8BhvDsKn
         WmjlmrAPAUf3kFRi8+IvGikngQJi0obu7RgqQU40yFgVHiDYJKxjX1v49c3d1PxJlWsb
         saypLeHcNe8+I5dXdy0UZD0j4Pxx1zkiKOg+gQGHc264POXFNgkB6s0Z0KZCaKgCfuom
         QBM6XAbRuyou9MMgbP1YVP/w5zIF2czq1OU5YD9zfuBWTu3DMKL31VvwTfDzl8UYCDb9
         zlLZxdlC7/47vpONSyRahY1v0IQNgYqeCOko4Vep1raTdS4kxzkjoAwSqFgjzN+0Vrul
         j5zQ==
X-Gm-Message-State: AOPr4FUQ5NeZkMicETgnyJui3yXeb5oE70jLHla2d5nyCdysANCashAg0GcnEaQHghoZcQ==
X-Received: by 10.140.151.206 with SMTP id 197mr2764579qhx.4.1461787531786;
        Wed, 27 Apr 2016 13:05:31 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292797>

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
index e56a644..40869fe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2469,7 +2469,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
-	int watchman = 0;
+	int watchman = 0, untracked = 0;
 	uint64_t start = getnanotime();
 
 	for (i = removed = extended = 0; i < entries; i++) {
@@ -2499,6 +2499,11 @@ static int do_write_index(struct index_state *istate, int newfd,
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
