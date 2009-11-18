From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 05/12] Add a config option for remotes to specify a foreign vcs
Date: Wed, 18 Nov 2009 02:42:25 +0100
Message-ID: <1258508552-20752-6-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZap-0000vW-Kl
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbZKRBne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756831AbZKRBnd
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:33 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:17370 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407AbZKRBn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:29 -0500
Received: by ey-out-2122.google.com with SMTP id 25so5797eya.19
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=opEAb8DZboMPdNOT052ggsK34RZVRYb9dG20y7qAPT8=;
        b=am6bZ32Dc90HHdZf2R2i8hdE7NclNktAKafowZC0jxEBcwHGdS+vPsBdol95m8/4MJ
         qWxKDJXYxninEmE1741byE8hvEexWM+R4Go0u1U9YpgP82fdfMgXw454UgAgMlIdDVe+
         zYuY+JsZAUaxuHXnuJHguZ6MFdtfHOSBkMETw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uFxXAMsGxMdEGQr3zJFhA5OjVyq2i/Eyu67juYk71zLrY0k9+l8DOG7qvyNBWjz8Q2
         tH45S5GFJPWvU6V/EWAFnmDW3c3phchWIs7k5lwlvKeR1rGNDtowGoqjxTKJppifKmc7
         3Mw7KoFSmoDvtKP9sjCHsFUABlxM8BmfQIY/w=
Received: by 10.213.96.65 with SMTP id g1mr153819ebn.44.1258508614943;
        Tue, 17 Nov 2009 17:43:34 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:34 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133128>

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
index cb73d75..dd57a8d 100644
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
index e882991..aa90648 100644
--- a/transport.c
+++ b/transport.c
@@ -821,6 +821,11 @@ struct transport *transport_get(struct remote *remote, const char *url)
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
1.6.5.3.164.g07b0c
