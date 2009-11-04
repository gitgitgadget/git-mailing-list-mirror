From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 05/13] Add a config option for remotes to specify a foreign vcs
Date: Wed,  4 Nov 2009 20:48:10 +0100
Message-ID: <1257364098-1685-6-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrf-0000NL-TM
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758085AbZKDTtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758083AbZKDTtI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:08 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55343 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758075AbZKDTtG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:06 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490482ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=s5+Y2Z7DZfBaGsfPslaW+w7xZXC+tIuokGxRw9sb0cc=;
        b=LvNKLhL35BoIjBIurgSDZcdK931aeR8s/7+8IVMQCbGG93vOEL/m+OOfmXs6zTypDz
         beoWL/SbNQZ1jKj+uNObxIHj4OBm0xjT6ahhr/H3FrYAEzbUCO70twzOYO/cpqzUA99D
         U1o0NLUC9eg8YIkYfbc0zqd/bGzwznFiyXs0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wl04RAsJua7V9Du3UlEsOX14l64kk8V0/bKWiLtLQh7mg5NzB7UXsKJacTC2CfvK4Q
         RgdWOSH4UJsjpt+svDKglmys6Iy2KC8b0RRHQbniTb8oUgcMZwvX9KXJth3IN1XRtEtb
         K1ohEU/4E2sjj6XIeHNys71Q/Am84c0OMnxF4=
Received: by 10.213.23.146 with SMTP id r18mr2187774ebb.74.1257364151940;
        Wed, 04 Nov 2009 11:49:11 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:11 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132129>

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

	Unchanged.

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
1.6.5.2.295.g0d105
