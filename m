From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] add ":" is a pathspec that is too wide
Date: Mon,  9 May 2011 22:51:13 -0700
Message-ID: <1305006678-4051-5-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:51:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfrB-0001Bh-Qt
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab1EJFvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 01:51:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab1EJFvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 01:51:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DD095C94;
	Tue, 10 May 2011 01:53:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=O5e6
	5BfUZVc6rFnXMXwq6BD/NeA=; b=I5u/ErSfs68ZYWB7IAtkM8tdQDBueXJ2eSXq
	H4pE80bXrW5mtEX9KY6TcQdgmakwimPmI22ifvG+5gj6wF6wMIBnacPCPbfDkNPW
	KZy7xzGd2+QYS2gucEIMnoZu11PpR0jMkvDTn7jVzE7fTz9RCEDk7wNKYiuR+S84
	gjcBwqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	omx7dQegKmQIt7nSs2xkg3dXkJJrGG8PC/4GgVLOjLBRxU76G1fuC4khDzcQH6iC
	4/iNADjm4qH1eL9b/QW9GLiAcmoDXQYmOez+26kSsP6SgAi+1+AIKbZZ9jrwHksQ
	WWc/qdGx8xWJEdFX5aUwub3e0yPMSky2JJB0uLQf4sE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 88F675C91;
	Tue, 10 May 2011 01:53:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C91045C90; Tue, 10 May 2011
 01:53:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DB24CD20-7AC9-11E0-A065-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173308>

"git cmd :" should be exactly the same as "git cmd" run from the root
level of the working tree.  "git add" without any pathspec should not
add anything.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e127d5a..43a8aad 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -406,12 +406,12 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (!(addremove || take_worktree_changes)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
-	if (require_pathspec && argc == 0) {
+	pathspec = validate_pathspec(argc, argv, prefix);
+	if (require_pathspec && (!argc || !pathspec)) {
 		fprintf(stderr, "Nothing specified, nothing added.\n");
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
 		return 0;
 	}
-	pathspec = validate_pathspec(argc, argv, prefix);
 
 	if (read_cache() < 0)
 		die("index file corrupt");
-- 
1.7.5.1.290.g1b565
