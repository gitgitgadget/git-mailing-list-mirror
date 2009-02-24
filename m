From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 12/23] builtin-remote: name remote_refs consistently
Date: Tue, 24 Feb 2009 04:51:00 -0500
Message-ID: <713e5cc2722a0eacd5b14146b01bb5d455870474.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzz-0002Ej-Ad
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbZBXJvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbZBXJvx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:53 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:17431 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbZBXJvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:46 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1006856ywh.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NWRR/PQmmwRooUwjMKPUXOO8hKGtdTHy7Ft06L48wcA=;
        b=k7qcQdswcxpYwvRdSNZC/mNB2vogA/cyBfny5HA1BPF6Wh7cR5OjlN998L8W/pG5c6
         fW4tKTsvXeW+PXbUSlc2LvEiC8gjdNdasfASaD/u8tzo5P+550mwVJtKzgK0VS+dfHDF
         GliHQz+3lCsRhQoCwwNzFm2GmSpc6lQpapjwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LJ3/7eCznErUxc6ac3uKvXvlFKTg/OAyh0KMTEmleOa/p7DKB1XVak/F7l1M1M4SWh
         KOAOvcCPVcB/E3dsGJIBUgXuMml2Fg9rDpv2TzRFKtFM5jxh4+0yYh/VaqhT+B5hqK5E
         vYRnhhHSBKKw+9D48XilARQXE7+1uRHr28MrU=
Received: by 10.100.140.15 with SMTP id n15mr5519519and.17.1235469104010;
        Tue, 24 Feb 2009 01:51:44 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c23sm9772660ana.12.2009.02.24.01.51.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:42 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111258>

Clarify the code a bit by consistently referring to the remote refs
returned by transport_get_remote_refs() as remote_refs.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 48d668e..d5c808c 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -238,13 +238,14 @@ static int handle_one_branch(const char *refname,
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
 
@@ -271,7 +272,7 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 	return 0;
 }
 
-static int get_head_names(const struct ref *refs,
+static int get_head_names(const struct ref *remote_refs,
 	const char *remote_name, struct ref_states *states)
 {
 	struct ref *ref, *matches = NULL;
@@ -282,8 +283,8 @@ static int get_head_names(const struct ref *refs,
 	refspec.pattern = 1;
 	refspec.src = refspec.dst = "refs/heads/";
 	states->heads.strdup_strings = 1;
-	get_fetch_map(refs, &refspec, &fetch_map_tail, 0);
-	guess_remote_head(refs, fetch_map, NULL, &matches);
+	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
+	guess_remote_head(remote_refs, fetch_map, NULL, &matches);
 	for(ref = matches; ref; ref = ref->next)
 		string_list_append(abbrev_branch(ref->name), &states->heads);
 
@@ -667,7 +668,7 @@ static int get_remote_ref_states(const char *name,
 				 int query)
 {
 	struct transport *transport;
-	const struct ref *ref;
+	const struct ref *remote_refs;
 
 	states->remote = remote_get(name);
 	if (!states->remote)
@@ -678,11 +679,11 @@ static int get_remote_ref_states(const char *name,
 	if (query) {
 		transport = transport_get(NULL, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
-		ref = transport_get_remote_refs(transport);
+		remote_refs = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
 
-		get_head_names(ref, name, states);
-		get_ref_states(ref, states);
+		get_head_names(remote_refs, name, states);
+		get_ref_states(remote_refs, states);
 	}
 
 	return 0;
-- 
1.6.2.rc1.291.g83eb
