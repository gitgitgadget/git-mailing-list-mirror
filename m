From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] show-index: uniform error messages for index read
Date: Mon,  1 Jun 2015 15:50:04 +0200
Message-ID: <b87777a4de06a56472f2d23ab8bbce9a332bb2d7.1433166363.git.git@drmicha.warpmail.net>
References: <cover.1433166363.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 15:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzQ6e-0003N3-9r
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 15:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbbFANuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 09:50:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41883 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752967AbbFANuL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 09:50:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 90F5E3808E0
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 09:50:10 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 01 Jun 2015 09:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=Tl77Oq6qelOMArJ1XiJOFkbaCk0
	=; b=juqMP6MfjLSE9JmvNj4zEWorz7r3p3CoHhPTFNt8ljsb9bJnaR9qKuBpHM+
	MMYabtcf4jsHEbL+i2f2ZKynv1GQP3Pio/Jap5R68HSnniSB3LvjLN/PCfvFexC/
	rBiVGtSjiR+3bA/en0b0dMrPe0b7ZomvzJz+JXfq5hkdnGqw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Tl77
	Oq6qelOMArJ1XiJOFkbaCk0=; b=Dyf2J6RsmDJMZ9wd4Ydta+wifeM4dIsJ5szc
	0yzUn48hDZxS+IRlo/Csge3q8Xx7lDyC/a5iRP5/V3mZk960CJHmOzC6rEtM9pMl
	h9rKjufc+O4IBEEngQFnSK0UoZHsoauIKI5qPJQFz4eVL0yavooljZkafrFvBiR1
	pK+IDG4=
X-Sasl-enc: 3KrdcTXfjnsSiJ8HccKIsXskYg/yQjjmoX5HOamqqMrw 1433166610
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 04146C0002F;
	Mon,  1 Jun 2015 09:50:09 -0400 (EDT)
X-Mailer: git-send-email 2.4.2.548.g1e81565
In-Reply-To: <cover.1433166363.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270411>

Currently, we have different wordings for the same index read error
message, which may be confusing to users and increase3s the risk of more
severely different translated messages:

builtin/apply.c:			die(_("unable to read index file"));
show-index.c:			die("unable to read index");
show-index.c:			die("unable to read index");
test-dump-cache-tree.c:		die("unable to read index file");
test-dump-untracked-cache.c:		die("unable to read index file");
test-scrap-cache-tree.c:		die("unable to read index file");
builtin/commit.c:			die(_("Cannot read index"));
rerere.c:		return error("Could not read index");
rerere.c:		return error("Could not read index");
rerere.c:		return error("Could not read index");

Turn all of them into "unable to read index file" except for the rerere
messages: They appear on a higher level (index file access + parsing)
and are worded similarly to other rerere messages.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/commit.c | 2 +-
 show-index.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 254477f..04d49d5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -878,7 +878,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		const char *parent = "HEAD";
 
 		if (!active_nr && read_cache() < 0)
-			die(_("Cannot read index"));
+			die(_("unable to read index file"));
 
 		if (amend)
 			parent = "HEAD^1";
diff --git a/show-index.c b/show-index.c
index 5a9eed7..e7797d0 100644
--- a/show-index.c
+++ b/show-index.c
@@ -22,11 +22,11 @@ int main(int argc, char **argv)
 		if (version < 2 || version > 2)
 			die("unknown index version");
 		if (fread(top_index, 256 * 4, 1, stdin) != 1)
-			die("unable to read index");
+			die("unable to read index file");
 	} else {
 		version = 1;
 		if (fread(&top_index[2], 254 * 4, 1, stdin) != 1)
-			die("unable to read index");
+			die("unable to read index file");
 	}
 	nr = 0;
 	for (i = 0; i < 256; i++) {
-- 
2.4.2.548.g1e81565
