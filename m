From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 08/16] transport: select transport version via command line or config
Date: Mon,  1 Jun 2015 17:02:10 -0700
Message-ID: <1433203338-27493-9-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfW-0000j9-Dx
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbbFBACw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:02:52 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35444 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbbFBACn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:43 -0400
Received: by igbyr2 with SMTP id yr2so74911195igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NyFKAQN7DHI6blXakYhgVeTWwqq6MM7lqVax3tl4Z08=;
        b=j1jXVqOmnn1KBehsFmGcrOqepQErHUk8yBYLEeimIw7+hQ7jzXLyTC1D1LUHg26XP0
         rDc+pln9aj7hNgDLSuVwBtQUg9SfDcN0frQVjmYkvfJWwO9v5nbUpJXCNdlfWBdJzx2t
         q2xFnzIUG/4x/ZZVT7PJrm0VsXmNNLnRVtppn2InJeFVFeYinvP7oxKuw03pozcX9QXq
         r94ZJu4P/lpAq07fMgA8Za8yRoXGBwfy6e2a+GLDNdXw/+x4UICFayMId+QAH0gJ1eyr
         92C5iaLaICYPfvgfiqTw4om7Nkjams9N/2gsVHAVKaQcDkPMg+YadTKHWQ10gaAhmPmL
         ysBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NyFKAQN7DHI6blXakYhgVeTWwqq6MM7lqVax3tl4Z08=;
        b=UbYg3IJeH5W90DUYxlO5HqDTUzbWtt9uGcN/1BIUqGlJivqBqJE6dy4RhCmkSnTMnK
         YQnxz8POUi+ykUfAFyGZupSmL7ya5X0oIPXuxbU08C/w6iQCrO0bIcF56TlcKijRhPL5
         IdvGjZ2pGVfyliQ7i3rjYZ+Lw+Zi6TbVWew+maeKJn1+HCJviK4hMHYPYc3GQ+Yiwjga
         sQk20o/PuVxpRN4fPKtd7NvNDZjb3aU3Y2pXXC2V0EFF6UxHMjdgNBrBzj+kK2RZCyGP
         HQ7n4B5H3KIp8lRu5mWU79SbBjSrb6I7EhARGm1jaYY6OwE46I3nolywcbn2uDAhqL4k
         iGUA==
X-Gm-Message-State: ALoCoQnIjQeH3i/Z9tLsAfzcPep68j/0iqNWxuHKVYq25DJQJd2gQpkuWrUmFtvrwSPPBj74vV3R
X-Received: by 10.107.31.134 with SMTP id f128mr12284472iof.19.1433203362577;
        Mon, 01 Jun 2015 17:02:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id j4sm8918084igo.0.2015.06.01.17.02.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270487>

The transport version set via command line argument in
git fetch takes precedence over the configured version.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    removed -y as the short --transport-version
    
    This patch has been split up and is the second part
    carrying only the exposure to the user.

 builtin/fetch.c | 6 ++++++
 remote.c        | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7910419..a558563 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -46,6 +46,7 @@ static const char *recurse_submodules_default;
 static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
+static const char *transport_version;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -121,6 +122,9 @@ static struct option builtin_fetch_options[] = {
 		   N_("default mode for recursion"), PARSE_OPT_HIDDEN },
 	OPT_BOOL(0, "update-shallow", &update_shallow,
 		 N_("accept refs that update .git/shallow")),
+	OPT_STRING(0, "transport-version", &transport_version,
+		   N_("transport-version"),
+		   N_("specify transport version to be used")),
 	{ OPTION_CALLBACK, 0, "refmap", NULL, N_("refmap"),
 	  N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg },
 	OPT_END()
@@ -848,6 +852,8 @@ static struct transport *prepare_transport(struct remote *remote)
 	struct transport *transport;
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
+	if (transport_version)
+		set_option(transport, TRANS_OPT_TRANSPORTVERSION, transport_version);
 	if (upload_pack)
 		set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/remote.c b/remote.c
index 68901b0..2914d9d 100644
--- a/remote.c
+++ b/remote.c
@@ -476,6 +476,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 					 key, value);
 	} else if (!strcmp(subkey, ".vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
+	} else if (!strcmp(subkey, ".transportversion")) {
+		remote->transport_version = git_config_int(key, value);
 	}
 	return 0;
 }
-- 
2.4.1.345.gab207b6.dirty
