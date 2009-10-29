From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 04/19] Add a config option for remotes to specify a foreign vcs
Date: Thu, 29 Oct 2009 11:01:12 -0700
Message-ID: <1256839287-19016-5-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:03:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKj-0004ac-F0
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbZJ2SCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbZJ2SCT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:19 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:48301 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbZJ2SCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:17 -0400
Received: by pwj9 with SMTP id 9so194495pwj.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dbuniuwROWIDXCADYYAEjRqQAHaerRlc+u9WawqWMJY=;
        b=GfZoREfXxvAtJW09Tsfd5dY9jydVhXmzl9R6O2rejEGj+H1+nycnXNQ8JKGCtlAtNz
         ny8Rqw3+F9QWxCeih4Ij53SWqE0lkEdtOFtmbUm21/2lWThH3+xIaFqZfnob1gJTdusC
         zyRtlMmbDWlcWubQXF+oYPdDpexp/Lfz44APQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xWCwiPFXKCSKpBwnDSvcW89nGmWwW590vZobZA1YAO9hO+czM+/E3Ay+EjLG8tIAxW
         dS+uc8CwJroFzfr1DPxsoL5Q1AgrOFEsq3EEYabfSiNCzT28BLvHsyTPBnUbR2k9vsrL
         88lDoBdual1bhFNRPYDyUaq9+q3C6tBtL47aM=
Received: by 10.114.86.11 with SMTP id j11mr272400wab.73.1256839340858;
        Thu, 29 Oct 2009 11:02:20 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131631>

From: Daniel Barkalow <barkalow@iabervon.org>

If this is set, the url is not required, and the transport always uses
a helper named "git-remote-<value>".

It is a separate configuration option in order to allow a sensible
configuration for foreign systems which either have no meaningful urls
for repositories or which require urls that do not specify the system
used by the repository at that location. However, this only affects
how the name of the helper is determined, not anything about the
interaction with the helper, and the contruction is such that, if the
foreign scm does happen to use a co-named url method, a url with that
method may be used directly.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	This has my patch to fix valid_remote to allow for both url
	vcs squashed in.

 Documentation/config.txt |    4 ++++
 remote.c                 |    4 +++-
 remote.h                 |    2 ++
 transport.c              |    5 +++++
 4 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1e2120..0d9d369 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1408,6 +1408,10 @@ remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>
 
+remote.<name>.vcs::
+	Setting this to a value <vcs> will cause git to interact with
+	the remote with the git-remote-<vcs> helper.
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/remote.c b/remote.c
index 15c9cec..09bb79c 100644
--- a/remote.c
+++ b/remote.c
@@ -54,7 +54,7 @@ static char buffer[BUF_SIZE];
 
 static int valid_remote(const struct remote *remote)
 {
-	return !!remote->url;
+	return (!!remote->url) || (!!remote->foreign_vcs);
 }
 
 static const char *alias_url(const char *url, struct rewrites *r)
@@ -444,6 +444,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	} else if (!strcmp(subkey, ".proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
+	} else if (!strcmp(subkey, ".vcs")) {
+		return git_config_string(&remote->foreign_vcs, key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 5db8420..ac0ce2f 100644
--- a/remote.h
+++ b/remote.h
@@ -11,6 +11,8 @@ struct remote {
 	const char *name;
 	int origin;
 
+	const char *foreign_vcs;
+
 	const char **url;
 	int url_nr;
 	int url_alloc;
diff --git a/transport.c b/transport.c
index 5ae8db6..13bab4e 100644
--- a/transport.c
+++ b/transport.c
@@ -818,6 +818,11 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		url = remote->url[0];
 	ret->url = url;
 
+	if (remote && remote->foreign_vcs) {
+		transport_helper_init(ret, remote->foreign_vcs);
+		return ret;
+	}
+
 	if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
-- 
1.6.5.2.291.gf76a3
