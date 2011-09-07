From: Junio C Hamano <gitster@pobox.com>
Subject: Re* Git without morning coffee
Date: Wed, 07 Sep 2011 11:16:03 -0700
Message-ID: <7vty8o2p7g.fsf_-_@alter.siamese.dyndns.org>
References: <4E6721E3.7000207@drmicha.warpmail.net>
 <7vehzs47we.fsf@alter.siamese.dyndns.org>
 <7v62l445nw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 20:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1MfW-0002sf-Pl
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 20:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab1IGSQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 14:16:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765Ab1IGSQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 14:16:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BC584561;
	Wed,  7 Sep 2011 14:16:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lZRC2krZVgZljwdTQwS+O20fFh8=; b=HUqnV+
	wWXJ2GvlB5bE7sCh4ZhZ9nbvZDIXVWMIYfE5baRL3pmQOG0mUDYpTTiODe+tWdlJ
	/ZeulVwEZL2fJS2WZuffSCtCyjOGM19qBg5kQ/jdVkMSHb1GjgRZs6Cug7NNaOH3
	FqCXTuhA9RT+DaL5OvMLC7+N2iPcKFi58IRu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ixy1opvCGxStUf23dzXemQXA5u/pQs9J
	XYN74Vq9iV+DHTBG9bxYSNek1ib5E6k2LMZ5ydNrqkxDMzyR64JmTzal1vuKJc3m
	itQSNHqHOHJeat86C9LQUL5PGuiWYuK8+tgmPlZLYmuphhwmpLRGhJLHZL1rberO
	ZoA0wl3kwIo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CC2B4560;
	Wed,  7 Sep 2011 14:16:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE4B2455F; Wed,  7 Sep 2011
 14:16:05 -0400 (EDT)
In-Reply-To: <7v62l445nw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 07 Sep 2011 10:35:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73D4700E-D97D-11E0-A5E7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180892>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> git merge ":/Merge branch 'jk/generation-numbers' into pu"
>>> fatal: ':/Merge branch 'jk/generation-numbers' into pu' does not point
>>> to a commit
>>> # Huh?
>>
>> Interesting.
>
> This is because 1c7b76b (Build in merge, 2008-07-07) grabs the name of the
> commit to be merged using peel_to_type(), which was defined in 8177631
> (expose a helper function peel_to_type()., 2007-12-24) in terms of
> get_sha1_1(). It understands $commit~$n, $commit^$n and $ref@{$nth}, but
> does not understand :/$str, $treeish:$path, and :$stage:$path.

-- >8 --
Subject: Allow git merge ":/<pattern>"

It probably is not such a good idea to use ":/<pattern>" to specify which
commit to merge, as ":/<pattern>" can often hit unexpected commits, but
somebody tried it and got a nonsense error message:

	fatal: ':/Foo bar' does not point to a commit

So here is a for-the-sake-of-consistency update that is fairly useless
that allows users to carefully try not shooting in the foot.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |   19 ++++++++++++++-----
 sha1_name.c     |    6 ------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ab4077f..ee56974 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -403,6 +403,16 @@ static void finish(const unsigned char *new_head, const char *msg)
 	strbuf_release(&reflog_message);
 }
 
+static struct object *want_commit(const char *name)
+{
+	struct object *obj;
+	unsigned char sha1[20];
+	if (get_sha1(name, sha1))
+		return NULL;
+	obj = parse_object(sha1);
+	return peel_to_type(name, 0, obj, OBJ_COMMIT);
+}
+
 /* Get the name for the merge commit's message. */
 static void merge_name(const char *remote, struct strbuf *msg)
 {
@@ -418,7 +428,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	remote = bname.buf;
 
 	memset(branch_head, 0, sizeof(branch_head));
-	remote_head = peel_to_type(remote, 0, NULL, OBJ_COMMIT);
+	remote_head = want_commit(remote);
 	if (!remote_head)
 		die(_("'%s' does not point to a commit"), remote);
 
@@ -1124,7 +1134,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!allow_fast_forward)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
-		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
+		remote_head = want_commit(argv[0]);
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
 		read_empty(remote_head->sha1, 0);
@@ -1170,7 +1180,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		struct object *o;
 		struct commit *commit;
 
-		o = peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
+		o = want_commit(argv[i]);
 		if (!o)
 			die(_("%s - not something we can merge"), argv[i]);
 		commit = lookup_commit(o->sha1);
@@ -1238,8 +1248,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (have_message)
 			strbuf_addstr(&msg,
 				" (no commit created; -m option ignored)");
-		o = peel_to_type(sha1_to_hex(remoteheads->item->object.sha1),
-			0, NULL, OBJ_COMMIT);
+		o = want_commit(sha1_to_hex(remoteheads->item->object.sha1));
 		if (!o)
 			return 1;
 
diff --git a/sha1_name.c b/sha1_name.c
index ff5992a..653b065 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -501,12 +501,6 @@ struct object *peel_to_type(const char *name, int namelen,
 {
 	if (name && !namelen)
 		namelen = strlen(name);
-	if (!o) {
-		unsigned char sha1[20];
-		if (get_sha1_1(name, namelen, sha1))
-			return NULL;
-		o = parse_object(sha1);
-	}
 	while (1) {
 		if (!o || (!o->parsed && !parse_object(o->sha1)))
 			return NULL;
