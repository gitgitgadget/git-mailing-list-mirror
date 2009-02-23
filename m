From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 05/13] remote: name remote_refs consistently
Date: Mon, 23 Feb 2009 01:28:53 -0500
Message-ID: <81ae3692383f006b730c0f5fa35842149c2da4b2.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULN-00072Y-AX
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbZBWG31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbZBWG3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:25 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:51890 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZBWG3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:17 -0500
Received: by an-out-0708.google.com with SMTP id c2so770366anc.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HXGcBTo27/K8YK2/p3c/xTjdOIIEUWrE3PQXFZ7eUec=;
        b=vpnSu2URllAfWkDpDu3gxlekrHzmwcf5emwsIbzOtg7pRmoNoMcNDiPcF+sn/fSA8c
         ugWQDwT8cc/XsIx7h1oGpAuvJAxSji8DkWkP0rJiFNQ5y/jFnTa1IOaPNtJdJt9hvnLP
         oPkyGwU/OO4F7HaQfx2WRLpmlXr9hWS3iVGBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Bj3xxYEZIiHCHozbGtQ/0FHt0jNsSahkT7X4lC3IWAvoLyE75VfXYJFLhVkAB/cN+/
         2jyLvVeoSq1zWtYadeBWe5DxOfvrHptEAObC9NCe01ss+OnUG95TlV3ZZD/Dud8S2a5l
         OT0M2hq3x1Qvu9FFIuHnlZdB89KHZDjwsEsrY=
Received: by 10.100.122.8 with SMTP id u8mr3509669anc.131.1235370556187;
        Sun, 22 Feb 2009 22:29:16 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d38sm12090348and.29.2009.02.22.22.29.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:15 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111095>

Clarify the code a bit by consistently referring to the remote refs
returned by transport_get_remote_refs() as remote_refs.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index b61f754..df6b525 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -236,13 +236,14 @@ static int handle_one_branch(const char *refname,
 	return 0;
 }
 
-static int get_ref_states(const struct ref *ref, struct ref_states *states)
+static int get_ref_states(const struct ref *remote_refs, struct ref_states *states)
 {
 	struct ref *fetch_map = NULL, **tail = &fetch_map;
+	struct ref *ref;
 	int i;
 
 	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
-		if (get_fetch_map(ref, states->remote->fetch + i, &tail, 1))
+		if (get_fetch_map(remote_refs, states->remote->fetch + i, &tail, 1))
 			die("Could not get fetch map for refspec %s",
 				states->remote->fetch_refspec[i]);
 
@@ -264,7 +265,7 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 	return 0;
 }
 
-static int get_head_names(const struct ref *refs,
+static int get_head_names(const struct ref *remote_refs,
 	const char *remote_name, struct ref_states *states)
 {
 	struct ref *ref, *matches;
@@ -275,9 +276,9 @@ static int get_head_names(const struct ref *refs,
 	refspec.pattern = 1;
 	refspec.src = refspec.dst = "refs/heads/";
 	states->heads.strdup_strings = 1;
-	get_fetch_map(refs, &refspec, &fetch_map_tail, 0);
-	matches = guess_remote_head(find_ref_by_name(refs, "HEAD"),
-					fetch_map, 1);
+	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
+	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
+				    fetch_map, 1);
 	for(ref = matches; ref; ref = ref->next)
 		string_list_append(abbrev_branch(ref->name), &states->heads);
 
@@ -678,7 +679,7 @@ static int get_remote_ref_states(const char *name,
 				 int query)
 {
 	struct transport *transport;
-	const struct ref *ref;
+	const struct ref *remote_refs;
 
 	states->remote = remote_get(name);
 	if (!states->remote)
@@ -689,11 +690,10 @@ static int get_remote_ref_states(const char *name,
 	if (query) {
 		transport = transport_get(NULL, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
-		ref = transport_get_remote_refs(transport);
+		remote_refs = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
-
-		get_head_names(ref, name, states);
-		get_ref_states(ref, states);
+		get_head_names(remote_refs, name, states);
+		get_ref_states(remote_refs, states);
 	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
 		sort_string_list(&states->tracked);
-- 
1.6.2.rc1.223.gfed32
